Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3F0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B132077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qt7AYLjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B132077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJJTcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:32:02 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47686 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJJTcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oQz4ELaZejDnCIlxC+D2wr5haUw00+QPiXiYSiPXiWo=; b=Qt7AYLjxGLq/Rm0sCI3KUN06e
        YR3kd3tpzMCbmoADfFhe/QXUhkaYE1X1ufebxqix9UHGSoFdsXjygtlf1iHXVEODVRZPDKOjzXwNL
        7VX9RIRSOakaySvHp9V+ZJBGJLMtxq3VgM79QlPx8hpgKcfuLHBNvzFouoCiN92fwhNJw=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:41212)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gADJQ-0006bg-So; Wed, 10 Oct 2018 13:10:01 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gADJN-0001iO-2m; Wed, 10 Oct 2018 13:09:57 +0100
Date:   Wed, 10 Oct 2018 13:09:55 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Question] directory for SoC-related DT binding
Message-ID: <20181010120955.GQ30658@n2100.armlinux.org.uk>
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
 <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
 <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:04:14PM +0200, Stefan Wahren wrote:
> Hi,
> 
> Am 10.10.2018 um 13:19 schrieb Rob Herring:
> > On Wed, Oct 10, 2018 at 6:08 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> Hi,
> >>
> >>
> >> I see a bunch of vendor (or SoC) names in
> >> Documentation/device/bindings/arm/
> >>
> >> ./Documentation/devicetree/bindings/arm/altera
> >> ./Documentation/devicetree/bindings/arm/amlogic
> > Yeah, it's kind of a mixture of board/soc bindings mostly with some
> > ARM architecture, ARM, Ltd. IP, and SoC system reg bindings.
> >
> > Eventually, I'd like to not split board bindings by arch and maybe we
> > should move all the system/misc reg bindings out.
> >
> > [,,,]
> >
> >> I also see some vendor names in
> >> Documentation/device/bindings/soc/
> >>
> >> ./Documentation/devicetree/bindings/soc/bcm
> >> ./Documentation/devicetree/bindings/soc/dove
> >> ./Documentation/devicetree/bindings/soc/fsl
> >> ./Documentation/devicetree/bindings/soc/mediatek
> >> ./Documentation/devicetree/bindings/soc/qcom
> >> ./Documentation/devicetree/bindings/soc/rockchip
> >> ./Documentation/devicetree/bindings/soc/ti
> >> ./Documentation/devicetree/bindings/soc/xilinx
> >> ./Documentation/devicetree/bindings/soc/zte
> > This I believe is mostly SoC system reg bindings though there's
> > probably a few other things.
> >
> >> Confusingly, I see bcm, mediatek, rockchip
> >> in both locations.
> >>
> >> Is there any rule to choose one than the other?
> > Top-level SoC/board bindings in arm/ and anything else elsewhere ideally.
> 
> in case of Documentation/devicetree/bindings/soc/bcm the directory
> contains SoC / board bindings, cpu-enable and a firmware binding.

I think you're confused there...

$ ls -1 Documentation/devicetree/bindings/soc/bcm/
brcm,bcm2835-vchiq.txt
raspberrypi,bcm2835-power.txt

Doesn't look like SoC/board bindings to me...

whereas:

$ ls -1 Documentation/devicetree/bindings/arm/bcm/
brcm,bcm11351-cpu-method.txt
brcm,bcm11351.txt
brcm,bcm21664.txt
brcm,bcm23550-cpu-method.txt
brcm,bcm23550.txt
brcm,bcm2835.txt
brcm,bcm4708.txt
brcm,bcm63138.txt
brcm,brcmstb.txt
brcm,cygnus.txt
brcm,hr2.txt
brcm,ns2.txt
brcm,nsp-cpu-method.txt
brcm,nsp.txt
brcm,stingray.txt
brcm,vulcan-soc.txt
raspberrypi,bcm2835-firmware.txt

does fit with your description, except for the directory path...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
