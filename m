Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeCIJeh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:34:37 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:59587 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751167AbeCIJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:34:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FjAADUU6Jah8qZ6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmfygKg0aKHo13ggKBFocejQyCFQqFJQIagnUhNBgBAgEBAQE?=
 =?us-ascii?q?BAQIBAhABAQEIDQkIKC6COCKCSgEBAQEDIwQNOgsMBAIBCBEBAwEBAQICHwQDA?=
 =?us-ascii?q?gICHyUBAgEFCAIEAQ0FCIR5AxWsQYFsOocqDYEwghqBDoQogi6DPIMtgmqCJRk?=
 =?us-ascii?q?QIQKCT4JiBI1/jCUxCY0ygy2Oa4oyhxWBLB6CC3BPgkOCMRAMFoFldwGIQyqBB?=
 =?us-ascii?q?4EXAQEB?=
X-IPAS-Result: =?us-ascii?q?A2FjAADUU6Jah8qZ6EReGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mfygKg0aKHo13ggKBFocejQyCFQqFJQIagnUhNBgBAgEBAQEBAQIBAhABAQEID?=
 =?us-ascii?q?QkIKC6COCKCSgEBAQEDIwQNOgsMBAIBCBEBAwEBAQICHwQDAgICHyUBAgEFCAI?=
 =?us-ascii?q?EAQ0FCIR5AxWsQYFsOocqDYEwghqBDoQogi6DPIMtgmqCJRkQIQKCT4JiBI1/j?=
 =?us-ascii?q?CUxCY0ygy2Oa4oyhxWBLB6CC3BPgkOCMRAMFoFldwGIQyqBB4EXAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.47,444,1515477600";
   d="scan'208";a="147432509"
X-DLP: DLP_GlobalPCIDSS
To: <kai.heng.feng@canonical.com>, <pali.rohar@gmail.com>
CC: <mjg59@srcf.ucam.org>, <dvhart@infradead.org>, <andy@infradead.org>,
        <tiwai@suse.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: RE: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Topic: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Index: AQHTtr1XC+3UjKIddE2I55hGuXPKiaPIAceAgAAHyYD//5ufkA==
Date: Fri, 9 Mar 2018 09:34:01 +0000
Message-ID: <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
In-Reply-To: <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w299YjuV021474

> -----Original Message-----
> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Friday, March 9, 2018 5:30 PM
> To: Pali Rohár <pali.rohar@gmail.com>
> Cc: mjg59@srcf.ucam.org; dvhart@infradead.org; andy@infradead.org;
> Limonciello, Mario <Mario_Limonciello@Dell.com>; tiwai@suse.com; platform-
> driver-x86@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for Dell
> platforms with Switchable Graphics
> 
> 
> > On Mar 9, 2018, at 5:02 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Thursday 08 March 2018 17:10:23 Kai-Heng Feng wrote:
> >> Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
> >> "Switchable Graphics" (SG).
> >>
> >> When SG is enabled, we have:
> >> 00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
> >> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> >> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >> [AMD/ATI] Ellesmere [Polaris10]
> >> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> >> [Radeon RX 580]
> >>
> >> The Intel Audio outputs all the sound, including HDMI audio. The audio
> >> controller comes with AMD graphics doesn't get used.
> >>
> >> When SG is disabled, we have:
> >> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> >> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >> [AMD/ATI] Ellesmere [Polaris10]
> >> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> >> [Radeon RX 580]
> >>
> >> Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> >> controller, others from Intel audio controller.
> >>
> >> When SG is enabled, the unused AMD audio controller still exposes its
> >> sysfs, so userspace still opens the control file and stream. If
> >> userspace tries to output sound through the stream, it hangs when
> >> runtime suspend kicks in:
> >> [ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
> >> [ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
> >>
> >> Since the discrete audio controller isn't useful when SG enabled, we
> >> should just disable the device.
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> v2: Mario suggested to squash the HDA part into the same series.
> >>
> >>  sound/pci/hda/hda_intel.c | 35 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >>
> >> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> >> index 96143df19b21..8e3e8b88624a 100644
> >> --- a/sound/pci/hda/hda_intel.c
> >> +++ b/sound/pci/hda/hda_intel.c
> >> @@ -49,6 +49,7 @@
> >>  #include <linux/clocksource.h>
> >>  #include <linux/time.h>
> >>  #include <linux/completion.h>
> >> +#include <linux/dell-common.h>
> >>
> >>  #ifdef CONFIG_X86
> >>  /* for snoop control */
> >> @@ -1620,6 +1621,35 @@ static void check_msi(struct azx *chip)
> >>  	}
> >>  }
> >>
> >> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
> >> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> >> +{
> >> +	static int (*dell_switchable_gfx_enabled_func)(bool *);
> >> +	bool enabled;
> >> +	int err;
> >> +
> >> +	if (pdev->vendor != PCI_VENDOR_ID_ATI ||
> >> +	    pdev->subsystem_vendor != PCI_VENDOR_ID_DELL)
> >> +		return false;
> >
> > Are you sure that you want to do this check unconditionally on all
> > machines which have enabled CONFIG_DELL_LAPTOP?
> >
> > Subvendor ID_DELL for dell specific code is not suspicious, but ID_ATI
> > is. What would happen if ATI vendor changes to NVIDIA or other which is
> > not related to Dell?
> 
> We only check it when it's both ATI and DELL, otherwise just return false?
> 
> The platform does have a NVIDIA variant, but the discrete NVIDIA have a
> audio controller, hence it doesn't have the issue.
> The issue only happens to AMD/ATI configs with "Switchable Graphics" option.
> 

Pali is your concern that this code for matching vendor/subsystem is running
on non-Dell too?  The only other recommendation I think that can be to restrict
to matching Dell OEM strings in SMBIOS table, but I don't think that's any better
than the matching for VID/SSVID.

> >
> > Interesting question would be, how handle this situation Windows?
> 
> I don't know how this platform handles this on Windows, I guess we need
> Mario to shed some lights here.

Sorry I don't have this information to share.   I don't think it's too useful here
anyway though because Windows driver architecture is much different in this
area.
