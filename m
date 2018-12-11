Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1FFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200832084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="abhuCIta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200832084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLKKzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:55:50 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36927 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLKKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:55:50 -0500
Received: by mail-io1-f66.google.com with SMTP id f14so11442791iol.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZMBhKDg4pKiTmlT/8UOyZXJmoDT5fBnrkWFkFHiKAk=;
        b=abhuCItaTd/Oq31WI0QDJh92mo71L7Ha/pz+oZUfl4myy8nCeSJwmiQaK0b2vRQm3Q
         QUUKPAgmFsS9hTHG4kIaPYmcjkVojcZ3G3VxxxgZFkd4jPkZ4SDoVjMu2eNuk2BKuT2h
         AaBi3+4MK0ObPBqWeYNxyUcY2niNWS7LKzx/yZucaZfMa8lJs1PAjF2crPTKxDjENNUz
         kvNfueHVmjVE88lp/SCvsS1JqEYAD/b8crMmD0/JZgAs/gVL0rdl4cF6f1fiAvXKgy34
         1H4j7V34Y5p5VP+gzZdP/Y4V6C6GLYMpM9xKd2tc9E5L7YggCbzr3uL+ULVFxDD8RVxB
         6KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZMBhKDg4pKiTmlT/8UOyZXJmoDT5fBnrkWFkFHiKAk=;
        b=JA0vovwZ8zAigo42cXPtS+aFcl6NtaSY0M5Lwknl6QK7KLEKpC38hq/JEPOOsTSlIj
         bftvACvuNTtT2yBv/aSE9OW+3dAT1MAfNK0+I9JwDgk+3/BTqgE3ZLXTX75Q8z5klkjH
         GWj55k/+q1THmlklnYK9/72S1rcEFsehlFTZWPsZ9m+sSpoujR8aBcvMUblZ+6WTOBgS
         3B8Aq6yDlUpT8k7knXFt0zs3SQ2Auw5HQvat1wW9LEtgO5MT2cx6a3Xvaf240GoXwLSQ
         ohZG/TyxdrG+6e6ZgRIkPmDB2WtGvZuqRm/pmnvQbOZ6e/nPyvcu6K3wBY1RhbZMDF32
         Wenw==
X-Gm-Message-State: AA+aEWYPOtiem8lbXVjakZXBrLFFKBLgojNJtKjoaJu7idLNE835nMLM
        wg8YIlqBhO9MCFOT//6gt7Ox0/AWcmUxxlOYcR/XyQ==
X-Google-Smtp-Source: AFSGD/WeRAkhHyqQJqzUTVcpiBu+fol201V/MqWUw0nynDrk/KqJVFk0v4ML4KgETpxfpXQOCENSi4GYaKxU2MYgFUw=
X-Received: by 2002:a5e:aa06:: with SMTP id s6mr12239041ioe.187.1544525749521;
 Tue, 11 Dec 2018 02:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20181210151024.3906-1-brgl@bgdev.pl> <20181210151024.3906-3-brgl@bgdev.pl>
 <20181210154125.GE6307@sirena.org.uk>
In-Reply-To: <20181210154125.GE6307@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 11 Dec 2018 11:55:37 +0100
Message-ID: <CAMRc=MfC-E9DpMhDSXSQ-o5xG1ONccbT35=0rHsZy6oLt9j8cA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: provide regulator_set_voltage_sel_regmap_step()
 helper
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 10 gru 2018 o 16:41 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Mon, Dec 10, 2018 at 04:10:24PM +0100, Bartosz Golaszewski wrote:
>
> > On some devices we need to manually ramp the regulators to desired
> > voltage one step at a time. This patch adds a helper routine for
> > regmap users that checks if the regulator is enabled and, if so,
>
> My first question would be why do this at the regmap helper level, why
> not do this at the core level by stepping through selectors?  I'd also
> expect to be programming the step size here, while some regulators
> aren't able to regulate well over larger step changes I'd expect that
> they wouldn't need to step through every single possible voltage value,
> that's potentially extremely slow.
>

This sounds like a good improvement to the core regulator code indeed.
I'll give it a try but I'm not sure I'll have something before the
next merge window, so for now I'll put this logic into my driver that
I'd like to get merged for 4.22 and we can factor it out later on once
we agree on the right approach.

> > +     asc =3D diff > 0 ? false : true;
> > +     end =3D asc ? sel + 1 : sel - 1;
> > +     asc ? curr++ : curr--;
>
> Please just write normal conditional statements so the code is more
> readable and hence maintainable.

Sure.

Thanks,
Bartosz
