Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx49GlHevqLIwZLcohcw+BAYDNcG5dJnmfCJTEhhNw13plktbZYzVDLejgDYAGJAabZ0F0jN3
ARC-Seal: i=1; a=rsa-sha256; t=1524743789; cv=none;
        d=google.com; s=arc-20160816;
        b=CtyBcNN+7oab8fdOc/O0WaEzvF3g0jjPVG8TgsJQFw4AdNNi+Fk/zxVJRYWiALDiq0
         lNls4JGjNb03ff/sxNTWV/rSsoPMotEIkxRxDFvGHBgwTottpsE4HdwSa9Fp5AIsCxPc
         0CSIQSqBLuaIMmP0hZrnm4obulxHSwUTSgzbkiMdAVCMuTuzCG74PAHXEpvfAXp66PV4
         QxhsTjNdXeQE0ym88NuiApCkeFs5fTLeIli9MYnld2VQs9fUlpUJR6qX+QqVBU8AkyJE
         WnbZGYSaD8bKvCFwPW/EBZ0p9aGhtn1eEJoPR1T8ULjX5/MkjO+I624RImBsoxnUrAjO
         7ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=YKoB4C74TIV4K5UgdbLliDVW3U+dHlvnV06HLfLRzZw=;
        b=hVz0UPDcxuY+zYiS7+w6WRAxwFE0YkcHjBdnxPPJAJamxsB92wBRrgNR5pb6kRY8G9
         VCz+iId+TObkZZJ2mDQXoAqgv8c/J2T7acDjCUsOM07LBUWXn0zb/3N4ePre2R3PHlSx
         j1yOD3umNOvfMIm+ILtA7dOOMvCtxrSqXkaDrCD2SuPU4vIc5nLzURN8RJjTZ/gACTJM
         yI+VBbM6h1BdC/wgcNr2YyEsgoPwOnz25nE4tuVRy64rq4lSZ/USuNiLqfSsHccfJVVK
         OjseXq5Y1oTEkINTB2gt65R4MRj8804kFF2xN3CIwHou13Sh5dwU/y/QtA1yQNYPxwnt
         bF9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 26 Apr 2018 13:56:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Wang <davidwang@zhaoxin.com>
cc: mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
    x86@kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
    cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
    lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH v3] report correct CPU/cache topology
In-Reply-To: <1524739647-30980-1-git-send-email-davidwang@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1804261353400.1584@nanos.tec.linutronix.de>
References: <1524739647-30980-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598805408410089263?=
X-GMAIL-MSGID: =?utf-8?q?1598809743561962792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thu, 26 Apr 2018, David Wang wrote:

> Centaur CPUs enumerate the cache topology in the same way as Intel CPUs,
> but the function is unused so far.
> The Centaur init code also misses to initialize x86_info::max_cores, so
> the CPU topology can't be described correctly.
> 
> Initialize x86_info::max_cores and invoke init_intel_cachinfo() to make
> CPU and cache topology information avaliable and correct

Now that looks pretty good.

> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> 
> Changes from v2 to v3:
> *1 define new detect_num_cpu_cores() in common.c to replace the original
> intel_num_cpu_cores;  
> *2 move cpu_detect_cache_sizes inside init_intel_cacheinfo.

But I asked for that being a separate patch with a separate changelog. And
the intel_cache_info() change wants to be in a separate patch as well. Then
the third patch is the one which makes use of these changes for
centaur.

Please read review comments carefully and rather ask when you have doubts
about the meaning.

Thanks,

	tglx
