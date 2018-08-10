Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43E9C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51559223B5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ergs16lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51559223B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHJLHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:07:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJLHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i3p5HOTsH66bE3rKDJciSA9YT+DW5W6msZPYG7Ppyuw=; b=ergs16lmdGHUISsrD7wirnuc7
        4OC/s+PGRYn9akRmfSLuPqZQQRr6mlqCR45D1IpubsJKthazjcThYEm06+Ruv2Y9W8fn90hbAPyAr
        dqczz40508lObkbY2BlogTqe1/BLPhNlKiQjzjhEzNdtUh993XQhTdvEFzuqiDL18qK5/1gZ0QXX/
        KjHfr2WnluhJ1GupcHOPH+RAkB+qj5laobl1X7t8Xx5o+mtqqUhFHZYuwoPqiHxU8juW+GDKuTpBB
        QWA0pv+CwWbvq8ZcYQq/bjTAmTo+Cw+8KGunNhInMGh2zBbin7pjsJcWYmwyl/oc6FevNldB/0jFP
        dIbsLxGYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fo2wB-0001Hx-DA; Fri, 10 Aug 2018 08:38:23 +0000
Date:   Fri, 10 Aug 2018 01:38:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Drop setup_initrd
Message-ID: <20180810083823.GB20415@infradead.org>
References: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 09:11:40PM -0700, Guenter Roeck wrote:
> setup_initrd() does not appear to serve a practical purpose other than
> preventing qemu boots with "-initrd" parameter, so let's drop it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
