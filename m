Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161775AbeBNSTU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:19:20 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:3615 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161673AbeBNSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:19:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GiAwBFfIRah8uZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQoEHAoCoNbmCgxgVGBF2oyhmOOWIIDChuBE4QNAhqCY1gUAQI?=
 =?us-ascii?q?BAQEBAQECAQIQAQEBCgsJCCgiDYI4IoE0WzsBAQEBAgEjEUUMBAIBCBEEAQEBA?=
 =?us-ascii?q?gIjAwICAh8lAQgIAgQBDQUIihUDDQivYIInh0INgTKCEwEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAR2BD4NzghWGbYJrgX8EOxAjgl2CZQWKZYlfjzY1CYggiFqFAoIoZ?=
 =?us-ascii?q?4VDi3yOSoVQAYN+gTw2gXNwgxgJgkwQDIIGeIsZKoEKgRkBAQE?=
X-IPAS-Result: =?us-ascii?q?A2GiAwBFfIRah8uZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?oEHAoCoNbmCgxgVGBF2oyhmOOWIIDChuBE4QNAhqCY1gUAQIBAQEBAQECAQIQA?=
 =?us-ascii?q?QEBCgsJCCgiDYI4IoE0WzsBAQEBAgEjEUUMBAIBCBEEAQEBAgIjAwICAh8lAQg?=
 =?us-ascii?q?IAgQBDQUIihUDDQivYIInh0INgTKCEwEBAQEBAQEBAQEBAQEBAQEBAQEBAR2BD?=
 =?us-ascii?q?4NzghWGbYJrgX8EOxAjgl2CZQWKZYlfjzY1CYggiFqFAoIoZ4VDi3yOSoVQAYN?=
 =?us-ascii?q?+gTw2gXNwgxgJgkwQDIIGeIsZKoEKgRkBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.46,513,1511848800";
   d="scan'208";a="1216020686"
X-DLP: DLP_GlobalPCIDSS
To: <pmenzel+linux-input@molgen.mpg.de>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <it+linux-input@molgen.mpg.de>, <linux@leemhuis.info>
Subject: RE: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13
 9360
Thread-Topic: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13
 9360
Thread-Index: AQHTpbKybUmpckaH40yGvHCktg4tlqOkIKZg
Date: Wed, 14 Feb 2018 17:11:40 +0000
Message-ID: <609c1f35df7346da8ac1d12c35e04cf7@ausx13mpc120.AMER.DELL.COM>
References: <5a74e1a7-2083-c6b2-f51a-f44908ac8bc4@molgen.mpg.de>
 <20180130175017.72inurhk5l7tcvae@dtor-ws>
 <20180130180736.ehucqywbz7zdl4v7@dtor-ws>
 <f02b699d-b130-c09f-3e09-db62ecf2df2c@molgen.mpg.de>
In-Reply-To: <f02b699d-b130-c09f-3e09-db62ecf2df2c@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1EIJPgj016108



> -----Original Message-----
> From: Paul Menzel [mailto:pmenzel+linux-input@molgen.mpg.de]
> Sent: Wednesday, February 14, 2018 10:41 AM
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; it+linux-
> input@molgen.mpg.de; Limonciello, Mario <Mario_Limonciello@Dell.com>;
> Thorsten Leemhuis <linux@leemhuis.info>
> Subject: Re: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13 9360
> 
> Dear Dmitry,
> 
> 
> On 01/30/18 19:07, Dmitry Torokhov wrote:
> > On Tue, Jan 30, 2018 at 09:52:45AM -0800, Dmitry Torokhov wrote:
> 
> >> On Tue, Jan 30, 2018 at 06:36:34PM +0100, Paul Menzel wrote:
> 
> >>> I do not know, when it started, but with Linux 4.14-rc8 and 4.15,
> >>> benchmarking suspend and resume time with `sleepgraph.py` [1][2], there is a
> >>> regression, that i8042 AUX port [serio1] suspend takes a second on Dell XPS
> >>> 13 9360 and TUXEDO Book 1406.
> >>
> >> It would be really helpful to know when the regression started.
> >
> > So the reason it takes longer is because the touchpad does not want to
> > talk to us for some reason and we wait until commands time out:
> >
> > [   94.591636] calling  serio1+ @ 2299, parent: i8042
> > [   94.794292] psmouse serio1: Failed to disable mouse on isa0060/serio1
> > [   95.593303] call serio1+ returned 0 after 974280 usecs
> >
> > but it is not clear why it happens, I do not think we changed anything
> > in that path for a while, so it might be some other change affecting
> > things indirectly. I'm afraid you'll have to narrow the scope, and
> > ideally bisect.

Please keep in mind the XPS 9360 has a touchpad that can operate in I2C
or PS2 modes.  It's connected to both buses and with the right initialization
sequence will come up in I2C mode.

Assuming Paul M. has compiled and used hid-multitouch and i2c-hid the
touchpad should be operating in I2C mode.

When this happens I expect that the touchpad shouldn't be responding
to PS2 commands.

As a debugging tactic, you may consider to unload psmouse before
suspend and still see the touchpad operational.

> 
> Thank you for your replies. First of all, it looks like *only* the Dell
> system is effected as I was unable to reproduce it on the TUXEDO Book
> 1406. I have to verify that by finding old log files.

Does this other laptop you are drawing a comparison to also have a 
touchpad that can operate in multiple modes?

To make an accurate comparison you should determine what mode it's in.

> 
> Starting the bisect between 4.14 and 4.15-rc1 it turns out, that the
> problem is also reproducible with 4.14, and I remembered wrong. Looking
> more into it, I could also reproduce it with Linux 4.13.0-32-generic
> from Ubuntu 16.04 (Hardware Enablement Stack). But my old logs do not
> show the problem. As the UEFI firmware was updated to version 2.5.0 in
> the meantime, it could also be related to that.
> 
> So it turns out, with 4.16-rc1 I see this delay/failure message only
> during the first suspend. Suspending a second time, I do not see the
> message.
> 
> Any hints how to debug this further are much appreciated. Could it be
> related to the embedded controller?
> 
> 
> Kind regards,
> 
> Paul
