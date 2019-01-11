Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E46C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E8C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfAKUnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:43:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34658 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfAKUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:43:41 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gi3eU-0004Fu-9k; Fri, 11 Jan 2019 21:43:38 +0100
Date:   Fri, 11 Jan 2019 21:43:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: tsc: Fast TSC calibration failed with AMD B350M/Ryzen 3 2200G
In-Reply-To: <9f444c64-c221-e729-7eb5-fc4f093c16d3@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1901112141480.1661@nanos.tec.linutronix.de>
References: <fd05d500-f1b5-7115-4326-7c7fee9f5456@molgen.mpg.de> <alpine.DEB.2.21.1901071622160.2688@nanos.tec.linutronix.de> <9f444c64-c221-e729-7eb5-fc4f093c16d3@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Mon, 7 Jan 2019, Paul Menzel wrote:
> On 01/07/19 16:24, Thomas Gleixner wrote:
> >> Linux 4.19.13 from Debian Sid/unstable logs the message below on the board MSI
> >> MS-7A37/B350M MORTAR with the processor AMD Ryzen 3 2200G.
> >>
> >> As a result, the early time stamps do not seem to be working.
> > 
> >>> [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.I0 11/06/2018
> >>> [    0.000000] tsc: Fast TSC calibration failed
> > 
> > And the further boot log says:
> > 
> > [    0.036000] tsc: Unable to calibrate against PIT
> > [    0.036000] tsc: using HPET reference calibration
> > [    0.036000] tsc: Detected 3500.117 MHz processor
> > 
> > So the quick calibration in early boot fails because the PIT seems not to
> > do what the kernel expects. Nothing we can cure :(
> 
> I see. Can AMD confirm that this is the expected behavior? If yes, should
> the fast TSC calibration be skipped on these devices?

It should work and we really don't want to add cpu family/model based
decisions whether we invoke something or not. Those tables are stale before
they hit mainline.

Thanks,

	tglx
