Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E65FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CD52083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa4nFYd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CD52083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeGZNfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:35:13 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40179 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbeGZNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:35:13 -0400
Received: by mail-qk0-f193.google.com with SMTP id c126-v6so813559qkd.7;
        Thu, 26 Jul 2018 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wMG5Kl7sCZ9L9pOOdZJT3wJiDRE44fMECHYum9lJbzQ=;
        b=qa4nFYd+cDUNYN/AAnQTq5f2hO9bo4MK2As56wwhz7fUFajIAlh+mAbF5Tvb+W/ypZ
         VRnqx/28KW0+u/gJaC5cxa+VfI+998JGk+1OxurFlvfgbClGmzIT4Dd+u5iRM3EP8uFX
         yR5hHNOA+NZM65xen2nii3eaP4r8OhkgGgaLaFFaofpfewEtlYdgrv11SJ6orSjT+mSt
         Kd7nku4hD27NY74Kn8n7G/FzrrMbPkgAVabfpk07jtBNtfHqGXysujkXV+Wee6iDhiuh
         mX16nWsAy1Nr7FcAy1ijf1TVDbC3vZfwOQyalNgwHzO+rGdK1vrC7xPOy+U/tqLJwzoe
         eQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wMG5Kl7sCZ9L9pOOdZJT3wJiDRE44fMECHYum9lJbzQ=;
        b=ul0IJlp9a9Jxv/Zk2s+1b8iJxK5Uxk7qzuL9lBQ+9E6Tf02QfqRP6RhN5ycvdll7V7
         Jau1pnca4fRIhYTuf7RK42bgkKJ1q9yttX+1i78FzxTjDAg/wlllWOf6RMo50lHsDnqO
         iuNu8XPqekni3YZyWuoguzRmo+sKGg5uQc0g29LefQ/P1TGwS57pyzj4ZSnTILxHc7Es
         Ecwim7S7492e1hfLMyFgrN0V6ToHlnn4MCQ7ARD46azOanFMohIncH1shfV8cuxM+Lgt
         meegSRXRLDxRUiq3Ia5qw1c13LNt0uK7npn/JOfT74/SkcJDaWwJrvf7/X99I0+97p0n
         4UKg==
X-Gm-Message-State: AOUpUlHZWKYBmrwui/znsLVyGpaex9qQ6bnNpiyTZs/lf//RCMl/U/f+
        6BcJXj6Ya4tba2aPXCckqjXyG9iUzMdCqtZjXgk=
X-Google-Smtp-Source: AAOMgpdixFeBKL0hCgfn/31VamvMU1qGWjsI/vaQZ17BD1QrgXL7QDjirbTRfpcJTMPN1n14GsjIGWhFM8og/i81GGs=
X-Received: by 2002:a37:d706:: with SMTP id m6-v6mr1357130qki.123.1532607518987;
 Thu, 26 Jul 2018 05:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180725210819.1458-1-brian.brooks@linaro.org>
In-Reply-To: <20180725210819.1458-1-brian.brooks@linaro.org>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 26 Jul 2018 14:18:27 +0200
Message-ID: <CAJ+HfNh19+_7oPBXAfGYksKRGHD=B1pJ6qfu8ta_BDza75YsGw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] samples/bpf: xdpsock: order memory on AArch64
To:     Brian Brooks <brian.brooks@linaro.org>
Cc:     ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den ons 25 juli 2018 kl 23:09 skrev Brian Brooks <brian.brooks@linaro.org>:
>
> Define u_smp_rmb() and u_smp_wmb() to respective barrier instructions.
> This ensures the processor will order accesses to queue indices against
> accesses to queue ring entries.
>

Thanks Brian!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

> Signed-off-by: Brian Brooks <brian.brooks@linaro.org>
> ---
>  samples/bpf/xdpsock_user.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
> index 5904b1543831..1e82f7c617c3 100644
> --- a/samples/bpf/xdpsock_user.c
> +++ b/samples/bpf/xdpsock_user.c
> @@ -145,8 +145,13 @@ static void dump_stats(void);
>         } while (0)
>
>  #define barrier() __asm__ __volatile__("": : :"memory")
> +#ifdef __aarch64__
> +#define u_smp_rmb() __asm__ __volatile__("dmb ishld": : :"memory")
> +#define u_smp_wmb() __asm__ __volatile__("dmb ishst": : :"memory")
> +#else
>  #define u_smp_rmb() barrier()
>  #define u_smp_wmb() barrier()
> +#endif
>  #define likely(x) __builtin_expect(!!(x), 1)
>  #define unlikely(x) __builtin_expect(!!(x), 0)
>
> --
> 2.18.0
>
