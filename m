Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7149C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890CB206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r14O71PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890CB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeI2MwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:52:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35783 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeI2MwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:52:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so486908ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vY+kz8ayoxMh7RQA90JtnFxykE4TIc2bxzF2G41cSOg=;
        b=r14O71PSNFg8djYXMPXLMs9GL8JcikbnjKYWoMKIDffq8Wlhf8euKTDT/VOEGM4KVM
         qE+bv0vuNJtQ2AsQRUkVgqbQAaJhR2mLYqreJx0vsCpvpgTJ2G7b/yGLez1mnciUbIXm
         4yKj1alKj63QfabwLetoZDMa4MAfd4Vg8KjkktftjQPkqp0jCD4qqWH3/iSBisAvB/56
         oWMbpbk9NDH+KmvsTNMJgsSDGy1sSJRhZ49c8Xt6pcMSh3rcK9RuiZefBqFBW45q2lIL
         eDO2uEdWls7qFl5/MAwguQYYwLH9xtSg9xvnUhkPYmzTOUaqxgFgkOVVKk453DA71Guf
         mOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vY+kz8ayoxMh7RQA90JtnFxykE4TIc2bxzF2G41cSOg=;
        b=kW3JSkH54oqDAIBlGqLB3uesIg4VMaz5aoGWH1sQNfGCgQlWTYZEa+AJp174hEMeGD
         2aVGuPY79U9ABeINd04/3/OMS4RpC6tJkOknXqNy7UnG1Hu4Shr/wQkooVatbAN+8n/2
         YNcBv5Q0/i/H08e/jJqaQYXEsigbFC3BGAlPItls/jI32fwRH4gw49O0LhueM3tj0Z+t
         rTgXjiXX25yNJ6F2DfkZufsqqQxmOXwPxX6qbOBT8wg8gi+2CdyN3RidvCPXmtwyxka1
         8+jft/V6g+W63vQ61Yo2y4tzfdmPX/PFwOf81W4iSijPkYyyOHToqKqDNh1RtTEXJB0X
         muLQ==
X-Gm-Message-State: ABuFfojaNPNk7X0fL8kryjAkTb78EWrEoGS65fFu8Tp1zfxhq7HHMK6o
        EGSgrw2k5XWrTkRuZZurCQklH1HhocBj5nmfHVY=
X-Google-Smtp-Source: ACcGV61BJ4cYQom6tuaJ3h8AmEaAFBBFtvPSHJhDTCQjIjVYIPTXRiXNwtj3lf/NSy9NCYf9kMiUA4W+iwXUSFdGTXw=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr944050lji.140.1538202312596;
 Fri, 28 Sep 2018 23:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
 <20180905143643.9871-4-ricardo.ribalda@gmail.com> <20180927133513.487666f0@bbrezillon>
In-Reply-To: <20180927133513.487666f0@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Sat, 29 Sep 2018 08:24:55 +0200
Message-ID: <CAPybu_2hLyhrf+itbJthJG7+uWPs1jiiQaNRvRjh_FLJS65WRQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] mtd: maps: gpio-addr-flash: Use devm_* functions
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On Thu, 27 Sep 2018, 13:35 Boris Brezillon, <boris.brezillon@bootlin.com> wrote:
>
> On Wed,  5 Sep 2018 16:36:38 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > @@ -234,9 +234,11 @@ static int gpio_flash_probe(struct platform_device *pdev)
> >       state->map.copy_to    = gf_copy_to;
> >       state->map.bankwidth  = pdata->width;
> >       state->map.size       = state->win_size * (1 << state->gpio_count);
> > -     state->map.virt       = ioremap_nocache(memory->start, state->win_size);
> > -     if (!state->map.virt)
> > -             return -ENOMEM;
> > +     state->map.virt       = devm_ioremap_resource(&pdev->dev, memory);
> > +     if (IS_ERR(state->map.virt)) {
> > +             dev_err(&pdev->dev, "failed to map memory\n");
>
> You can drop this error message, devm_ioremap_resource() already takes
> care of that (no need to send a new version, I'll fix it when applying).

Thanks for you review. I will do the port to gpiod next monday (I want
to try it on real hw)

Cheers!
>
> > +             return PTR_ERR(state->map.virt);
> > +     }
>
