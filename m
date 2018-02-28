Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519836890; cv=none;
        d=google.com; s=arc-20160816;
        b=Fcpiz7dqSXBFYUqtEkA+g6PKlR91CZ7+jL4vjYzJbSD5oveuIaeeQosCOEV4thjaZn
         XWxpmoeJl4JzwGwEMGGBhBslr3coU3ID0BMGiRPLEcu3xedyjmNmYs2CsyKpRMjZi9Qc
         jaBkpN78fobqKLV1vUP8Eaal2OjTOOJjt2LE91r9TSjKV4dOFP5veUFcF6PsFS+dqmD1
         /4ly97INWPZXRAs+TlhOzGmp/IaxJxN6T3SeA/j6v1aKUXivRzO6qrvpNC0Ilc46r5uI
         QZ9fLggpwful1qBLSmenPkF6wviDw0htBXWMOPBVo+4GJ0mzQsp1RnYSh2vvETvX9+gp
         j1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=HQhHogxdzvIDXHL3779eXw6k6iYGv6sFJuBp7uDDGrk=;
        b=lpKXaxUURM4SexgW+kpH1Yb0pQrKubo8bgE51bZEjkPnltw9PNyV9fttnsBktDD3o9
         1jS/6lss5pMDScu65cXPUjyYHDrhMCEFQdroIDMk5Ui2fjXyz64qhKzn1lsfwGtl4geP
         oO/ZHw3xzPwDs+UjatiTwJzVN/oIFlc91Vf6YeanRcLR+K8kq2ZECRpM59KzEqkNuhLy
         YvdKftXm7ZukotStr46k0hBuLCZdxZ3ZitsPqCfCbNaXjVxDkYKrFSgIpgcX2DwWQUq3
         CFdFfvDncCho3MBN1HkhfWpBzjbS9FsFedmu8rvwNGEYUmwWXvF7unuVlhCzKpjd611b
         S/Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OvkmQMLy;
       dkim=pass header.i=@chromium.org header.s=google header.b=NfDj4Uei;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OvkmQMLy;
       dkim=pass header.i=@chromium.org header.s=google header.b=NfDj4Uei;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsd93hK3jYvOcuAaRHBW2kI/sqzf1Zosg7IYvyAS25epzo1qDM3Ld7KHaMzWsKKLqxBLrHKBw1NgpdPgTxpGqw=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180228143037.GA3150@pjb1027-Latitude-E5410>
References: <20180228143037.GA3150@pjb1027-Latitude-E5410>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Feb 2018 08:54:48 -0800
X-Google-Sender-Auth: Y8FAsG-4tac4mz96GazsRn1VLsw
Message-ID: <CAGXu5j+OUHmviXLeZGzLH3q9F-z1s6-8epG-y1ZusgOyGEy24Q@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 2/2] arm: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE
To: Jinbum Park <jinb.park7@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Philippe Ombredanne <pombredanne@nexb.co>, Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>,
	Andy Lutomirski <luto@amacapital.net>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Micay <danielmicay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593655422038750745?=
X-GMAIL-MSGID: =?utf-8?q?1593664486643432055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 6:30 AM, Jinbum Park <jinb.park7@gmail.com> wrote:
> CONFIG_FORTIFY_SOURCE detects various overflows at compile-time.
> (6974f0c4555e ("include/linux/string.h:
> add the option of fortified string.h functions)
>
> ARCH_HAS_FORTIFY_SOURCE means that the architecture can be built and
> run with CONFIG_FORTIFY_SOURCE.
>
> Since ARM can be built and run with that flag like other architectures,
> select ARCH_HAS_FORTIFY_SOURCE as default.
>
> Signed-off-by: Jinbum Park <jinb.park7@gmail.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7e3d535..3765336 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,6 +7,7 @@ config ARM
>         select ARCH_HAS_DEBUG_VIRTUAL if MMU
>         select ARCH_HAS_DEVMEM_IS_ALLOWED
>         select ARCH_HAS_ELF_RANDOMIZE
> +       select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_SET_MEMORY
>         select ARCH_HAS_PHYS_TO_DMA
>         select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> --
> 1.9.1
>



-- 
Kees Cook
Pixel Security
