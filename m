Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE627C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E8722419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OsWxkV2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E8722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbeKMTVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:21:46 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51592 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKMTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nl+e/fZXKmnpho7WCMuVj7V50gmJz1QfXADE8qU3qO0=; b=OsWxkV2N7VO504RQO6gM6GV23
        ugf3Fsxkp7l+4Acxobr34M+T9JC3UHogZ1xA4pK/konUyW3RUq9qikPOTR0EXUTMO/5/wWM3aKhNB
        V5KdTJImHedFhMLcMLeK+xG2S1YCn/xJ93MKBUY9bTOfFeN3OobmeIs5owQEGWaNlTYFc=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39450)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gMUvq-00075z-QS; Tue, 13 Nov 2018 09:24:26 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gMUvo-0007Iz-CL; Tue, 13 Nov 2018 09:24:24 +0000
Date:   Tue, 13 Nov 2018 09:24:23 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Bich HEMON <bich.hemon@st.com>
Cc:     Olof Johansson <olof@lixom.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH] ARM: stm32: debug: add low-level debug support
Message-ID: <20181113092422.GJ30658@n2100.armlinux.org.uk>
References: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
 <1501174209-27550-2-git-send-email-bich.hemon@st.com>
 <20181112182236.s7cs6dol4dmxkp7u@localhost>
 <f244c67b-de86-b0e7-7283-7b27f9591cf9@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f244c67b-de86-b0e7-7283-7b27f9591cf9@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 09:16:16AM +0000, Bich HEMON wrote:
> 
> On 11/12/18 7:22 PM, Olof Johansson wrote:
> > On Thu, Jul 27, 2017 at 04:50:20PM +0000, Bich HEMON wrote:
> >> From: Gerald Baeza <gerald.baeza@st.com>
> >>
> >> This adds low-level debug support on USART1 for STM32F4
> >> and STM32F7.
> >> Compiled via 'CONFIG_DEBUG_LL' and 'CONFIG_EARLY_PRINTK'.
> >> Enabled via 'earlyprintk' in bootargs.
> >>
> >> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> >> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> > 
> > Hi,
> > 
> > This had fallen between the chairs it seems. I have applied it to arm-soc
> > next/soc now, for 4.21 merge window.
> > 
> > It ended up being patched up manually to consolidate the version in
> > Russell's patch tracker with this posted version, and I tweaked whitespace
> > a bit. Let me know if I missed something.
> > 
> > 
> > Thanks,
> > 
> > -Olof
> > 
> 
> Hi Olof,
> 
> Please note that this patch has to be abandoned as Ludovic BARRE pushed 
> a new version of this change:
> https://patchwork.codeaurora.org/patch/400563/
> 
> You can find it in Russell's tracker here:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8803/1

And I'm not going to merge that because:

1) it's not for me to merge - it doesn't go through my tree, but through
   arm-soc, which Olof and Arnd manage.
2) it's not been on the mailing list as per normal submission process.

Sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
