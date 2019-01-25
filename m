Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B175C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA621934
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD8QdFDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfAYIUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:20:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44713 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfAYIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:20:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id g16so3783570otg.11;
        Fri, 25 Jan 2019 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDpwFo8slxvY3MeyQ7feqeISNLme7f0W9Ov63wW5t7A=;
        b=UD8QdFDmdJKdG1UwBXvJ9IhfvLh4SU3O1FGCq3sfLSOBcix22SSKCoXplxRE81UR96
         Djc8PeuYJ8C3ASyuycyeOLamSAnZldi4GwWpaSVsp81lpIbRhPtv8vQRvt9xTgC1TR/u
         Opq+yMYRRtT5TsugPFRC3WgAVtF+0YekrSes/ZQUgswWpoHKW8PH8eSE5cOOMTK2JHSX
         zPAcs5R7jFNQqIGyyU3GP1C6SSQWLIfqGvCbjeqkyPPTkMBAr+FRyu45iDOQ8P5in8k3
         GJj0a/6Wpfe/L2sB+M1KxvtT6w6vBhN4y6ctwAeinsgvgqAzoJTpVMMdSNoNJN7itzTT
         utYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDpwFo8slxvY3MeyQ7feqeISNLme7f0W9Ov63wW5t7A=;
        b=HCaspL+YEWL5jjVc8MXxIeIXhd7Yp6p9QDdF7jqs7wi4PNjcM5A4UOgCa7eOeA8Nu7
         xGFZRbkkUVZg9NtPks0pxIt6gbGkdeyQaX82+OETQ8wTuQgptna9M3kKPtV1/EELKdDo
         HfpWwHaICJyzqN+3w99fAshqhkV1rcLcUREyITY0uzNXUunhCht/mr5M3caLRo97ZRoC
         D21mtl70Xrrwl+qcLpH5DkBWz7RgQ36gZvCTkxXjG97k21usxYD+FSkDukLnVgRkq6sW
         YeTeZlCcJzYGyXyl57rjxxbG2g8Qr5chd1YnneCY8dNH+QiwWlqQ1TdDAUiVH0ZPmiHf
         eqIg==
X-Gm-Message-State: AJcUukfy8gFkdCsZ9uMD1FCxf1/Io7qAUBbiPZuyyOwCU81lQKK+kNDx
        LI6z4D6+4Vx61VdkEhmYxPwYryqoAur9NxlOPzw=
X-Google-Smtp-Source: ALg8bN5YBqAvsrlNX4mvODmlLpvBNa1o2LNwCm8A9UgsKl5xsNj99ri5FdZIMdiXqTcRZoGQPQnC/pEcRN10jvKk1Lk=
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr7197398otf.66.1548404406667;
 Fri, 25 Jan 2019 00:20:06 -0800 (PST)
MIME-Version: 1.0
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
In-Reply-To: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 25 Jan 2019 10:19:54 +0200
Message-ID: <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD -> RESERVED
To:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, Rafael Tsuha <rafael.tsuha@usp.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
>
> Remove the checkpatch.pl check:
>
> CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?

Hey,

A bit curios about this one.
Are you using this chip/driver ?

Thing is: the part is nearing EOL, and it could be an idea to be
marked for removal (since it's still in staging).
But if there are users for this driver, it could be left around for a while.

Thanks
Alex

>
> Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> ---
> This macro is not used anywhere. Should we just correct the
> spelling or remove the macro?
>
>  drivers/staging/iio/cdc/ad7152.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 25f51db..c9da6d4 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -35,7 +35,7 @@
>  #define AD7152_REG_CH2_GAIN_HIGH       12
>  #define AD7152_REG_CH2_SETUP           14
>  #define AD7152_REG_CFG                 15
> -#define AD7152_REG_RESEVERD            16
> +#define AD7152_REG_RESERVED            16
>  #define AD7152_REG_CAPDAC_POS          17
>  #define AD7152_REG_CAPDAC_NEG          18
>  #define AD7152_REG_CFG2                        26
> --
> 2.7.4
>
