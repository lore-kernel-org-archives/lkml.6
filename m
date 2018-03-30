Return-Path: <kernel-hardening-return-12835-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/Dl9iSsPRy1LkzSLK98xQpROhkmK1TI0F0f9NslvaIKkcTXjU0OUpUPkZ/e5B6XLId5Xwj
ARC-Seal: i=1; a=rsa-sha256; t=1522422467; cv=none;
        d=google.com; s=arc-20160816;
        b=n8Gl2I5qlv3h7vk/ABGCZhk1dgOLuHnQ1VeqT6ic9HWbuSdiAEN6fa9pauCNOMk8qW
         DpmG5o1CF8h3VU40UuF6exmF/fUfg2DiscPh2ZJdRD0OIVa10KXH+bQ24pEduWuLSKM8
         noTa8SX2u5KD24IOljZw2tyiuwo12vKQVTymy8igE7z8/+Tf44Zof5zVZYs1pDW5ufHR
         tVJSHbX6iA2z/sb1cCwEnDeY7B+jGx6Oh9BetVD2eZkZTCUBityx0uTFLFy6C1iWgbGC
         vsAC8qCukXQh36ahWfhb9WlCfoljM7MYfonV1RlsgIcUJjXqWZ1H0FUNc4stnJIP7cVx
         g8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=HyTRJb/l+mgWEH4Y4SQsbmMlY1ZvozekgDku9k9wyuA=;
        b=PvxCOpGxso1tj3zrw+EohRU2qjKdW/Jl/1DPh5Y1GKU15b+rgFrVv47yu7F8SCDi1e
         xzmvuHp+yDeZRTy2MKIPBwGnOIERh40vJnceQAtSUaaGF7QGjkZc5rfiu9vFMcgPRObb
         J6caVGqbuoHZApqqINcnfn7LOAW+4BNiSlpSMQKM1KT3YsO4zOFMyGWDFXAm1o2al+Tz
         tXSjdMcELzgvj/AcWxyLSvDY+/sMfAo1WZzD5+4A208+DyPJnyj6SRWIOlYUJwfdrw/b
         kpwL8CxKRlAueJoEKx3lO7PJ6Lc0P7TrrGo2EyVAnuwFBFsJwnnVtFbwa165IM+QVk+n
         PJmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12835-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12835-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12835-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12835-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAB3217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 30 Mar 2018 10:34:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, Ingo
 Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [v2] ftrace: drop a VLA in module_exists()
Message-ID: <20180330103411.5ed25f43@gandalf.local.home>
In-Reply-To: <1522399988-8815-1-git-send-email-s.mesoraca16@gmail.com>
References: <1522399988-8815-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596352124099470452?=
X-GMAIL-MSGID: =?utf-8?q?1596375661195008301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 30 Mar 2018 10:53:08 +0200
Salvatore Mesoraca <s.mesoraca16@gmail.com> wrote:

Couple of things. First, "PATCH" was dropped from the subject. If my
inbox was busy today, I probably would have missed this email.

> Avoid a VLA[1] by using a real constant expression instead of a variable.
> The compiler should be able to optimize the original code and avoid using
> an actual VLA. Anyway this change is useful because it will avoid a false
> positive with -Wvla, it might also help the compiler generating better
> code.
> 
> [1] https://lkml.org/lkml/2018/3/7/621

Second, do not use lkml.org, use http://lkml.kernel.org/r/<messageid>

Search for "Link:" tags in git log to see examples.

Other than that, the patch looks fine to me and I can pull it for the
next merge window.

-- Steve

> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  kernel/trace/ftrace.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index eac9ce2..16bbf06 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3902,14 +3902,13 @@ static bool module_exists(const char *module)
>  {
>  	/* All modules have the symbol __this_module */
>  	const char this_mod[] = "__this_module";
> -	const int modname_size = MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1;
> -	char modname[modname_size + 1];
> +	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
>  	unsigned long val;
>  	int n;
>  
> -	n = snprintf(modname, modname_size + 1, "%s:%s", module, this_mod);
> +	n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
>  
> -	if (n > modname_size)
> +	if (n > sizeof(modname) - 1)
>  		return false;
>  
>  	val = module_kallsyms_lookup_name(modname);
