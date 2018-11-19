Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ECEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A86D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A86D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeKTCgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:36:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46525 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbeKTCgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:36:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so49406209qkf.13;
        Mon, 19 Nov 2018 08:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/CljHlhtduQLF35Irouy1QmlECeaT79XOoHMWeQgcA=;
        b=ehEUbEVap9kAzguKCOaJ00DFWaA9+ZRD6Q0T0Z3X8KoOYvsmFpzmIR/wiLqGt0MCRi
         GR991T+ip6ABoxD92Rwv+yjgOTxepiWmxzg7F6lNZz7iAttJPic37dxFKpe/9ZqTi4t/
         XshXw7G+xp40McHj/Qj6RjH+Lk68+1CwlGqt5+bSnlYAIQKhoLePkHnN6XNDZkrh2p5v
         KVZYM/tTuLOOFtJzLPUVD02s+2tVXisbaVmowz+f9SU1OvUhsfs8jQH9rhokgrRWWfis
         nxiO6KVENcY9gzVmZcCbK8CCmZUE1N2Q7vbjbxXFwM8zpGfF/gjJPGyW1XyZHaR/HVa/
         8lVQ==
X-Gm-Message-State: AGRZ1gJbUVUS/3k+j3rGtitpKs/ajga41syKuUAPfzoyyX7GP8M4DtPA
        050Gog65guAVTDZ/R3Yb6E4/4bnfE14Z6v0J+5w=
X-Google-Smtp-Source: AJdET5dPIGsiE6RUf3i4cx4BCE5CZGvyj34krT9bAqeMDTqC1zdXy6tixqW2CNM/QRGHQTM99Pv5+MW2YDUPY+gahUQ=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr21184819qke.173.1542643934914;
 Mon, 19 Nov 2018 08:12:14 -0800 (PST)
MIME-Version: 1.0
References: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org> <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 17:11:58 +0100
Message-ID: <CAK8P3a2AsQKPpFRKpNiEo2TVjfanuTSUjhO1wxgvLYyiqeaMNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc: move macro definition from asm/systbl.h
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com,
        Geert Uytterhoeven <geert@linux-m68k.org>, leitao@debian.org,
        Boqun Feng <boqun.feng@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:04 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> index 01b5171..c4321b9 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -76,7 +76,6 @@
>  SYSCALL_SPU(ssetmask)
>  SYSCALL_SPU(setreuid)
>  SYSCALL_SPU(setregid)
> -#define compat_sys_sigsuspend sys_sigsuspend
>  SYS32ONLY(sigsuspend)

I think the macro here is just a workaround for the fact that SYS32ONLY()
always prepends the name with 'compat_' for the compat version, and there
is no other macro to do this. After the conversion, this can easily be
done using the regular table, as you need separate names for the
32-bit entries anyway.

>  SYSX(sys_ni_syscall,compat_sys_s
> diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
> index 8ae8620..7517a43 100644
> --- a/arch/powerpc/platforms/cell/spu_callbacks.c
> +++ b/arch/powerpc/platforms/cell/spu_callbacks.c
> @@ -47,6 +47,7 @@
>  #define COMPAT_SPU_NEW(func)   sys_##func,
>  #define SYSX_SPU(f, f3264, f32)        f,
>
> +#define compat_sys_sigsuspend  sys_sigsuspend
>  #include <asm/systbl.h>
>  };

The spu_callbacks.c and systbl_chk.c files don't need this macro,
but that doesn't matter once you drop this patch.

      Arnd
