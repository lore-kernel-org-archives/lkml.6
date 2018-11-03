Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24217C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5022082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myQxigc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5022082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeKDILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:11:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37930 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeKDILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:11:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id q186-v6so4793937ljb.5;
        Sat, 03 Nov 2018 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUtZ9vLQEnmbByGnakN4MiK+R36kqMhUX85EM4K5aqE=;
        b=myQxigc+GccPUmyCkNImccJMFp3yLbRHpNTkeTJ39DXfFG+FnefT+kuwzwG6AXKsf3
         I8mGmtMlqfJ7T7XISy2NzA3zfdH8A7POs9Ot14jAEbtBis3Ewar1XLSONF+Zu/GQU3q1
         Wwr8v/l0rULcQlmT7LBpMspHi5kV95bZEvaaNaCkR+0sELPvjnNAhiG9DPPEAh4RHkI6
         3Mmm7TWyBfjKNqrtA5SaVWJ0/TktuG5tJ/LJ7MYKkpdG9m/KaYXiSje1EchzOwJztRU6
         K69r0NHaMALTDCchwFRFR+4Qjvy83ZXMKTjbtoGKAECqCm7lxFljyBxJLvazndfWKM58
         TiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUtZ9vLQEnmbByGnakN4MiK+R36kqMhUX85EM4K5aqE=;
        b=krHqwnoEMtx5SnS72yARfGUy8aJm5N0wcHUPbGbDUsOxgfMt0aHKjkGINpNc6TJ9iF
         ibKVitRTc78UgqRirPzbWUub4ehg3CMvmvdkwU3EQABx2ycSZOXsr61aEJdDpFl8DD04
         +xsdKKlQPMYMqJH/dnY8PFQKSID2mMkHnX2/fuZfBWBrpL+lx+Vn/7ea7HnXtKD7GYPs
         IwZc02ZpkM5FLlXJJjGIkijzsj23dQBwPyEmDpEBfKMJJI+PJIiJvoTQCmr5T4CEyXBF
         yvC691Sv2EWPGqaNhhzHPiewD9/iY+dKdJdCqZj50UYxBJ13jtXvvnb+5suAf19hwdmG
         DW0A==
X-Gm-Message-State: AGRZ1gK/qWuNrJlCDpZemTqKMbuH0++JQQFn4HrJZ76oZumOso0/dr8o
        35oOH2OjTYg7gTvrKI587txWjr7XIclk7ib95IY=
X-Google-Smtp-Source: AJdET5eq/kOX8qBhULEMWNN9QKpKWZzYIs5vJbwDIlrPSn55yAjOoO4M/8N2K1aQINN0Y0TECFJO0qUtDYOR1qWcqLA=
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr10687013ljg.150.1541285915856;
 Sat, 03 Nov 2018 15:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181102143018.09feb051@canb.auug.org.au> <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
 <20181103002218.3bd015b3@canb.auug.org.au> <CANiq72=kHErmujzMgM4akXeoWkSR0Q3VLd-6Mwiaj5mGan8yZw@mail.gmail.com>
 <20227164-2ef3-d684-bf4e-fb69ac828789@infradead.org> <CANiq72kBx4+R4SVFZ_iTfk61=oHMLwvhHdmBDe=cBFP5Lp7bSQ@mail.gmail.com>
 <6ecaed34-eb66-24ed-e6c7-e33f9583be5e@infradead.org>
In-Reply-To: <6ecaed34-eb66-24ed-e6c7-e33f9583be5e@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 3 Nov 2018 23:58:24 +0100
Message-ID: <CANiq72mqO36FotJ6pHQpAB18DLEYV+kSL64Sc+A6yoqDu47bAg@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 2 (compiler-gcc.h)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wolfgang Rohdewald <wolfgang@rohdewald.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 5:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> No plugins are enabled.
> The failing randconfig file (for x86_64) is attached.

Confirmed with a built-from-sources 4.8.5 on current master
(d2ff0ff2c23f). The ICE also happens with 4.6.4. With 8.1.0, however,
we get an error instead:

In file included from drivers/media/usb/dvb-usb/pctv452e.c:20:
drivers/media/usb/dvb-usb/pctv452e.c: In function 'pctv452e_frontend_attach':
./drivers/media/dvb-frontends/stb0899_drv.h:151:36: error: weak
declaration of 'stb0899_attach' being applied to a already existing,
static definition
 static inline struct dvb_frontend *stb0899_attach(struct
stb0899_config *config,
                                    ^~~~~~~~~~~~~~

Which seems to have been spotted by kbuild months ago:

  https://lkml.org/lkml/2018/3/10/358

The problem is in pctv452e_frontend_attach():

/*
* dvb_frontend will call dvb_detach for both stb0899_detach
* and stb0899_release but we only do dvb_attach(stb0899_attach).
* Increment the module refcount instead.
*/
symbol_get(stb0899_attach);

Here symbol_get() is declaring a weak function (due to
!CONFIG_MODULES) while this definition in stb0899_drv.h occurs (due to
!CONFIG_DVB_STB0899):

static inline struct dvb_frontend *stb0899_attach(struct stb0899_config *config,
  struct i2c_adapter *i2c)
{
printk(KERN_WARNING "%s: Driver disabled by Kconfig\n", __func__);
return NULL;
}

I guess pctv452e should require CONFIG_DVB_STB0899, or similar. CC'ing
Mauro, Wolfgang, linux-media.

Hope that helps!

Cheers,
Miguel
