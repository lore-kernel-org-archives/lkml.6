Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6520700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="topm4irO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfBVANz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:13:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35621 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBVANz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:13:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so229624pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOeop6k/ATulTYc9RAA3FktE0iQO8Zmhg7BcbfC17+s=;
        b=topm4irOQodKCaINTjIWW97FAbzlP77GPGjuIMW2HEHmBr3rqKgdrf1xWrwdeY0HKq
         j4gLhBH2IV+qH2D52joEGlYps+sk10jlr5YfYZ8hFXDBIyRyA0N5gtO6mLqwLVp8cnPo
         JWPt2D6Lq1NR4yvWVa6LTVl+uQgGAeDdY92ywe8yxdHefUOLmipK+61MqNXGJWIj3RVD
         8zelQLOPdUnsIYepU2S3bP6uagnlX5az0z82hsVYoyGwgPPqtNjlT0qhlMJrtv0zo8NW
         33ujfM1HwbypmyKnUQwrSUwW7HCCMfeSSpEhkCpQ7UgpJAViNllpgr9z7h0wJASVM3MM
         iszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOeop6k/ATulTYc9RAA3FktE0iQO8Zmhg7BcbfC17+s=;
        b=njt711y3gRXmGfbwWIiFWJB1wzlE+ved+pKHnIV7nxygI5v7LeWbqNpkVa5R1NK6Cg
         340hAfNWfHHVTiJ0FvITPhoaFy6xabQcARJINul3DwlrSqo5BZjlwfqacFr/f4bJS1AO
         68AeXBRNm/LWFWS0k/CDjIWd5m5dTsnS1mA6BjhlSsRUr5HNT3LhKJx4K1H8nGcYObTm
         hTuCHE5y7sUXxx94MY0EXhcbvqEXswlphGLYL076QpBGb+ttvpjyqXHd6YpjWAl2IFwS
         5mVurVmXDws5WYcyq8w0pvjafmXVdqIKVJKke2GdZTxRyJEinEgCprbSXF/9zF+9iR4X
         V77g==
X-Gm-Message-State: AHQUAuaUBqOwYkMd4aDMoRdOs0PyF+61t2j3anPAo71OHrIyroquT+pS
        LxBIztSp9+Vk7Uw13BwRdszZpVPCBNQqi69q+SgCBw==
X-Google-Smtp-Source: AHgI3IYsdCZ1+hEt521ZrnBxs9BJAGbS+dbLYW5bZdW9dvpg3l4cR5HyWhwcYrqlIuZqq2htkp/EJup40zBLnd2hEus=
X-Received: by 2002:a63:f544:: with SMTP id e4mr1161430pgk.145.1550794433844;
 Thu, 21 Feb 2019 16:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20190219182105.19933-1-natechancellor@gmail.com> <20190221080617.2795-1-natechancellor@gmail.com>
In-Reply-To: <20190221080617.2795-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Feb 2019 16:13:42 -0800
Message-ID: <CAKwvOdmCeHxiGPkXXzjwnTtgzEDDjYRE1QBdu7BHeuzCE4YtRA@mail.gmail.com>
Subject: Re: [PATCH v2] iwlwifi: mvm: Use div_s64 instead of do_div in iwl_mvm_debug_range_resp
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:08 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c:465:2: warning:
> comparison of distinct pointer types ('typeof ((rtt_avg)) *' (aka 'long
> long *') and 'uint64_t *' (aka 'unsigned long long *'))
> [-Wcompare-distinct-pointer-types]
>         do_div(rtt_avg, 6666);
>         ^~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
>         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
>                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
> 1 warning generated.
>
> do_div expects an unsigned dividend. Use div_s64, which expects a signed
> dividend.
>
> Fixes: 937b10c0de68 ("iwlwifi: mvm: add debug prints for FTM")
> Link: https://github.com/ClangBuiltLinux/linux/issues/372
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Fix logic (as the return value of div{,64}_s64 must be used), thanks
>   to Arnd for the review.

oh boy, sorry I missed that in the initial code review, thanks Arnd
for the sharp eye!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Side tangent: we see this kind of difference in APIs a lot (modifying
the parameter vs returning a new value or making a copy then modifying
that) in C++ when a call site isn't passing the explicit address of
some variable or an identifier that's clearly a pointer. Ex.

int foo;
bar(foo);

Doesn't tell you whether bar mutates foo or not without looking at the
definition of bar, as it could be:
void bar(int x);
or
void bar(int& x);

I miss the convention in Ruby of using `!` suffixes on methods to
differentiate between such cases. ex:

"hello".capitalize
vs
"hello".capitalize!

both return the same value, but the one with the ! mutates the
existing object, while the one without creates a new object.  And
that's a very standard convention throughout the standard library.
Whether or not people follow that convention is always another story.

One thing I'm curious about, is "why does do_div exist?" When should I
use do_div vs div_u64 (not div_s64 as is used in this patch)?

>
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
> index e9822a3ec373..94132cfd1f56 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
> @@ -460,9 +460,7 @@ static int iwl_mvm_ftm_range_resp_valid(struct iwl_mvm *mvm, u8 request_id,
>  static void iwl_mvm_debug_range_resp(struct iwl_mvm *mvm, u8 index,
>                                      struct cfg80211_pmsr_result *res)
>  {
> -       s64 rtt_avg = res->ftm.rtt_avg * 100;
> -
> -       do_div(rtt_avg, 6666);
> +       s64 rtt_avg = div_s64(res->ftm.rtt_avg * 100, 6666);
>
>         IWL_DEBUG_INFO(mvm, "entry %d\n", index);
>         IWL_DEBUG_INFO(mvm, "\tstatus: %d\n", res->status);
> --
> 2.21.0.rc1
>


-- 
Thanks,
~Nick Desaulniers
