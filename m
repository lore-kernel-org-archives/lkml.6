Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575C02086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3PbDxSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575C02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbeKQNPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:15:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37281 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:15:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so9577764pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 19:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Sc/M36Ei74RaPEa3/A8ZDHIQzv2c1MVSO4ZjZr6oH4c=;
        b=N3PbDxSU4xQV5FRoRjIV5ocUEKL2WT3unxllxxfftO3bStY5VEG2UcVGp5R/cZfA9Q
         ifWb1Yof5gzGk9a9yZwPtJOWV2Rvrtyq7J4i6/NdZ7A9nP7OfhCDD171OM1cclwM6RC2
         xqkRSP3fDmxhJtWyKRJTIbNxl2t7RkZL9iQE7gtMeiPs2EDaJRVEDAmVxFffdHG8q8Qg
         FOJOGGrnwVkn/2ac6aVqyfjcNmO2W4xy0xpWqwkyRNF2tIFvSf+op5rxQQkHYm0nwB8A
         k8Kjs05HRAfxtjjO5zxzeN4zhe0khmidGshByA9yy2gLFQ6ENaX+i8zOQwCahZwvmww7
         alRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Sc/M36Ei74RaPEa3/A8ZDHIQzv2c1MVSO4ZjZr6oH4c=;
        b=TTF6T0zymX8/C71kKHQH19rJlcSkpHcYfiaaoeNv8Y4fGoXbud7AXOqWJCbGTt0WGv
         8spRMYOnzAwQ/8Fcld0anAL+4s06JAYnKmb4+Gcz6G2FZMAoqj5EvHV5H7xgC38CXjYr
         V/VelP0NckEvS7hWylLAlmQrLa0z4f41HwnjezuROI7qFS/1b2/0ViOqNh0k1ZAYp78u
         bxieiJ8++OB139+X84jVvZssnxgfnt9MvgpZ13FCXUblBaIC+1UZfcJKdqE8X4lRAVZ/
         PE0ot7MwAslcgHYNKbZDVwzdR3amBYs0c5rrn3/qtax45Gv6gGOrYD22SrZ4jNupmsqc
         hAyA==
X-Gm-Message-State: AGRZ1gKooyr1Cgo9OCYOUpEdahAxmKJys8oJ1PVTgWZXa5dD2nUpPo6k
        sVd69EkMvp5jNHVHvITRX4E=
X-Google-Smtp-Source: AJdET5cgEPlrM2jXj/p6YHxEcExPw/3a+I6rWlEOw6gUxvsNZIbt0AMp/2tvazf9wH+kGCMMp57TtQ==
X-Received: by 2002:a63:6dc8:: with SMTP id i191mr11852668pgc.215.1542423647845;
        Fri, 16 Nov 2018 19:00:47 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id q187sm6087950pfq.128.2018.11.16.19.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 19:00:47 -0800 (PST)
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
To:     Finn Thain <fthain@telegraphics.com.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811151427210.19@nippy.intranet>
 <20181116174705.GY30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811170934300.45@nippy.intranet>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e6b5fffd-1d40-494d-d59b-f98f3c6c9655@gmail.com>
Date:   Sat, 17 Nov 2018 16:00:39 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1811170934300.45@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 17.11.2018 um 11:49 schrieb Finn Thain:
> On Fri, 16 Nov 2018, Russell King - ARM Linux wrote:
>
>>
>> The EBSA110 is probably in a similar boat - I don't remember whether it
>> had 16MB or 32MB as the maximal amount of memory, but memory was getting
>> tight with some kernels even running a minimalist userspace.
>>
>> So, it's probably time to say goodbyte to the kernel support for these
>> platforms.
>>
>
> Your call.
>
> Note that removing code from mainline won't help users obtain older,
> smaller, -stable kernel releases, free from the bug we were discussing.
> (The bug appeared in Linux v2.6.32.)
>
> BTW, if you did want to boot Linux on a 16 MB system, you do have some
> options.
>
> https://lwn.net/Articles/741494/
> https://lwn.net/Articles/608945/
> https://tiny.wiki.kernel.org/
>
> Contributing to this kind of effort probably has value for IoT
> deployments. I suspect it also cuts a small amount of bloat from a large
> number of other Linux systems.

I boot 4.19 on a system with 14 MB RAM - 10 MB remain for user space 
once the kernel loads. After remote login, 4 MB of that remain free for 
buffers or user code (1.5 MB swapped).
That's with sysvinit - Christian tried to boot a systemd userland on his 
Falcon once, and ran out of memory before swap could be activated.

I shouldn't say 16 or 32 MB are hopeless. And the 2.6 kernels were a lot 
more sluggish to my recollection.

Cheers,

	Michael
