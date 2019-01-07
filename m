Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93088C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B222087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfAGPYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:24:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfAGPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:24:31 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ggWlP-00042H-5g; Mon, 07 Jan 2019 16:24:27 +0100
Date:   Mon, 7 Jan 2019 16:24:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: tsc: Fast TSC calibration failed with AMD B350M/Ryzen 3 2200G
In-Reply-To: <fd05d500-f1b5-7115-4326-7c7fee9f5456@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1901071622160.2688@nanos.tec.linutronix.de>
References: <fd05d500-f1b5-7115-4326-7c7fee9f5456@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Mon, 31 Dec 2018, Paul Menzel wrote:

> Linux 4.19.13 from Debian Sid/unstable logs the message below on the board MSI
> MS-7A37/B350M MORTAR with the processor AMD Ryzen 3 2200G.
> 
> As a result, the early time stamps do not seem to be working.

> > [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7A37/B350M MORTAR
> > (MS-7A37), BIOS 1.I0 11/06/2018
> > [    0.000000] tsc: Fast TSC calibration failed

And the further boot log says:

[    0.036000] tsc: Unable to calibrate against PIT
[    0.036000] tsc: using HPET reference calibration
[    0.036000] tsc: Detected 3500.117 MHz processor

So the quick calibration in early boot fails because the PIT seems not to
do what the kernel expects. Nothing we can cure :(

Thanks,

	tglx


