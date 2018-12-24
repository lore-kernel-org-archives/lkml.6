Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA6C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED1A217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+06A+gX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbeLXVLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:11:16 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34698 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 16:11:15 -0500
Received: by mail-wr1-f49.google.com with SMTP id j2so12507033wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 13:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iLzFhcDitj7H4o30ARzCc6mWmBomakBjOI+RpH3RyaQ=;
        b=X+06A+gXvgvUuny1xIAY4k7k5zGsy60cXhsxTP4sQLKCDvMuKWv/1TNj4GGb8J7sOw
         oaJtAAd0KTHFCHvwfHVLrSacHFFrR4nCG+GMaZoMWKXmwOzNzX0roeHGMtKhTqjP26lN
         oak8zv0jyBGg+WoAzMr7NXrcKDg8NN/yE+ZIVo3Sa6iGpE3+H/sPJpaiOOzGXETvYwgS
         xEeYDFpCp4ystvzdv1divSfdpSe+yPuBRWJHTMQ55oEhqJtOturJe2jIJZaQ1rNTVYZo
         9DEqnWthfwJQ/8iFBy5KPXalzParjI5FCPDyf5V3BfGugvf+JxG63RAf8IWYXLPf/VQ0
         48bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iLzFhcDitj7H4o30ARzCc6mWmBomakBjOI+RpH3RyaQ=;
        b=p3XRe+iRLe+URdDCtj9NgiMnkrogC3Kj6Y0YzKJpc68AMmCSfKmxMGc1T0IgFFg1gH
         SgK9xQ1F+NzTzYTaLmiO3huPM+wQZmhHfSvFhNWgP4XgkkYhbQiN54QzI116WJJ3dZEQ
         OLINi9wlohfAPsInwWPaNdEqObIFMtv5vXONvFGLy9tmpIflGnSgCu+hgsegpbXKfLGq
         o95keUd4DSDJGOxMgtVqovv93Qh/FK7TY5u1me1je9U4HQSyc9DBJkQijFL6zKYx+68T
         P1RHIwXosmv8yf92VL37t9/f2phthHDAz2thTSUqWjd3Ga4dFwkKRFPFgeFILn3xGUgm
         HCBQ==
X-Gm-Message-State: AJcUukfTU0GdKeNQah3KlVLsLNqkaUPYE033P0ciTdJ9P6+NuD3ztVvf
        ehJokyD/WlT60dtslNm0SAo=
X-Google-Smtp-Source: ALg8bN6/ZQHFv4YVWbylbWpLsW2mhhl026xmUT5fMjMpWLRoWY4NenaIh/bzmwVb5WAEv5Cyak7hzw==
X-Received: by 2002:adf:b716:: with SMTP id l22mr13536171wre.186.1545685873408;
        Mon, 24 Dec 2018 13:11:13 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:dcf1:6934:a532:a875? (p200300EA8BCFE300DCF16934A532A875.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:dcf1:6934:a532:a875])
        by smtp.googlemail.com with ESMTPSA id v12sm656600wmd.27.2018.12.24.13.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 13:11:12 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
Message-ID: <96aa7901-10a2-e0c3-d7d6-10e8b1a19354@gmail.com>
Date:   Mon, 24 Dec 2018 22:11:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.2018 22:58, Heiner Kallweit wrote:
> On 28.09.2018 15:18, Frederic Weisbecker wrote:
>> On Thu, Sep 27, 2018 at 06:05:46PM +0200, Thomas Gleixner wrote:
>>> On Tue, 28 Aug 2018, Frederic Weisbecker wrote:
>>>> On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
>>>>> I tested it and Frederic is right, it doesn't help. Can it be somehow related to
>>>>> the cpu being brought down during suspend? Because I get the warning only during
>>>>> suspend when the cpu is inactive already (but still online).
>>>>
>>>> It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.
>>>>
>>>> Does this script eventually trigger it after some time?
>>>
>>> Any update to this?
>>
>> Heiner? Can you please test the script I sent to you?
>>
>> Thanks.
>>
> Sorry, took some time .. And yes, running your script triggers the message too.
> 
> [   25.646015] x86: Booting SMP configuration:
> [   25.646044] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.664491] smpboot: CPU 1 is now offline
> [   25.679299] x86: Booting SMP configuration:
> [   25.679329] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.698449] smpboot: CPU 1 is now offline
> [   25.711698] x86: Booting SMP configuration:
> [   25.711727] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.729185] NOHZ: local_softirq_pending 202
> [   25.729229] NOHZ: local_softirq_pending 202
> [   25.730759] smpboot: CPU 1 is now offline
> [   25.744053] x86: Booting SMP configuration:
> [   25.744083] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.762520] smpboot: CPU 1 is now offline
> [   25.776834] x86: Booting SMP configuration:
> [   25.776863] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.794189] NOHZ: local_softirq_pending 202
> [   25.796672] smpboot: CPU 1 is now offline
> [   25.805970] x86: Booting SMP configuration:
> [   25.805999] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.827360] smpboot: CPU 1 is now offline
> [   25.839043] x86: Booting SMP configuration:
> [   25.839073] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.858184] NOHZ: local_softirq_pending 202
> [   25.862182] smpboot: CPU 1 is now offline
> [   25.873759] x86: Booting SMP configuration:
> [   25.873789] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.893385] smpboot: CPU 1 is now offline
> 
Almost forgot about his topic, but the warning is still there.
Has there been any progress in analysis?
