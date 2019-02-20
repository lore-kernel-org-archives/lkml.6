Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B156BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF702086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VG8D8PJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfBTNXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:23:19 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46112 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTNXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:23:17 -0500
Received: by mail-yb1-f194.google.com with SMTP id 7so9537671ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UPBimqpX1XmXfQQA5dxV0A4d1+kbj31tNEUudF2+Ju0=;
        b=VG8D8PJQA2/tlOWaEfqfFoc14YHCnxlRxmd/+RnHm1bxZXGpIVLxc4lcpSeiv68ULv
         gkCHPcKsKNRSNANxL5DfBRj3xmapPeNnwlKIdcbIqyI3pZjD8Pu/RsQRuo/iEq5n6v+l
         NbilojFtwDrTeHoV6OCYFMDPEa7QX9iV29WqDFiCy6rclyFSUJIZ9HDdEOT46L9ylazy
         sj22IVCagIlxaiUszKJg4dkXbNOnmasb2NvQj0EqQ81t35MyjRNqMTFkJwBwQjxz/UTb
         tIOQettP9vvIffs35BygcArfU60cMNqv4mKfxWexqOmZ95f7oBIwXyWTQdu+m9TCwuXk
         JcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UPBimqpX1XmXfQQA5dxV0A4d1+kbj31tNEUudF2+Ju0=;
        b=ElvvZn9hBftt4HdUSuJyc0PCe7htSqDjR143PEsT1aL+KYw2StCQSV9avbiMvTXDLt
         i55KfGwTAPeygzY9sQt3wF+inBOOge8Ha095KIvxQoaxzdPBFbKoUYeBxEf8t7Q1U8HX
         9c7K+/G/iELzsNUTg+8ffnlde2rRhFLbxFtY52/xSU+lCgMnSuIid1E581uJX61T/tdp
         cF1+WdvQkeFy1e0Tv6VU2NimQ3PvaF6TkXzbXWRIKWbu6unY6ZNesrkl/idHX4iS2G//
         IuoLI6kO+wYUXD9ic6xguTo8j8kbDCfls4pRuGz+uqf0TxjvY7e/dwUHYoV2Cz4o02xO
         v6sg==
X-Gm-Message-State: AHQUAuZi+GlUElbFpOZWL0wzN2JFZhjz+0RiUIQ6nmwqWkDxE+Idob0w
        FF2KgIATxwWx/MwlBNWiWL/mwoQ/BYBzNnvQdBm+og==
X-Google-Smtp-Source: AHgI3IY231O3KisMBH/4GvvgbcbIbpjDiA8V5kAxX/MkEpzKSdIOBP0FYVhIVd1g44xSVYb9L9+IUtdbREmLu2VT6cM=
X-Received: by 2002:a25:57c4:: with SMTP id l187mr13805906ybb.269.1550668995675;
 Wed, 20 Feb 2019 05:23:15 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com> <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
 <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com> <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
In-Reply-To: <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
From:   Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date:   Wed, 20 Feb 2019 22:23:04 +0900
Message-ID: <CAA93ih3EUfgw9TeduOCOJZzWjQEv_VKp9t0+rdZA6rwk_8ThLA@mail.gmail.com>
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

2019=E5=B9=B42=E6=9C=8820=E6=97=A5(=E6=B0=B4) 22:18 Arnd Bergmann <arnd@arn=
db.de>:
>
> On Wed, Feb 20, 2019 at 2:16 PM Masami Hiramatsu
> <masami.hiramatsu@linaro.org> wrote:
> > 2019=E5=B9=B42=E6=9C=8820=E6=97=A5(=E6=B0=B4) 21:28 Arnd Bergmann <arnd=
@arndb.de>:
> > > On Wed, Feb 20, 2019 at 12:27 PM Sugaya, Taichi
> > > <sugaya.taichi@socionext.com> wrote:
> > > > On 2019/02/20 18:28, Arnd Bergmann wrote:
> > > > > On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
> > > > > <sugaya.taichi@socionext.com> wrote:
> > > > >
> > > > >> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm=
/configs/milbeaut_m10v_defconfig
> > > > >> new file mode 100644
> > > > >> index 0000000..a263211
> > > > >> --- /dev/null
> > > > >> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> > > > >> @@ -0,0 +1,175 @@
> > > > >
> > > > > I no longer see anything here that should be turned off, but you
> > > > > might want to run 'make savedefconfig' and use the output of that=
,
> > > > > to make it easier to keep it up to date.
> > > > >
> > > >
> > > > I got it, I use the output of 'make savedefconfig'.
> > > > One question, is that OK to add some options on it?
> > > >   -Because "CONFIG_ARCH_MILBEAUT" was not listed.
> > >
> > > What I'd do here is to apply all the patches you want to get merged i=
n
> > > the next few releases before running 'savedefconfig' and use the outp=
ut
> > > of that.
> >
> > Let me check. Would you mean that the defconfig will include all those
> > drivers configs, which will not appear at this moment?
>
> Correct.
>
> > > If you already know that you will need the options, including
> > > them now means you don't have to update the defconfig file
> > > as much in the future.
> >
> > I just concern that if other subsystem maintainer comments
> > on the config name. Even in that case, can we just update the
> > defconfig with new name?
>
> Yes, that's easy enough.

OK, I got it :)

Thank you!

>
>       Arnd



--=20
Masami Hiramatsu
