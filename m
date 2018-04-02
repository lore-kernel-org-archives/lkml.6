Return-Path: <nicolas.pitre@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522692496; cv=none;
        d=google.com; s=arc-20160816;
        b=elPHNkqASJVlmssdq7l6psuhm9pHJGsGWIV9SRT8PlURhMI5VL/O/1sdxeTf/lX4OW
         qkL4UNtsn48OEYYAUPaNHDMtVFqrACSeYaLPl3dXALoWg5qRxHv5l6Vkf0evMtOyOd6d
         gCPqBxNM99+5/IeE4aqVs+RPh5/f9M2hqR0Csia7qqNhI6UwZiFIplHalF4qkLqY8fzy
         KgqFiSstkZG1D8TmOZAfQxt/S0kRiCJPdNjAwr2iPYOS66t5jk2twWXnqh8fbw2CfaQy
         rxf/IWeaJqv/AhjggycUbR0ZWWe+AZ7uyjoXIhOUxDuDExbmrfeNUYFkNcO6y+QcdziN
         4lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=mY2EG03vlST2dofZLxR3viwdhb95wTLrl9amojQFlPA=;
        b=thOhbKkUEmglCcPgbPZJ6HSNKG96pZR48AhlhvWdoz3oV2u61KDGh1qJ3Rl1jqXcab
         Wzybu+msKRxFGqeVHD3Ou04JyHlN1+6XnX/ohgV4PhoaxBrKnkc0bBUyD3cSv+ohY+Ji
         CmZz+sKXJoAcitFt19m5g4S+FASzwf1ovSnelDpgZAkGEq3lzKTa8oasTxnM7Ql7NRm6
         2XdPt8VAj5YRvxucn/Xk6RiGeqCB4KGKdn2P50cHbs3nKV1f2jiNujah7owgSWW+/hOU
         8Nf8q77q0lIrSlHiQmo4KWVxZ3WsvZ9u92i2yf50HfSLkbj2+pc1158ZxqUvTxPARm3N
         NwRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Oxz0ahqN;
       spf=pass (google.com: domain of nicolas.pitre@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=nicolas.pitre@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Oxz0ahqN;
       spf=pass (google.com: domain of nicolas.pitre@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=nicolas.pitre@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48dYOQDAbwstPsHPxSpc+TSbkFyxWUwy0sNzGGxNsm8E4MNM1QkyPhX3HaNJqMIe50wkSkYhw==
Date: Mon, 2 Apr 2018 14:08:13 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Abbott Liu <liuwenliang@huawei.com>
cc: aryabinin@virtuozzo.com, dvyukov@google.com,
    Jonathan Corbet <corbet@lwn.net>,
    Russell King - ARM Linux <linux@armlinux.org.uk>,
    christoffer.dall@linaro.org, marc.zyngier@arm.com,
    kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
    f.fainelli@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
    linux@rasmusvillemoes.dk, mawilcox@microsoft.com, pombredanne@nexb.com,
    ard.biesheuvel@linaro.org, vladimir.murzin@arm.com,
    alexander.levin@verizon.com, tglx@linutronix.de, thgarnie@google.com,
    dhowells@redhat.com, keescook@chromium.org, Arnd Bergmann <arnd@arndb.de>,
    geert@linux-m68k.org, tixy@linaro.org, julien.thierry@arm.com,
    mark.rutland@arm.com, james.morse@arm.com, zhichao.huang@linaro.org,
    jinb.park7@gmail.com, labbott@redhat.com, philip@cog.systems,
    grygorii.strashko@linaro.org, Catalin Marinas <catalin.marinas@arm.com>,
    opendmb@gmail.com, kirill.shutemov@linux.intel.com,
    kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
    kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
Subject: Re: [PATCH v3 5/6] Initialize the mapping of KASan shadow memory
In-Reply-To: <20180402120440.31900-6-liuwenliang@huawei.com>
Message-ID: <nycvar.YSQ.7.76.1804021402521.28462@knanqh.ubzr>
References: <20180402120440.31900-1-liuwenliang@huawei.com> <20180402120440.31900-6-liuwenliang@huawei.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596637214651692602?=
X-GMAIL-MSGID: =?utf-8?q?1596658807484483040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2 Apr 2018, Abbott Liu wrote:

> index c79b829..20161e2 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -115,6 +115,9 @@ __mmap_switched:
>  	str	r8, [r2]			@ Save atags pointer
>  	cmp	r3, #0
>  	strne	r10, [r3]			@ Save control register values
> +#ifdef CONFIG_KASAN
> +	bl	kasan_early_init
> +#endif
>  	mov	lr, #0
>  	b	start_kernel
>  ENDPROC(__mmap_switched)

Would be better if lr was cleared before calling kasan_early_init.


Nicolas
