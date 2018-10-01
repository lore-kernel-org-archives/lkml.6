Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018782089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQVfFSsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018782089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJAX4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:56:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42995 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJAX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:56:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so9688031pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRtggt4FXN3bTBKNXdfJdZQx2PWHARKCnRCpA0Ez/+g=;
        b=pQVfFSsuvsMZ1FGzaoYZ53PVOwzaEKb/f81ZystARA7YjLh1CAP5us02ExPNAD1cqF
         iaZAQJ4/dqvlB8LpGtq8yqGXVjrrncfaKeinvI+wIfiRdKjoDU6Fq/ydixZi2gseowdI
         0B3b5rWnkzsr+ajD9fN8WRM52mTAQLxnpX/KwxwhDj/NPAz4H/MolXyVcjRdyeCA+WLK
         vaGhH5iBzbTkTG+4ZSRNtfMWzVwZvQEND4+zNZ/kzozrU5HsyvyxWJRoaEnS90BD5eph
         E+Vv3LKP/ugQcLg10VNrKDf4zvuZWH6BoCm9BWOOyoZxnd8zZ6HmNIGPA5/BGX23g2aL
         lPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRtggt4FXN3bTBKNXdfJdZQx2PWHARKCnRCpA0Ez/+g=;
        b=MM2B4NBlN05l0H29Si0ILEQm29Wz/R2TFD5JzCkJbNkf86ylj4E9SY2dPQybpVIfhr
         IBBiwJW5bZfr+7Wj0bTA0bkkndjRD/ST0Cm43lCjuecRGEw4TzS92J4Tigqoy4lrec4h
         4h1Jfoa50Bsu5xC8aYalpaGPTqghp5ZmqUNLFH11IpxurXpyye1Htb8zxJUbPqrStY9l
         zZrG9S9YCEYQIxA6NBxVC8lqXt+SWjPCxlzhRWk7oUCRGdSKg3DsYtQJMhpXasXwvsMb
         hhP6YAExUYXDJDcxU3AyNGtuff7RvThgJWMWvh7X29UpjFZONlAhoXXGyMjEjUVaDl6r
         xsIg==
X-Gm-Message-State: ABuFfoit+hU+zMFg/cBmQHR7FBTHWR6EHzleDTooAnxLflic314JWc4K
        oCEnpQkxJus417PiuSP9hT1TxbT+/2+SWaQCYC0O1QihPJY=
X-Google-Smtp-Source: ACcGV63TTHQ846ZGLBTQVBU1hVeznNM7T/PIYrly4YVmMiyVazOXi3TQxUjtaFPGXJ0bLKMy1VbnN6whtGUk5oyrSuQ=
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr12892871plz.238.1538414244049;
 Mon, 01 Oct 2018 10:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com> <1538387078-21892-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538387078-21892-3-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 10:17:12 -0700
Message-ID: <CAKwvOd=R1FN_nmR4Wkpb=nTt+v2f2+uWOcQCFoB+B1hWzCXCXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: add -Wno-unused-but-set-variable compiler
 flag unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 2:45 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We have raised the compiler requirement from time to time.
> With commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), the minimum for GCC is 4.6 now.
>
> This flag was added by GCC 4.6, and it is recognized by Clang and
> ICC as well.

This doesn't seem to be the case for Clang:
https://godbolt.org/z/qesF5o

Nacked-by: Nick Desaulniers <ndesaulniers@google.com>


>
> Let's rip off the cc-disable-warning switch, and see if somebody
> complains about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 8a23fee..2627266 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -716,7 +716,7 @@ else
>
>  # These warnings generated too much noise in a regular build.
>  # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> +KBUILD_CFLAGS += -Wno-unused-but-set-variable
>  endif
>
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
