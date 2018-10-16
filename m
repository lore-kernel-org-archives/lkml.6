Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F05F204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM/IeTVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F05F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJPVpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:45:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46223 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:45:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id q12-v6so14113951qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GEVHFKwKK7CBWAyv1W3iG2CPRqjoY77JChN4qZEPEY=;
        b=eM/IeTVeF0vdYaaL9+0ajrIoI/Gyd6OTgnLrJVvIoP3zc49in/2A404O25QzCgxhe8
         w2daJZpzkv9+ho3qKepCsuqFSyOoap83iGVmqk42lJc+oedHR5tKf5K5aUGAYTDaK+QI
         s3L+1+w7MjsbR55pAWcS0p7Xz1kxZZRaz5FyvT4vBmfLw0bBCiioW5DUAfHwOwtx1D3b
         NASi6SP4qB/T3FUzzrK0MPAr8TS5E/nGnEak70Ew1uHWBWWke0POpslK5/QjTYc7Bfof
         JFa8Tl1H6oQvzrGNv7j9uXhdlPe2aPT8fw/ZtCaYhimCsI501yd94dbdNwv1buEkEPIq
         x1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GEVHFKwKK7CBWAyv1W3iG2CPRqjoY77JChN4qZEPEY=;
        b=azz5Yw2Ar/ROiKVqgU0PZGyZGQHyy7RjqCaQYAUla6esJdXLqjCghP8DB/IDFNvWbw
         fQv6IZ+rM2w7/Ue0RV4/tboZAVFnRErO4ayBqzSYXk3BEGxbeGInO4A8B7lPPkP4QHNJ
         DwGoX4DMo13+k82jzCn79Wt2cpqwMJZI+sqKaa+Dkd4yUAg1NrRGgwYV6GKhCxv2MDQc
         3ddG1SW7JLHuwCFxmAV6vzhVS6vC1V7n/Pf/FYKx0uKaRKOq3d3lqd6N0oiZetBHh/rD
         XfG/ZEdPWvIg7+utBxXkAgKhqUs2en7uGo+HIQS9oXOMp4t0O9R5/vHEewvmEv0ImJ5/
         pG7g==
X-Gm-Message-State: ABuFfogbgVJvTqmPR6MFcMiGBc6N2NKboTFyisHqjfBJhFfyeKXy9WKi
        l6bBiADshclrd5VLMWMEucXiw+COg3Ril5pjyMg=
X-Google-Smtp-Source: ACcGV63DmhCWWNOL62Kt/A575/frCPfWwCLcG/XZw1FJnL/nqRHfY6EE7RxKWjIQiDJwXbvQyIQxe2UiaJw7LqW+GBU=
X-Received: by 2002:ae9:f40b:: with SMTP id y11-v6mr20963056qkl.137.1539698111448;
 Tue, 16 Oct 2018 06:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com> <20181016072244.1216-2-a.hajda@samsung.com>
 <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
 <605bd00e-ed0d-4259-bdc3-1784b2b3b16a@samsung.com> <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
In-Reply-To: <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Oct 2018 16:55:00 +0300
Message-ID: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 3:55 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 16.10.2018 13:29, Andrzej Hajda wrote:
> > On 16.10.2018 13:01, Andy Shevchenko wrote:
> >> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>> During probe every time driver gets resource it should usually check for error
> >>> printk some message if it is not -EPROBE_DEFER and return the error. This
> >>> pattern is simple but requires adding few lines after any resource acquisition
> >>> code, as a result it is often omited or implemented only partially.
> >>> probe_err helps to replace such code seqences with simple call, so code:
> >>>         if (err != -EPROBE_DEFER)
> >>>                 dev_err(dev, ...);
> >>>         return err;
> >>> becomes:
> >>>         return probe_err(dev, err, ...);

> >>> +               va_start(args, fmt);
> >>> +
> >>> +               vaf.fmt = fmt;
> >>> +               vaf.va = &args;
> >>> +
> >>> +               __dev_printk(KERN_ERR, dev, &vaf);

> >> It would be nice to print an error code as well, wouldn't it?
> > Hmm, on probe fail error is printed anyway (with exception of
> > EPROBE_DEFER, ENODEV and ENXIO):
> >     "probe of %s failed with error %d\n"
> > On the other side currently some drivers prints the error code anyway
> > via dev_err or similar, so I guess during conversion to probe_err it
> > should be removed then.
> >
> > If we add error code to probe_err is it OK to report it this way?
> >     dev_err(dev, "%V, %d\n", &vaf, err);
>
> Ups, I forgot that message passed to probe_err will contain already
> newline character.

You may consider not to pass it.

> So the err must be before message passed to probe_err, for example:
>     dev_err(dev, "err=%d: %V\n", err, &vaf);

> Is it OK?

For me would work either (no \n in the message, or err preceding the message).

-- 
With Best Regards,
Andy Shevchenko
