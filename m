Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5476C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F9A22448
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXhe5CAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F9A22448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbeGDI6Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:58:25 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40547 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932324AbeGDI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:58:21 -0400
Received: by mail-vk0-f67.google.com with SMTP id s23-v6so2686154vks.7;
        Wed, 04 Jul 2018 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f788dIF0nlLNs87FISDVoL3IT8MwJRoSn3qv/zepE8M=;
        b=XXhe5CAlrTrGn3opuvv0j5HwsIcrKtnYch1KHik9iH5SfO7fRPRww8c9J/Ig6pJAzO
         tkYik3+5xFt4EmG5pbZyfTU6m6Szbu5IJnPL94O9cW4CYpIiUxyn69nOqH1T/Qj2L6RQ
         Qyk6N4bNWfMT2J4aOf1ApPt5+Z2/DsMTqiQi3LGW7YaHfsgXE+8smpjK3vSRZ9KOA/Hs
         ajP7ZRBRtvyDBgwiuu8KeH9OmLHNY6pT8lUXFDy8KSlS7MJsgJkdoyOgaAaOfbkVDNCh
         liG2bO1doDzCqam0+tPS9n2INyn0DdZo9xKjqHciFgprjsue869JnXnUO6qGlr0UzYTy
         ofLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f788dIF0nlLNs87FISDVoL3IT8MwJRoSn3qv/zepE8M=;
        b=HBrHtI97IWQpi5vXQiFgB9/3t9oIuQ9y4abcVAV2X0cLRZDIEzF52v26EzFIZF3Qri
         NNJ13vOa0qpEDtrr4DwWV9ZDWSqWt9xX0AXSKsH9vRFK9Yv1EmcHujl0LChFJmYd++mD
         2GO8eLhW1cw6XBOovOWTSF7nLGNLIb0UIVQdmzusVttEUu9TjrE+y7mGPDptCdamOMBr
         XdwxEWnTKX2oc6TynOm8K5KFcBhqFCDJxrL5bn8VDhF9ZAxDhzsMIF9Xh0AWzu60RX9J
         8vgxIcVf0aK5yM7zWW91T765/vuZsd2SdxHO5jpH8sZiIu7+yrZsCnQskcRnaX+VnB6E
         ib1A==
X-Gm-Message-State: APt69E0nIVclge1efIEMx73OH5XKwmzrEIyS9IyfQtCPq7MWHLwoAY7j
        G4P+BuIRaUWFHcqtU1x+/nL1/vVqFjwmcWImQak=
X-Google-Smtp-Source: AAOMgpd3G929ppJowLbKpuDeKNsi22v4z1a8AyrYUtGMYljwTwixB1B5fK17WwsshUDBCzRVCXrMCobWKTk0CYpl1Xw=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr569716vkc.15.1530694700318;
 Wed, 04 Jul 2018 01:58:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 01:58:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1807040728490.6169@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com> <alpine.DEB.2.20.1807040728490.6169@fox.voss.local>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 11:58:19 +0300
Message-ID: <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 9:37 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>
>> On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>
>>> struct i2c_device_id argument of probe() is not used, so use probe_new()
>>> instead.
>>>
>>
>> This makes...
>>
>>>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>>
>>
>> ...this table obsolete IIUC. At least that's what I did when switched
>> to ->probe_new() in some drivers.
>>
>> If I'm mistaken (again? :-) ) I would hear from someone to point me
>> how it can be used after a switch.
>
>
> It is still used by the i2c-core in i2c_device_match() if DT and ACPI
> matching fails.

> And it is used to create the corresponding modaliases for
> driver loading.

My question is "How?!"
I don't really see any points to match against it after switching to
->probe_new().

Could you point me to the code path in i2c (or OF?) core for that?

> So it is necessary for non-DT/ non-ACPI systems and used for
> fallback matching if no match is found in of_device_ids.


-- 
With Best Regards,
Andy Shevchenko
