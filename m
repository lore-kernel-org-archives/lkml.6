Return-Path: <dvlasenk@redhat.com>
X-Google-Smtp-Source: AG47ELunzED+2JlHdpBBvkkkkgenFWmhY7YzFhNBV1aJEenun3uL0IMXJ4nWhViwstiufgPwdwL0
ARC-Seal: i=1; a=rsa-sha256; t=1520266190; cv=none;
        d=google.com; s=arc-20160816;
        b=vElHKjIdkL0Zp7wSNvfGvRf3aJhEkNCZG+9QC52O1v6bujGH1J7mG9138e+ED/yTUi
         /5wKdTpttu+OlTMS+ofXJXIXx///K67zj/yH/aM+fo4m6G45FlPFoJ+VRY9kfCG7Bb1m
         Vr/WZREWmSVViIFvtcBytwaA98cbpWakEEWadhf63S7IN0YynC3VSRfQGInOVXBtf7jd
         J8M+LEZwL3B9U2htUWpliNW0TWk6uzMZvHfxEJXc5WoB7+1KrECByq/DA6Gvy2vAOQES
         f+AJ6JakpHR4dYp4UWYirzDYbGGlg4gn1275cRIkX5w7J6DWWqIJXwE75EBQR74Gu8ZF
         kPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=AuQmjhLaNleeevZy8wKTkhHX20fJQCyxh2iu1cS3j0Y=;
        b=a4zIXRPkzS/CdiXIndhjq4w2ZD+FFkTHRAhoczBNHpjseJeKO651Vhu6BbMNxhCjW5
         Eky76/nUk/g37J7jjs/JU6bpA73ry+33UHKEjMikArutro+3VNaMn8Rbscxs/qoRSA2D
         eJoPzKhVyjHSg/8GUbK/VPYmWKg46TjeGdBxCmjxF90V0ErJ5zMwSYwCMXCAA/2QO3J/
         BPI/nmEa1XtYkk44QRZbrjnuGNOKxQDNSfSWnp0x48Fcjot+H4OZjhZQ/YzitXKDwL+p
         5NTgJd3dhl5rbROniZaVJEb8YyYBjKpux4M687slfzpZM+fc6gdgSsmrgCM1yx7bU5a5
         uTbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dvlasenk@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dvlasenk@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dvlasenk@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dvlasenk@redhat.com;
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
 Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
 daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
 Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>,
 Pavel Machek <pavel@ucw.cz>, jroedel@suse.de
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-35-git-send-email-joro@8bytes.org>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <c024f4d3-4780-5d62-a36a-8ccd79bc6299@redhat.com>
Date: Mon, 5 Mar 2018 17:09:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1520245563-8444-35-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093033976694451?=
X-GMAIL-MSGID: =?utf-8?q?1594114640648598393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 11:26 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Warn the user in case the performance can be significantly
> improved by switching to a 64-bit kernel.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   arch/x86/mm/pti.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 3ffd923..8f5aa0d 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -385,6 +385,22 @@ void __init pti_init(void)
>   
>   	pr_info("enabled\n");
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

Isn't it a bit too dramatic? Not one, but two lines of big fat warnings?

There are people who run 32-bit kernels on purpose, not because they
did not yet realize 64 bits are upon us.

E.g. industrial setups with strict regulations and licensing requirements.
In many such cases they already are more than satisfied with CPU speeds,
thus not interested in 64-bit migration for performance reasons,
and avoid it because it would incur mountains of paperwork
with no tangible gains.

The big fat warning on every boot would be irritating.
