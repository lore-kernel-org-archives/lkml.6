Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B54FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D145720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6JF98jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D145720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKITin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:38:43 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38347 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKITin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:38:43 -0500
Received: by mail-yw1-f65.google.com with SMTP id i65-v6so1415670ywc.5;
        Fri, 09 Nov 2018 01:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eD/fA43NB2RWmxgi4NEd4Qq7I5TsTM1rqiC6H166UQ4=;
        b=e6JF98jbyAfDoKZt2THKHJR6S1srWjhK2zG/57IBJxX7j2teBgPHGJxperP655ZbjI
         KB0sXA7sYQ/YJPwjNygAFGN58vP9sr9XT7afYgwcvfoCSImSA+eDywdgXjvPdq5xMFjV
         eS+OcslmUgNYJkR6mmJe5HsnKWEaO7q1v+aO+pa1L+qOqZz7H0l8aXobV3xNoiMHN5+Q
         jIKVkg8VhToPeLdsIO3QLOHt7T+cdtWD3WH8ElfeoLE4HkQQQ6uRDh24+4GjiZLkzuuE
         meRC+knGL81KaUz7dcJXkUKRoP2b2fLNKx+0XKDFogWfg5+bF6xdO/pWh8FLkGi3xeyM
         H7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eD/fA43NB2RWmxgi4NEd4Qq7I5TsTM1rqiC6H166UQ4=;
        b=QsQn8cQQFp9tCljfRfDnK03L9IEsW3IoHmTh+qBM16mKuGmrkCl5FyhbOjARAHPXDP
         1nQxkybE+brIazbVVE+WNYyvrsMd9QL8B3plP+rp6CfksyAkEw7Oc0zU4v98mSqzlpDd
         NDJS/dMCPrP7oACKQOkKNcdGvu7ZJoR2x/OOCLlVSAFA+WFHU8g+iR8fxBS2bfpzvc+7
         IeQ3ZW1lzki3Vat2mYbx7xdGhnZ9agyCmQp3/uTjNT6d/qg5fvodCINZQ+6wthUPwc29
         l6oQA8faCwgUzGlwC9RyyzyeQs3qOsMfRxqyIhHWJMdwxoQjtyzLJRtLePc0MOQT8DM8
         U1tA==
X-Gm-Message-State: AGRZ1gIJYMGbdvq3m5pflQfhXyfN+H44Xp4LV9pxa9WpXXb4iKVwn2DS
        oGpkC9J/sHBwTKAM8Qk+O7HA0cPKavBp3r4xBnY=
X-Google-Smtp-Source: AJdET5daLg/7adEwE/+25igO/Zm8x5m27MO1Q4qQCncLzwyih4eFf/SxFP69VGDUyfiM5/g6Q68pmCQHg+Jhq0Mgc5A=
X-Received: by 2002:a81:7bc1:: with SMTP id w184-v6mr7612257ywc.345.1541757532351;
 Fri, 09 Nov 2018 01:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107161247.sesu2comhes2d4kx@pengutronix.de>
 <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com> <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
 <20181108122246.GB1340@ulmo>
In-Reply-To: <20181108122246.GB1340@ulmo>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 9 Nov 2018 10:58:41 +0100
Message-ID: <CAJiuCcc07mTfqk1UOKqkSuJGOR-2AN18EJZ7qcvzkKoTGeUhaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus arch
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        u.kleine-koenig@pengutronix.de,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Thu, 8 Nov 2018 at 13:22, Thierry Reding <thierry.reding@gmail.com> wrot=
e:
>
> On Thu, Nov 08, 2018 at 11:47:53AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Uwe, Scott,
> >
> > On Wed, 7 Nov 2018 at 17:48, Scott Branden <scott.branden@broadcom.com>=
 wrote:
> > >
> > >
> > > On 2018-11-07 8:12 a.m., Uwe Kleine-K=C3=B6nig wrote:
> > > > On Wed, Nov 07, 2018 at 10:36:12AM +0100, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > > >> The Cygnus architecture use a Kona PWM. This is already present
> > > >> in the device tree but can't be built actually. Hence, allow the
> > > >> Kona PWM to be built for Cygnus arch.
> > > >>
> > > >> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > >> ---
> > > >>   drivers/pwm/Kconfig | 3 ++-
> > > >>   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > >> index 763ee50ea57d..76d56fc8b1b7 100644
> > > >> --- a/drivers/pwm/Kconfig
> > > >> +++ b/drivers/pwm/Kconfig
> > > >> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
> > > >>
> > > >>   config PWM_BCM_KONA
> > > >>      tristate "Kona PWM support"
> > > >> -    depends on ARCH_BCM_MOBILE
> > > >> +    depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
> > > >> +    default ARCH_BCM_CYGNUS
> > > > Is it possible to build this driver also on other arches? Then you =
might
> > > > want to consider
> > > >
> > > >       depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> > > good idea to add the COMPILE_TEST just to increase compile coverage
> >
> > Will Do.
>
> This is known to potentially break builds on things like UM where we
> have !HAS_IOMEM. Please make sure you thoroughly build-test before you
> switch on COMPILE_TEST.

Thanks for the point, so something like this (but maybe it's too
protective no ?) :

config PWM_BCM_KONA
        tristate "Kona PWM support"
        depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
        depends on COMMON_CLK && HAS_IOMEM && OF
        default ARCH_BCM_CYGNUS

Regards,
Clement


>
> Thierry
