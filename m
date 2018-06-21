Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF65C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD24820883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jn2+RErE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD24820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeFUMkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:40:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeFUMkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1YRazIREcG4Ml6wgN4NMgRm9G/jpc/Dr7vnEj4TbW4w=; b=jn2+RErE3vDCn8AKXk1z2wkhR
        VmWbxzHmT3JfOTc5iUaYcISevyARF8nLl1S4QHcMUIw66vQdMk9VOZUFiCYB1as1kr0WiwpfkwNRH
        dVFY0uaWXSCsOxaXhRwxYnVyihUHwnnK/HCjKlzw8EoKtpeCXKCvBAU9YQlSDDFj0vf5siJCcNDsT
        UKyyXFhwZTsapaFNvT+nXcnnOL/M2FPO77ChGY6f7jPvr3idAc8xXMHVKhYOl/1DD0USZfcH2Z6YO
        FRWFiMi1k28Z2jsqKXq/0MqtQLaz28fFAlCXcLTPsnwoxKHNtHCFSmP+UGmVEWtVyFwuu+bq21nEU
        EdBnLzOKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVytA-00036b-VZ; Thu, 21 Jun 2018 12:40:36 +0000
Date:   Thu, 21 Jun 2018 05:40:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        kernel-hardening@lists.openwall.com, security@kernel.org
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
Message-ID: <20180621124036.GA6348@infradead.org>
References: <20180615152335.208202-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615152335.208202-1-jannh@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you resend a patch for the sg driver alone?  Also I think
we just want the scsi_safe_file_access code inside sg itself,
it really has nothing to do with the reset of the contents in
scsi_cmnd.h
