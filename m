Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84E420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k4AJzh6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84E420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbeKGCDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:03:35 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54678 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388927AbeKGCDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3/n3ubq0OvqMAj8fIqoN7l0a9gNkaEd6ejwTFUoCEwo=; b=k4AJzh6P3aAHCP59h8iiRAiyD
        WS99oJ2TRO4taPrZWWTnr+zkZlCvNPnZxzCj467WAaydRbdMtKNW761y+kZ3vYip5V3NTg9gDBGmL
        dG8xpPIj4Qvcx0947PAZ0Qrw2KLcYm1O3fcB4Vi/cTa0Af1q3MALCsdAluGdjoIabzvik=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44450)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gK4M4-0001K1-My; Tue, 06 Nov 2018 16:37:28 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gK4M2-0006HC-18; Tue, 06 Nov 2018 16:37:26 +0000
Date:   Tue, 6 Nov 2018 16:37:24 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     David Binderman <dcb314@hotmail.com>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible
 cut'n'paste error
Message-ID: <20181106163724.GK30658@n2100.armlinux.org.uk>
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <20181106162014.GH30658@n2100.armlinux.org.uk>
 <VI1PR08MB33427CD1C653245DBB979B9B9CCB0@VI1PR08MB3342.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR08MB33427CD1C653245DBB979B9B9CCB0@VI1PR08MB3342.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:33:26PM +0000, David Binderman wrote:
> hello there Russell,
> 
> > linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576]: (warning) Redundant assignment of >'ufp_exc->fpinst2' to itself.
> 
> >Thanks for the report - it most certainly is a bug introduced by
> >Julien's patches, but I don't get your warning here.  Which compiler
> >produces that warning?
> 
> Not a compiler, cppcheck, a static analyser for C and C++ code.
> 
> Interestingly, more of the same in file linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c
> 
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:84]: (warning) Redundant assignment of 'ASCR' to itself.
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:85]: (warning) Redundant assignment of 'ARSR' to itself.
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:120]: (warning) Redundant assignment of 'ASCR' to itself.
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:121]: (warning) Redundant assignment of 'ARSR' to itself.
> 
> I don't know if these four are also worth fixing.

There are cases where this can be false positives.  In the case of a
status register with write-1-to-clear bits for example.  These ones
look very much like that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
