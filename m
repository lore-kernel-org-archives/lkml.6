Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EBC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqdunkSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EBC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeGRMJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:09:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33496 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeGRMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:09:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id l10-v6so8125497oii.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G0UibmH5yuy24RRniXHxdqQ5+sTId6u5eAWXnlNnOtk=;
        b=cqdunkSr0Av7hLsRa3uJIXgLUpcUHKv8KQpm/6/NCPkAS3iaBdfWYmvr9pM9wuAK6f
         vbFqs0UqTLDdvQgEVtUOEyNLHsgsF+qeAVGMc17x6IwR/p/oMkmu2O3mea+iaaqxbRZv
         EHmuw3o2S0dVcdm2rbQ1JNl5rL3mD1RePjtjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G0UibmH5yuy24RRniXHxdqQ5+sTId6u5eAWXnlNnOtk=;
        b=JZVZ8J7ByfpD+qPCd+GiHenkvSjHAOpc9nfLezuGGAhHPgPhCMWCIX3Ml7E5lTqEeu
         Xiv9JkSkreNFNpN7cWu8CrRbfRfw4XzOZUre1cexllGpZinM37cZm5ciS32uc4t552Ke
         hyQWRfgx3vHLsvK0l4vdfUDDuEZcj6r+AckEwUbj81gvc67iHHPfpEi9isXnZLSM0QCV
         XQNstOWl1wzGiTer59YALFz04qUa/O/XBU5PqLotCLHoSIzVruiZrjSkxZYZNnEeX3uC
         wOvCUqEiP1izxpXmaK+T7YXIQRvhYM/aC8rETaPe3umMph6XsOD+hiAxQBVKAeNbfGwi
         RNzg==
X-Gm-Message-State: AOUpUlEz+BdIWyCHtnsSDw7CMSnvFmui8uQxr8F/8xJsADaMNEqsppil
        drbZe1O5ACZZxWAoI2F6znPiOMWcHDYti7pBK3n7vQ==
X-Google-Smtp-Source: AAOMgpd+6LjcL3buB5ZSwe3+/q225fLCYFHw0eh8trc2vdKTgF6cektJ+AlKC4Bwk+nJMxQrWBRjZ8C6IfXY4APwhrc=
X-Received: by 2002:aca:e142:: with SMTP id y63-v6mr5393403oig.128.1531913522299;
 Wed, 18 Jul 2018 04:32:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:32:01
 -0700 (PDT)
In-Reply-To: <20180718075637.GA10279@amd>
References: <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com> <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd> <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com> <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
 <20180718075637.GA10279@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 18 Jul 2018 19:32:01 +0800
Message-ID: <CAMz4kuJa=s19q7wQFQT1giUe0AN4hpux4PG2koUcnE7q_x7LCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Lechner <david@lechnology.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 15:56, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >>>>I believe I meant "changing patterns from kernel in response to events
>> >>>>is probably overkill"... or something like that.
>> >>>
>> >>>Anyway -- to clean up the confusion -- I'd like to see
>> >>>
>> >>>echo pattern > trigger
>> >>>echo "1 2 3 4 5 6 7 8" > somewhere
>> >>
>> >>s/somewhere/pattern/
>> >>
>> >>pattern trigger should create "pattern" file similarly how ledtrig-timer
>> >>creates delay_{on|off} files.
>
> Yes, that sounds reasonable. v5 still says
>
> +               Writing non-empty string to this file will activate the pattern,
> +               and empty string will disable the pattern.
>
> I'd deactivate the pattern by simply writing something else to the
> trigger file.

For the case we met in patch 2, it is not related with trigger things.
We just set some series of tuples including brightness and duration
(ms) to the hardware to enable the breath mode of the LED, we did not
trigger anything. So it is weird to write something to trigger file to
deactive the pattern.

-- 
Baolin Wang
Best Regards
