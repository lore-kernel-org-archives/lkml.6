Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44495ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A14F2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thrbiJF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A14F2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJQT2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:28:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42291 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:28:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id j46-v6so29495695qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHNQy+TtQ0F8MQ5t2Kb6nCFPUjzCI8OsSYuq57JXksE=;
        b=thrbiJF/GbFBIt06Q1f4P2IyS2FXw2+4t/WuWu8TLLaAXB7nBpaNCUvw7hu2f36laz
         RLz3tLGXeE4coGRryi5ywEEpPxcI9ZOtfk2jp2Od7pXZH0atd7FZTA8Z1cJQjTc57GHa
         1yLdbiJjZWZGememSHfKV9ANbu0k7iAkQGcqkuCei+uOemooMHDxq/Moid5CPMG4susp
         6Eig8sW5CULQ3tQ4iKwOJwARgVP6vCObpYlYCgZfUW2CZ/+HOhKFXIsHuM+S/JR+zybf
         3Qgl0IqmLtheO7RTp9RkUT43IRQuGdWW1og6rtzZk5E3SUXaL9kZSIib5pcJ4OniRtSj
         crJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHNQy+TtQ0F8MQ5t2Kb6nCFPUjzCI8OsSYuq57JXksE=;
        b=aaL6ynsGoxSKtKYJ2TKt0JZ+jk+JPy0li73yi8lchs3jHuWWHhBdE00ijr2saa3k5x
         yKPHx0NziCMGDdTE/v2SnNmAwh4UiIlQvbeLb6jT07+Z8pXJqL0mJly6Q0NB0ga0qkse
         fFbBDcfD1uRSwWFRo+NeqSAtSaT3F2iLZlwrjYLozJ47UVBom6CQh8Lt9hJuWpUu0rOg
         8SrR/vcqjmTST3PxjOFahH2ZVoGdre753h9M1CnMH2IxVYABiq4vab/rZZLjEo8iPuqB
         VsTf1D6Lgex2wvZJCTDWKA0QBOlmgaa7feV8Ml3/PSQhdJWanMdjybePnOAQyOGePpFY
         TJcg==
X-Gm-Message-State: ABuFfoiA28Ceznl4mp5EDtfQjLYU9Vne1UzfE06wRXKI6I8UrrJSNq2a
        Sr28Hqbe2XfZ5rfXUelSKcO49n1zkXgsnq5CsHc=
X-Google-Smtp-Source: ACcGV60t//0vuCgf6HGQOHRcgjzTdCZdd7/wf0ngQERaM/KEAxu0XTnHce/zGdvxWpeEPi8CondCF8FTW8JKBwg1Aew=
X-Received: by 2002:aed:2de3:: with SMTP id i90-v6mr5618806qtd.229.1539775999909;
 Wed, 17 Oct 2018 04:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com> <20181016072244.1216-2-a.hajda@samsung.com>
 <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
 <605bd00e-ed0d-4259-bdc3-1784b2b3b16a@samsung.com> <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
 <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com> <20181017112914.GH30658@n2100.armlinux.org.uk>
In-Reply-To: <20181017112914.GH30658@n2100.armlinux.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 14:33:08 +0300
Message-ID: <CAHp75Vd1JQVx96FLEtTO7a7-OBaC1nUKcoSk4S6wvO6BtjJ-3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 2:29 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 16, 2018 at 04:55:00PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 16, 2018 at 3:55 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > > On 16.10.2018 13:29, Andrzej Hajda wrote:
> > > > On 16.10.2018 13:01, Andy Shevchenko wrote:
> > > >> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > > >>> During probe every time driver gets resource it should usually check for error
> > > >>> printk some message if it is not -EPROBE_DEFER and return the error. This
> > > >>> pattern is simple but requires adding few lines after any resource acquisition
> > > >>> code, as a result it is often omited or implemented only partially.
> > > >>> probe_err helps to replace such code seqences with simple call, so code:
> > > >>>         if (err != -EPROBE_DEFER)
> > > >>>                 dev_err(dev, ...);
> > > >>>         return err;
> > > >>> becomes:
> > > >>>         return probe_err(dev, err, ...);
> >
> > > >>> +               va_start(args, fmt);
> > > >>> +
> > > >>> +               vaf.fmt = fmt;
> > > >>> +               vaf.va = &args;
> > > >>> +
> > > >>> +               __dev_printk(KERN_ERR, dev, &vaf);
> >
> > > >> It would be nice to print an error code as well, wouldn't it?
> > > > Hmm, on probe fail error is printed anyway (with exception of
> > > > EPROBE_DEFER, ENODEV and ENXIO):
> > > >     "probe of %s failed with error %d\n"
> > > > On the other side currently some drivers prints the error code anyway
> > > > via dev_err or similar, so I guess during conversion to probe_err it
> > > > should be removed then.
> > > >
> > > > If we add error code to probe_err is it OK to report it this way?
> > > >     dev_err(dev, "%V, %d\n", &vaf, err);
> > >
> > > Ups, I forgot that message passed to probe_err will contain already
> > > newline character.
> >
> > You may consider not to pass it.
>
> It's normal to pass the '\n', so by doing this, we create the situation
> where this function becomes the exception to the norm.  That's not a
> good idea - we will see people forget that appending '\n' should not
> be done for this particular function.
>
> While we could add a checkpatch rule, that's hassle (extra rework).  In
> any case, I think the message would be much better formatted if we did:
>
>         dev_err(dev, "error %d: %V", err, &vaf);
>
> which means we end up with (eg):
>
>         error -5: request_irq failed for irq 9
>
> rather than:
>
>         request_irq failed for irq 9, -5
>
> which is more confusing.

As I said earlier, I'm fine to either variant and I see your point
here, so, I tend to agree to this variant.

P.S. Andrzej, in any case my Rb tag, which I just gave, stays.

-- 
With Best Regards,
Andy Shevchenko
