Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34201C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2ED2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFjcZgjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2ED2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeLDPac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:30:32 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54955 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:30:32 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so15937048ita.4;
        Tue, 04 Dec 2018 07:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53h13QCmBRAPqXPxhLeaCkZF+BdeUpdULO+iYx58oFA=;
        b=fFjcZgjQ/ZJRLWOGKnqpLUgXyZ7lCsySTq/FPo4jJ2aszNdIkPDPYmzxzGxp0j8r4z
         2TI26a+TTE79u6Lxq/ABU3Zrpy/g3xNVEZvNKzbZm+8aOV/K5pTNtzr6LLKasAaVzyk1
         Rgyu1F25wAVTt/Z+TNAGEptBP/GUr/SX2ckmoQ+c2qog7/sUtiDIAdoZvgbWwq/TlG/9
         DBoHgQhcZcdWhjFWqV2meMGzvQrKmpgnb/sdGG7cCxZVu9yJ+I3AmUhiJXLU8qK759DJ
         JPaNdj1F348+iRPWi9/Uc1x0yqQ1xQKv3E29ge8+3804TpRrDxi/7Nf/T2kibCiiAEvJ
         JZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53h13QCmBRAPqXPxhLeaCkZF+BdeUpdULO+iYx58oFA=;
        b=BK0a1ofyIGkV8WVNxB4G7GoMyPgYyQfHP3FEUQ0BgOwAgVGZg67f+fA3y8/Cuz6KHo
         +1Aar/RJoRnTzcCJNFwmiYWrSBMg2EEbq6dv8FAa1Z9BypnYnBRsPzLoSC+aor9KWt0V
         N0Ll7xzGRC8hBCbnYhwObn6K9gP7psH9/aaiY4+CzCF9OB09+ZVvGbNO+a88m2T3MB4c
         eeU2etzH3hkulDQzlM7Hk4f+u1n4U6yEJzFPz3lTVVKk05aznvKdyD5v/B+r3RhHc52c
         RH8TbqlLO0twY6N90YfVVr6Qm9kQEhl94WobZWmiaf+UXTdvdd2F8X2Kyt/PiGfTtdXb
         XQ3Q==
X-Gm-Message-State: AA+aEWZ8LXb0FFfpixhpdFTdCGy5ooq0g635i4IxVXQnZJbyqlyopGIK
        3X8BVfoaFNtP7fwUmsIZeRnTrS9YZumNHsNHMPAHOi7SSvA=
X-Google-Smtp-Source: AFSGD/WIBCys310n8gAWltxvUHI6Z6elPb9soow2rCfn8A6qzfvuF6SRD/T0NmiSvpHnZLYi9FgrwYM82HsF+0zTXfA=
X-Received: by 2002:a24:648f:: with SMTP id t137mr11512984itc.95.1543937431188;
 Tue, 04 Dec 2018 07:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com> <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
In-Reply-To: <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 4 Dec 2018 23:30:08 +0800
Message-ID: <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     rajneesh.bhardwaj@intel.com, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org,
        David Box <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 8:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 5:59 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > On Tue, Dec 4, 2018 at 3:09 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Sat, Dec 1, 2018 at 5:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > >
> > > > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> > >
>
> I like your patch, but...
>
> > > By some reason it's not applicable.
> > > Please, rebase on top of our for-next branch, thanks!
>
> > For what reason?
>
> ...because I can't apply it, it fails with conflicts.
>
> >  I thought that for-next branch has not changed much.
>
> That's correct, it's updated only by approved patch series which is
> not many _this_ cycle.
I am confused about what you said.
Because I pulled your .git down, there is no conflicts when apply it.......

MBR,
Yangtao
>
> --
> With Best Regards,
> Andy Shevchenko
