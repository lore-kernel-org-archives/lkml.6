Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921BD20684
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqMSFs2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfBVA2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:28:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37144 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfBVA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:28:50 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so767932itc.2;
        Thu, 21 Feb 2019 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WIxBzC1qZr0Cp0NDovR/cu0oFlL1ogM53Z5Zrpsubm8=;
        b=CqMSFs2eyj7pb6TL9yKLBDho/iqxXnASXKd4T715uT9m9XdYgZt/Vpu5gOeXjwEieY
         8SvFe7/h3bKU96k//rEE0snkEZiPEgtgmanLDmz6IYQm+3EsXeNEU/P3CtTfhO9tUkc/
         hvJUJTdcVWnf8EbByXalCXY47+j/RODAeTxmqZy+/ljqEArk0XxmgAsiBGBmWkT7o9qj
         bn6r+bp3rjam7mKdnZiCk8Tf9UxJNZyLIrQMFyitPd4OJxu8TUrUhicV3+Lus464qoOL
         hgb7QrtmHPzUPebdkbv4eCGIar+RCVdqJJn1l+WaEAwyJkMlKOHLCzHEWaa1gc/btVc6
         uqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WIxBzC1qZr0Cp0NDovR/cu0oFlL1ogM53Z5Zrpsubm8=;
        b=jXY7nOU4/8boZkFdz462h2tptsvFaetmvdZLcuZwU24iX5/O1D7XYa2LHy8JJDKeTV
         9BJHZVR7cyUNTy+g9GXcc0Ol2cql4XBh9Bl2b9K0kF/ow5bjY347i2Yv41pnCjUMGFiF
         cC05gmQgV2Qf1/4l+3nJCu17jIxJjXNr9BDQ3VuudYex0i4iwj+3XJApgg1xiWaOlGAw
         hF+PlFx/LTeVHbNZ/Wajlh+Akh+HvT3JymooQQzkfhKUp/BIfop4ZndbJxymaJ1uH4Ch
         mlyKTLof/i2Zag5bEYMlkpJfYqsiYl55o9JID4ybdHaA5zIYcfm69r0v5BUdClKrFlPY
         4C4w==
X-Gm-Message-State: AHQUAuZsyzKKMY0TQj68YpYtZqH4KQXFw3La5HQIVcqEjMQrVqnCwQPo
        TmHx1XV8UnsQY4OvJClZGEBNKhQA0GpPUulmRdc=
X-Google-Smtp-Source: AHgI3IZB16asG07nzkyrLUUWpkia12FQy+BoxPh674iaHbOLUbFyAK7J7ajv3psk0nW0CQrGcN9R/TDviJSpnVbaeHg=
X-Received: by 2002:a24:6c46:: with SMTP id w67mr818694itb.13.1550795329734;
 Thu, 21 Feb 2019 16:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20190221203000.10194-1-federico.vaga@vaga.pv.it> <20190221203000.10194-2-federico.vaga@vaga.pv.it>
In-Reply-To: <20190221203000.10194-2-federico.vaga@vaga.pv.it>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Fri, 22 Feb 2019 09:28:23 +0900
Message-ID: <CAEjAshqs2xwauz2JPgkp+nuNZdjo596mGf4kgXjtspUn+iPTZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: process: complete removal of info about -git patches
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-kernel@zh-kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: SeongJae Park <sj38.park@gmail.com>

On Fri, Feb 22, 2019 at 5:30 AM Federico Vaga <federico.vaga@vaga.pv.it> wr=
ote:
>
> The following patch forgot to remove a reference to the -git
> patches
>
> commit 2c71d305caf9 ("docs: process: Remove outdated info about -git patc=
hes")
>
> This patch complete the removal and update all translations
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/process/howto.rst                    | 1 -
>  Documentation/translations/it_IT/process/howto.rst | 1 -
>  Documentation/translations/ja_JP/howto.rst         | 1 -
>  Documentation/translations/ko_KR/howto.rst         | 1 -
>  Documentation/translations/zh_CN/HOWTO             | 1 -
>  5 files changed, 5 deletions(-)
>
> diff --git a/Documentation/process/howto.rst b/Documentation/process/howt=
o.rst
> index bdd2eda81a1c..80488a5e6738 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -237,7 +237,6 @@ branches.  These different branches are:
>
>    - main 4.x kernel tree
>    - 4.x.y -stable kernel tree
> -  - 4.x -git kernel patches
>    - subsystem specific kernel trees and patches
>    - the 4.x -next kernel tree for integration tests
>
> diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documen=
tation/translations/it_IT/process/howto.rst
> index 15199aa5b4df..9903ac7c566b 100644
> --- a/Documentation/translations/it_IT/process/howto.rst
> +++ b/Documentation/translations/it_IT/process/howto.rst
> @@ -244,7 +244,6 @@ e di molti altri rami per specifici sottosistemi. Que=
sti rami sono:
>
>    - I sorgenti kernel 4.x
>    - I sorgenti stabili del kernel 4.x.y -stable
> -  - Le modifiche in 4.x -git
>    - Sorgenti dei sottosistemi del kernel e le loro modifiche
>    - Il kernel 4.x -next per test d'integrazione
>
> diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/t=
ranslations/ja_JP/howto.rst
> index 4fbf40552728..2621b770a745 100644
> --- a/Documentation/translations/ja_JP/howto.rst
> +++ b/Documentation/translations/ja_JP/howto.rst
> @@ -256,7 +256,6 @@ Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AE=
=E9=96=8B=E7=99=BA=E3=83=97=E3=83=AD=E3=82=BB=E3=82=B9=E3=81=AF=E7=8F=BE=E5=
=9C=A8=E5=B9=BE=E3=81=A4=E3=81=8B=E3=81=AE=E7=95=B0=E3=81=AA=E3=82=8B=E3=83=
=A1=E3=82=A4=E3=83=B3
>
>    - =E3=83=A1=E3=82=A4=E3=83=B3=E3=81=AE 4.x =E3=82=AB=E3=83=BC=E3=83=8D=
=E3=83=AB=E3=83=84=E3=83=AA=E3=83=BC
>    - 4.x.y -stable =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=84=E3=83=AA=
=E3=83=BC
> -  - 4.x -git =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=91=E3=83=83=E3=
=83=81
>    - =E3=82=B5=E3=83=96=E3=82=B7=E3=82=B9=E3=83=86=E3=83=A0=E6=AF=8E=E3=
=81=AE=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=84=E3=83=AA=E3=83=BC=E3=81=
=A8=E3=83=91=E3=83=83=E3=83=81
>    - =E7=B5=B1=E5=90=88=E3=83=86=E3=82=B9=E3=83=88=E3=81=AE=E3=81=9F=E3=
=82=81=E3=81=AE 4.x -next =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=84=E3=
=83=AA=E3=83=BC
>
> diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/t=
ranslations/ko_KR/howto.rst
> index d8acf255ac5f..bcd63731b80a 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -242,7 +242,6 @@ ReST =EB=A7=88=ED=81=AC=EC=97=85=EC=9D=84 =EC=82=AC=
=EC=9A=A9=ED=95=98=EB=8A=94 =EB=AC=B8=EC=84=9C=EB=93=A4=EC=9D=80 Documentat=
ion/output =EC=97=90 =EC=83=9D=EC=84=B1=EB=90=9C
>
>    - main 4.x =EC=BB=A4=EB=84=90 =ED=8A=B8=EB=A6=AC
>    - 4.x.y - =EC=95=88=EC=A0=95=EB=90=9C =EC=BB=A4=EB=84=90 =ED=8A=B8=EB=
=A6=AC
> -  - 4.x -git =EC=BB=A4=EB=84=90 =ED=8C=A8=EC=B9=98=EB=93=A4
>    - =EC=84=9C=EB=B8=8C=EC=8B=9C=EC=8A=A4=ED=85=9C=EC=9D=84 =EC=9C=84=ED=
=95=9C =EC=BB=A4=EB=84=90 =ED=8A=B8=EB=A6=AC=EB=93=A4=EA=B3=BC =ED=8C=A8=EC=
=B9=98=EB=93=A4
>    - 4.x - =ED=86=B5=ED=95=A9 =ED=85=8C=EC=8A=A4=ED=8A=B8=EB=A5=BC =EC=9C=
=84=ED=95=9C next =EC=BB=A4=EB=84=90 =ED=8A=B8=EB=A6=AC
>
> diff --git a/Documentation/translations/zh_CN/HOWTO b/Documentation/trans=
lations/zh_CN/HOWTO
> index 8e7dee80a087..7a00a8a4eb15 100644
> --- a/Documentation/translations/zh_CN/HOWTO
> +++ b/Documentation/translations/zh_CN/HOWTO
> @@ -192,7 +192,6 @@ Linux=E5=86=85=E6=A0=B8=E4=BB=A3=E7=A0=81=E4=B8=AD=E5=
=8C=85=E5=90=AB=E6=9C=89=E5=A4=A7=E9=87=8F=E7=9A=84=E6=96=87=E6=A1=A3=E3=80=
=82=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E5=AF=B9=E4=BA=8E=E5=AD=A6=E4=B9=A0=
=E5=A6=82=E4=BD=95=E4=B8=8E
>  =E4=BA=9B=E5=88=86=E6=94=AF=E5=8C=85=E6=8B=AC=EF=BC=9A
>    - 2.6.x=E4=B8=BB=E5=86=85=E6=A0=B8=E6=BA=90=E7=A0=81=E6=A0=91
>    - 2.6.x.y -stable=E5=86=85=E6=A0=B8=E6=BA=90=E7=A0=81=E6=A0=91
> -  - 2.6.x -git=E5=86=85=E6=A0=B8=E8=A1=A5=E4=B8=81=E9=9B=86
>    - 2.6.x -mm=E5=86=85=E6=A0=B8=E8=A1=A5=E4=B8=81=E9=9B=86
>    - =E5=AD=90=E7=B3=BB=E7=BB=9F=E7=9B=B8=E5=85=B3=E7=9A=84=E5=86=85=E6=
=A0=B8=E6=BA=90=E7=A0=81=E6=A0=91=E5=92=8C=E8=A1=A5=E4=B8=81=E9=9B=86
>
> --
> 2.20.1
>
