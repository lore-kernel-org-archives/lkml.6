Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FBF20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FBF20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeKXHaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:30:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51205 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKXHaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:30:23 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQIJA-0006ic-SU; Fri, 23 Nov 2018 21:44:13 +0100
Date:   Fri, 23 Nov 2018 21:44:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     hpa@zytor.com
cc:     Guenter Roeck <linux@roeck-us.net>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
In-Reply-To: <62E011F5-639B-4CF9-8A8B-091C84749F43@zytor.com>
Message-ID: <alpine.DEB.2.21.1811232143000.1684@nanos.tec.linutronix.de>
References: <20181119184556.11479-1-bp@alien8.de> <20181123200307.GA6223@roeck-us.net> <62E011F5-639B-4CF9-8A8B-091C84749F43@zytor.com>
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

On Fri, 23 Nov 2018, hpa@zytor.com wrote:
> On November 23, 2018 12:03:07 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> ># first bad commit: [2e94061096c5c3aa6c3fe3ec2bec176c1f9c1b07] x86/TSC:
> >Use RDTSCP
> 
> Right, because that cpu predates RDTSCP, so it needs to use a fallback.

Well, that's not the problem.

The default here is MFENCE; RDTSC; But P3 does not have MFENCE either :)

We need alternative_3 with default RDTSC

Thanks,

	tglx

