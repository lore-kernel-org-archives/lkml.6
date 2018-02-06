Return-Path: <kernel-hardening-return-11626-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226XbkI5SPXjj9oDNDXjbAsTdDjvWgzmVMb+EfBOcX93gg6x+uL//bFKbZrVzhS3FgVVtU3n
ARC-Seal: i=1; a=rsa-sha256; t=1517878482; cv=none;
        d=google.com; s=arc-20160816;
        b=Vrkz3LOrD5wrz7Q7TE20duoc55hUeFBt6iZ4JTSCvrgBoou6PGX+bxBJH0cwPH+Jml
         aHg+ZgROAsYG9Ub91wTRvmjUdAvx6zmiKcYeCykIYe2ANcJiRLz1AoPGAEVj4Wlhjw9z
         +CaJliPHIe1o6HCpUqwunVcMiOvcOJAoqSdh6SsOnQeSHhFFmW7Cm/ZOqeKz50qDke0D
         3N352bjTIxr2q/vT2LzP7Drd/vJrBok9IP/KweW+nVEhX6X9z5fNVMlxKq+eJcFpFsZN
         GJPF3tI2laynPQyu+cpErlIgG9F5MVHCx8jS+nJ+bCAHP1xNzSLza6WEdEmksApg29c2
         ASDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=jrQ3OygmcjyYyRbrVDwxRwVu7vEp35WGmf9vj1KVxEs=;
        b=B+5Pjjc/cJJ7VTF8USrqfYIrDkKRUEMhOX8fROd1yzw+x4PadkeIqLAa4+KSMP+Qio
         fg1OIH7YELxG9taFoPVk/5Jpjlw4/HyqUmkWY3CTol0XS8Q4/zyBLNtB0DWDmJoNxNcr
         oxTxAkSrkpcvUsdeIZVozeC6selvoUG7Cso34l4Bn3K+myKaWVkRXhspU1QjqTiac4IX
         LddT8MRNl779acprZYwXGkBf6uHSImcmL/NcS8wPObQ+cHKQLRfIICmCAh24QSmmDYqh
         bmqPB6of2zJ6OjU+dYvAbKUba6XQorsIo2m6WjhN81iB4lpdNPOHPpyVdSPc64gNB3CG
         M7DA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=actcRZ8m;
       dkim=pass header.i=@chromium.org header.s=google header.b=lGg3i6Oi;
       spf=pass (google.com: domain of kernel-hardening-return-11626-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11626-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=actcRZ8m;
       dkim=pass header.i=@chromium.org header.s=google header.b=lGg3i6Oi;
       spf=pass (google.com: domain of kernel-hardening-return-11626-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11626-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <119189.1517763703@turing-police.cc.vt.edu>
References: <119189.1517763703@turing-police.cc.vt.edu>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Feb 2018 11:54:22 +1100
X-Google-Sender-Auth: PG0Fy5u63g_qgk_gzBv_IyG35iI
Message-ID: <CAGXu5jLs5D_py8GgcoVefahrSMF_a=Zky3qSbirYHKMRtDRNpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] GCC release 8 support for gcc-plugins
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: kernel-hardening@lists.openwall.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490625322246882?=
X-GMAIL-MSGID: =?utf-8?q?1591610947566778910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 4:01 AM,  <valdis.kletnieks@vt.edu> wrote:
> GCC requires another #include to get the gcc-plugins to build cleanly.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> index ffd1dfaa1cc1..f46750053377 100644
> --- a/scripts/gcc-plugins/gcc-common.h
> +++ b/scripts/gcc-plugins/gcc-common.h
> @@ -97,6 +97,10 @@
>  #include "predict.h"
>  #include "ipa-utils.h"
>
> +#if BUILDING_GCC_VERSION >= 8000
> +#include "stringpool.h"
> +#endif
> +
>  #if BUILDING_GCC_VERSION >= 4009
>  #include "attribs.h"
>  #include "varasm.h"

Thanks! I can confirm this works for me. I'll get it applied.

-Kees

-- 
Kees Cook
Pixel Security
