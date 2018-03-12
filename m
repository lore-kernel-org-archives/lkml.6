Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeCLBac (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 21:30:32 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:37370 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932419AbeCLBab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 21:30:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H5AAC016VamMqZ6ERdGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQmfzKDRoofjXCCBHsblDKCFQqFJQIagnchNBgBAgEBAQEBAQIBAhA?=
 =?us-ascii?q?BAQEBAQgLCwYoLoI4IoJKAQEBAwEdBhFFEAIBCBoCHwcCAgJFEAIEAQ0NE4R1C?=
 =?us-ascii?q?KpTgiaIWoIagQ2EKIIugzyCeDaFPoJrgmIEkzmHHQmQWYFthDWISZFIgSweggt?=
 =?us-ascii?q?wgxOCQSKBY4xggRgBAQE?=
X-IPAS-Result: =?us-ascii?q?A2H5AAC016VamMqZ6ERdGgEBAQEBAgEBAQEIAQEBAYQmfzK?=
 =?us-ascii?q?DRoofjXCCBHsblDKCFQqFJQIagnchNBgBAgEBAQEBAQIBAhABAQEBAQgLCwYoL?=
 =?us-ascii?q?oI4IoJKAQEBAwEdBhFFEAIBCBoCHwcCAgJFEAIEAQ0NE4R1CKpTgiaIWoIagQ2?=
 =?us-ascii?q?EKIIugzyCeDaFPoJrgmIEkzmHHQmQWYFthDWISZFIgSweggtwgxOCQSKBY4xgg?=
 =?us-ascii?q?RgBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.47,458,1515477600";
   d="scan'208";a="147699032"
X-DLP: DLP_GlobalPCIDSS
To: <pali.rohar@gmail.com>, <kai.heng.feng@canonical.com>
CC: <mjg59@srcf.ucam.org>, <dvhart@infradead.org>, <andy@infradead.org>,
        <tiwai@suse.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: RE: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Topic: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Index: AQHTtr1XC+3UjKIddE2I55hGuXPKiaPIAceAgAAHyYD//5ufkIAAaMcA//+dHPCAAgPLgIABZOtwgABdgwCAAGHKMA==
Date: Mon, 12 Mar 2018 01:30:28 +0000
Message-ID: <c49f28560996405fa4173a5a492bf201@ausx13mpc124.AMER.DELL.COM>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
 <20180309094600.m24d3zbzdsmls7aw@pali>
 <09eadabb264f401a88b427744505adf8@ausx13mpc124.AMER.DELL.COM>
 <20180310103809.5nnwoulua2u64rku@pali>
 <ea9ab148c4bb45b9ae7369020300b74b@ausx13mpc124.AMER.DELL.COM>
 <20180311143018.u64cldtxuv7divta@pali>
In-Reply-To: <20180311143018.u64cldtxuv7divta@pali>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2C1Ubdl025936

> > I think the missing aspect is that this is only used in AIO and laptop form
> > factors where the discrete graphics is in a non-removable form factor.
> 
> Why we are not checking if kernel is running on AIO or laptop form
> factor then? Or it is not possible?

Kai Heng, can you please confirm if AIO sets chassis type properly?
It should be 0Dh.

If so, then I think as second check for chassis type should be possible for
next version of this patch.

> 
> Basically what I see there is that we need to detect if current HW
> platform has switchable graphics and check how is configured AUDIO MUX.
> 
> But instead of directly checking hw state of audio MUX, we are trying to
> check something different which could get us information of state of the
> audio mux.
> 
> I suspect that we do not have a way how to check audio MUX directly, so
> it needs to be done indirectly -- via some Dell SMBIOS call and some
> other heuristic. This is something which should be specified either in
> comment or in commit message (problem of type: we need X, but check for
> Y).
> 
> And if we are doing this check indirectly, we should do the most
> specific test and not more general.

Right.

> 
> I think that PCI vendor ID check of audio device is more general test
> then checking if kernel is running on Dell laptop (check via DMI). And
> if we can check also if running on AIO or laptop form, then it would be
> more specific test.
> 
> > Running with your hypothetical though, what would happen is if it's
> > on a non-Dell machine the PCI check would pass and then the code
> > would not be executed by dell-laptop (since dell-smbios didn't load).
> 
> Right.
> 
> > If it was on a Dell machine it would load but the BIOS would return
> > either Switchable graphics turned off, or invalid token.
> >
> > Even though these aren't real for switchable graphics on Dell I don't
> > see a problem with either of these situations if it ever came up.
> 
> I see, this solution is working...
> 
> ... but, I see there a very bad precedense. What would happen if another
> laptop manufactor comes with similar solution for hybrid graphics. Does
> it mean that hda audio driver would try to call for every one vendor its
> vendor dependent API function (EFI, SMM, WMI, whatever) to check if
> current HW has some switchable graphics and needs special checks?
> 
> Those vendor dependent API functions (which Dell SMBIOS is) should be
> really called on vendor hardware.
> 
> Otherwise audio drivers would load bunch of the other vendor dependent
> platform modules and all of those modules (except maximally one) just
> return error.
> 

Sure the more specific the check the less symbol requests needed that
will fail.

Kai Heng,

Can you please use Alex Hung's OEM strings patch in your series to match
"Dell System" in OEM strings too?

Between chassis type, OEM strings match, and AMD vendor/Dell subsystem
vendor that should satisfy all of Pali's concerns I think.

If anyone thinks that's too much, please speak up.

> > Compiling a whitelist is a wasted effort because it will have to change
> > Every year for every new platform that has AMD switchable graphics.
> 
> I agree, But see that this patch already uses vendor ID whitelisting.

I mean making a whitelist of all individual affected Dell platforms will grow
each year.  I want to avoid that approach.
