Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B4BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C109217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYesw6QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfAVU6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:58:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37846 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:58:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id s13so25006658otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MhA3sbHOTHi1Xy14xK0EAulnyAOLp5GkUDx/l5Bl5MA=;
        b=RYesw6QWJLPj31ULKwfhDnf0R6D+ltHe/nRYgXULplWu7J3a3dgrvKZWhbThqnB+zj
         QgDTMKtHt3QzmKvvU6tBwWiMEIEfPoG6rYWqBZSMyFHsrbil2fcGbyv6cs/CffiWhQJC
         T8rWfMWbbfKyQppbc/QrOkcN31kD0uK2z/RMSgr3/QvYJBJQYCjT4grUGCLtXQ5pkiKo
         p2Y52Z8VLnKlvH7vhcSDoI1TgT2PX8YDdn7/e6Lrj2+/NKstmgifyNOebJfansMqPyeV
         iwiPul43KljtX4mcyfb4nQeodtSGs50+TnIwJXwtPMfnDIMuS6l2aTYub2eEFw1TMYbV
         uVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=MhA3sbHOTHi1Xy14xK0EAulnyAOLp5GkUDx/l5Bl5MA=;
        b=NBpjbVAxoOAHx6vS4yN9w1xuYQC3V2LAj+a5ZTD4A4qiC8Em04GlLwuSZWNP9espkT
         xB1ilfD22tO3MtQ9AehdyTm7oWu9Vv0PdyDKJR0esugHopRZ59QfRHio+p0gvywEzmjt
         PjAmZyM/Q+anTdqYXOn22k3JYSPVHuVnz5ayTpQvJmiFVGEd/0baJ0sIIZ0BV5R9DRb6
         Um825yFyi5ezdjMn5YVyIrQ6cgJwGV5Oi6FB5aFI+2Pj1VOO5rHM5125P4iD/bRSkHfs
         tjaD85+ENj5oJwu72oal5/M2/1NIpsNtajxTXKEOxBOSYnA1DIZHCJB/HnDCEucVpgbg
         SABg==
X-Gm-Message-State: AJcUukf9Cjied/3GaRErDSQRkOFVEgGIeTDEFxa0/TRNCkx3zjhhMJNy
        eq9spflhv0iQ29oFX0LGtQ==
X-Google-Smtp-Source: ALg8bN7Rd8y8jkS+CyoScd1G/Wmy7P49hM/8WkocwVbMNb2hT/3Y08RFBSbUmL7N9X9PNQ0uNmUgqA==
X-Received: by 2002:a9d:18f:: with SMTP id e15mr24345482ote.84.1548190717000;
        Tue, 22 Jan 2019 12:58:37 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id q128sm7938801oia.4.2019.01.22.12.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 12:58:36 -0800 (PST)
Received: from [IPv6:2001:470:b8f6:1b:a64e:31ff:fe14:d744] (unknown [IPv6:2001:470:b8f6:1b:a64e:31ff:fe14:d744])
        by serve.minyard.net (Postfix) with ESMTPSA id EE2FD3A0;
        Tue, 22 Jan 2019 14:58:35 -0600 (CST)
Reply-To: minyard@acm.org
Subject: Re: ipmi_si: 90 s delay in system start with 4.14.94, but not 4.18.6
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Cc:     it+lkml@molgen.mpg.de
References: <8520014d-6805-ce87-143d-fffbeb94d11d@molgen.mpg.de>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <78de72f8-e218-f91f-97b2-768ff5a920e4@acm.org>
Date:   Tue, 22 Jan 2019 14:58:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8520014d-6805-ce87-143d-fffbeb94d11d@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 10:17 AM, Paul Menzel wrote:
> Dear Linux folks,
>
>
> Using Linux 4.14.94 on a HP EliteDesk 705 G4 MT desktop system, there
> is a 100 s delay during boot.
>
> ```
> [    0.000000] Linux version 4.14.94.mx64.239 (root@x.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Mon Jan 21 11:39:45 CET 2019
> […]
> [    3.263092] ipmi message handler version 39.2
> [    3.263520] ipmi device interface
> [    3.263893] IPMI System Interface driver.
> [    3.264325] ipmi_si 0000:06:00.3: probing via PCI
> [    3.264804] ipmi_si 0000:06:00.3: [io  0x3000-0x30ff] regsize 1 spacing 1 irq 39
> [    3.265496] ipmi_si: Adding PCI-specified kcs state machine
> [    3.266019] ipmi_si: Trying PCI-specified kcs state machine at i/o address 0x3000, slave address 0x0, irq 39
> [    4.255042] tsc: Refined TSC clocksource calibration: 3593.250 MHz
> [    4.255618] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33cb6addeae, max_idle_ns: 440795225061 ns
> [    5.264130] clocksource: Switched to clocksource tsc
> [  104.978023] ipmi_si 0000:06:00.3: There appears to be no BMC at this location
> [  104.978658] IPMI Watchdog: driver initialized
> [  104.979095] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
> […]
> ```
>
> Testing Linux 4.18.6 and 4.20, there is no such delay.
>
> ```
> [    0.000000] Linux version 4.18.6.mx64.221 (root@x.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Thu Sep 6 07:51:05 CEST 2018
> […]
> [    2.951174] ipmi message handler version 39.2
> [    2.951604] ipmi device interface
> [    2.951973] IPMI System Interface driver.
> [    2.952404] ipmi_si: Unable to find any System Interface(s)
> [    2.952909] IPMI Watchdog: driver initialized
> [    2.953339] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
> [    2.954053] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> […]
> ```
>
> Do you have a suggestion, what commit might have fixed this? Quickly
> going through the commit history, it looks like, last year a lot of
> bug fixes and clean-up was done.

That's really strange.  Generally when something like this happens, it
means that there is sort of an IPMI interface there, but it's not complete.
This happens when the low-level hardware is there, but there is no
processor behind it to actually do anything.

But as you can see, in 4.18 it wasn't detecting anything, and in 4.19
it is seeing an IPMI device on the PCI bus.  The discovery here is done
by the PCI code, it's out of the IPMI drivers hands until the PCI code
delivers it.

So what I'm guessing is that something changed so that the PCI
code is now recognising that there is an IPMI device there by the
PCI class codes.  There really isn't a device completely there, so
it doesn't work.

I don't see anything in the IPMI code that would cause that.

If this is a problem, the device can be blacklisted in
ipmi_pci_blacklist in ipmi_si_pci.c.

-corey


>
> If nobody knows, I might bisect to find the commit fixing this, but
> will probably put more effort into updating the system to the Linux
> 4.19 series, where the only problem holding us back is that Nvidia’s
> driver 390.87 needs to be patched.
>
>
> Kind regards,
>
> Paul


