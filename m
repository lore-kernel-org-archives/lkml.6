Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E3F2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="auggXh3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfAKJwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:52:03 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39024 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfAKJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:52:03 -0500
Received: by mail-vs1-f68.google.com with SMTP id h78so8848543vsi.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TXYG0bRygv37lt/cmIuFfZcnUSM355T9n2ZJXUOXPE=;
        b=auggXh3eSLNCvw2+OMx6WOeqof/9eRBvDRe3sNrVnKSytLC0n6jddw1GRRW8kAJCfQ
         L1Ci0N/vlIQYbtnCKmcNG5j3YLRFH2ImiXEaRx5OfQIM0yezxdHi/J52vsbCNtAuMB9b
         eZVb5nz9KMlhsBXCglVo/6kBsUM2tESEqqyzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TXYG0bRygv37lt/cmIuFfZcnUSM355T9n2ZJXUOXPE=;
        b=nsjy+x4WuNfeZhakCTYtqAA6X6xVuaVdeKN/gA7GhONCle/O7EQwBV+tm42h+jz4y3
         CrSi/qYLzyZLMOCT4lTeZ1hxpK1iK25JnvAXgeKdZwPNpZh2azFwlIoUoQlhh08tfMNE
         nMIfizGS0X+aTV8rDYweWlTuDKefbTgbkdb2Dgks/obY9p6/6jT5qSHzGuLF1iDs3HCZ
         brxIpZy0bWK2S6x4YaIkDm+eDqoH8a6V6cg6cke8iOHx71cm6sQqVAnd76DnLaDdnnj4
         9UOS42JgdhZCWZ8eMtUpd8mpekPygBorn0vCGgRly3vu7kWK1rlLboBwSByI0iPpXShM
         TIag==
X-Gm-Message-State: AJcUukcDMZQlUceKYWvuu8IhcEsIBVbHyn7JtDhaZZww0dCaJkLAESBp
        5Ndj1EXowdvc94RSieWUfQKk4LaV9tKMLFRv2Gww1Q==
X-Google-Smtp-Source: ALg8bN4PF1Axmm3q/vaJb9HeicK/Bp4AvzPVk8dEcLkvR/I3xClXHtXXlYhNB94xF29IhkuBpad6GwZa0XRnf2JuXBQ=
X-Received: by 2002:a67:2045:: with SMTP id g66mr5711533vsg.180.1547200321471;
 Fri, 11 Jan 2019 01:52:01 -0800 (PST)
MIME-Version: 1.0
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-3-git-send-email-sumit.garg@linaro.org> <20190110141856.p3evqyf34py74gkg@holly.lan>
 <CAFA6WYPHmtY4N9ruGLZ70FNeiDCbQE-fs+EP2px-S+GEj2nPTw@mail.gmail.com> <20190111093902.hfxb67txjhhlegzu@holly.lan>
In-Reply-To: <20190111093902.hfxb67txjhhlegzu@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 11 Jan 2019 15:21:50 +0530
Message-ID: <CAFA6WYNp5ve=xZ1bQL+HUGK4Pz7dpzMzWy_fuS0_q8NHaZWL4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tee: optee: add TEE bus device enumeration support
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, mpm@selenic.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 at 15:09, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jan 11, 2019 at 12:52:19PM +0530, Sumit Garg wrote:
> > On Thu, 10 Jan 2019 at 19:49, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > > +static int get_devices(struct tee_context *ctx, u32 session,
> > > > +                    struct tee_shm *device_uuid, u32 *shm_size)
> > >
> > > Missing const on device_uuid?
> > >
> >
> > I don't think we should have a const for device_uuid here as this is
> > shared memory struct pointer which is dynamically allocated and used
> > to fetch device UUIDs.
>
> Agree. Perhaps device_uuid is misnamed though (part of the reason I
> misread this is that it is singular so I though it was a single UUID
> travelling into the TZ).
>

Will rename it to device_shm instead.

> > > > +     rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> > > > +     if (rc < 0)
> > > > +             goto out_shm;
> > > > +
> > > > +     device_uuid = tee_shm_get_va(device_shm, 0);
> > > > +     if (IS_ERR(device_uuid)) {
> > > > +             pr_err("tee_shm_get_va failed\n");
> > > > +             rc = PTR_ERR(device_uuid);
> > > > +             goto out_shm;
> > > > +     }
> > > > +
> > > > +     while (idx < shm_size / sizeof(uuid_t)) {
> > >
> > > This is a very uncommon way to write a for loop ;-).
> > >
> >
> > Ok, will add "num_devices" variable.
>
> num_devices might add readability but that is not what I meant.
>
> The most idiomatic way to write somthing that loops for every valid index
> value is:
>
>         for (i=0; i < limit; i++)
>
> You wrote it like this:
>
>         int idx=0;
>
>         /* lots of code between initializer and first use */
>
>         while (idx < limit) {
>                 /* more code */
>                 idx++;
>         }
>
> Sure, they are equivalent but the idiomatic form is easier to read.
>

Oh okay, will use "for" loop instead.

-Sumit

>
> Daniel.
