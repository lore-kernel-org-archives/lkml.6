Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14892C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDE322360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qer4H/bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDE322360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbeKNM72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:59:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37092 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeKNM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:59:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so4435734pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 18:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=x8N96Y++F4M/r16UJbAT47ooPKUZRq4EHzeknrtP+bg=;
        b=Qer4H/bgSl0YKxpWsY0eODnRR8aHtGXjZeRxnKcanwHUbz/5GurniuSvVTFiBLty5q
         hjk77kV+4k4rE9ejqQdvl6b5zEONjStw3hxtBQGJIthvzCc3IyGUSjOT8Ps81zH4Dlal
         kAn1EFCec6R47CqJv4pM2gPTP67WrLP9reEJj9RI+jWdKpvURiRDDs9OLfS+qE6sV/lC
         lx9EP/OhhcTwM2THigp1a9JmDgCWj8p6MN4dis8t8WYzMK568ni7FRGSsmPLiEMHh3yo
         ryQQzSpuUCTc3yMejKSBFGCEWVCY3b8FXx8ONxb8DeY49e4DaInKpBr3YLl5AIEEmSoq
         ujSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=x8N96Y++F4M/r16UJbAT47ooPKUZRq4EHzeknrtP+bg=;
        b=nPGVoOQ4jwRdvAPgSWBao3KOunvxbHUMF8a86eHD36HDNvXoJIsGE+IH37Fwehk2r7
         y7pq6evX8OE5qIVZoEpdrggJodIekdpNLCDAarJEEbGRiviG3y0G6WWypF/VHjNQGIYX
         Aqb8JUkltnprykfTAfhCmqC1uC1osZnU/OMHje3HAGZI7SfZp7uG9FoAB51HIbk1lUgv
         K6Cy22ia8JIBkFfek/Yb4O3DbmhxBEsMb20BpGCBoy6dd73ScdQQU5tg3Ba2sdMoAPbo
         OvV4o+wIY2iwsezUecHqJO8wyHqkHMExwrE4BrDQpY3HFgNrm7wNhoXYmtiYyvvZfCpL
         Otzg==
X-Gm-Message-State: AGRZ1gK+KfAy9tqs4TCQiaZ0Rbqf+zjifawAEhIuE7qfK/rzHSJ+BgYB
        h9dsOc/KEjPZdj6qspox4Aw=
X-Google-Smtp-Source: AJdET5dB3Ed4A6FsMD32vZbE8pJjiy6pQjjyEVWpXJZU4xgqlsbRrtt2RnoKNm3l9oAbZNUXR/1FHA==
X-Received: by 2002:a62:d084:: with SMTP id p126-v6mr149284pfg.147.1542164294111;
        Tue, 13 Nov 2018 18:58:14 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id f64sm20110264pfh.0.2018.11.13.18.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 18:58:13 -0800 (PST)
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
To:     Finn Thain <fthain@telegraphics.com.au>
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
 <73f75453-ce74-2c13-ba7c-f36f976d4ff7@gmail.com>
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
Message-ID: <ab36d408-a05f-f220-1c2b-b88333f1c33b@gmail.com>
Date:   Wed, 14 Nov 2018 15:58:05 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <73f75453-ce74-2c13-ba7c-f36f976d4ff7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 14.11.2018 um 14:08 schrieb Michael Schmitz:
>> Can you also test tree fbf8405cd982 please?
>>
> My tests were on c606b5cf902 in case it wasn't clear. I've now seen
> fbf8405cd982, one moment please ...
>
> That one does appear to work - different versions of ARAnyM, and
> different userland versions though. I'll test that again with the setup
> that saw c606b5cf902 fail.

Still fails on that emulator / userland.

Cheers,

	Michael


>
> Cheers,
>
>     Michael
>
>
>
