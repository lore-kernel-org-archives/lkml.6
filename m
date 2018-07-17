Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A28ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D23820C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sHR9WKrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D23820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeGQNUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:20:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbeGQNUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZX1ICzTmvoHn6+qhigcuaywA4WvQEh+PkeFnZ+ftr1E=; b=sHR9WKrTnEzPLsJdne36CcNh8
        ZaP9EnYXnRTxK9/ATLn6gt3Ic4EQd/0x+EMBs5ToYyMzGqlr7ZzZpQpYpOMdTYz00TIoh1gTwtKEK
        6kHxnLg2U4skY3umbUUmaW9O60Mku3wpmsH5nR5CdxhCDOqOdZFoKz0Bjntxs7r3Pfqo5f8MMiNr4
        6LUQw7tyJNVuTijwtSfR8qWO85scCxD0S5wBU/leeX7oy23sFx/l/0s0IkFaQeMvYetqjL+z75CsD
        v/RIsQKUJKbykrro0Y9B+HcAm8xZmq1x3E4UgpYHi6Rug/ffKB8ifdUDdyJY5O8N9+sfI8V5CEnzi
        ssR3dijag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffPOg-0006QA-3j; Tue, 17 Jul 2018 12:48:06 +0000
Date:   Tue, 17 Jul 2018 05:48:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     Christoph Hellwig <hch@infradead.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org, linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Message-ID: <20180717124805.GB22099@infradead.org>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <20180708202136.GA1546@infradead.org>
 <4964583a-d13f-7b92-9838-e4398ec8c682@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4964583a-d13f-7b92-9838-e4398ec8c682@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:20:06PM +0530, Sayali Lokhande wrote:
> Agree. Will add separate config for UFS Provision and set it dependent on
> CONFIGFS_FS

Please add an actual CONFIG_UFS_PROVISIONING user selectable option.
