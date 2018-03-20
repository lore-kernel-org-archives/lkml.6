Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488525-1521525997-2-8386774944635791458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521525996; b=OMnl6ZHfMMjwqp4OKWfGUIuYUQTqpJRhAGyMbFbT3MOIwMQ
    vk75zsVWDg3ohHw7N9rFUdpPIFF/eo/W5XAl0WSqx6Gn4ZJBwH40gYVENQgV6/LF
    ezv9cGnxA5moiWYvX5PHuw6UFud6cmufcj0JXOo/eSuCHgVFaMYAMwinxbJiTS7f
    LKv0Og9rfhUiyIhYz+E+0cChgoDQJ35PIuwOrYuakxLJS6r5j1HpkVC1Kzrv2IFX
    NABirlfMeYUwcnBXLJPZcZHRXNmyuaYAoG/c2EtSfXSegdioo/JYJKjN7VY5vmEe
    izivGxqw32JKjoVoliXEhaULChr5X2RuLzNiuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521525996; bh=Nzw0oIpqIIzQ5x74N+KIpbip4y
    0BjEMCjwQtw4TPp1Q=; b=jUBDkB6/aSo2KSu7y3GF1ZSjaUadLizTQfWCfsqxGT
    VxaVzzzX+6wRUf4lHfP6OpNP8/Ln4cWWrmppgcowbqIOlpBfOXDih0O4uX2kBili
    crsodpy+HY1+LGQ3SZwbvVt49QBdVOt9reobsaFMk+JvrfngzSfZOTOPRVIH5Bcw
    e7WiuOpgUdfvuSMJYr3yKP6KT2Np27dN75f/XAJ08D4Sw1hTm9jSxI3NORRyNpoZ
    gQt1jrUpzkVehKEii7SLO+YGoQSptosYSWlEp92K8xbnRqat/YnIJz1M3ZZ00lFZ
    ldnJSO9ioB6adB4YVRxtnaeOqTK3zIrIy5CYedA7+ufg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GiAL0uGp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fVXSSI8s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GiAL0uGp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fVXSSI8s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeCTGGe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 02:06:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32806 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTGGd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 02:06:33 -0400
X-Google-Smtp-Source: AG47ELs3PaJVYurd0LUbcr09mN/xyWr6g6SA2awysiFadwxrJXJhQ1sGmCPwIviFhH3ezLG+Lny3Dg==
Date: Tue, 20 Mar 2018 14:06:30 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Tero Kristo <t-kristo@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 038/134] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Message-ID: <20180320060630.iy4wlqnzj6vrmhyd@xps>
Mail-Followup-To: Tero Kristo <t-kristo@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171854.858515505@linuxfoundation.org>
 <20180319235251.ui2gf3nlg2icbbdx@xps>
 <f43909b9-e4d2-2279-9857-1e10a03197c7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43909b9-e4d2-2279-9857-1e10a03197c7@ti.com>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 07:08:36AM +0200, Tero Kristo wrote:
> On 20/03/18 01:52, Dan Rue wrote:
> > On Mon, Mar 19, 2018 at 07:05:21PM +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Roger Quadros <rogerq@ti.com>
> > > 
> > > 
> > > [ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]
> > > 
> > > It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
> > > is in use then there are random chances that the usb_otg_ss module
> > > will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.
> > > 
> > > Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
> > > fixes this issue.
> > > 
> > > We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
> > > issue or not so don't add this flag for those instances.
> > > 
> > > Cc: Tero Kristo <t-kristo@ti.com>
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This fails to build for me on arm32 with default config.
> > 
> > #
> > # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
> > #
> > #
> > # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
> > #
> > ../arch/arm/mach-omap2/omap_hwmod_7xx_data.c:2243:12: error: 'HWMOD_CLKDM_NOAUTO' undeclared here (not in a function)
> >    .flags  = HWMOD_CLKDM_NOAUTO,
> >              ^
> > ../scripts/Makefile.build:269: recipe for target 'arch/arm/mach-omap2/omap_hwmod_7xx_data.o' failed
> > make[2]: *** [arch/arm/mach-omap2/omap_hwmod_7xx_data.o] Error 1
> > make[2]: Target '__build' not remade because of errors.
> > /home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/multi_v7_defconfig/label/builder/Makefile:969: recipe for target 'arch/arm/mach-omap2' failed
> > make[1]: *** [arch/arm/mach-omap2] Error 2
> > make[1]: Target '_all' not remade because of errors.
> > Makefile:152: recipe for target 'sub-make' failed
> > make: *** [sub-make] Error 2
> > make: Target '_all' not remade because of errors.
> 
> This again has some dependencies, at least:
> 
> 8ff42da41147 ("ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO")

Thank you - I can confirm that adding 8ff42da41147 fixes the arm32 build
for me.

> 
> -Tero
> 
> > 
> > Dan
> > 
> > > ---
> > >   arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > > +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > > @@ -2240,6 +2240,7 @@ static struct omap_hwmod dra7xx_usb_otg_
> > >   	.class		= &dra7xx_usb_otg_ss_hwmod_class,
> > >   	.clkdm_name	= "l3init_clkdm",
> > >   	.main_clk	= "dpll_core_h13x2_ck",
> > > +	.flags		= HWMOD_CLKDM_NOAUTO,
> > >   	.prcm = {
> > >   		.omap4 = {
> > >   			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
> > > @@ -2261,6 +2262,7 @@ static struct omap_hwmod dra7xx_usb_otg_
> > >   	.class		= &dra7xx_usb_otg_ss_hwmod_class,
> > >   	.clkdm_name	= "l3init_clkdm",
> > >   	.main_clk	= "dpll_core_h13x2_ck",
> > > +	.flags		= HWMOD_CLKDM_NOAUTO,
> > >   	.prcm = {
> > >   		.omap4 = {
> > >   			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
> > > 
> > > 
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
