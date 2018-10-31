Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69715C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC642080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="FeUzRy1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC642080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeKACxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:53:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45244 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbeKACxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:53:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so18090754qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KU7NTQjjJ2BEHJJ1W7BtEhUyIBSVtGvlz07nH730Syw=;
        b=FeUzRy1rIDoaPIgNBVvo/O8O9Nu7ajTn1Q6VVQeK2UGHo9Ppu5n06DOUeW3J2D0oNH
         AIXaSY6WaHSCFH/W7NMQeBNvWo0HfB+2X8B+UWVCFgdQVJv5Fq2ufogwgwzwgZumV9U+
         fGPqHYKmCdNp6H5aYmuz3XqeZBfwZhvlQ/b1fZjmTfMslWa9OL7kK7EWSiEPwINDs0H4
         wcuVmz54OmA0wQVir9TgRkgYnzQk/0AmyVH9Bu5zcnD3f5J5Hfy5P/UZ4LiM7tcggW7n
         IPQ3LxAiiLF1gI+fuXl6ITwTjKdoWFz2rTWHd81ZPTnaMtd5OgObRxqC245lmOul+Lgd
         aoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KU7NTQjjJ2BEHJJ1W7BtEhUyIBSVtGvlz07nH730Syw=;
        b=OKv6hEozgfnw6+bokK0qL2iKcSFA9LiKDSNAYsbXok83CH7SHmYPQUxo96vuThXfF2
         rb74119rWEz+HsRJaw2jbue1HNprt9+orbgP3AVO6x9AsDNDOsLxa01I3XIG7ZVNo2GU
         5Q4MZ59QtKX9OXdKjnYJcimqg0Xht+bRUmeZ0XkbcSFBOpLDaPOQfwa82+b+YnylHtyV
         I3mahN1LRX/EcoWp4Flt9NsEXuiwwcMXtx3w0Y+HqAwdULDYbkUyVY2Xwrf2D/VTWFzY
         l0hnt4bAQRxccSe3d5KF5iF0osfkjH1ABQci8w+ZWf3Hu2bQ87+IIaxA9YGoQUNUksB8
         n8Hg==
X-Gm-Message-State: AGRZ1gJtf9DlOie/EXLhbvgJdKS19p0PUmM3GLfNtZrmTV0PtCGZDj7g
        r8uRViDCO1+XPVpURAYPv7Qlgg==
X-Google-Smtp-Source: AJdET5e3RcWV2BMTEtFm1DdEERjmhu3XiZI8JH04bxfD8YOSu8liQHC2Smj84MBpQLKjZIbxgbVHgQ==
X-Received: by 2002:aed:2a0b:: with SMTP id c11-v6mr3604978qtd.147.1541008491703;
        Wed, 31 Oct 2018 10:54:51 -0700 (PDT)
Received: from cisco ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id o68-v6sm19015355qkl.65.2018.10.31.10.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:54:50 -0700 (PDT)
Date:   Wed, 31 Oct 2018 11:54:48 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com, cyphar@cyphar.com,
        christian.brauner@canonical.com, ebiederm@xmission.com,
        keescook@chromium.org, oleg@redhat.com
Subject: Re: [PATCH v3] Implement /proc/pid/kill
Message-ID: <20181031175448.GC2180@cisco>
References: <20181029221037.87724-1-dancol@google.com>
 <20181031155912.45088-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031155912.45088-1-dancol@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 03:59:12PM +0000, Daniel Colascione wrote:
> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> write the signal number in base-10 ASCII to the kill file of the
> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
> 
> Semantically, /proc/pid/kill works like kill(2), except that the
> process ID comes from the proc filesystem context instead of from an
> explicit system call parameter. This way, it's possible to avoid races
> between inspecting some aspect of a process and that process's PID
> being reused for some other process.
> 
> Note that the write(2) to the kill file descriptor works only if it
> happens in the security context as the call to open(2), where
> "security context" is defined as the set of all ambient user IDs
> (effective uid, fs uid, real uid, and saved uid) as well as the
> presence of the CAP_KILL capability.  This check prevents confused
> deputy attacks via, e.g., supplying a /proc/$(pidof httpd)/kill file
> descriptor as the standard output of setuid program and convincing
> that program to write a "9".
> 
> With /proc/pid/kill, it's possible to write a proper race-free and
> safe pkill(1). An approximation follows. A real program might use
> openat(2), having opened a process's /proc/pid directory explicitly,
> with the directory file descriptor serving as a sort of "process
> handle".
> 
>     #!/bin/bash
>     set -euo pipefail
>     pat=$1
>     for proc_status in /proc/*/status; do (
>         cd $(dirname $proc_status)
>         readarray proc_argv -d'' < cmdline
>         if ((${#proc_argv[@]} > 0)) &&
>                [[ ${proc_argv[0]} = *$pat* ]];
>         then
>             echo 15 > kill
>         fi
>     ) || true; done
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
> 
> Turns out that checking struct user isn't sufficient, since signal.c's
> permissions check also cares about effective UIDs. Let's be
> extra-paranoid and bail if _anything_ relevant in struct cred
> has changed.
> 
> Also, as Joel suggested, switch from goto-return to direct return.
> 
>  fs/proc/base.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7e9f07bf260d..b0e7ded96af9 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -205,6 +205,72 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
>  	return result;
>  }
>  
> +static ssize_t proc_pid_kill_write(struct file *file,
> +				   const char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	ssize_t res;
> +	int sig;
> +	char buffer[4];
> +	const struct cred *cur_cred;
> +	const struct cred *open_cred;
> +	bool security_changed;
> +
> +	/* This check prevents a confused deputy attack in which an
> +	 * unprivileged process opens /proc/victim/kill and convinces
> +	 * a privileged process to write to that kill FD, effectively
> +	 * performing a kill with the privileges of the unwitting
> +	 * privileged process.  Here, we just fail the kill operation
> +	 * if someone calls write(2) with a real user ID that differs
> +	 * from the one used to open the kill FD.
> +	 */
> +	cur_cred = current_cred();
> +	open_cred = file->f_cred;
> +	security_changed =
> +		cur_cred->user_ns != open_cred->user_ns ||
> +		!uid_eq(cur_cred->euid, open_cred->euid) ||
> +		!uid_eq(cur_cred->fsuid, open_cred->fsuid) ||
> +		!uid_eq(cur_cred->suid, open_cred->suid) ||
> +		!uid_eq(cur_cred->uid, open_cred->uid) ||
> +		/* No audit: if we actually use the capability, we'll
> +		 * audit during the actual kill. Here, we're just
> +		 * checking whether our kill-FD has escaped its
> +		 * original security context and bailing if it has.
> +		 */
> +		(security_capable_noaudit(cur_cred,
> +					  cur_cred->user_ns,
> +					  CAP_KILL)
> +		 != security_capable_noaudit(open_cred,
> +					     open_cred->user_ns,
> +					     CAP_KILL));
> +	if (security_changed)
> +		return -EPERM;

Why not just use an ioctl() like Jann suggested instead of this big
security check? Then we avoid the whole setuid writer thing entirely,
and we can pass the fd around if we want to.

Tycho
