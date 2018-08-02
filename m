Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED72DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9562C214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQzMnYKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9562C214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbeHBLzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:55:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHBLzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QWTTubVQE6xDeeQ+j+xY/c9yjAtGJp9ZdSEgYsPLlys=; b=qQzMnYKbOKPymgtt8WpQpWPG3
        aNJv8TufzeVL7HECXm6RGfWry932G9ItBS0HAd8ngLP3eenOwpZkiVKIGX2o2IDSX1QEDaloVToym
        QT39+0dqs5LwIKipJlRERwyKqPkbb6qDXwseFhfMk7HexRJac6O/avSbnaQNegE+Tg3I0F+m13Y53
        1zb9wiF+IHMvZ6mW6Cj4020vdiimbLFf10PG1P0kLiXz2Renxuj3FVgjLjaJfdPensh5I5k8a6N2V
        kM8GHIfjfw4662XtBRNscKVBCR0CoupU0Ao3HlwZptGyY+TivSik9vnz9/rziON24DQWYkTUN3jAy
        zah5JInLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flATu-0002P5-Cs; Thu, 02 Aug 2018 10:05:18 +0000
Date:   Thu, 2 Aug 2018 03:05:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime@adnestech.com
Subject: Re: [PATCH] RISC-V: Add the directive for alignment of stvec's value
Message-ID: <20180802100518.GA4144@infradead.org>
References: <1529545207-26999-1-git-send-email-zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529545207-26999-1-git-send-email-zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:40:07AM +0800, Zong Li wrote:
> The stvec's value must be 4 byte alignment by specification definition.
> This directive avoids to stvec be set the non-alignment value by the
> following code in head.S
> 
>  /* Point stvec to virtual address of intruction after satp write */
> la a0, 1f
> add a0, a0, a1
> csrw stvec, a0
> 
> Signed-off-by: Zong Li <zong@andestech.com>

Just noticed this didn't get picked up yet, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
