Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C615C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCB820881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFI9XWIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCB820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeGIVZO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:25:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbeGIVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OtRM44YHjx185uB1enQZvY1OibpB5swcgEo8+eNJJM0=; b=dFI9XWIXLWDpPs+rNz0Hz8Sw1
        vec1EHwLY5wpIQWphdFP5hLbYYrym6NFNEEhd8PXlFOPxDz8q37xU0PCUY94/48K91ub5TVChKVp2
        FuH4u498hodLKGXKd6gcEnZiyPQLaLoSjmLlCjKfTMutvldjmtXau22nsocyjMR0e9WMQgGIY+kV6
        Zf2X9txoxcm49y9bju6aKLiZrA2VFvnu2p+DcjduyBaojFn/QRoSJx7EXn7pdcwOMF2GoZDUKdFQA
        J1Ydk6Ou9iDj3R5sQg5CarWAvxSJsqfSeT/pMDkrJzzz42PDTtRk10C4+Ix1aOdHfxrZamKfmFLML
        TrnYhk0vQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcdei-0002au-Gf; Mon, 09 Jul 2018 21:25:12 +0000
Date:   Mon, 9 Jul 2018 14:25:11 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH] platform/x86/toshiba_acpi.c: fix defined but not used
 build warnings
Message-ID: <20180709212511.GB30247@fury>
References: <59774e7f-103c-70b1-11bf-b2af16947dc8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59774e7f-103c-70b1-11bf-b2af16947dc8@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:53:09PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a build warning in toshiba_acpi.c when CONFIG_PROC_FS is not enabled
> by marking the unused function as __maybe_unused.
> 
> ../drivers/platform/x86/toshiba_acpi.c:1685:12: warning: 'version_proc_show' defined but not used [-Wunused-function]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Azael Avalos <coproscefalo@gmail.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>

Thanks Randy, queued.

-- 
Darren Hart
VMware Open Source Technology Center
