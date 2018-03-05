Return-Path: <longman@redhat.com>
X-Google-Smtp-Source: AG47ELtpAH5PgASzaoNq1PoYRpH/CGFMCR8yLY0dvmxpNDCsmih0+Jf1XiBJAIk8A8xbBwwx8fKK
ARC-Seal: i=1; a=rsa-sha256; t=1520257174; cv=none;
        d=google.com; s=arc-20160816;
        b=QR3vi6btguerfNwGMpDQlFcoR8L5kLB8t8NGIKDalAJvKHjMZm37EXjRgp6Ei05WV0
         j+268aPCkvn83lW8wjgOpY2MtzGzwb01HNcq9xR+C26XR2Monl6OrHhioODeROIwK2TS
         aT1S15O8iUa9/wxRvHyA6VcxmGZkLQOAEA5DCeOAWJRoMZhaGfXV7Pr8MUnYd/NvaMji
         /cGcNkZ87zssEf8IIgLOKBe94tMbQ63DNl1qsGWKi5OgtjoW96dnKCYazosMv/vNrEQb
         P28QBhsWYQ+sr2C2JZi7k0W1aMDNhRUxJNHW83YiscE2igVzs/iigVBK2Lu9L8sOkHAt
         p3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=oleO6uIqKRxgciax9wsNzwK6Jl4Sl9EveCSbxNpaUq4=;
        b=Ywdlv7fARoeTehkkuMNMOISUYJQome1eluq+9MwlilaQl8ixtkhSkBiBx/+LVXnUFt
         vs/FOh+WGt5Rcvb1OKiXDDjL1MQiYeLPxIgDej91UjGkTYtNB/7q/lK2Ag2UcgiHuouM
         KbLOGoeZH31wO0UcvTSchVxXqBCFOg8snfEd8fA+xpkX4Zxn3+2iv0amEvE2w9gP6iWK
         iA90bqu8KTo14aMxHv49PueiP9jCag8BetcrstiBf92g8ib2alnXwX+RGBO5BJMXUMNk
         wl8z1oZv6zEwdv6zDEM1cFkMHODn2uTVh0OAFJFGt+eAtdhdInRzdJqVPhR7giAlIVeD
         mp0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH 34/34] x86/mm/pti: Add Warning when booting on a PCIE
 capable CPU
To: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Brian Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 aliguori@amazon.com, daniel.gruss@iaik.tugraz.at, hughd@google.com,
 keescook@google.com, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, jroedel@suse.de
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-35-git-send-email-joro@8bytes.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d879496a-887d-9077-3a7d-ee878a691bdc@redhat.com>
Date: Mon, 5 Mar 2018 08:39:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1520245563-8444-35-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093033976694451?=
X-GMAIL-MSGID: =?utf-8?q?1594105186846531756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 05:26 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Warn the user in case the performance can be significantly
> improved by switching to a 64-bit kernel.
>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/mm/pti.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 3ffd923..8f5aa0d 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -385,6 +385,22 @@ void __init pti_init(void)
>  
>  	pr_info("enabled\n");
>  
> +#ifdef CONFIG_X86_32
> +	if (boot_cpu_has(X86_FEATURE_PCID)) {
> +		/* Use printk to work around pr_fmt() */
> +		printk(KERN_WARNING "\n");
> +		printk(KERN_WARNING "************************************************************\n");
> +		printk(KERN_WARNING "** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **\n");
> +		printk(KERN_WARNING "**                                                        **\n");
> +		printk(KERN_WARNING "** You are using 32-bit PTI on a 64-bit PCID-capable CPU. **\n");
> +		printk(KERN_WARNING "** Your performance will increase dramatically if you     **\n");
> +		printk(KERN_WARNING "** switch to a 64-bit kernel!                             **\n");
> +		printk(KERN_WARNING "**                                                        **\n");
> +		printk(KERN_WARNING "** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **\n");
> +		printk(KERN_WARNING "************************************************************\n");
> +	}
> +#endif
> +
>  	pti_clone_user_shared();
>  	pti_clone_entry_text();
>  	pti_setup_espfix64();

Typo in the patch title: PCIE => PCID.

-Longman
