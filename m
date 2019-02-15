Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A747C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E72218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFJysJLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391009AbfBOH6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:58:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38735 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfBOH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:58:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id h58so7182113edb.5;
        Thu, 14 Feb 2019 23:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9hadSi4LFcMfVTlwwQG+41oFCFy8OhnB/f4tmYYI81c=;
        b=hFJysJLWkGLtXG1O5bEgyGRtaiEsrbDgqrAmcqolx1PRFxSXlR2/gtI/gSrbU8Dtu1
         /f47WdBKnG7pGHxKRqgnqSuzk4hnwcAH63OCYSf21D2Djg/rcpibvn6gz3AhMhD5ZHRK
         +jjDWjFEYH42HrtWf1zUe83/sLVovkTFlJ8jlC5+zn+V2JKvBLDQ9K1OLut3CTfjpy9v
         uHHAl8YoQEK60thdD73+TRj2unwTfB0P5ZeyhBiVZTiLjDeanAv+SP74SEo8CCTpUrr/
         AeLVZ4wyC9695moE3AxZjltTQzeilvvms5tSoUNTAGKFt5N0mAq1YU2Yw7xfIgQDjUGQ
         lDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9hadSi4LFcMfVTlwwQG+41oFCFy8OhnB/f4tmYYI81c=;
        b=C6fT72l/lzeiZP0lw6b6iNiTp0IuFTYM05rWPYSppZ8LTRBYs+k969VRY2DuDrRCVG
         eKAeyraXrpSN6vMqZDzDsJlqboicQ7quP4q5UkEZlCC1xwSSSfDdkGoiSGagYQ0ZyRWW
         EAr28WgzCzjj9hRAyOV6w770AlJKf5tzBwSQf0LhPYodbQyNCJ6Ft3oFnB2FBnTXXz8R
         lL7DWzgxgbyoUb7Ehog3PtJKLzn4n32cry2PmXBxEEKEccWqLQnbI/9KFVxYLLuUtoNl
         4/yyEe9NZzRtWEK1kBKqOhakgxHBbCtsHPf3UEoLRajyB9pCKa5bh30ZTanp66GtHt/u
         zQrw==
X-Gm-Message-State: AHQUAuYcmmuBIFXvWaXPf82dZrmrymw4Vd2niFxiDxpMTAnzjEx28P1N
        DXbV7N0szx6x+FI52lhDn/iYhg4PKIn6KxChjHCQjgI4
X-Google-Smtp-Source: AHgI3IYk+97brw7+2M2gsoq0t5Rme1jfRYz4kkvzqwCZT7uVIBuSU1MdnUBpIqQHCaGv8ygJYxBFb/p5CQiqNo7uGOE=
X-Received: by 2002:a17:906:1c4b:: with SMTP id l11mr5664488ejg.20.1550217529477;
 Thu, 14 Feb 2019 23:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-7-hch@lst.de>
 <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
In-Reply-To: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 15 Feb 2019 15:58:11 +0800
Message-ID: <CAEbi=3ctaYwjCxOVaCyUrvT=741keKPwXj6v8rS9bzoTZPcsOA@mail.gmail.com>
Subject: Re: [PATCH 06/11] lockdep: consolidate the LOCKDEP_SUPPORT symbol
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xtensa@linux-xtensa.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada,

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B42=E6=
=9C=8815=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:17=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> +CC Greentime Hu
> +CC Vincent Chen
>
>
> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add one definition to lib/Kconfig.debug and let the architectures
> > select if it supported.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
>
> This changes the behavior of nds32.
>
> So please leave a note in the commit description.
> (Ideally, we want Ack of a NDS32 maintainer)
>
> Also, please do compile test for NDS32.
>
>
> -------------------------
> This commit changes CONFIG_LOCKDEP_SUPPORT to y for nds32.
>
> NDS32 selects LOCKEP_SUPPORT, but there was previously
> no config entry of LOCKDEP_SUPPORT in nds32.
>
> It is now available in lib/Kconfig.debug,
> so this commit enables LOCKDEP_SUPPORT for nds32.
> -------------------------

Thank you to let us know this change.
I think it's ok to enable LOCKDEP_SUPPORT for nds32.
I just verified it in 5.0.0-rc1.
