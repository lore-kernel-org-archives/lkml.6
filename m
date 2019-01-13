Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B9CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B64B20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHXIDtmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfAMECF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 23:02:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfAMECF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 23:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jo+wHiijO2v5oxmYxIjE2Z7XoSZdTNOS3RZkryBuM9w=; b=hHXIDtmHE6dBjCohHx/UUbl6eI
        p8poncKrQ0q3oJSlL9PnT/ZcMP1sLOtJzuYzvJGqJUFtoe2fJyHgOlu7wmD12IrbQMx7WhORhFxRw
        bsZOy/Cv9nG+1HqqBHqJuQgtTCkA0fJAWUok/p/FThI0wEjzaP+h8oH2HTNXVuDW9wsZA2VlMU+50
        GegX5eNAdHqStYqyx3Q8aM4OgBlyEg8NGYh/fB4oG2beL5U6vM7o0b86nHPze5/ZcPDk4n/Eztlc6
        9QUTG5+rNscJV2WfZ2Wgjfz3bgdTN7fbsMLhp4BKDkGLJVfOUO5zqiY7UI/VmxprVZ+6kd7N/VX1Y
        lQ0+2oqw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giWyJ-0000E7-5b; Sun, 13 Jan 2019 04:02:03 +0000
Date:   Sat, 12 Jan 2019 20:02:01 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Jan Vlietland <j.vlietland@nisi.nl>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SAMSUNG LAPTOP DRIVER" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: Keyboard backlight not working on my NP900X5N laptop
Message-ID: <20190113040201.GA1349@wrath>
References: <ffa49970-ce0a-614e-3c90-03eb4924fbef@nisi.nl>
 <20190103020323.GA21617@wrath>
 <a675b43e-b40b-5049-2045-294325053723@nisi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a675b43e-b40b-5049-2045-294325053723@nisi.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 05:16:38PM +0100, Jan Vlietland wrote:
> Hi Darren,
> 
> I understand your extra workload. For me it is just being another user
> complaining about some bug. Sorry for that :-) Good to know the response
> time. I will keep that in mind.
> 
> Anyway. I have changed the static variable to "0A", recompiled the module
> and I get the same output 'no such device'.
> 
> However I am now running in EFI mode based on another bug:
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=109209
> 
> ...and I see in the code....
> 
>     struct samsung_laptop *samsung;
>     int ret;
> 
>     if (efi_enabled(EFI_BOOT))
>         return -ENODEV;
> 
>     quirks = &samsung_unknown;
>     if (!force && !dmi_check_system(samsung_dmi_table))
>         return -ENODEV;
> 
>     samsung = kzalloc(sizeof(*samsung), GFP_KERNEL);
>     if (!samsung)
>         return -ENOMEM
> 
> Is that EFI restriction still valid. As far as I remember Samsung repaired
> their BIOS. Or does the driver not work in EFI mode anyway?

Hi Jan,

Taking a closer look at the driver and the git log, the driver was disabled for
EFI because it pokes at BIOS memory and that would mean poking at a completely
different memory map when in EFI mode - it would be expected to fail - and in
some cases it failed by bricking the laptop. See:

e0094244e41c samsung-laptop: Disable on EFI hardware

What appears to be needed here is for someone with the hardware and some
experience tracing ACPI calls from whatever OS it ships with to figure out the
new interface. I suspect it is either pure ACPI or possibly WMI, and a new
driver may be needed.

Have you tried this driver in BIOS mode with the OA change above?

> 
> 
> On 03-01-19 03:03, Darren Hart wrote:
> > On Mon, Dec 31, 2018 at 08:40:43PM +0100, Jan Vlietland wrote:
> > > Hi all,
> > > 
> > Hey Jan,
> > 
> > > Greg K-H suggested to mail you guys.
> > > 
> > > I installed Linux 4.20.0-rc7 (downloaded, compiled and installed) on a Samsung NP900X5N laptop and have noticed 3 bugs. 2 of them I found in Bugzilla and replied on them (i915 and Nouveau issues). I am currently discussing them with an intel engineer.
> > > 
> > > On other bug I haven't found so therefore a mail directly to you guys as maintainers.
> > > 
> > > On my other machine, a Samsung NP900X4D (just bought it in the USA, 2017 model), the samsung-laptop.ko module is enabling the use of the keyboard backlight keys.
> > > 
> > > It is not working on my new machine NP900X5N. My samsung-laptop.ko driver isn't loading. If I try to load it manually it complains about 'no such device".
> > > 
> > > My Linux kernel is working in CSM mode. The module is still not loaded.
> > > 
> > That's correct.
> > 
> > > As it is weekend I did some more reading and debugging of the module. To my understanding the module checks the model and type of the laptop. The known models and types are stored in the struct:
> > > 
> > > static struct dmi_system_id __initdata samsung_dmi_table[]
> > > 
> > > I wondr if the NP900X5N notebook is included in this list.
> > > 
> > > With dmidecode -t chassis it shows:
> > > Getting SMBIOS data from sysfs.
> > > SMBIOS 3.0.0 present.
> > > 
> > > Handle 0x0003, DMI type 3, 22 bytes
> > > Chassis Information
> > >          Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
> > >          Type: Notebook
> > >          Lock: Not Present
> > >          Version: N/A
> > >          Serial Number: 0F4C91CJ900346
> > >          Asset Tag: No Asset Tag
> > >          Boot-up State: Safe
> > >          Power Supply State: Safe
> > >          Thermal State: Other
> > >          Security Status: None
> > >          OEM Information: 0x00000000
> > >          Height: Unspecified
> > >          Number Of Power Cords: 1
> > >          Contained Elements: 0
> > >          SKU Number: Chassis
> > > 
> > > If I use the -u flag. The notebook value is 0x0A, not 0x10!!!
> > > 
> > > Could that be the reason for not loading?
> > Seems likely.
> > 
> > > 		.matches = {
> > > 			DMI_MATCH(DMI_SYS_VENDOR,
> > > 					"SAMSUNG ELECTRONICS CO., LTD."),
> > > 			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> > > 		},
> > > 
> > > Maybe another reason could that that either the i915 and Nouveau modules are
> > > not working well. I get black screens with the i915 and MMIO faults with the
> > > nouveau driver. That is another issue that I need to tackle.
> > > 
> > I would expect a different error than "no such device" in that case.
> > I think your first thought was correct.
> > 
> > As a simple test, I'd suggest replacing "10" with "0A" in the existing
> > DMI_CHASSIS_TYPE match, recompile, and see if it loads and works
> > correctly.  Would you be able to test this?
> > 
> > > Oh happy new year :-)
> > 
> > Happy New Year!
> > 
> 
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
