Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9265C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BA62086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cirpHcDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfA2RE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:04:59 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36416 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfA2RE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:04:59 -0500
Received: by mail-vk1-f196.google.com with SMTP id 185so4659270vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hvr50WOe5YAp+ZfNWlbBzbHKySkVFiVrgRzeI4jrxMY=;
        b=cirpHcDvmVexDxUSFxEOMfTqD9LddehQ6agRWW1r/TYMjffUW4bEbw7rEs+b/eBIfm
         rQkPjrQXfZnB9c63yzODT1AdFY9zX86Zwyns2lSICzrfoppBiDthnWVeS0wTejgvefo2
         1VGJHhTfUz+20nu0NMDQ1ENbO3SwB2U9gwxBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hvr50WOe5YAp+ZfNWlbBzbHKySkVFiVrgRzeI4jrxMY=;
        b=SzQqzDxm7uOEJ+yDuU74JpulpEPyWJpy3b9i7o/2YDjH6Cw3+IR53wdK9EF/4bby0k
         Hpqaqn9tbK77QxoB7ex9UwUT0OVLG6jR7aFiUSsYaepMIsK4OzIyn4qD7NLKrAOjTnxz
         Kcpgx7vMLV9s8AceBJYx7R/Bxu9/H0ta1dJOnh1UAmpPyefWFpvmWNA96jXMyPXzjL3y
         xzTJLFPq0cFS8ft+D1ynGoo0qqYShjeay3ZM3qCHOFddm3qA50b6fCweDKV3PyAhclBY
         JNPoNwjGoadYbijB+Ueu/085vG3EKHxOP/pHu7RJh5nsbHDYD5IVpPoP6eFX69ERAwL1
         c7jg==
X-Gm-Message-State: AJcUukdzF+A8KMsiGi7G2Q0GC9/KVK1CPlPcA6r55Wjqfiy0F97C1XuD
        E5vekxVWDzMABFLxquBm5jhAp3UM0NU=
X-Google-Smtp-Source: ALg8bN7UqdwjjjvWLBhCBBia1+Ka3sM6dPQXSG6eCG9ZLNIUAH7SgXwB7ukJppsNX1kItknFSUf6Sw==
X-Received: by 2002:a1f:54e:: with SMTP id 75mr10744996vkf.71.1548781497735;
        Tue, 29 Jan 2019 09:04:57 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id q199sm14617387vke.23.2019.01.29.09.04.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:04:57 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 185so4659247vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:04:56 -0800 (PST)
X-Received: by 2002:a1f:bfd6:: with SMTP id p205mr11125087vkf.70.1548781496482;
 Tue, 29 Jan 2019 09:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20190129164813.GA5720@atomide.com>
In-Reply-To: <20190129164813.GA5720@atomide.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Jan 2019 09:04:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
Message-ID: <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 29, 2019 at 8:48 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> enabled consumers") started showing new warnings with v5.0-rc cycle:
>
> regulator-dummy: Underflow of regulator enable count
>
> I'm seeing this at least with my pwm-vibra test case:
>
> # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
> input: pwm-vibrator as /devices/platform/vibrator/input/input4
> regulator-dummy: Underflow of regulator enable count
> Upload rumble effect... id=0
> regulator-dummy: Underflow of regulator enable count
>
> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

My first guess is that there's a real unpaired regulator call somewhere.

I actually meant to include this in the commit message, but I'm an
idiot and I used "--" to break up the parts of the commit message
which confused git when Mark applied it.  Sigh.  For the full commit
message, see:

https://lkml.kernel.org/r/20181120175255.227783-1-dianders@chromium.org

In that message I said:

> - We can (and will) spit errors out for code that used to be invalid
>   but was never caught before.  Specifically if someone leaves a
>   regulator enabled and calls regulator_put() we'll yell.  We'll also
>   yell if a single consumer calls more disables than enables.

Looking quickly at 'pwm-vibra.c' it wouldn't surprise me at all if you
call regulator_disable() more times than regulator_enable().  If
that's true it should be fixed.

-Doug
