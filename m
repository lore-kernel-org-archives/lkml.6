Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E51B214FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoL+He73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E51B214FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeGDQL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:11:59 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:32941 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeGDQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:11:55 -0400
Received: by mail-ua0-f195.google.com with SMTP id g18-v6so3746369uak.0;
        Wed, 04 Jul 2018 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=etP9KNRNqMHrRxJ/igl4EiGPgokvO9OGvtLxpdLY4Xk=;
        b=hoL+He73ZHix+IJ2Kq82Ftv6UyDI5eZzGYg/dAJAowuFQosw6GlL7pOyVHbW8D3B8j
         LZ6TtzSvk9OYmPTuAv2GwZZGoA+lOYFXbqyRnbl0A6CqS1nd6LdBiNf5O5+tS+tC2EKa
         bIVXjPlYehwIYx0ddBfalqJzimu1XkyIhE+HOMz5IBF4TLDbXdLlJsp1oS57W+gV6yQm
         NQfXiYpowVRtxnIMYxHVY286xeSNETS9p6Uw7oCBBv7rOOEXMCgX0RkiuVfYp1DEdZ1S
         13hbEYvAtPUqVcwKgxRkW4e4q7zCX4NDnIY+nkzy5KHbBMMXFL0FL1ZVGiUiLIGlwAdR
         TXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=etP9KNRNqMHrRxJ/igl4EiGPgokvO9OGvtLxpdLY4Xk=;
        b=gRJnZzEs6MzCnR4474pXQyipacW3+nil4O/7qxI9Md7nSmjr7dObD1Xl93GXJknT6O
         t33N4SctZSZXIew0U50hpm25ovgIZqliSRjlHTB6/Km/kjrEr1mMXu5pVipspoXF0J9I
         eUyjdf8aQWpIAoyMyhl0YNWblURSaJKMMtlX0CSQmRT0C9Cp/GilmUtVxoqki3CM9wZy
         PjQ2/NHMaPhotpfjGhUlN07U8AhFGjbpO965Zky8Lv1+Ev2yDx2JyY/PB1bB3AyaRbaa
         EQm5IdUJhSPmkoSlsBEnCIpJniZLr/bUa3YkItegk2Yk5VKVVMOe7g5CJGVbjdSeRXS5
         +O5Q==
X-Gm-Message-State: APt69E1+Xq8Rl4XMz8YNPqXUNyou3FWrbQoCJPwzEbpZnPqR+eln61IM
        xsStMtBkeiOHy+oYJKURUzYXP4e+p/OHdVmNIQY=
X-Google-Smtp-Source: AAOMgpdPRtA8GDQ6KbaccTCZLij6PD3ayJ9JfA9f+LYjNy0MMtWJpNkTQ7Noxp8CQgKykTa3Ya5asx1LYa8+aDFZv4s=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr1582297uai.122.1530720715174;
 Wed, 04 Jul 2018 09:11:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:11:54 -0700 (PDT)
In-Reply-To: <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041332340.9872@fox.voss.local> <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
 <alpine.DEB.2.20.1807041420160.9872@fox.voss.local> <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
 <alpine.DEB.2.20.1807041501420.11004@fox.voss.local> <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 19:11:54 +0300
Message-ID: <CAHp75VeNAfKF6C1RuMJgHMLDSBFH7=X9YJSzsueM7soMYSKung@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 4:44 PM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 07/04/2018 03:24 PM, Nikolaus Voss wrote:

>> I hope you're still not annoyed...
> Don't worry for that, it's very hard to get my annoyed :)

Javier, thanks for your patience and nice explanation!

-- 
With Best Regards,
Andy Shevchenko
