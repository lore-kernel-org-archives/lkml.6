Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E68C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A2C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OV7jWntv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A2C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeH2K3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:29:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2K3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HNyPbwzq+7GnX5pM/zEpsvE2YjuEn4AoeGtK3ThvBLc=; b=OV7jWntvbMZ9s5HL88QUyBdFG
        C34grUBl6LTYDYr0fcHnyJ9axkLB8ICglKhSWEUjWrVM4hDA66YFI1RK794NyOTGz0JPWhS7NxCun
        l0bolfQcoXo4A0IekaFf3M5rbm6dBdrjiieaKNwWogV37NeK0409OClc6tbVn+A9glWk+7i9cQ1xo
        MJEP+5RBneGLSR5NKfrRkhAjuUQXK2SaajFaS4VV/3AjUIxKDv4Ynyp8Hf8cvaf1QyyUfTaUUwaUM
        FkJewvy+F97iUeBzVAM7mluCI2uSUMltkkNwQxQSI0FBF2twnmKnLLkjPOed6EBxNPiYeb5Uhj9hM
        bhd+fNNPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuu32-0000QG-4r; Wed, 29 Aug 2018 06:33:48 +0000
Date:   Tue, 28 Aug 2018 23:33:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] codafs: Fix build using bare-metal toolchain
Message-ID: <20180829063347.GB32392@infradead.org>
References: <20180828142421.15335-1-semen.protsenko@linaro.org>
 <20180828142421.15335-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828142421.15335-2-semen.protsenko@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please just drop the ifdef entirely.  The file is part of the kernel
tree and can't be used for anything non-Linux.
