Return-Path: <palmer@sifive.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522795175; cv=none;
        d=google.com; s=arc-20160816;
        b=I04n8TjyXMK2Sst3Q9D90ywM/rqnyOEGbne+x+RcWx/TE1TY28nbwXQq+otAxdmFWR
         toJpr/jP8I529ppj61VwWcK6nnW3kdsRZv8WRSK14A5IM4xo7Z0HsFlQ/P7TYpyLin6o
         D+vvDn/6bfbJHLp+SqtneQMETRRzdPq2lZ7BjWeANhXAZce0FEeckfthMGYkTZRRLFXy
         YRrs1EcI8vHlUrQSl0ZYW+0jy7tkUrgUmXWwIOxXh/kSiNmCb/H+m1RUuxYOQRRWViZK
         KwZjxw/gZn+5wt7tng14sf/Z7FTNg4o3OIcYSxgSa+slFrYw5ieubRX8cmnvShMIULXM
         /1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:dkim-signature:arc-authentication-results;
        bh=e6TGHgGuhE2sDKEUuKy3I6reJj10e/WVDRy1rHnCDms=;
        b=vqD6/+WUfP7f++rREucW2U5ZMmuSWo6lkktI34YGS0jheRAbG2rFyfyxe4lLVubH5n
         cwi6kZ30GDc9fmW8TJO2Yyg/zVEGbRpNcA+UBfvBx/jjFoIxhbUGDGiimjXEn8hwXQiY
         USJFXydWMzPbvu94uH4VmkoF4zc0L4CV34miWkajWxKS50gYebqBYSenC/JFq1eD0TIf
         0L1cs/pHX+v7snclfx1wO93ugGEnmtesYVtkK7W9lhVWxOj34/lvmAkc7U3dF3i3s5BG
         Xy743Ov7MfynqjqEpQDGHjXULK8XyCAizygJuda9eklQ8a/mUBFurTaNnpR5lQ+O6uFz
         jiyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sifive.com header.s=google header.b=EHh1d3Fe;
       spf=pass (google.com: domain of palmer@sifive.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=palmer@sifive.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sifive.com header.s=google header.b=EHh1d3Fe;
       spf=pass (google.com: domain of palmer@sifive.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=palmer@sifive.com
X-Google-Smtp-Source: AIpwx48dL2DTxQWmjVdqKg0+nYc3V30buMJVeG8pwLHaqeZhXc7Vj0SGl7TgWsfiftAjDC6H3Ph6Dg==
Date: Tue, 03 Apr 2018 15:39:34 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Apr 2018 15:35:04 PDT (-0700)
Subject: Re: [PATCH v5 2/3] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
In-Reply-To: <1522747466-22081-2-git-send-email-matt.redfearn@mips.com>
CC: antonynpavlov@gmail.com, jhogan@kernel.org, ralf@linux-mips.org,
  linux-mips@linux-mips.org, matt.redfearn@mips.com, mcgrof@kernel.org, robin.murphy@arm.com,
  geert@linux-m68k.org, linux-riscv@lists.infradead.org, clm@fb.com, ynorov@caviumnetworks.com,
  jk@ozlabs.org, f.fainelli@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
  akpm@linux-foundation.org, bart.vanassche@wdc.com, robh@kernel.org, terrelln@fb.com,
  dan.j.williams@intel.com, albert@sifive.com, viro@zeniv.linux.org.uk, tom@quantonium.net,
  linux-kernel@vger.kernel.org, richard@nod.at, paulmck@linux.vnet.ibm.com
From: Palmer Dabbelt <palmer@sifive.com>
To: matt.redfearn@mips.com
Message-ID: <mhng-58affcc9-9eff-4403-861e-e40aea063afc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596716596411217880?=
X-GMAIL-MSGID: =?utf-8?q?1596766474630300884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 03 Apr 2018 02:24:25 PDT (-0700), matt.redfearn@mips.com wrote:
> When these are included into arch Kconfig files, maintaining
> alphabetical ordering of the selects means these get split up. To allow
> for keeping things tidier and alphabetical, rename the selects to
> GENERIC_LIB_*
>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> ---
>
> Changes in v5: None
> Changes in v4:
> Rename Kconfig symbols GENERIC_* -> GENERIC_LIB_*
>
> Changes in v3: None
> Changes in v2: None
>
>  arch/riscv/Kconfig |  6 +++---
>  lib/Kconfig        | 12 ++++++------
>  lib/Makefile       | 12 ++++++------
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 04807c7f64cc..20185aaaf933 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -104,9 +104,9 @@ config ARCH_RV32I
>  	bool "RV32I"
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select 32BIT
> -	select GENERIC_ASHLDI3
> -	select GENERIC_ASHRDI3
> -	select GENERIC_LSHRDI3
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_LSHRDI3
>
>  config ARCH_RV64I
>  	bool "RV64I"
> diff --git a/lib/Kconfig b/lib/Kconfig
> index e96089499371..e54ebe00937e 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -588,20 +588,20 @@ config STRING_SELFTEST
>
>  endmenu
>
> -config GENERIC_ASHLDI3
> +config GENERIC_LIB_ASHLDI3
>  	bool
>
> -config GENERIC_ASHRDI3
> +config GENERIC_LIB_ASHRDI3
>  	bool
>
> -config GENERIC_LSHRDI3
> +config GENERIC_LIB_LSHRDI3
>  	bool
>
> -config GENERIC_MULDI3
> +config GENERIC_LIB_MULDI3
>  	bool
>
> -config GENERIC_CMPDI2
> +config GENERIC_LIB_CMPDI2
>  	bool
>
> -config GENERIC_UCMPDI2
> +config GENERIC_LIB_UCMPDI2
>  	bool
> diff --git a/lib/Makefile b/lib/Makefile
> index a90d4fcd748f..7425e177f08c 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -253,9 +253,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>  obj-$(CONFIG_PARMAN) += parman.o
>
>  # GCC library routines
> -obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
> -obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
> -obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
> -obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
> -obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
> -obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
> +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> +obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o

Sorry, I'm not sure if this is the right patch -- someone suggested acking 
this, but it's already Review-By me and if I understand correctly it's going 
through your tree.  I'm a bit new to this, but if it helps then here's a

Acked-By: Palmer Dabbelt <palmer@sifive.com>
