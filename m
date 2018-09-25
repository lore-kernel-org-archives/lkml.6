Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F2FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F58920880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6bjq3py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F58920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIZCdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:33:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42971 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIZCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:33:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so12370869pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nu4XXgxpBGQhQONDopVbUiR6adZmnd6kts1ldMx3YsM=;
        b=X6bjq3pyoSrJ0dAJmDOOuXsl09c+VEj9UJc4V0p8s8MUpP04xJp3/mH7wUcnW9GJQJ
         Mk6YGWuJ9/1tqJ6PfTTwHnCNnr8dFgD1VLZtKSSIhFwqqZjidwZa2az7WwWc/MrB665M
         TRcqZG1J5/3rkikU59xscrFUbZh53n46eFJIwaPjp1PhdeuzUyWd5chO/pMfFtk/GeG/
         RnsJnicZ9wq67+yI3XQEhQjtV3U5W9vSgaShyp0YG/QcLk7TLQjX1yeGi9aG/vRcdHzJ
         eUU0ZVymn0i/Qe98u5PcH8O/kg5TX+nhJZ5cfiKTElO2FOghO+fEJwlSMfK0N+Iwe8fW
         oGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu4XXgxpBGQhQONDopVbUiR6adZmnd6kts1ldMx3YsM=;
        b=DaU7/xr0xq2LBEwTG0HDb8JJGs7zBtt9rNn5Xs07s6qx7+mRn1SQHyAFGRFSTm2ljm
         8yTiCKwx/tRqgQpfb1fR3Ery+2H/WxfTi+9wjkVY2gycfc/wA2WANFmS07OSqmre/AqB
         506RN1phrfnDRRwkqr4vH3+mUa5DQyTpCO6zncPvxQKhzajhI3J1SoTBnw+xgad1292q
         hZ00+goTjAalp+O+rSHuyBc04/nyw3AxUsFmTHtq0Gn2zq6pWxQHBzBYbyc4f3NANMWG
         WAE2Z2C/0jwj/fdt4NE6Ijq0K/Ou+UFJyyLdou06mZqVDx6huH9a7GNldv3sD0CGlCrX
         qXRA==
X-Gm-Message-State: ABuFfogUsY0LNxQYufXUW2Spocsoy4i5TLhdfunoyUabPfNllGZyR0Er
        d32NWpmDjazXu43NhQ42OKBWjqv3vQZSXJa0Em1L4Q==
X-Google-Smtp-Source: ACcGV61ALZLfuX0BdtQoLKy+SKY5eYsL/a0+3bp7T0P0oJxD926SQs6qiu+SyoJ52mJw7PKTHhDYL7oMKvN+dNGaPpI=
X-Received: by 2002:a62:1895:: with SMTP id 143-v6mr2661842pfy.227.1537907057991;
 Tue, 25 Sep 2018 13:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180925194459.13088-1-natechancellor@gmail.com>
In-Reply-To: <20180925194459.13088-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Sep 2018 13:24:06 -0700
Message-ID: <CAKwvOdnzN0E0HD--3GmC9b=20fx3AE-8-x0iZ04-LEXnxh=YoQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: percpu: Initialize ret in the default case
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dennis@kernel.org, tj@kernel.org, Christoph Lameter <cl@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, psodagud@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:45 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that if the default case is taken, ret will be
> uninitialized.
>
> ./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> ./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
> here
>         return ret;
>                ^~~
> ./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
> 'ret' to silence this warning
>         unsigned long ret, loop;
>                          ^
>                           = 0
>
> This warning appears several times while building the erofs filesystem.
> While it's not strictly wrong, the BUILD_BUG will prevent this from
> becoming a true problem. Initialize ret to 0 in the default case right
> before the BUILD_BUG to silence all of these warnings.

Clang does semantic analysis BEFORE inlining/optimizations, so I can't
determine that default is never reachable.  Nathan, thanks for this
patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm64/include/asm/percpu.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 9234013e759e..21a81b59a0cc 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -96,6 +96,7 @@ static inline unsigned long __percpu_##op(void *ptr,                  \
>                 : [val] "Ir" (val));                                    \
>                 break;                                                  \
>         default:                                                        \
> +               ret = 0;                                                \
>                 BUILD_BUG();                                            \
>         }                                                               \
>                                                                         \
> @@ -125,6 +126,7 @@ static inline unsigned long __percpu_read(void *ptr, int size)
>                 ret = READ_ONCE(*(u64 *)ptr);
>                 break;
>         default:
> +               ret = 0;
>                 BUILD_BUG();
>         }
>
> @@ -194,6 +196,7 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
>                 : [val] "r" (val));
>                 break;
>         default:
> +               ret = 0;
>                 BUILD_BUG();
>         }
>
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
