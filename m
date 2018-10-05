Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159DD20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R32oHxVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159DD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJEND2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:03:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38459 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJEND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:03:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so6319542plr.5;
        Thu, 04 Oct 2018 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2v/ptwqZjKOOXta0gFUD/vV+Hs7Z/HEHJWgkpGf5g+A=;
        b=R32oHxVdxZ8X32NZDVhx5BUkom99SHZBGJb0YuAppRLZOme2cSuQ6dHdpZcNvVFvxs
         lYRQFXTLmQSEKy8a4VGYksHhQJMDEADH4EbNQhg/h20nHrNgrA2KwuZnYzMBixCRuZPN
         mu7/laXqg/E7ZlbJ7IpwPTxP3RhHrP7RUdcSClvsutWCoPxGUPyC4vOAnHejhPakEfBQ
         /H8aOmRk1vlNJM5Uvau0orDAKasupcqtI9OQO6r+1AYa0DICbp2EpjBQTiJNz3IXxitf
         7sK8sZv/zOkSBJn/igEmo7hE/zHTKtIcA/uMzsG9T7jbJVM65Jtzw2Z6d+tJhvsnUf+r
         +eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2v/ptwqZjKOOXta0gFUD/vV+Hs7Z/HEHJWgkpGf5g+A=;
        b=d/L/VipjiFoqpVLPmQqfMtSsiL8BP0Ve5gLGQz1AsbFJFexmerRpjsznOFhmC4iTTY
         3BGdvWXliCVi8xB2gHSmWJ/F9bXEBZNgXSNWQHM+fSTGrdUtCKzprk5PGWGh84iTtWZQ
         TSjU+u0F6j5ZxCjTut9b/idt6O3UmrQAUGbkxc0C+WbHjJIidiwvqdeiZjenle/00iJE
         TXRZ/lcLHuowZSxagBPgG90GPyjj98MdVPASJ5eMyle56JQZgurogZuI+C6vVgnp366a
         LrtJvNWt9nvZkNJCEWZl3CkV7vBFOkqF3WoeF3blkRCNn3OJ2qIgJLQf5Q8RfLcex3KE
         zNHA==
X-Gm-Message-State: ABuFfogWUmzaYaVfJQ1jHq1cfd/tDKRSBVuPLwduXy4jZu/ASWSPc04y
        xFAAgi/0LxkjQXVtC6xkP84=
X-Google-Smtp-Source: ACcGV61UDNSf2UxVFuR32TICtU4koGuGrukA9dMbytSObF1+ZPBWx3GFh/7dDPxY8qaFrMxXRnf6SQ==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21-v6mr9964275pls.38.1538719576221;
        Thu, 04 Oct 2018 23:06:16 -0700 (PDT)
Received: from gmail.com (h126.142.139.40.ip.windstream.net. [40.139.142.126])
        by smtp.gmail.com with ESMTPSA id k83-v6sm10826269pfj.63.2018.10.04.23.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 23:06:15 -0700 (PDT)
Date:   Thu, 4 Oct 2018 23:06:13 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REVIEW][PATCH 2/6] signal: Fail sigqueueinfo if si_signo != sig
Message-ID: <20181005060611.GA19061@gmail.com>
References: <87h8idv6nw.fsf@xmission.com>
 <20180925171906.19683-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180925171906.19683-2-ebiederm@xmission.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:19:02PM +0200, Eric W. Biederman wrote:
> The kernel needs to validate that the contents of struct siginfo make
> sense as siginfo is copied into the kernel, so that the proper union
> members can be put in the appropriate locations.  The field si_signo
> is a fundamental part of that validation.  As such changing the
> contents of si_signo after the validation make no sense and can result
> in nonsense values in the kernel.

Accoding to the man page, the user should not set si_signo, it has to be set
by kernel.

$ man 2 rt_sigqueueinfo

    The uinfo argument specifies the data to accompany  the  signal.   This
       argument  is  a  pointer to a structure of type siginfo_t, described in
       sigaction(2) (and defined  by  including  <sigaction.h>).   The  caller
       should set the following fields in this structure:

       si_code
              This  must  be  one of the SI_* codes in the Linux kernel source
              file include/asm-generic/siginfo.h, with  the  restriction  that
              the  code  must  be  negative (i.e., cannot be SI_USER, which is
              used by the kernel to indicate a signal  sent  by  kill(2))  and
              cannot  (since  Linux  2.6.39) be SI_TKILL (which is used by the
              kernel to indicate a signal sent using tgkill(2)).

       si_pid This should be set to a process ID, typically the process ID  of
              the sender.

       si_uid This  should  be set to a user ID, typically the real user ID of
              the sender.

       si_value
              This field contains the user data to accompany the signal.   For
              more information, see the description of the last (union sigval)
              argument of sigqueue(3).

       Internally, the kernel sets the si_signo field to the  value  specified
       in  sig,  so that the receiver of the signal can also obtain the signal
       number via that field.

> 
> As such simply fail if someone is silly enough to set si_signo out of
> sync with the signal number passed to sigqueueinfo.
> 
> I don't expect a problem as glibc's sigqueue implementation sets
> "si_signo = sig" and CRIU just returns to the kernel what the kernel
> gave to it.
> 
> If there is some application that calls sigqueueinfo directly that has
> a problem with this added sanity check we can revisit this when we see
> what kind of crazy that application is doing.


I already know two "applications" ;)

https://github.com/torvalds/linux/blob/master/tools/testing/selftests/ptrace/peeksiginfo.c
https://github.com/checkpoint-restore/criu/blob/master/test/zdtm/static/sigpending.c

Disclaimer: I'm the author of both of them.

> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/signal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7b49c31d3fdb..e445b0a63faa 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3306,7 +3306,8 @@ static int do_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t *info)
>  	    (task_pid_vnr(current) != pid))
>  		return -EPERM;
>  
> -	info->si_signo = sig;
> +	if (info->si_signo != sig)
> +		return -EINVAL;
>  
>  	/* POSIX.1b doesn't mention process groups.  */
>  	return kill_proc_info(sig, info, pid);
> @@ -3354,7 +3355,8 @@ static int do_rt_tgsigqueueinfo(pid_t tgid, pid_t pid, int sig, siginfo_t *info)
>  	    (task_pid_vnr(current) != pid))
>  		return -EPERM;
>  
> -	info->si_signo = sig;
> +	if (info->si_signo != sig)
> +		return -EINVAL;
>  
>  	return do_send_specific(tgid, pid, sig, info);
>  }
