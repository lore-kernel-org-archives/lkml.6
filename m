Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE152085A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ58E2+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfBTNQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:16:27 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37014 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfBTNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:16:26 -0500
Received: by mail-yw1-f67.google.com with SMTP id k14so9164816ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FAlIGQCYj27WzYwAN2yS5eVNYPmVEv6xTu9i5VkvUJg=;
        b=qZ58E2+Rz+r4uOfnHb7+Rvb8IW0J3Lskl7qEDQYV3wOB5bgYbsNDWOvQ8vCEOdF1O3
         7zRYpgJaxYUCKjkND2yugrlnWdC5WdQD55m5BxOzJTkXfT6ECI9WQpauzaMdennYsKaD
         bxLRQ+Ibr9AfEqngwb0KX04f2LGDf5C2o+j74cDFjdOZUDrYm628h9MlSssVoOKh5dM7
         /MzHSso0AL1NyTfc1EqgkS76Y40jawGBbIMoxY2UnsTZM/p/GceRQQZ7qzXBxS/gqBi5
         CIRZyiHDi1bIhgSlyUiaZo7fCcjIBt5Ez3jMqzMfC6BJBdnqEw5pr167xoaWy1T55q1A
         demQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FAlIGQCYj27WzYwAN2yS5eVNYPmVEv6xTu9i5VkvUJg=;
        b=lzzTVOUGleU9Je3BXJAwUHbcN8a/Z4s2B9BHePtw/Skda/DTWKM9HfrpXWhjXcEo3d
         Xf1Nw7+ZmUR/7jE0Sx8KGJNQc8pBtkf+zUF2I/bWZI8AAwU4zzAozRe+P3CLxtQCpR+5
         4XW7PlCHMR9yEPRmxTFw0R+KW6imvXhM9kSbBs/DgBgnGfKgJAfKhfHmCyN2z2xsJCx0
         I/annW1XlhWfBkkJZd7flhMUM9WP23qbdhzxKyaTG3hrcizakRjUXgTl9qapWe+nakt3
         Hrn49cTChqnXOnHx/t7/rR+ZUkQj5aWpTMSXK8uqT8PgUtlmFHQpEwJORY+DAagME31c
         Kx9Q==
X-Gm-Message-State: AHQUAuZZ6zMyLjj+qlBfL9PEi9oNEZCaP0uDbeJ+bXDyqXQY0tJOxlo/
        5MHX5D8hEpDPPWt9rgey+fiVA5pyIlPQ3nKYC7PYV1z7cS0=
X-Google-Smtp-Source: AHgI3IYYQq9FKrCXNUp5a3y1mW0Opvom5VBRxBQe6l6oivu6QLLeBzvfsccSA2SJy6Wfefn/E/Iz17sCC7rzniMWpR4=
X-Received: by 2002:a81:20d4:: with SMTP id g203mr28331506ywg.142.1550668585192;
 Wed, 20 Feb 2019 05:16:25 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com> <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
From:   Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date:   Wed, 20 Feb 2019 22:16:14 +0900
Message-ID: <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
2019=E5=B9=B42=E6=9C=8820=E6=97=A5(=E6=B0=B4) 21:28 Arnd Bergmann <arnd@arn=
db.de>:
>
> On Wed, Feb 20, 2019 at 12:27 PM Sugaya, Taichi
> <sugaya.taichi@socionext.com> wrote:
> >
> > Hi
> >
> > On 2019/02/20 18:28, Arnd Bergmann wrote:
> > > On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
> > > <sugaya.taichi@socionext.com> wrote:
> > >
> > >> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/con=
figs/milbeaut_m10v_defconfig
> > >> new file mode 100644
> > >> index 0000000..a263211
> > >> --- /dev/null
> > >> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> > >> @@ -0,0 +1,175 @@
> > >
> > > I no longer see anything here that should be turned off, but you
> > > might want to run 'make savedefconfig' and use the output of that,
> > > to make it easier to keep it up to date.
> > >
> >
> > I got it, I use the output of 'make savedefconfig'.
> > One question, is that OK to add some options on it?
> >   -Because "CONFIG_ARCH_MILBEAUT" was not listed.
>
> What I'd do here is to apply all the patches you want to get merged in
> the next few releases before running 'savedefconfig' and use the output
> of that.

Let me check. Would you mean that the defconfig will include all those
drivers configs, which will not appear at this moment?

> If you already know that you will need the options, including
> them now means you don't have to update the defconfig file
> as much in the future.

I just concern that if other subsystem maintainer comments
on the config name. Even in that case, can we just update the
defconfig with new name?

Thank you,

--=20
Masami Hiramatsu
