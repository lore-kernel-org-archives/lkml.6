Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D215C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93F120871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="UB+qSvxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RO0Pem0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93F120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeFTFFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:05:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35869 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750821AbeFTFFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:05:10 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 494DE21ADA;
        Wed, 20 Jun 2018 01:05:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 01:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=U+s9xVQiY+lHx786TP4Y1R+2910Ppr8HtfH1fsWk/fE=; b=UB+qSvxi
        ZEW6jGtbTeYGUNmA/HyDolypUlfS2VED7xZ/9UeqxjUtWQz5BJqXl3GxTlyM2PQp
        wrg2HDwOvWSBFy5VRU538OvhKVE2dhJPMwmrQ0msA397Fp3RNjqY/Tu3HlFIJz/T
        gosrmEqm5PioPP2e6pHNJUK5iPOPDyhIP1FpGIfsRZ7VS8z7UHFwWoguoz6g5cSl
        TvzbGxxgdWpBlxVlms/D1aGswrI/XUOJJFXycWeVyZIz1oAYCkQo/CwTHZBvjIkJ
        8y7OhO+Kue/rVucDVKnzE9oW9iGe17jmb4OGjFS0Vf8YciUgoWOVLk3vTxMdBK9w
        kU+fwdjCniwW5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=U+s9xVQiY+lHx786TP4Y1R+2910Pp
        r8HtfH1fsWk/fE=; b=RO0Pem0jN9eQSIZ0abxxUwRWLraG6KVltOxthHaSk/Er3
        x50UFA6d0J1vXws5HkuQcrMRevjtl5fbnRy3bVxJFKgkihh2UquPXFBjXBkRauJ+
        71dm16tt2OGBpZtUzLqeYFg95n/T9GI9zPA3iWy+jOx3/iO6EMj769iyQdteZ6hF
        qnV5t5tO5x4Xb4HWJ5V2Qv0GCjpmxtQ/ijbAb9IWa6cDAuFtu0VRlf0+9BqZUcra
        H+xQrcN0ZHhX1RYkRbNIX5XYdvPiSqa0DuJizOFtD0Awp8p2zdYvKSD0Y9W9TjsA
        bbUd6GCyq9ACZE4SOd0i9UvhMisc6hk4XhqWr97FA==
X-ME-Proxy: <xmx:heApW3c7Uv_pjRs3fUT0F23R1ImAlx67hj4eYo2WWgFx52jTuB-PmA>
    <xmx:heApW2pxZUjD79wdP9ZCNZ7yCs9rFS-cwUxB2IgmxTCaVW-Wqx6LYg>
    <xmx:huApWwHUZL_SX6TXc7Ded-ZuV12RYkwFHApnZd3awDteRD2jepvtyg>
    <xmx:huApW-s9PusykVw-7dKm37yUOC-9AjyVflGV4yjE9I44rC_l0MG-ug>
    <xmx:huApW6Vl8g5punUlLmu8lzS2_kHh9VpoFNeVfvqTewmdO2iwEOEglQ>
    <xmx:huApW00WQwYjNUGP4PjOs0wpWIfi0ratssKyxqZT5MCAaVjCdK5_aQ>
X-ME-Sender: <xms:heApW99Lt01zu0hkAKAl-6kxBfVjlW1qDPMaTxTFJ9An6gmtoP5Vvg>
Received: from localhost (ppp118-211-207-6.bras1.syd2.internode.on.net [118.211.207.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35423E4270;
        Wed, 20 Jun 2018 01:05:08 -0400 (EDT)
Date:   Wed, 20 Jun 2018 15:05:05 +1000
From:   "Tobin C . Harding" <me@tobin.cc>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180620050505.GB11671@eros>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531144949.24995-2-tycho@tycho.ws>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:49:46AM -0600, Tycho Andersen wrote:
> This patch introduces a means for syscalls matched in seccomp to notify
> some other task that a particular filter has been triggered.
> 
> The motivation for this is primarily for use with containers. For example,
> if a container does an init_module(), we obviously don't want to load this
> untrusted code, which may be compiled for the wrong version of the kernel
> anyway. Instead, we could parse the module image, figure out which module
> the container is trying to load and load it on the host.
> 
> As another example, containers cannot mknod(), since this checks
> capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
> /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
> coding some whitelist in the kernel. Another example is mount(), which has
> many security restrictions for good reason, but configuration or runtime
> knowledge could potentially be used to relax these restrictions.
> 
> This patch adds functionality that is already possible via at least two
> other means that I know about, both of which involve ptrace(): first, one
> could ptrace attach, and then iterate through syscalls via PTRACE_SYSCALL.
> Unfortunately this is slow, so a faster version would be to install a
> filter that does SECCOMP_RET_TRACE, which triggers a PTRACE_EVENT_SECCOMP.
> Since ptrace allows only one tracer, if the container runtime is that
> tracer, users inside the container (or outside) trying to debug it will not
> be able to use ptrace, which is annoying. It also means that older
> distributions based on Upstart cannot boot inside containers using ptrace,
> since upstart itself uses ptrace to start services.
> 
> The actual implementation of this is fairly small, although getting the
> synchronization right was/is slightly complex.
> 
> Finally, it's worth noting that the classic seccomp TOCTOU of reading
> memory data from the task still applies here, but can be avoided with
> careful design of the userspace handler: if the userspace handler reads all
> of the task memory that is necessary before applying its security policy,
> the tracee's subsequent memory edits will not be read by the tracer.
> 
> v2: * make id a u64; the idea here being that it will never overflow,
>       because 64 is huge (one syscall every nanosecond => wrap every 584
>       years) (Andy)
>     * prevent nesting of user notifications: if someone is already attached
>       the tree in one place, nobody else can attach to the tree (Andy)
>     * notify the listener of signals the tracee receives as well (Andy)
>     * implement poll
> v3: * lockdep fix (Oleg)
>     * drop unnecessary WARN()s (Christian)
>     * rearrange error returns to be more rpetty (Christian)
>     * fix build in !CONFIG_SECCOMP_USER_NOTIFICATION case
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
>  arch/Kconfig                                  |   7 +
>  include/linux/seccomp.h                       |   3 +-
>  include/uapi/linux/seccomp.h                  |  18 +-
>  kernel/seccomp.c                              | 398 +++++++++++++++++-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 195 ++++++++-
>  5 files changed, 615 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 75dd23acf133..1c1ae8d8c8b9 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -401,6 +401,13 @@ config SECCOMP_FILTER
>  
>  	  See Documentation/prctl/seccomp_filter.txt for details.
>  
> +config SECCOMP_USER_NOTIFICATION
> +	bool "Enable the SECCOMP_RET_USER_NOTIF seccomp action"
> +	depends on SECCOMP_FILTER
> +	help
> +	  Enable SECCOMP_RET_USER_NOTIF, a return code which can be used by seccomp
> +	  programs to notify a userspace listener that a particular event happened.
> +
>  config HAVE_GCC_PLUGINS
>  	bool
>  	help
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index c723a5c4e3ff..0fd3e0676a1c 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -5,7 +5,8 @@
>  #include <uapi/linux/seccomp.h>
>  
>  #define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC | \
> -					 SECCOMP_FILTER_FLAG_LOG)
> +					 SECCOMP_FILTER_FLAG_LOG | \
> +					 SECCOMP_FILTER_FLAG_GET_LISTENER)
>  
>  #ifdef CONFIG_SECCOMP
>  
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 2a0bd9dd104d..8160e6cad528 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -17,8 +17,9 @@
>  #define SECCOMP_GET_ACTION_AVAIL	2
>  
>  /* Valid flags for SECCOMP_SET_MODE_FILTER */
> -#define SECCOMP_FILTER_FLAG_TSYNC	1
> -#define SECCOMP_FILTER_FLAG_LOG		2
> +#define SECCOMP_FILTER_FLAG_TSYNC		1
> +#define SECCOMP_FILTER_FLAG_LOG			2
> +#define SECCOMP_FILTER_FLAG_GET_LISTENER	4
>  
>  /*
>   * All BPF programs must return a 32-bit value.
> @@ -34,6 +35,7 @@
>  #define SECCOMP_RET_KILL	 SECCOMP_RET_KILL_THREAD
>  #define SECCOMP_RET_TRAP	 0x00030000U /* disallow and force a SIGSYS */
>  #define SECCOMP_RET_ERRNO	 0x00050000U /* returns an errno */
> +#define SECCOMP_RET_USER_NOTIF   0x7fc00000U /* notifies userspace */
>  #define SECCOMP_RET_TRACE	 0x7ff00000U /* pass to a tracer or disallow */
>  #define SECCOMP_RET_LOG		 0x7ffc0000U /* allow after logging */
>  #define SECCOMP_RET_ALLOW	 0x7fff0000U /* allow */
> @@ -59,4 +61,16 @@ struct seccomp_data {
>  	__u64 args[6];
>  };
>  
> +struct seccomp_notif {
> +	__u64 id;
> +	pid_t pid;
> +	struct seccomp_data data;
> +};
> +
> +struct seccomp_notif_resp {
> +	__u64 id;
> +	__s32 error;
> +	__s64 val;
> +};
> +
>  #endif /* _UAPI_LINUX_SECCOMP_H */
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index dc77548167ef..f69327d5f7c7 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -31,6 +31,7 @@
>  #endif
>  
>  #ifdef CONFIG_SECCOMP_FILTER
> +#include <linux/file.h>
>  #include <linux/filter.h>
>  #include <linux/pid.h>
>  #include <linux/ptrace.h>
> @@ -38,6 +39,52 @@
>  #include <linux/tracehook.h>
>  #include <linux/uaccess.h>
>  
> +#ifdef CONFIG_SECCOMP_USER_NOTIFICATION
> +#include <linux/anon_inodes.h>
> +
> +enum notify_state {
> +	SECCOMP_NOTIFY_INIT,
> +	SECCOMP_NOTIFY_SENT,
> +	SECCOMP_NOTIFY_REPLIED,
> +};
> +
> +struct seccomp_knotif {
> +	/* The pid whose filter triggered the notification */
> +	pid_t pid;
> +
> +	/*
> +	 * The "cookie" for this request; this is unique for this filter.
> +	 */
> +	u32 id;

Perhaps
	 /* The "cookie" for this request; this is unique for this filter. */


Epic patch review :)

thanks,
Tobin.
