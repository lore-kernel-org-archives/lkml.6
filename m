Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE5C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACCA21C3C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dndfs6qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACCA21C3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeHIJ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:26:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m3HvwTfznfbqvKVbLdI9HFcxhW/p1HHekeLJ7xgwAuI=; b=Dndfs6qZonnlWLIBz50YPLKLO
        GGGLOgLwHszM+X18JNlzclHuQR25/8oYyU2hYOyBQL3ZqD0gF0VtMR2dv1ZhL+DGhcCNCEhlBrThH
        fF5VRNv3Q0kp3AokrrcSt2/JrC0943Twj6U25qe02G/are87Rv1BI587cfY2CoaSDsNsyZc4/NE7x
        DaZqv1umOJR5fASJSabeiTSYz2hq2Cxk8qeI0FY3sX3oZcF91NgQpssmpZQxCDCM8rPtAxTTV7OuK
        3aErtPf6xEG8kKvPHtDaxV8pCk409kBmga1GvKpg/mJUNCuTjFv3kOLeC4KihGCGfT4rL09uZd+mT
        MtLzIC38A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fneyI-0003Li-Jj; Thu, 09 Aug 2018 07:02:58 +0000
Date:   Thu, 9 Aug 2018 00:02:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     Christoph Hellwig <hch@infradead.org>, vincentc@andestech.com,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, greentime@andestech.com,
        zong@andestech.com, Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org, nickhu@andestech.com
Subject: Re: [PATCH v5 5/5] Auto-detect whether a FPU exists
Message-ID: <20180809070258.GA11082@infradead.org>
References: <1533796003-680-1-git-send-email-alankao@andestech.com>
 <1533796003-680-6-git-send-email-alankao@andestech.com>
 <20180809063124.GA26062@infradead.org>
 <20180809064336.GA18746@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809064336.GA18746@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:43:36PM +0800, Alan Kao wrote:
> It does look a little bit weird.  Should I send a v6 for this?

Yes, please resend the series or just this patch.

I think the hswap.h definition should go away and we should just
keep the switch_to.h one, even if that means including the header
in another C file.
