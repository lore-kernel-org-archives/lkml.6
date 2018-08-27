Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE97C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381952054F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XCTtvZ24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381952054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeH0XyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:54:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55946 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeH0XyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:54:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2138D106DFB;
        Mon, 27 Aug 2018 16:05:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=eeTrkg15XF4R
        k+DLcRw7VlE7M3A=; b=XCTtvZ24Vi1lZIETTKDnt3693IfoUFtcQvy8DDy8rVxc
        +O/8ljvQwdEhEnmAzpNzfh4UnddHseP70JyY4hrxBnu20fQs/1icfue4UXfFEK9E
        VfDkfnoNemn5nYmqgQDJHssBX12k31onNnshhv0e4rWkxWs3q8PAHJR/6wwPqMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S0tUtf
        27RZ+p5/H8oW9s0+4oxspYOk/+UmGZMXStOYQmtwVyxQd2wbblPuSUbPzmQi1FMe
        aVXFeXkhmLGU/1pXpHE9pEC8/oait2OMn4R48sp/m4VkybhghewTfHi08/UVC2RO
        fn2uQWlQM+8BSA1FHd8ZZIWyRpGVGwlvekScg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16D5F106DFA;
        Mon, 27 Aug 2018 16:05:49 -0400 (EDT)
Received: from [192.168.1.127] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DCB1106DF9;
        Mon, 27 Aug 2018 16:05:48 -0400 (EDT)
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
Date:   Mon, 27 Aug 2018 15:05:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 9727DD9A-AA34-11E8-8FC9-063AD72159A7-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro,


On 08/25/2018 01:16 PM, Masahiro Yamada wrote:
> __compiletime_assert_fallback() is supposed to stop building earlier
> by using the negative-array-size method in case the compiler does not
> support "error" attribute, but has never worked like that.
>
> You can simply try:
>
>     BUILD_BUG_ON(1);
>
> GCC immediately terminates the build, but Clang does not report
> anything because Clang does not support the "error" attribute now.
> It will later fail at link time, but __compiletime_assert_fallback()
> is not working at least.
>
> The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluatio=
n
> of `condition' in BUILD_BUG_ON").

I didn't really think this particular patch was necessary, but it was
requested that I eliminate double evaluation and I didn't feel like
arguing it at the time. :)=C2=A0 In my philosophy however, one should *ne=
ver*
use an expression with side effects in any type of assert.

> Prior to that commit, BUILD_BUG_ON()
> was checked by the negative-array-size method *and* the link-time trick=
.
> Since that commit, the negative-array-size is not effective because
> '__cond' is no longer constant.

Now we're back to the question of "what do you mean by 'constant'"?=C2=A0=
 If
you mean a C constant expression (as defined in the C standard) than
almost none of this code fits that criteria.=C2=A0 For these compile-time
assertions to work, we are concerned with the data flow analysis and
constant propagation performed by the compiler during optimization.=C2=A0=
 You
will notice in include/linux/compiler.h that __compiletime_assert is a
no-op when __OPTIMIZE__ is not defined.

> As the comment in <linux/build_bug.h>
> says, GCC (and Clang as well) only emits the error for obvious cases.
>
> When '__cond' is a variable,
>
>     ((void)sizeof(char[1 - 2 * __cond]))
>
> ... is not obvious for the compiler to know the array size is negative.
>
> Reverting that commit would break BUILD_BUG() because negative-size-arr=
ay
> is evaluated before the code is optimized out.
>
> Let's give up __compiletime_assert_fallback().  This commit does not
> change the current behavior since it just rips off the useless code.

Clang is not the only target audience of
__compiletime_assert_fallback().=C2=A0 Instead of ripping out something t=
hat
may benefit builds with gcc 4.2 and earlier, why not override its
definition in compiler-clang.h with something that will break the build
for Clang?=C2=A0 It would need an #ifndef __compiletime_error_fallback he=
re
though.

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>
> Changes in v2:
>   - Rebase
>
>  include/linux/compiler.h | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 681d866..87c776c 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -314,29 +314,14 @@ static inline void *offset_to_ptr(const int *off)
>  #endif
>  #ifndef __compiletime_error
>  # define __compiletime_error(message)
> -/*
> - * Sparse complains of variable sized arrays due to the temporary vari=
able in
> - * __compiletime_assert. Unfortunately we can't just expand it out to =
make
> - * sparse see a constant array size without breaking compiletime_asser=
t on old
> - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altoget=
her.
> - */
> -# ifndef __CHECKER__
> -#  define __compiletime_error_fallback(condition) \
> -	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
> -# endif
> -#endif
> -#ifndef __compiletime_error_fallback
> -# define __compiletime_error_fallback(condition) do { } while (0)
>  #endif
> =20
>  #ifdef __OPTIMIZE__
>  # define __compiletime_assert(condition, msg, prefix, suffix)		\
>  	do {								\
> -		int __cond =3D !(condition);				\
>  		extern void prefix ## suffix(void) __compiletime_error(msg); \
> -		if (__cond)						\
> +		if (!(condition))					\
>  			prefix ## suffix();				\
> -		__compiletime_error_fallback(__cond);			\
>  	} while (0)
>  #else
>  # define __compiletime_assert(condition, msg, prefix, suffix) do { } w=
hile (0)

To give any more meaningful feedback I think I will need to experiment
with Clang, older GCC versions and icc.=C2=A0 It occurred to me that I sh=
ould
probably clean up and publish my __builtin_constant_p test program and
also generate results for more recent compilers.=C2=A0 I can extend it to
test various negative sized array constructs and it could help inform
this decision.

IMO, the most ideal solution would be a set of C2x (or future)
extensions providing something similar to C++'s constexpr, GCC's
__builtin_constant_p and our BUILD_BUG_ON.=C2=A0 This would cross deeply =
into
territory traditionally considered to belong to the implementation, so
it's no small request.=C2=A0 A lot would have to be resolved for it to wo=
rk
in the standard.

Daniel
