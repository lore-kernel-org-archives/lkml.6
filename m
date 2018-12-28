Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E300208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBeZWapy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeL1Get (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 01:34:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34496 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeL1Ges (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 01:34:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so20149286wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 22:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sI4UaXv0crGpLnwjpk3s9vZ+Cd+E/Ogl+e3Oo6KsdyY=;
        b=nBeZWapyHMOobkiZuM71l7xZg4d7kQKIfVuBs8gOp4nhJ7/shaHrpbEPGF3lEy4BIQ
         bkBNWwkGNZjZ9rkSyGqQgo/jvTL1wKbHkMIVMMRWHhonvux4Ear5H/YS0nvfkp2+9qTA
         YbaK/lxGu7fGxMsOtj8702bJZs30vNRt6B3kQ6Fw+obHb6wsjYYFVioq0SDy4N9aQUeu
         lCDeQ8DOaaZPL84w+3V6NwazgwYkR0H/ltYlbimdIFdcciAItNoVUjnA60CC4NlHLj25
         d1HHOpTbNqn/Vqq2oIkLYGo5XxguDPqvximfqnzFmc/npNXaB8NZqVsJ4YESzTJlaD3a
         yZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sI4UaXv0crGpLnwjpk3s9vZ+Cd+E/Ogl+e3Oo6KsdyY=;
        b=rgGb21L7bxDVvewbxxK93ORPtnazHmCTDECXS4A1veBNNGnrGrBOqDIryZYyP2eOtW
         4bZa1V7xm+Kb+nzvODF/EGwi0ffv55NC/5ffLergBpJIYnF5lNrLtm2K2PDDKIKmIRIi
         hHEapiWTi8aKj49U3ViYO9styueAvbR36/Sw+jSZqx3O1ughhVaa0axyuVCQuDpIZYLq
         JomlWFEOkOMbQ3MHOtwiT5AK/mdOhdb7WWqr2xO1uq05Hqnce+12Gh58OHYVB21sX7Ma
         9AgCNsshq4uFuaG8wwnN1kPpKmdoofvPbwYz7bt9hChTe5QVErpWNHDSKFY8N8YN7ETm
         4ioA==
X-Gm-Message-State: AJcUukfTUGI8rvoTZwoQaN1AZ9uGfGpKhUyOCe9Knhvx7BwoPbKHSvWd
        Ic5OZWH5iYZsgqskz4BwZf8=
X-Google-Smtp-Source: ALg8bN6HKRf5c1ZAeGLXJoenp9suTL7A8U80Zkz0yOHWyVkvZ4utgINo0YM4nQCImh5ApHsI/cZjhg==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr22921457wrd.20.1545978886043;
        Thu, 27 Dec 2018 22:34:46 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:2979:4edf:61e9:6fb9? (p200300EA8BCFE30029794EDF61E96FB9.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:2979:4edf:61e9:6fb9])
        by smtp.googlemail.com with ESMTPSA id q3sm32685219wrn.84.2018.12.27.22.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 22:34:45 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
 <20181228013109.GB3749@lerouge>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d9647487-28db-d138-ae3e-3fd0d2fbe589@gmail.com>
Date:   Fri, 28 Dec 2018 07:34:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181228013109.GB3749@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.12.2018 02:31, Frederic Weisbecker wrote:
> On Fri, Dec 28, 2018 at 12:11:12AM +0100, Heiner Kallweit wrote:
>>
[...]
> 
> Interesting, the softirq is raised from hardirq but it's not handled in the end of
> the IRQ. Are you running threaded IRQS by any chance? If so I would expect ksoftirqd
> to handle the pending work before we go idle. However I can imagine a small window
> where such an expectation may not be met: if the softirq is raised after the ksoftirqd
> thread is parked (CPUHP_AP_SMPBOOT_THREADS), which is right before we disable the CPU
> (CPUHP_TEARDOWN_CPU).
> 
I have a network driver (r8169) using NAPI which runs in softirq context AFAIK.
For testing purposes I sometimes trigger system suspend via network, so there is
network adapter activity when system suspends. Apart from that nothing really
exciting:
            CPU0       CPU1       CPU2       CPU3
   0:         43          0          0          0   IO-APIC    2-edge      timer
   1:          4          0          0          0   IO-APIC    1-edge      i8042
   8:          0          1          0          0   IO-APIC    8-fasteoi   rtc0
   9:          0          0          0          0   IO-APIC    9-fasteoi   acpi
  12:          0          0          0          5   IO-APIC   12-edge      i8042
 120:          0          0          0          0   PCI-MSI 311296-edge      PCIe PME
 121:          0          0          0          0   PCI-MSI 315392-edge      PCIe PME
 122:          0          0          0          0   PCI-MSI 327680-edge      PCIe PME
 123:          0          0       3328          0   PCI-MSI 294912-edge      ahci[0000:00:12.0]
 124:          0        133          0          0   PCI-MSI 344064-edge      xhci_hcd
 125:          0          0         32          0   PCI-MSI 245760-edge      mei_me
 127:        381          0          0          0   PCI-MSI 1572864-edge      enp3s0
 128:          0          0          0        236   PCI-MSI 32768-edge      i915
 129:          0        374          0          0   PCI-MSI 229376-edge      snd_hda_intel:card0

> I don't know if we can afford to ignore a softirq even at this late stage. We should
> probably avoid leaking any. So here is a possible fix, if you don't mind trying:
> 
I tested your patch and at least in the first minutes of testing couldn't reproduce
the issue any longer. I tested manual system suspend and the following script you
sent when we started to analyze the issue.

Heiner

--------------------------------------------------------------------------

#!/bin/bash

do_hotplug()
{
	for i in $(seq 1 $2)
	do
		echo $1 > /sys/devices/system/cpu/cpu$i/online
	done
}

LAST_CPU=$(($(nproc)-1))

while true
do
	do_hotplug 0 $LAST_CPU
	do_hotplug 1 $LAST_CPU
done
