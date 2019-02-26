Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDBF217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBZJTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:19:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46911 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBZJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:19:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so13016622wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WAqaeBZociJP5yev0HU2+p0aRChkJsIy2eypiwRZQFE=;
        b=YVE9uxJlobkd/ni56iUHQ2OOYEyt1/YH4704olgt1DVxTV8ryawt5XuVwk6wrZ3NOE
         UI2t4WvydjNerLiV/9vRhrrJNpiAAAyAyottWHqLLPRlHXWpi1l5RW3qI/3d3O60eX13
         mC0T8La5Egwm1zSTTMdVyPGNvHwRi3GOpatlldV4XNOV/OnKb7/vIXivNt9auGemNcRh
         ONlXJjNmWLqtGVGURWJt+uBwr+fd4CZPwwFZP8taAo5COIK9u4HPFHpbd53CfuIOic6w
         XmyZzqM7rPE4CA12SFfIcWxuBQYndtsSA3kuuNx9fn8Zgi4P6q2i+In4G8VZftbbc2oM
         xgwg==
X-Gm-Message-State: AHQUAubgpFEXDBQ2eIPMP/feyM/r9CstO0m3iKWuies8eNA1+bK63BUe
        9DLTOjZ8rfJX9n5+gz3z56I=
X-Google-Smtp-Source: AHgI3IaJIwrpc9kWs64biO8BzVIQWgrTSFzK+F0aeltPJG9M3beBCx5qLxPxJ5DxkLs3Vv6a6mHEXg==
X-Received: by 2002:adf:e641:: with SMTP id b1mr15326500wrn.213.1551172744294;
        Tue, 26 Feb 2019 01:19:04 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id f13sm1522064wme.4.2019.02.26.01.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 01:19:03 -0800 (PST)
Subject: Re: [PATCH v2] kernel: release ptraced tasks before
 zap_pid_ns_processes
To:     Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20190110175200.12442-1-avagin@gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9049595f-5c48-6866-2769-96be697f9493@suse.cz>
Date:   Tue, 26 Feb 2019 10:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190110175200.12442-1-avagin@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 01. 19, 18:52, Andrei Vagin wrote:
> Currently, exit_ptrace() adds all ptraced tasks in a dead list, than
> zap_pid_ns_processes() waits all tasks in a current pidns, and only
> then tasks from the dead list are released.
> 
> zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
> this case, we will have one unkillable process with one or more dead
> children.
> 
> Thanks to Oleg for the advice to release tasks in find_child_reaper().
> 
> Fixes: 7c8bd2322c7f ("exit: ptrace: shift "reap dead" code from exit_ptrace() to forget_original_parent()")
> 
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
> 
> v2: Oleg showed that ptraced tasks can be released in
> find_child_reaper(). This allows to avoid additional
> write_lock/unlock(tasklist), and another list_for_each_entry_safe(dead)
> loop is called only if it is actually needed.
> 
>  kernel/exit.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 2d14979577ee..5df787a497f5 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -558,12 +558,14 @@ static struct task_struct *find_alive_thread(struct task_struct *p)
>  	return NULL;
>  }
>  
> -static struct task_struct *find_child_reaper(struct task_struct *father)
> +static struct task_struct *find_child_reaper(struct task_struct *father,
> +						struct list_head *dead)
>  	__releases(&tasklist_lock)
>  	__acquires(&tasklist_lock)
>  {
>  	struct pid_namespace *pid_ns = task_active_pid_ns(father);
>  	struct task_struct *reaper = pid_ns->child_reaper;
> +	struct task_struct *p, *n;
>  
>  	if (likely(reaper != father))
>  		return reaper;
> @@ -579,6 +581,12 @@ static struct task_struct *find_child_reaper(struct task_struct *father)
>  		panic("Attempted to kill init! exitcode=0x%08x\n",
>  			father->signal->group_exit_code ?: father->exit_code);
>  	}
> +
> +	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
> +		list_del_init(&p->ptrace_entry);
> +		release_task(p);
> +	}
> +

Hi,

from our (SUSE) QA we received a report that this patch causes a
performance decline in libmicro pthread_* benchmark as reported in:
https://bugzilla.suse.com/show_bug.cgi?id=1126762

I tried myself from the repo:
https://github.com/redhat-performance/libMicro

I ran
pthread_create -B 8 -C 200 -S

and with the patch applied:
# STATISTICS       usecs/call (raw)          usecs/call (outliers removed)
#                   mean     23.38611                17.29311

Without:
#                   mean     41.36539                39.21347

The values vary, but they are around 23 and 42, respectively.

The benchmark seems to create 8 (-B above) pthreads, does lock/unlock in
them and then the threads exit. The benchmark reaps the threads via
pthread_join. This all happens 200 times (-C above).

Any idea how to restore the performance close to the previous state?

>  	zap_pid_ns_processes(pid_ns);
>  	write_lock_irq(&tasklist_lock);
>  
> @@ -668,7 +676,7 @@ static void forget_original_parent(struct task_struct *father,
>  		exit_ptrace(father, dead);
>  
>  	/* Can drop and reacquire tasklist_lock */
> -	reaper = find_child_reaper(father);
> +	reaper = find_child_reaper(father, dead);
>  	if (list_empty(&father->children))
>  		return;

thanks,
-- 
js
suse labs
