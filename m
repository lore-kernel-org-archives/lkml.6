Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F05C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78D8223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0J72tEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78D8223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeKMOrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:47:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47018 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:47:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id s9-v6so5391483pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 20:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PSIu/HQdLaK6hL7Oz9vhaTNC72Qhz570Bbuuow7ytEM=;
        b=U0J72tEobGtHY9ta4NUT73hZCQqukEqWWt73AQlP6VxF9ppZBPVKmC8//bS0A5yajl
         +lhEgQO2aV5ABRbUqVivMnrqdaoPbSmneDFy4fUVYv3/8jthqJGjTsl/t1J5jJaJl0cn
         kdpOuywat/Aaoe7bUNdbtSSxXsuzdfAxVIuqPD48gipd3OjYBz0zzdn159yKNv1b6EBv
         8IFefEsIDRH8YD7snxMDfOPA69pg1upWwLHN3L2ueSAZHOd5oCoXfGOjLG0IzQwSzE2v
         7mBsi86aGFR8i4dJlee0cUvyQhJ3viqi0tqjZuebEwFlaRTHTyL60BMeH0tOf+NFuHjB
         AwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PSIu/HQdLaK6hL7Oz9vhaTNC72Qhz570Bbuuow7ytEM=;
        b=cpY9AFBAGZJxjWJwaNF29ZebIcmFVpAaQRtnyWeuJM1JTo677rIzJPZu4HGN9Zv/d9
         1FYYetkPEVHvRBWUnKUZemszuGHPzvTajbpwEhht2c0AImep5azQ3bJmK5LXSZ20s9rJ
         oUMCwjjuCwj1vpmJXrb4y6PxXwxm2hPWmlgkTEBfZyLB6vmfn5oIcuiDgUKRY5WMsE7Q
         B+o/dacMJVuG3/ZzjhBBtPAcjII3OEV6124LojzI3MxvhG7O1VLIifA3VZMCzi8d95AA
         MXnmYqq2PG4vLyy/fiUHYVGOpowFb+okeOsMZwkF5Ccg1KqnYIs1dsCbLqccYJ+5mp9M
         fpug==
X-Gm-Message-State: AGRZ1gL+I4eLDnZlggbiNTVGP1jIiRAquvqz9npz/vYUbgSt/02lcBKD
        gYTsxf6oEhznubB82Dbakt8P/CwsCKg=
X-Google-Smtp-Source: AJdET5eQdtepRoyhl7WnK0xtQu/X99izNdrHzXfU/rziMWCoPrD5f9E0fL1NExXtvUsr/q13e8FzcA==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr3440268pgo.378.1542084646374;
        Mon, 12 Nov 2018 20:50:46 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id r1-v6sm14040611pfb.69.2018.11.12.20.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:50:45 -0800 (PST)
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
To:     Finn Thain <fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
 <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
 <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com>
 <alpine.LNX.2.21.1811131413210.362@nippy.intranet>
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
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com>
Date:   Tue, 13 Nov 2018 17:50:37 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1811131413210.362@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 13.11.2018 um 16:14 schrieb Finn Thain:
> On Tue, 13 Nov 2018, Michael Schmitz wrote:
>
>> Hi Finn,
>>
>> Am 12.11.2018 um 22:06 schrieb Finn Thain:
>>> On Mon, 12 Nov 2018, Geert Uytterhoeven wrote:
>>>
>>>> Hi Finn,
>>>>
>>>> Thanks for your patch!
>>>>
>>>> On Mon, Nov 12, 2018 at 5:46 AM Finn Thain <fthain@telegraphics.com.au>
>>>> wrote:
>>>>> The functions that implement arch_gettimeoffset are re-used by
>>>>> new clocksource drivers in subsequent patches.
>>>>
>>>> Disabling this first affects functionality during bisection, right?
>>>>
>>>
>>> It means that all platforms have to use the 'jiffies' clocksource.
>>
>> So all that happens is timer granularity drops to 10ms, then gets restored by
>> the later patches?
>>
>
> Yes, that was the plan, but I can't confirm that it worked out as I don't
> have any physical 68k hardware in front of me right now. If you can
> confirm this on your Atari Falcon, that would be great.

Will do.

> (It appears that a QEMU-emulated Mac does not benefit from having a
> clocksource that's more accurate than the 'jiffies' clocksource, in spite
> of "clocksource: Switched to clocksource via1".)

With the current code, kernel log timestamps have 10 ms resolution on 
Atari. Time resolution of times reported by initcall_debug is roughly 40 
us. I'd expect that changes with falling back to jiffies only. Might be 
worth a try on QEMU Mac.

Cheers,

	Michael

> The latest patches can be found at
> https://github.com/fthain/linux/commits/mac68k-queue/
>
