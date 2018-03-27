Return-Path: <will.deacon@arm.com>
X-Google-Smtp-Source: AIpwx4+HN0FPwaj9hcA5rd0/Ki73arstDdUaNGvzIxry10Pc16BKXG/I4Rttpp/ezoS9T4MusaIB
ARC-Seal: i=1; a=rsa-sha256; t=1522171686; cv=none;
        d=google.com; s=arc-20160816;
        b=rL5wxc60c8iFoMhppaj6nPZ0Fwgsd5TwHno55n2J614e4iiO9UblA82jBt3RoQe5/7
         b8AMGr3mhJjRaNs4xCgtupJLHtMpVQO069TB5hNj9th4vM5IYLIHzGvumMcjIst8LLSO
         TqCZc+MBOv/iD2MRYUKRhHv92jkNPCttHihnWGawwBO8aQJHo1twnWZdAREdPAsOETlO
         n3z7cIQep+HQdaPeavm+LjdcdkYtwPIYsfoXaIcRM0FNZIRE47XkoOvwJRBk679ctqUz
         2wRclAAjxXz33XN5r1yjF/UKXOz2YKoutRJRyohP4wE9iDIeXdLbXRjCtyWhiVcfB1/B
         lX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uZL1J/f9s4hDejb95/GXjDEhnaKFLJPfnMhI2VgM61A=;
        b=FgPWahoL4yuz4kEW/9wT8HSJaLJB4kbGGKJOZq4ztPnzbTdYlkYb0xTJ4+1wc5FYMF
         6u21A3oH3Hk3oma4hhLoWs20VP9ssObnTYaGwlk9LE9IXCiGBX/W6RZeMGEPy5EJZZ+b
         l1E5Nf/fWsm5Ou7gnvDEKP38SGrJo7o4LgLRSpRpRZrM7dn7RuX97nK9hi19LP+OsPU9
         Y3atGRF+9x1WbqJb4DUm3TrAtGmpaJETpWgeZF1AumFtLDTdnUilJMIgQuKXEir28X4T
         l+NjfZCsc2jEzTF5lPE1/i87AKbGWaTWGsQNApPC4Mo20vZkrPsaWFOFYK5vD+slItoJ
         EeqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of will.deacon@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=will.deacon@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of will.deacon@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=will.deacon@arm.com
Date: Tue, 27 Mar 2018 18:28:15 +0100
From: Will Deacon <will.deacon@arm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Nicolas Pitre <nico@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 21/21] arm64: move GCC version check for
 ARCH_SUPPORTS_INT128 to Kconfig
Message-ID: <20180327172815.GH18435@arm.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067581246942212?=
X-GMAIL-MSGID: =?utf-8?q?1596112697986331487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 02:29:35PM +0900, Masahiro Yamada wrote:
> This becomes much neater in Kconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Newly added
> 
>  arch/arm64/Kconfig  | 1 +
>  arch/arm64/Makefile | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7381eeb..0c97f40 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -43,6 +43,7 @@ config ARM64
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> +	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b481b4a..7318165 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -57,8 +57,6 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
>  
> -KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
> -

If this does what it claims to do, then I agree that it's much cleaner!

Acked-by: Will Deacon <will.deacon@arm.com>

Will
