Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5262CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40C4208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ+2rsF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40C4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJBF10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:27:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42527 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBF10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:27:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so10287603pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tzb51grmVOizLtgxGRhOCmsddQDqj0VKC3k1enTd7Q4=;
        b=SZ+2rsF4Wb4F3vQX8urTsZOV9XN5S7hid+URzdEx/sPlAwrEE+hTi2N+0SoejvPt3Q
         YtZ8+qZ0gUcqPdFxCRFCSPcaPYGVkWJA7vQ0NeOFXelPzbvzS40JCB3ivsEADL29V5Jn
         l+iEazeGBaFcfscz2PCY3bt2gS8ThcIHadePc3loVDw9hz5YyffVd5LrBvH/CmYe/vf6
         S1EnsAnQ7YiuIPwZ0wl7O82JEaPIGFrzH4iNdN8s5dZXHdul18Xuqf9QPI4lOqMnYczk
         pvtkiSoYSmZg8nZYvnffnRUY1gGDx8gsawUwfTBIi3L6akithec6MCbolsM5nGFyPWo5
         VQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tzb51grmVOizLtgxGRhOCmsddQDqj0VKC3k1enTd7Q4=;
        b=IkSYi1l5G+/9tK7t5BjrX9cpmkdw2AMCdjLiqDp8l+LoSy4ou5+orn2OXJTbBkHiIF
         ZZ+pAnnoa2kQMBKeld/nAIb+Pnz9Z+Hv53fYOg2uFZ8KYg6lWcCV+7uz2iFqCP5T7BPa
         AmqedAM35R+1nG7+Fqa5k9rlL6cmAO3+XdSJ2iGuXPh3P+omvoe14CLW0g6QJ5JWjZrf
         5YkFfauLWvCS1jRFGj5R7usaLwxis7U8DfUHPkmsh3SO6MV+GJEggMfm+FUMeJhHBLov
         T7h5hKfWsFq331KqaIlz7xDIk5uScx8HS7tba0HBPHgj90RRGan4MYhGqLQu3Q67HLlf
         o30w==
X-Gm-Message-State: ABuFfojQBtLF1c8v5qd1wzx5hpHFNHeVzlk1PvtwQJsVUe54YUavpm2j
        1Qjoq1YV6NAZReMieBox3DnYzxYVr5wvFK2pkEl4bg==
X-Google-Smtp-Source: ACcGV63RZX3tbiRRJ+jU4e/iaq3ZGAF/5JnkBx5mgEiSqzlceix7yTtQQo4bhe310M3e0XQK6gqW+f12wVD7SY5eEho=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr12234603pgl.302.1538434041996;
 Mon, 01 Oct 2018 15:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205126.25840-1-natechancellor@gmail.com>
In-Reply-To: <20180930205126.25840-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 15:47:10 -0700
Message-ID: <CAKwvOdmx0rnPyFKoM-dFOHp1ySMOk7yL3sQ1z1bpbwqJ6u8EWQ@mail.gmail.com>
Subject: Re: [PATCH] fs/exofs: Remove ignored __weak attribute
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     ooo@electrozaur.com, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 1:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that the __weak attribute is going to be ignored on
> g_attr_inode_data because it's not in the correct location (needs to be
> after the type).
>
> In file included from fs/exofs/dir.c:35:
> In file included from fs/exofs/exofs.h:41:
> fs/exofs/common.h:186:21: warning: 'weak' attribute only applies to
> variables, functions, and classes [-Wignored-attributes]
> static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
>                     ^
>
> Turns out that GCC ignores the attribute too albeit silently because
> moving the attribute after either osd_attr or g_attr_inode_data like
> all other uses of __weak on variables in the kernel causes a build
> error on both GCC and Clang because static variables cannot be weak
> since weak definitions rely on not having internal linkage:
>
> In file included from fs/exofs/namei.c:34:
> In file included from fs/exofs/exofs.h:41:
> fs/exofs/common.h:186:30: error: weak declaration cannot have internal
> linkage
> static const struct osd_attr __weak g_attr_inode_data = ATTR_DEF(
>                              ^
>
> Just remove the attribute because it hasn't been correct since the
> initial addition of this file in commit b14f8ab28449 ("exofs: Kbuild,
> Headers and osd utils").
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/exofs/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/exofs/common.h b/fs/exofs/common.h
> index 7d88ef566213..45da96a1528d 100644
> --- a/fs/exofs/common.h
> +++ b/fs/exofs/common.h
> @@ -183,7 +183,7 @@ struct exofs_fcb {
>  #define EXOFS_INO_ATTR_SIZE    sizeof(struct exofs_fcb)
>
>  /* This is the Attribute the fcb is stored in */
> -static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
> +static const struct osd_attr g_attr_inode_data = ATTR_DEF(
>         EXOFS_APAGE_FS_DATA,
>         EXOFS_ATTR_INODE_DATA,
>         EXOFS_INO_ATTR_SIZE);
> --
> 2.19.0
>

LGTM, thank you for sending, Nathan.

-- 
Thanks,
~Nick Desaulniers
