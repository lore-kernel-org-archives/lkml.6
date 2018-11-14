Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2DF21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh/DgIsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2DF21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeKNLJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 06:09:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38500 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeKNLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 06:09:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4-v6so6901987plo.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 17:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oq9SkIBabmh+mBDoDozP8rQ3zmT5TdRgAHk3cwyY54o=;
        b=Oh/DgIsfX72vjRikllWNgiCTPmWM6xhaRpWxExXPxBuSE86jd7dhswuKB2ZkXJcEaU
         h8mAyKZIXenPVNhnuv1CSeDqVSuuM9v/7mnp2Xh8gDjX84gNGbfwSKLBEDPWWBC7t0jV
         XQjxgmvULXQOO12QG1fbjYT4J0yLpeVwmK/A9athfLw1ou8GTUKHWwFAF+i+bjdLVkoL
         84h8p2p2ybh2jzMTOhlJICHSdCUEFhN+9NIQllVzDl33fQf/HxgHcGEwbwAYdp5wM+ml
         PgG7EDvkXebEgR63LIi6W0+Cn9ZJtCghVlpMZzqZXkChLQ5GHJ2c5B02dIUtfsSOXbfA
         DUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oq9SkIBabmh+mBDoDozP8rQ3zmT5TdRgAHk3cwyY54o=;
        b=ogPog8rJuU5+rluYIKinZVJfO5RhrFk0P9MKxuPyjCAOemW3FIjvgWhuIqZ8EwPGzo
         kdEpTqduckdrhPUBYtErGWKS59XzumoeBimWKs3Zs5qjzbIswheqyihqHl+m6iNRG8bp
         Rb3NiWvKneoisx27qHwkUfhNp/gjkchZaHmRYk3PwB7a/qYK9OW3eXyzlcN9hIg/yPl9
         2NJUBh4D7Oj+eUiSjm5zqd1cnkiwTxTsiG4wpHprYtZwhzv+LVob8qHc5XhFSRTuR71q
         T/M7l6QmV1FVkONGwwf9vsPKNIVkJOa3RnXq2qd3qXNpfLJBp8mzRV3BVFWNbVxe1EwS
         qJMQ==
X-Gm-Message-State: AGRZ1gIkYysa3K8vh2dk13Ne02hW8bX0bfc90gGLXS0tvCHFz1dL2GfJ
        ffz+FeVzsMm7IdlEGV8k3/I=
X-Google-Smtp-Source: AJdET5e8Q9cIXEKuxBWX6J3UctmItlLV84qJIdIDY/M3rIzo6KV8trkzF6N42xrno8cGzuKhfDwlpw==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3-v6mr7123841plr.122.1542157745180;
        Tue, 13 Nov 2018 17:09:05 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:213f:405e:f087:71ef? ([2001:df0:0:200c:213f:405e:f087:71ef])
        by smtp.gmail.com with ESMTPSA id k14sm22762948pgs.52.2018.11.13.17.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 17:09:04 -0800 (PST)
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
 <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
 <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com>
 <alpine.LNX.2.21.1811131413210.362@nippy.intranet>
 <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com>
 <alpine.LNX.2.21.1811131700010.366@nippy.intranet>
 <0054c37f-ef34-e892-ff1d-02968ab529fa@gmail.com>
 <alpine.LNX.2.21.1811140905440.371@nippy.intranet>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <73f75453-ce74-2c13-ba7c-f36f976d4ff7@gmail.com>
Date:   Wed, 14 Nov 2018 14:08:56 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1811140905440.371@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On 14/11/18 11:11 AM, Finn Thain wrote:
> On Tue, 13 Nov 2018, Michael Schmitz wrote:
>
>> Running a recent kernel under ARAnyM shows 40 ns resolution so the Atari
>> hardware emulation is a little more complete.
>>
> You mean, 40 us resolution, right?

Sorry, typo. Should have been us of course.

>
>> Using that for initial tests, I can confirm that timer resolution is
>> reduced to 10ms after patch 6, and gets restored to 40ns after applying
>> the full series
> Thanks for testing!
>
>> (once clocksource_init runs, that is - the first part of the boot is at
>> 10ms resolution only, a regression compared to with use of
>> arch_gettimeoffset).
>>
> Sounds like a theoretical regression (?)
>
> Is there any need for more precise timers (I mean, better than 40 us)
> before clocksource_init runs?

I don't think so, given that we can run just fine with 10 ms resolution.

>
>> Unfortunately, I can't log in at the console with all patches applied. I
>> immediately get the 'login timeout exceeded' message. Weird...
>>
> I didn't see that in my tests... Was this aranym or real hardware or both?

ARAnyM only so far.

>
> Can you also test tree fbf8405cd982 please?
>
My tests were on c606b5cf902 in case it wasn't clear. I've now seen 
fbf8405cd982, one moment please ...

That one does appear to work - different versions of ARAnyM, and 
different userland versions though. I'll test that again with the setup 
that saw c606b5cf902 fail.

Cheers,

     Michael



