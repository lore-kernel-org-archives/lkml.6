Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F164C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D24420833
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uMGD24TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfACCD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:03:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfACCD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TikSaG+yA4rcM65nT22L+1eHQgSWX18QG3b9BzIeN9I=; b=uMGD24TGm366ZRtvZk5Q0v3Vb
        krXKmqWUwmzecKCB7mdBRWIgKIYZ5Q7gVss7fk8gH6fv2fP5G0VDKDLsB25Jzvk8JZZRy4PtsdZQw
        sSkil21985Zwp411gPfr1cP4ysmPGpLBb35yIvwlbbym9/WTTRjcHpN6oQhs8DU61HYUVar9uG7SC
        LG+Jtk20U1DB0siE8ujvfk9NwYcsP0v3l5M9HXZB1fhhBFIasNxM20YU3/lKbNuE7GnW0e98vWKQb
        6+v4yMXcJicz5i93CezklVHYlamphkcIjiNPxLrpYK1cDyORiIY0i7Wnnt+xx8pdm1/h4PoWqGYT4
        DpDHeQtnw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gesM0-0002kx-Ix; Thu, 03 Jan 2019 02:03:24 +0000
Date:   Wed, 2 Jan 2019 18:03:23 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Jan Vlietland <j.vlietland@nisi.nl>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SAMSUNG LAPTOP DRIVER" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: Keyboard backlight not working on my NP900X5N laptop
Message-ID: <20190103020323.GA21617@wrath>
References: <ffa49970-ce0a-614e-3c90-03eb4924fbef@nisi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa49970-ce0a-614e-3c90-03eb4924fbef@nisi.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 08:40:43PM +0100, Jan Vlietland wrote:
> Hi all,
> 

Hey Jan,

> Greg K-H suggested to mail you guys.
> 
> I installed Linux 4.20.0-rc7 (downloaded, compiled and installed) on a Samsung NP900X5N laptop and have noticed 3 bugs. 2 of them I found in Bugzilla and replied on them (i915 and Nouveau issues). I am currently discussing them with an intel engineer.
> 
> On other bug I haven't found so therefore a mail directly to you guys as maintainers.
> 
> On my other machine, a Samsung NP900X4D (just bought it in the USA, 2017 model), the samsung-laptop.ko module is enabling the use of the keyboard backlight keys.
> 
> It is not working on my new machine NP900X5N. My samsung-laptop.ko driver isn't loading. If I try to load it manually it complains about 'no such device".
> 
> My Linux kernel is working in CSM mode. The module is still not loaded.
> 

That's correct.

> As it is weekend I did some more reading and debugging of the module. To my understanding the module checks the model and type of the laptop. The known models and types are stored in the struct:
> 
> static struct dmi_system_id __initdata samsung_dmi_table[]
> 
> I wondr if the NP900X5N notebook is included in this list.
> 
> With dmidecode -t chassis it shows:
> Getting SMBIOS data from sysfs.
> SMBIOS 3.0.0 present.
> 
> Handle 0x0003, DMI type 3, 22 bytes
> Chassis Information
>         Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>         Type: Notebook
>         Lock: Not Present
>         Version: N/A
>         Serial Number: 0F4C91CJ900346
>         Asset Tag: No Asset Tag
>         Boot-up State: Safe
>         Power Supply State: Safe
>         Thermal State: Other
>         Security Status: None
>         OEM Information: 0x00000000
>         Height: Unspecified
>         Number Of Power Cords: 1
>         Contained Elements: 0
>         SKU Number: Chassis
> 
> If I use the -u flag. The notebook value is 0x0A, not 0x10!!!
> 
> Could that be the reason for not loading?

Seems likely.

> 
> 		.matches = {
> 			DMI_MATCH(DMI_SYS_VENDOR,
> 					"SAMSUNG ELECTRONICS CO., LTD."),
> 			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> 		},
> 
> Maybe another reason could that that either the i915 and Nouveau modules are
> not working well. I get black screens with the i915 and MMIO faults with the
> nouveau driver. That is another issue that I need to tackle.
> 

I would expect a different error than "no such device" in that case.
I think your first thought was correct.

As a simple test, I'd suggest replacing "10" with "0A" in the existing
DMI_CHASSIS_TYPE match, recompile, and see if it loads and works
correctly.  Would you be able to test this?

> Oh happy new year :-)


Happy New Year!

-- 
Darren Hart
VMware Open Source Technology Center
