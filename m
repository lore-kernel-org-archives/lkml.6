Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeCMFN2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:13:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22937 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeCMFN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:13:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180313051325epoutp016a870ad91dadf6dab86db52c567cd539~bYt4fOuoq1567515675epoutp01u
X-AuditID: b6c32a35-879ff70000001031-8f-5aa75df4747e
Subject: Re: [PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
To: jinb.park@samsung.com,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <e279a3cf-c231-65b8-f966-de35e7df3035@samsung.com>
Date: Tue, 13 Mar 2018 14:13:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTT/dL7PIog5t/hS2+THrHbvF+WQ+j
        xaLj99ksNj2+xmpxedccNoul1y8yObB5rJm3htFj85J6j74tqxg9Pm+S83i9/xBjAGtUqk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElulaENDIz1DA3M9IyMjPRPjWCsjU6CShNSMS0sXMxb84am4
        fecpSwPjdq4uRk4OCQETifa+YyxdjFwcQgI7GCUeLTnHBOF8Z5SYuKWfGabq4pEPUFUbGCVe
        /p3FCuHcBWqZ2MoKUiUs4Cyx+NJzdpCEiMBqRolT55uYQRxmgfmMEr1/3rKBVLEJ6Ehs/3ac
        CcTmFbCTeLTlI1icRUBV4u39aywgtqhAmMTRmZ8YIWoEJX5MvgcU5+DgFPCTaGrxAwkzC2hK
        vPgyiQXCFpdobr0JZctLbF7zFmyvhMAJNolpTavZIH5wkVi6tpEdwhaWeHV8CzvITAkBaYlL
        R20hwu2MEmdnC0P0TmGUWDGjmwkiYSzxbGEXE8QCPol3X3tYIXp5JTrahCBKPCTuLj8MNdJR
        YuEvTkgATQWGw5YLTBMY5WYh+WYWkhdmIXlhFpIXFjCyrGIUSy0ozk1PLTYsMNQrTswtLs1L
        10vOz93ECE6AWqY7GKec8znEKMDBqMTD29G6LEqINbGsuDL3EKMEB7OSCK/yf6AQb0piZVVq
        UX58UWlOavEhRlNgaE9klhJNzgcm57ySeEMTSwMTMyNgYrM0NFQS5w0IcIkSEkhPLEnNTk0t
        SC2C6WPi4JRqYAzVKXiht2DDr1mfBD48NOM6e2rmzQVX7pz0Lqu6w3rKo/bQL8ncyFk7y33u
        FO5PYejJ2h7d/+LtHn7nwHTDfaGiBk/1LuyYMIGP02v6paaOY7LfH+xforbsOEeqsKn9vLag
        A0WrTfe/4dg65f6/Fv/q88o7Lwr+t/cysKznfXfFR/vqm+pdBxmVWIozEg21mIuKEwGmERR7
        lgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t9jQd0vscujDO6uYbb4Mukdu8X7ZT2M
        FouO32ez2PT4GqvF5V1z2CyWXr/I5MDmsWbeGkaPzUvqPfq2rGL0+LxJzuP1/kOMAaxRXDYp
        qTmZZalF+nYJXBmXli5mLPjDU3H7zlOWBsbtXF2MnBwSAiYSF498YOli5OIQEljHKHFp9QVG
        COc+kPNqKTtIlbCAs8TiS8/ZQRIiAqsZJe6uuwJWxSwwn1HizsNOVoiW6YwSt3ZvZgZpYRPQ
        kdj+7TgTiM0rYCfxaMtHNhCbRUBV4u39aywgtqhAmETPpsuMEDWCEj8m3wOKc3BwCvhJNLX4
        gZjMAuoSU6bkglQwC4hLNLfeZIGw5SU2r3nLPIFRYBaS5lkIHbOQdMxC0rGAkWUVo2RqQXFu
        em6xUYFhXmq5XnFibnFpXrpecn7uJkZg6G87rNW3g/H+kvhDjAIcjEo8vB2ty6KEWBPLiitz
        DzFKcDArifAq/wcK8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvE
        wSnVwOjuPWGZ2r2/+hsSi7p325TnufeUfxPV9fW4t/OJa0KUvVPux4XLjibeSAzz0D/4SjpH
        YLnmzWtMS+VrHPInyP/Jv9f20qTngsa7trthnq8EWLtr3tnu95ohpt1x+4y/L0u42TaVYNmn
        Wzyaf0qXuB04vPge871Y66M/97PHtYa+2ceyJmT5dSWW4oxEQy3mouJEAHio5uB5AgAA
X-CMS-MailID: 20180313051324epcas1p223607eeedce283cf72369f822376fe48
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
X-RootMTR: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
References: <CGME20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
        <20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 01:53 PM, Jinbum Park wrote:
> To enable UBSAN on arm, ARCH_HAS_UBSAN_SANITIZE_ALL is needed to be selected.
> 
> Basic test has passed on Raspberry Pi2, Raspbian jessi lite with
> CONFIG_UBSAN_SANITIZE_ALL, CONFIG_UBSAN_NULL.
> 
> Signed-off-by: Jinbum Park <jinb.park@samsung.com>
> ---
>  arch/arm/Kconfig                  | 1 +
>  arch/arm/boot/compressed/Makefile | 1 +
>  arch/arm/vdso/Makefile            | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1878083..bdd1561 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,6 +7,7 @@ config ARM
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
> +	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..1b374ba 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
>  endif
>  
>  GCOV_PROFILE		:= n
> +UBSAN_SANITIZE		:= n
>  
>  #
>  # Architecture dependencies
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index bb411821..05597f7 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -29,6 +29,7 @@ CFLAGS_vgettimeofday.o = -O2
>  
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
> +UBSAN_SANITIZE := n
>  
>  # Force dependency
>  $(obj)/vdso.o : $(obj)/vdso.so
> 
