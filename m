Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8599C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8551A2251D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMkFVnKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8551A2251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeKOG0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:26:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39613 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeKOG0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:26:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so15960920wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 12:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:openpgp:autocrypt:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Jy5+/IDXwPCi5wHf9F6g1wlcvfAGUXnucA4Dw2acufU=;
        b=KMkFVnKtgIZzYzr77rdtxOuhTwJPdYrl+n/2YBGRY/YBEqYfL+x7d8TjWi/XSPFdau
         gFWW24SeP8NPhIFYCzgLYUe9IDChE68MhtYQJGSONCB6t6hpH8bfh7aR+7IhshAW1mjq
         PCnt0Ow3UAJ1GFmBvOWyIZjNzmhYInyzZqzhPOFkRMOEtSXuUj8GttvEuctkUsUd+aqz
         cbx5upekgp9QTFcrnNcIW2U3z6mBbF6eGsEomHwIWoMuqKgw0uH542BjVRiunY1vBCAV
         6cN+hCyErjz3Ne+z5MFn9rIt8ydqbW6JHm9BkSf6eX4Nhzxtwphd/bLdKU7FaDL89QAM
         1Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:openpgp:autocrypt:to:cc:subject:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=Jy5+/IDXwPCi5wHf9F6g1wlcvfAGUXnucA4Dw2acufU=;
        b=ofYUTuHp/oW9doG8gQF/+UeGDUSajiYW+9hS8Z63N0vsIvTH//UH4DADQUYO+nYJjn
         2h6msBsUcepqZItG2gYj74oRrb5LXUNaOOH+FT/qEkDE0B4ZG39QZiQZX9iaRpPNRNfP
         CshaME8wlMVnn99UnSmphqKqOCMWxQJmwuB/0r2/5BIwwZgdfV85t0b/I8GvQcUoWBmb
         j9++wQfbDYkyNX+n/6vr82RscJLg6L0UhWWKzF8bnax1kvCB9jeTHPUMRX+hZ6npMf2J
         4e9vJ8jdDHezu7/WAM/R6JdGHrBZSr0uKJA9xg2hO3PL1GALIfTqDW0vfwTx6dHKFd/K
         6OYw==
X-Gm-Message-State: AGRZ1gI1ePiDmjEn45BJrge3znjL5CET4eOJ81i6n14fBtcxt8lOztT8
        x574vVBiNk6S+kzSMx6S9QA=
X-Google-Smtp-Source: AJdET5daLdoMzNn5wqAERJ6jzF2q/vEQNICSJUe7//7T8VFoAPJrMDKhybGPAp9OkmAr4yRvDFQBtA==
X-Received: by 2002:a1c:4683:: with SMTP id t125-v6mr3249324wma.112.1542226881625;
        Wed, 14 Nov 2018 12:21:21 -0800 (PST)
Received: from [10.67.49.62] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x14sm9568983wrm.65.2018.11.14.12.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 12:21:20 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, will.deacon@arm.com
Cc:     al.cooperx@gmail.com, tony@atomide.com, linux@armlinux.org.uk
Subject: ARM builtin perf tests for breakpoint failures
Message-ID: <2433ea10-8bdc-f9bc-8d53-f6bda4018564@gmail.com>
Date:   Wed, 14 Nov 2018 12:21:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Will,

I have been trying to debug some perf builtin tests on ARM 32-bit and
found that "Breakpoint overflow signal handler" and "Breakpoint overflow
sampling" were failing, but there are a number of reasons for that and
they may fail in seemingly unexpected ways.

My perf binary is built in Thumb2 because that is what the toolchain
produces by default. Going through the rabbit hole, I found the
following failure scenarios.

1) If __test_function()'s addresss has the Thumb bit set, then we set a
breakpoint length (bp_len = sizeof(long)) which makes us fail to
validate the event in hw_breakpoint_arch_parse() and we return -EINVAL
from SYS_perf_event_open(). This is because the offset computed has a
value of 1 (function address is e.g:  0x0004c169), but we requested a
bp_len of 4. The test fails right away.

2) If we correct the test such that if addr & 1 == true then we set
bp_len = 2, then we can see that the test runs to completion, but the
perf breakpoint event count returns 0 and indeed, no SIGIO is ever
delivered. This is presumably because of the alignment_mask value of 0x3
in hw_breakpoint_arch_parse() which would strip the Thumb bit and not
allow matching it when set assign info->address &= ~alignment_mask. We
would indeed not have the HW hit that breakpoint at all.

3) If we keep the fix from 2) and also change the the alignment_mask to
0x2 to preserve the Thumb bit, then we can run into what is described as
4) below.

4) if __test_function()'s address does not have the Thumb bit set (which
surprisingly can happen even if test_function does, go figure), then we
will set a bp_len = 4, and then we are just stuck in an infinite SIGIO
delivery that looks like this:

[pid  1859] perf_event_open(0xbebee790, 0, -1, -1, 0x8 /* PERF_FLAG_???
*/) = 3
[pid  1859] fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC) = 0
[pid  1859] fcntl64(3, F_SETSIG, 0x1d)  = 0
[pid  1859] fcntl64(3, F_SETOWN, 1859)  = 0
[pid  1859] ioctl(3, PERF_EVENT_IOC_RESET, 0) = 0
[pid  1859] ioctl(3, PERF_EVENT_IOC_ENABLE, 0) = 0
[pid  1859] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
[pid  1859] rt_sigreturn()

and on and on, we can't even see gettimeofday() begin called in that case.

This is observable on both 4.9.135 and 4.19 on ARMv7 and ARMv8 CPUs
running in AArch32.

I am not clear how to fix that properly, since there appears to be a
nesting of problems here.

Thanks!
-- 
Florian
