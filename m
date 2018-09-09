Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED718C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F792086B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T82n2A4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F792086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeIIIqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 04:46:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39081 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeIIIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 04:46:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so8821654pgc.6;
        Sat, 08 Sep 2018 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=psPoydgIbybMqu35uTV1t7Yblz2X139lg8lZPKMgRqY=;
        b=T82n2A4EapwGqGWk6m3MBmKkn1aaU5Z+XaefmiYNy3YNP64maBeriK5YD2UioWObBh
         +lpf0R++xoFdk6leu3fpMIaAVRzxwi50dI4EW6qEIggg+4SiM3SNUMdM9IVdvsT10VSW
         giO1JjTOfDcxbgJrzXjZ0gtzhbLWn30+SW4ClhV94fzNBUj38oZ47/UI4if5hsd+tQaz
         sfeddjEL761040rX4RVBsWPbAqTUrWh68jLzBP3YyGyyt9L+o9uK63gII6w64ML5UM7/
         EZpszA1/oc5r8vIns/sNq7NDgaUin8PBhfVzkfWfjNCrCNjCTf3wYhdv909hPU/xyPxD
         jY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=psPoydgIbybMqu35uTV1t7Yblz2X139lg8lZPKMgRqY=;
        b=WiyNBZSMzu411c2iLNtaBrx+Gvf65DKUXQbh1oF4F7Uu7/NNn6+BsTsuA0hkK/Z/vU
         BTfrUd9vZQm5iQuS32YvWoZB+uRI9AabLqJk0vkW8o9vCeOX+bGe5uI9Zhw45XLJmxKV
         dgF1B5DPFJi60gkSGWWeTU3Kbm8R4AwEkt5Cq6DW1A2Yb7Q7wQvA5ZYKDYdifM2K6NyV
         7+JDi4y/a7I0yDNzEaazORjPf9YpixKe+hXXPSM/u499GfRbia3mGlsSPhmRAYMvMu9J
         sjN46KTpDjsuBUMPX7/TiHM4DxoIJ6HJ038eeIh6xwgBvgmyOI4XHDIFgzQwybU4dFdc
         F/zA==
X-Gm-Message-State: APzg51Bzw6L+l1t4Ksd3p3qXhuwNY/qt8vUtd/qNPAMsrYnY0ZhVD6Xg
        ZniU5saW6GH1GtD5jrMR1pUdOJGH
X-Google-Smtp-Source: ANB0VdZFCvGwg5sC8ffib36mebNxyOyxPBBoGD0Wq1F4rqu3++BNCPDpWeQ4w10q4gZa/jRZn2ysvQ==
X-Received: by 2002:a65:6292:: with SMTP id f18-v6mr15720800pgv.85.1536465507170;
        Sat, 08 Sep 2018 20:58:27 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b64-v6sm15981599pfg.66.2018.09.08.20.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 20:58:26 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
References: <20180903165719.499675257@linuxfoundation.org>
 <20180904162434.GA16396@roeck-us.net> <20180905090110.GC30538@kroah.com>
 <7d4d11ab-c769-44b4-0037-d1be7f45e2c8@roeck-us.net>
 <CA+55aFzpnXYHNeog==-aWYO=V_67viGrMah1ZSdcDqcRO214-w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ec9bdd81-8dcd-38fa-0d96-cd7b1a550e92@roeck-us.net>
Date:   Sat, 8 Sep 2018 20:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFzpnXYHNeog==-aWYO=V_67viGrMah1ZSdcDqcRO214-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 10:01 AM, Linus Torvalds wrote:
> On Wed, Sep 5, 2018 at 8:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 09/05/2018 02:01 AM, Greg Kroah-Hartman wrote:
>>>> ---
>>>> [ 9990.754641] watchdog: BUG: soft lockup - CPU#5 stuck for 22s! [kworker/5:1:155]
>>>> [ 9990.762601] RIP: 0010:smp_call_function_many+0x208/0x270
>>>> [ 9990.762601] Code: e8 0d d1 77 00 3b 05 cb f0 24 01 0f 83 86 fe ff ff 48 63 d0 49 8b 0c 24 48 03 0c d5 00 f7 11 a7 8b 51 18 83 e2 01 74 0a f3 90 <8b> 51 18 83 e2 01 75 f6 eb c7 0f b6 4d d0 4c 89 f2 4c 89 ee 44 89
> 
> It's stuck in this loop:
> 
>     loop:
>          pause
>          mov    0x18(%rcx),%edx
>          and    $0x1,%edx
>          jne    loop
> 
> which is csd_lock_wait().
> 
> Judging by the offset in smp_call_function_many(), it's the final one
> (there's two: the other one is part of "csd_lock()"). But that's just
> a guess.
> 
> Anyway, it means that we're waiting for another CPU to finish
> processing an IPI - either a previous one we sent asynchronously (if
> it's the earlier csd_lock() case) or the TLB IPI we just sent and
> we're waiting for completion of.
> 
>> Not tested, but I see it in v4.17.19 and in v4.18.6-rc2. Turns out it is
>> related to heavy load, not to suspend/resume. At this point I suspect that
>> it may be an AMD/Ryzen specific problem - it looks like it disappears if I
>> add "kernel.randomize_va_space = 0" to /etc/sysctl.conf. No idea if it is a
>> CPU bug or some AMD specific code problem. I'll try to analyze it further.
> 
> Ouch. Some IPI sending/receiving problem would be very very painful to
> debug if it's hw related.
> 

Turns out this is a well known problem with Ryzen CPUs:

https://bugzilla.kernel.org/show_bug.cgi?id=196683

Guenter
