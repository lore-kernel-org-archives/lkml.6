Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256CAC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82AA204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1hJhHW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82AA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJIOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:47:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35052 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:47:47 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so1228566itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KRVMNeVbDrXeH53OKl1dAq2KW5cWSquk+kBb0bVCIYA=;
        b=q1hJhHW89prL+AZpHaqnF/IzjpgNMc0JSgzBYy/8yhY0JOLDFzCm1AcJAyy/MTYd1e
         5BQp/XCE6hHS+Zn1J4DHj7j1JzSWUAGESjyElbQi+IjXuZmulfCgpixQZkbl+SkB7xMy
         imYjsGmXZw+n+QUDodJB3yGEHgTtBHXUM3OyzO/7/TG3+MAuI2CoBDv6nCtL4YQR66Li
         ML0LPv7kjY54X7w5OzCirYVhzU8cCE8Rm0t+dAPZ2wyR8zVYVcV3GWKQqoKXltlPqSy/
         OTxtny+PnkcHuqI5e7lf/mC9L0nPSRk+uRKGWV0VMDpO6SoMgFBbZLnwfpEArOHwfpeG
         QkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KRVMNeVbDrXeH53OKl1dAq2KW5cWSquk+kBb0bVCIYA=;
        b=T+8v5NZCKEi1HM3ovAkeW8niWVS+HlHhcilMi+VTPvkQArCRhPqXFn222ClAjvtZc0
         rHV+o/QZA5QN+XnkgyfKi4FuG6GLApMuIcsRCGi1crW1PMD075E8DaDcl2fysn3LwZY0
         irzuB8I82oGIb+9p3MrKUK+36O0nLZft5+DOC8YS7olsKWc5t+RW/EQ6RcE8U7VHVtl8
         aMVS2GN/v6t6pe3r4HdXQSGEV9ptuFDR4lJ2R+xNoRFROtkgmRoLVw81l/WzO/npl9eH
         SL/w/ejUcjggS4mCx/jEix/0xSYYudUWuYA9ogG7TauOY6LErEsPqFuraQYMLBnadSl/
         O0Fw==
X-Gm-Message-State: ABuFfoikVlwNoJRiGyPBNQ+jcYDdfkSOHKr+xaBUDKuStx5zdZvMz5t6
        aU0r/lPrYx1m4rGXSvQhaR90nkeIsG5qywjwwE+xsw==
X-Google-Smtp-Source: ACcGV62jiFE9/SF4JZN8lcD8KOwyKhkB5oKKRmFcaCVsu6OPj6VsxcZy4jxEOKcWUxKFX0QZ7uKmuB9EYSO0ZnomJ10=
X-Received: by 2002:a24:b54b:: with SMTP id j11-v6mr966923iti.16.1539070332671;
 Tue, 09 Oct 2018 00:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181008114518.GA2475@AD01277334> <61b485f4-539b-0f25-cf3d-574ebb17197c@embeddedor.com>
In-Reply-To: <61b485f4-539b-0f25-cf3d-574ebb17197c@embeddedor.com>
From:   DaeSeok Youn <daeseok.youn@gmail.com>
Date:   Tue, 9 Oct 2018 16:31:59 +0900
Message-ID: <CAHb8M2A1OSs=WmDKwy9F8H4jkLheiM89yJgzj9NnWZ7xF8RSmA@mail.gmail.com>
Subject: Re: [PATCH] staging: erofs: adds a space around '*'
To:     gustavo@embeddedor.com
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel <devel@driverdev.osuosl.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=EB=85=84 10=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:37, G=
ustavo A. R. Silva <gustavo@embeddedor.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Hi,
>
> On 10/8/18 1:45 PM, Daeseok Youn wrote:
> > fix checkpatch.pl error:
> > ERROR: need consistent spacing around '*' (ctx:WxV)
> > +                       memcpy(vin + PAGE_SIZE *i, t, PAGE_SIZE);
> >
> > Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
> > ---
> >  drivers/staging/erofs/unzip_vle_lz4.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/er=
ofs/unzip_vle_lz4.c
> > index f5b665f..501cfe0 100644
> > --- a/drivers/staging/erofs/unzip_vle_lz4.c
> > +++ b/drivers/staging/erofs/unzip_vle_lz4.c
> > @@ -181,7 +181,7 @@ int z_erofs_vle_unzip_vmap(struct page **compressed=
_pages,
> >               for (i =3D 0; i < clusterpages; ++i) {
> >                       void *t =3D kmap_atomic(compressed_pages[i]);
> >
> > -                     memcpy(vin + PAGE_SIZE *i, t, PAGE_SIZE);
> > +                     memcpy(vin + PAGE_SIZE * i, t, PAGE_SIZE);
> >                       kunmap_atomic(t);
> >               }
> >       } else if (clusterpages =3D=3D 1)
> >
>
Hi Gustavo,

Thanks for letting me know the patch.
> This exact fix was applied to linux-next some days ago:
>
> commit ea0b2d429bd82ec152d286a0c026ebcaa4154ccc
yes, you're right.
>
> Make sure you are working from linux-next rather than from mainline.
I got the linux kernel source from the staging-next tree than
linux-next. I knew that the patches related to staging should be
merged into staging-tree first. But I didn't update the source tree to
get latest.
>
> See this link: https://www.kernel.org/doc/man-pages/linux-next.html
>
Thanks.
Regards,
Daeseok Youn.
> Thanks
> --
> Gustavo
