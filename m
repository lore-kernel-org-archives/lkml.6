Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeCKOGZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 10:06:25 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:6727 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932136AbeCKOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 10:06:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GaAAC1N6Vah8mZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmEG8oCo1ljW+CBIEWhySNDoIVCiOFAgKDESE0GAECAQEBAQE?=
 =?us-ascii?q?BAgECEAEBAQoLCQgoLoI4IhFLWQEBAQEBASMCDV0BAQEEbgsMBAIBCBEEAQEBI?=
 =?us-ascii?q?wQHISUJCAIEAQ0FCIR4AxUPq3KHHA2BMIIVBYU1gi6DPIMugmpEBBmBXYVjBI1?=
 =?us-ascii?q?/L4t3MQmGQ4Zpgy2Oa4l5OYcWgSweggtwT4JDgjIQDBaBY3cBiR8qgQeBGAEBA?=
 =?us-ascii?q?Q?=
X-IPAS-Result: =?us-ascii?q?A2GaAAC1N6Vah8mZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mEG8oCo1ljW+CBIEWhySNDoIVCiOFAgKDESE0GAECAQEBAQEBAgECEAEBAQoLC?=
 =?us-ascii?q?QgoLoI4IhFLWQEBAQEBASMCDV0BAQEEbgsMBAIBCBEEAQEBIwQHISUJCAIEAQ0?=
 =?us-ascii?q?FCIR4AxUPq3KHHA2BMIIVBYU1gi6DPIMugmpEBBmBXYVjBI1/L4t3MQmGQ4Zpg?=
 =?us-ascii?q?y2Oa4l5OYcWgSweggtwT4JDgjIQDBaBY3cBiR8qgQeBGAEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.47,455,1515477600";
   d="scan'208";a="147516033"
X-DLP: DLP_GlobalPCIDSS
To: <lukas@wunner.de>, <kai.heng.feng@canonical.com>
CC: <pali.rohar@gmail.com>, <mjg59@srcf.ucam.org>, <dvhart@infradead.org>,
        <andy@infradead.org>, <tiwai@suse.com>,
        <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: RE: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Topic: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Index: AQHTtr1XC+3UjKIddE2I55hGuXPKiaPIAceAgAAHyYCAAWW9gIABpsRw
Date: Sun, 11 Mar 2018 14:06:15 +0000
Message-ID: <12df9a905ea842498e3fba492fdef59e@ausx13mpc124.AMER.DELL.COM>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <20180310065039.GA6633@wunner.de>
In-Reply-To: <20180310065039.GA6633@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2BE6UiA031784

> -----Original Message-----
> From: Lukas Wunner [mailto:lukas@wunner.de]
> Sent: Saturday, March 10, 2018 2:51 PM
> To: Kai Heng Feng <kai.heng.feng@canonical.com>
> Cc: Pali Rohár <pali.rohar@gmail.com>; mjg59@srcf.ucam.org;
> dvhart@infradead.org; andy@infradead.org; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; tiwai@suse.com; platform-driver-
> x86@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; alsa-
> devel@alsa-project.org
> Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for Dell
> platforms with Switchable Graphics
> 
> On Fri, Mar 09, 2018 at 05:30:15PM +0800, Kai Heng Feng wrote:
> > >On Thursday 08 March 2018 17:10:23 Kai-Heng Feng wrote:
> > >>Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
> > >>"Switchable Graphics" (SG).
> > >>
> > >>When SG is enabled, we have:
> > >>00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
> > >>00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> > >>01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > >>[AMD/ATI] Ellesmere [Polaris10]
> > >>01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> > >>[Radeon RX 580]
> > >>
> > >>The Intel Audio outputs all the sound, including HDMI audio. The audio
> > >>controller comes with AMD graphics doesn't get used.
> > >>
> > >>When SG is disabled, we have:
> > >>00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> > >>01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > >>[AMD/ATI] Ellesmere [Polaris10]
> > >>01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> > >>[Radeon RX 580]
> > >>
> > >>Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> > >>controller, others from Intel audio controller.
> > >>
> > >>When SG is enabled, the unused AMD audio controller still exposes its
> > >>sysfs, so userspace still opens the control file and stream. If
> > >>userspace tries to output sound through the stream, it hangs when
> > >>runtime suspend kicks in:
> > >>[ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
> > >>[ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
> > >>
> > >>Since the discrete audio controller isn't useful when SG enabled, we
> > >>should just disable the device.
> >
> > The platform does have a NVIDIA variant, but the discrete NVIDIA have a
> > audio controller, hence it doesn't have the issue.
> 
> Sorry, I don't quite understand:  The AMD variant *also* has an audio
> controller, so what's the difference?  Or did you mean the Nvidia
> variant *doesn't* have an audio controller?
> 
> Pretty much all modern Nvidia GPUs do have an integrated HDA
> controller, however it's possible to hide it by clearing a bit
> at offset 0x488 in the GPU's config space.  Some BIOSes hide
> the HDA if no external display is attached.
> 
> I could imagine that the BIOS of the Dell machines in question
> hides the HDA if Switchable Graphics is enabled.  If that is the
> case, be aware that there's an ongoing discussion to always expose
> the HDA controller because the behavior of some BIOSes to only
> expose the HDA when a display is attached causes massive problems
> with Linux' HDA driver:
> https://bugs.freedesktop.org/show_bug.cgi?id=75985
> 
> If we decide to always expose the HDA controller on Nvidia cards,
> you may need to also match for the Nvidia vendor ID here.
> 
Like I said I don't know the details on why NVIDIA isn't affected, Kai
Heng will need to comment here.  You might very well be right.

I stand by my point that the heuristic makes sense for what exists
In the kernel today though.  If the point you mention is the reason
why NV isn't affected and this changes in the future it's a simple extra
|| to match NV cards too, or to remove the AMD part of the check
and just look for Dell subsystem vendor instead of AMD product
vendor and Dell subsystem vendor.
