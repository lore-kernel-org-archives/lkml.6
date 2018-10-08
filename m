Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D73C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3DD2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Kovw5igl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3DD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJHW2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:28:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37958 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeJHW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:28:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id 193-v6so8665947wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DetQFyQlePU+EYhSS1PCzOhKa78K4wtJ5cMv6JuPkxs=;
        b=Kovw5iglkPtrS2yKLMXvSX+zHn+CvJ+O9xSpAbYaMfR2G8atbmscOYEkrL4lTK+Bhq
         etjJV+sK2eyrghxyaW2WSDQJ+6yth6t2gOop41xF49EDE4Hi75ZEXZXn0n4iXS+uABlk
         j4fIjGg5O8peJTHD5B560p0/QROPHNJGsnurFrKlgFATMxfMROIunCnteIpSX66/Qkfd
         wGWsbCtf00PHJ0iNQgxsbfhUqSbXo1T4T9hIljWRueCFONA9vjx54EgFwEg8ipXZpzOP
         M82BjXEamUXBt1O9uefYeCwjg0O4SpimbEsvYKFMLKmna5bjydbAeX/vV2CcJ+r6vKwk
         Afow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DetQFyQlePU+EYhSS1PCzOhKa78K4wtJ5cMv6JuPkxs=;
        b=B1ASQ6eJLy1YxjHUGLlcgfEL4/4qs2U7JsS8WpegdPPojibz6kTzZWj2oR5S4yyihv
         NGAGZtjHIrELuCDtOUVrwYRMG6o59jJccaq5z0cN2gEuk+kvYh5/E+YopI+vcIRhaAbu
         UJYP6HHxwoObu8liF2NG+KQ0YF3D7W4DzsrYbriiuaaTW4xf0XYVToCJzKqyTI+QjTjX
         YbZkkfY0pjfZNk5h5PQZMEYIop8uchoc/+7VJe+06r9IaViFfbcPIPCVbGYFVKIBSsHC
         5+MiogtDyNjBiyaYLzblEnZB7uhTGqamEUDiTcsS1xwARd86YxSAc/MkN1bi7oPEp6HG
         DUjw==
X-Gm-Message-State: ABuFfoj6+4gJdk/41CWpXIHPewn5qw1GWuoYnHdp6+pEBNzH8Sn5n0or
        JzV2tvo0pr0K838VDte6C+jtHA==
X-Google-Smtp-Source: ACcGV621I7oFACvJ2BBgrTlwVgF4uKf2DGUtCtNNJyB8ZG2gh2eQWMu5Rr5lZ72M5a/Ji7veXG6dVQ==
X-Received: by 2002:a1c:1804:: with SMTP id 4-v6mr15028054wmy.29.1539011797151;
        Mon, 08 Oct 2018 08:16:37 -0700 (PDT)
Received: from brauner.io (u-086-c052.eap.uni-tuebingen.de. [134.2.86.52])
        by smtp.gmail.com with ESMTPSA id l67-v6sm29571621wma.20.2018.10.08.08.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 08:16:36 -0700 (PDT)
Date:   Mon, 8 Oct 2018 17:16:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181008151629.hkgzzsluevwtuclw@brauner.io>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927151119.9989-4-tycho@tycho.ws>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> version which can acquire filters is useful. There are at least two reasons
> this is preferable, even though it uses ptrace:
> 
> 1. You can control tasks that aren't cooperating with you
> 2. You can control tasks whose filters block sendmsg() and socket(); if the
>    task installs a filter which blocks these calls, there's no way with
>    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.

So for the slow of mind aka me:
I'm not sure I completely understand this problem. Can you outline how
sendmsg() and socket() are involved in this?

I'm also not sure that this holds (but I might misunderstand the
problem) afaict, you could do try to get the fd out via CLONE_FILES and
other means so something like: 

// let's pretend the libc wrapper for clone actually has sane semantics
pid = clone(CLONE_FILES);
if (pid == 0) {
        fd = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);

        // Now this fd will be valid in both parent and child.
        // If you haven't blocked it you can inform the parent what
        // the fd number is via pipe2(). If you have blocked it you can
        // use dup2() and dup to a known fd number.
}

> 
> v2: fix a bug where listener mode was not unset when an unused fd was not
>     available
> v3: fix refcounting bug (Oleg)
> v4: * change the listener's fd flags to be 0
>     * rename GET_LISTENER to NEW_LISTENER (Matthew)
> v5: * add capable(CAP_SYS_ADMIN) requirement
> v7: * point the new listener at the right filter (Jann)
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Christian Brauner <christian.brauner@ubuntu.com>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
>  include/linux/seccomp.h                       |  7 ++
>  include/uapi/linux/ptrace.h                   |  2 +
>  kernel/ptrace.c                               |  4 ++
>  kernel/seccomp.c                              | 31 +++++++++
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 68 +++++++++++++++++++
>  5 files changed, 112 insertions(+)
> 
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 017444b5efed..234c61b37405 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -83,6 +83,8 @@ static inline int seccomp_mode(struct seccomp *s)
>  #ifdef CONFIG_SECCOMP_FILTER
>  extern void put_seccomp_filter(struct task_struct *tsk);
>  extern void get_seccomp_filter(struct task_struct *tsk);
> +extern long seccomp_new_listener(struct task_struct *task,
> +				 unsigned long filter_off);
>  #else  /* CONFIG_SECCOMP_FILTER */
>  static inline void put_seccomp_filter(struct task_struct *tsk)
>  {
> @@ -92,6 +94,11 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
>  {
>  	return;
>  }
> +static inline long seccomp_new_listener(struct task_struct *task,
> +					unsigned long filter_off)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_SECCOMP_FILTER */
>  
>  #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index d5a1b8a492b9..e80ecb1bd427 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -73,6 +73,8 @@ struct seccomp_metadata {
>  	__u64 flags;		/* Output: filter's flags */
>  };
>  
> +#define PTRACE_SECCOMP_NEW_LISTENER	0x420e
> +
>  /* Read signals from a shared (process wide) queue */
>  #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
>  
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 21fec73d45d4..289960ac181b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
>  		ret = seccomp_get_metadata(child, addr, datavp);
>  		break;
>  
> +	case PTRACE_SECCOMP_NEW_LISTENER:
> +		ret = seccomp_new_listener(child, addr);
> +		break;
> +
>  	default:
>  		break;
>  	}
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 44a31ac8373a..17685803a2af 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
>  
>  	return ret;
>  }
> +
> +long seccomp_new_listener(struct task_struct *task,
> +			  unsigned long filter_off)
> +{
> +	struct seccomp_filter *filter;
> +	struct file *listener;
> +	int fd;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;

I know this might have been discussed a while back but why exactly do we
require CAP_SYS_ADMIN in init_userns and not in the target userns? What
if I want to do a setns()fd, CLONE_NEWUSER) to the target process and
use ptrace from in there?

> +
> +	filter = get_nth_filter(task, filter_off);
> +	if (IS_ERR(filter))
> +		return PTR_ERR(filter);
> +
> +	fd = get_unused_fd_flags(0);
> +	if (fd < 0) {
> +		__put_seccomp_filter(filter);
> +		return fd;
> +	}
> +
> +	listener = init_listener(task, filter);
> +	__put_seccomp_filter(filter);
> +	if (IS_ERR(listener)) {
> +		put_unused_fd(fd);
> +		return PTR_ERR(listener);
> +	}
> +
> +	fd_install(fd, listener);
> +	return fd;
> +}
>  #endif
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 5f4b836a6792..c6ba3ed5392e 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -193,6 +193,10 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
>  }
>  #endif
>  
> +#ifndef PTRACE_SECCOMP_NEW_LISTENER
> +#define PTRACE_SECCOMP_NEW_LISTENER 0x420e
> +#endif
> +
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>  #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
>  #elif __BYTE_ORDER == __BIG_ENDIAN
> @@ -3175,6 +3179,70 @@ TEST(get_user_notification_syscall)
>  	EXPECT_EQ(0, WEXITSTATUS(status));
>  }
>  
> +TEST(get_user_notification_ptrace)
> +{
> +	pid_t pid;
> +	int status, listener;
> +	int sk_pair[2];
> +	char c;
> +	struct seccomp_notif req = {};
> +	struct seccomp_notif_resp resp = {};
> +
> +	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
> +
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		EXPECT_EQ(user_trap_syscall(__NR_getpid, 0), 0);
> +
> +		/* Test that we get ENOSYS while not attached */
> +		EXPECT_EQ(syscall(__NR_getpid), -1);
> +		EXPECT_EQ(errno, ENOSYS);
> +
> +		/* Signal we're ready and have installed the filter. */
> +		EXPECT_EQ(write(sk_pair[1], "J", 1), 1);
> +
> +		EXPECT_EQ(read(sk_pair[1], &c, 1), 1);
> +		EXPECT_EQ(c, 'H');
> +
> +		exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
> +	}
> +
> +	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
> +	EXPECT_EQ(c, 'J');
> +
> +	EXPECT_EQ(ptrace(PTRACE_ATTACH, pid), 0);
> +	EXPECT_EQ(waitpid(pid, NULL, 0), pid);
> +	listener = ptrace(PTRACE_SECCOMP_NEW_LISTENER, pid, 0);
> +	EXPECT_GE(listener, 0);
> +
> +	/* EBUSY for second listener */
> +	EXPECT_EQ(ptrace(PTRACE_SECCOMP_NEW_LISTENER, pid, 0), -1);
> +	EXPECT_EQ(errno, EBUSY);
> +
> +	EXPECT_EQ(ptrace(PTRACE_DETACH, pid, NULL, 0), 0);
> +
> +	/* Now signal we are done and respond with magic */
> +	EXPECT_EQ(write(sk_pair[0], "H", 1), 1);
> +
> +	req.len = sizeof(req);
> +	EXPECT_EQ(ioctl(listener, SECCOMP_NOTIF_RECV, &req), sizeof(req));
> +
> +	resp.len = sizeof(resp);
> +	resp.id = req.id;
> +	resp.error = 0;
> +	resp.val = USER_NOTIF_MAGIC;
> +
> +	EXPECT_EQ(ioctl(listener, SECCOMP_NOTIF_SEND, &resp), sizeof(resp));
> +
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +
> +	close(listener);
> +}
> +
>  /*
>   * Check that a pid in a child namespace still shows up as valid in ours.
>   */
> -- 
> 2.17.1
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
