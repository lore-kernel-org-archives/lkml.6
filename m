Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0316C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD5920847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b="j9RBqFwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD5920847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934034AbeGDMJl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:09:41 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44487 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933815AbeGDMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:09:39 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so4678783ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c+Jv+WbtRAzeQDcGuANuUcKg4pWY0P2tyBMbi24GLRc=;
        b=j9RBqFwxMpwDCroR3fbwUtQxfm1Es+PSDD62SUY6r4CcuEpuF4Yoc+C0bWI4XbOw+l
         qhcvCZJRX0CrDtqYexBsFEgGdxb304IXLPUmbIU4EWjwHf/Hbyt4+6I6ZFmWoYQkHkvu
         kKPX1dSASXGxAStUkDGmbqn8invyjJckkd9lR6mbgu5eNv18Bq2HN7a6r8MTdYon4RWj
         Bf+31wcIleMTro5as6ObR6kU5krB1TYGFxo1V2kQ2ztnn95iAtK+N5/AzGqlrELstKBu
         BpdJjsEQ2p1yWs0hX2gUR3RLCl7nLJ3+ir6NmvNT/uUhhxN8sbTcTfBRSvbwryUd7qN9
         mmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c+Jv+WbtRAzeQDcGuANuUcKg4pWY0P2tyBMbi24GLRc=;
        b=rsMqt7MlSX9arwUI0ZEVuFlK4CWXOXo4gSmE839cJOCpjU+ILcn6wTtWXRYvoXD8du
         yo8AHYSyAMSCGhsjIfBw2VPg/jk5JKhexR0+0UHh6cK8AvS8qdrctRfd9DAthN63VXVV
         6BMURDUvivRmq5pYNNWCjbVCZM3Ge1V8DvJKVwjg/r2Uy7e8y0uGIUEBzcLzrY4qF8I2
         sMyu9ueeKvRjXInK3Kv0xOur0LIrzhEsGZnP/GW//Os07x8n4HCNEzt8IpI1KbPvZeF4
         URqeHwUpIsoJEPnkjOUJUvqNxxhYIUhEhLOCANTXqh50513IR0UzJZTwQSsaoznAtfay
         NJPQ==
X-Gm-Message-State: APt69E0482Q7/JTm4dcyDFaPiuyGHAbJG4iehgE27pFT6ku5zr3Lm6r+
        r+cmWxTbmCTDtsJyNyahvd/aDgMLJjNHS5JElyithw==
X-Google-Smtp-Source: AAOMgpezSa0GfgEoMlalhf2fR4Mxng2CVioRaQgUNB7EhZV6GnhL0QI3TnKnxAQSEGGS03aIwMOH43m5+INK+B2pBcs=
X-Received: by 2002:a6b:8721:: with SMTP id j33-v6mr1299187iod.35.1530706178333;
 Wed, 04 Jul 2018 05:09:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f017:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 05:09:37 -0700 (PDT)
X-Originating-IP: [195.166.127.210]
In-Reply-To: <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com> <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Wed, 4 Jul 2018 14:09:37 +0200
Message-ID: <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 1:46 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:

[snip]

>>>
>>> Ok, in my opinion it is an elegant way of not bloating the driver when no
>>> explicit handling (e.g. reading DT properties) is needed. Just adding an
>>> of_device_id doesn't change any driver functionality then but only maps
>>> to
>>> an already existing i2c_table_id.
>>>
>>
>> I disagree, in the case of OF for example a compatible string is
>> composed of both a vendor a device, the complete tuple is what should
>> be matched.
>>
>> But with the fallback, only the device portion would be used so both
>> <foo,bar> and <baz,bar> will match against the i2c device with id
>> "bar". It may or may not be correct but the vendor portion is very
>> important to disambiguate.
>
>
> Disambiguation via DT implies there is already a name collision in i2c
> modalias name space, so adding an of_id would work around this collision for

There wouldn't be a name collision between OF modaliases in that case
since the vendor would be different (of:N*T*Cfoo,bar and
of:N*T*Cbaz,bar). So it wouldn't be a problem for DT-only drivers.

> DT enumeration. I2c_board_info driver binding would still be broken. The
> right fix would be to remove the name collision.
>

Yes, for legacy drivers using board files it would be an issue. But
that's unrelated to what I'm saying. What I don't think is correct is
to ignore the vendor prefix since that's part of the compatible string
semantics.

In general, I think that there should be consistency between the
firmware interface used to register the device, how the module alias
uevent is reported to auto-load a driver and how the driver is matched
with the device. So drivers supporting DT should have a n OF table
(and export it with MODULE_DEVICE_TABLE), drivers supporting ACPI
should have a ACPI table and so on.

But this discussion isn't really related to your patch. I think is
correct but just said that (b) wasn't a justification to leave the I2C
table, points (a) and (c) are though. I won't really be convinced that
the fallback is the correct thing to do or even a good idea.

[snip]

>>>
>>> It could have been a null pointer and device driver binding (and
>>> auto-loading) done just via driver.name.
>>>
>>
>> I'm not sure I understood this comment.
>
>
> What I was trying to say is that if the i2c_device_id table information was
> not needed (i.d. only one single id), even the old probe() could be used
> without defining an i2c_device_id table, the i2c_device_id* argument to
> probe() being a nullptr.
>

I see, yes that would work too. I didn't authored the .probe_new
callback so I don't know if other options were discussed. I also can't
remember if the I2C core attempted to probe even without an I2C device
ID table, I thought it didn't but I can be wrong.

> Niko

Best regards,
Javier
