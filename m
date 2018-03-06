Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-156712-1520334372-2-17338111854213585178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520334371; b=qvUYFaHclxkWeelMj7bLgch/swG31r+vA8Ou61BevnBJ66I
    r2ZKP3naTIbkVbtyB57UvoFB9wBvvDdOVjF/BTFLYNeiu6OkZSjX/7CZgWLKKkdl
    tLrnQn+QYN7pFUgqFZ6wkRnsYyXXpV4gOqdECDFG9tXzxzbYKycChTUIZ3TbS+br
    wK+LbMd4FHljZJvPkVYidy8pS/HgEtaWYmBTG7WcUe1bLKZFab+FDnbb62bKZxhS
    jZWnzAzF8Kp7gK0BWObj274VtXQwbT0YqH23EZ0QFwNWA/+LA/d8SN5D5wi4Up69
    yqPTQyJTQ8YDDIw0SzZJUqCAmXzZODwie2GDL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520334371; bh=5dO5gBZeeceNaUjklCuGwsWcLD
    EzFApimZimxBVqvac=; b=FzJOC8uS74kRoSvaFpHlJOugsrguFYooxyO8Kq7Ovu
    cS5GLZM7klIQ9+7cCsIxO5pJmNsDEHwjOguHp2aDI5URDR1UDyGcNyLtna32gjtz
    zg0G/ywRPgAuvsp2SOqhKL/GuRobvOE3aF4d6+rEZ4B7SYEOherY8E5JZuh2roWX
    OhWQoAHiyk2hc7ADLcPqYmO6TXiAxXY3MdGvp+ItDohnFSfvpTDwMvOxf190RQAx
    0v3Eq6CD56A5LUBHb1lJOigZh9nQqF+VJQLV3lHVi5Yu0fn9bEzI0TOBgNsjyFfa
    iA7qNdQQ1fJSNkMuEej3rq7K0E2j7JFQsPgbQat8OvnA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbeCFLFt (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 06:05:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbeCFLFr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 06:05:47 -0500
Date: Tue, 6 Mar 2018 03:05:49 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: davem@davemloft.net, daniel@iogearbox.net,
        torvalds@linux-foundation.org, mcgrof@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180306110549.GB31087@kroah.com>
References: <20180306013457.1955486-1-ast@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306013457.1955486-1-ast@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 05:34:57PM -0800, Alexei Starovoitov wrote:
> As the first step in development of bpfilter project [1] the request_module()
> code is extended to allow user mode helpers to be invoked. Idea is that
> user mode helpers are built as part of the kernel build and installed as
> traditional kernel modules with .ko file extension into distro specified
> location, such that from a distribution point of view, they are no different
> than regular kernel modules. Thus, allow request_module() logic to load such
> user mode helper (umh) modules via:
> 
>   request_module("foo") ->
>     call_umh("modprobe foo") ->
>       sys_finit_module(FD of /lib/modules/.../foo.ko) ->
>         call_umh(struct file)
> 
> Such approach enables kernel to delegate functionality traditionally done
> by kernel modules into user space processes (either root or !root) and
> reduces security attack surface of such new code, meaning in case of
> potential bugs only the umh would crash but not the kernel. Another
> advantage coming with that would be that bpfilter.ko can be debugged and
> tested out of user space as well (e.g. opening the possibility to run
> all clang sanitizers, fuzzers or test suites for checking translation).
> Also, such architecture makes the kernel/user boundary very precise:
> control plane is done by the user space while data plane stays in the kernel.
> 
> It's easy to distinguish "umh module" from traditional kernel module:
> 
> $ readelf -h bld/net/bpfilter/bpfilter.ko|grep Type
>   Type:                              EXEC (Executable file)
> $ readelf -h bld/net/ipv4/netfilter/iptable_filter.ko |grep Type
>   Type:                              REL (Relocatable file)

Any chance you can add a field to your "umh module" type such that a
normal 'modinfo' program will be able to notice it is different easily?

> Since umh can crash, can be oom-ed by the kernel, killed by admin,
> the subsystem that uses them (like bpfilter) need to manage life
> time of umh on its own, so module infra doesn't do any accounting
> of them. They don't appear in "lsmod" and cannot be "rmmod".
> Multiple request_module("umh") will load multiple umh.ko processes.
> 
> Similar to kernel modules the kernel will be tainted if "umh module"
> has invalid signature.

Shouldn't we fail to load the "module" if the signature is not valid if
CONFIG_MODULE_SIG_FORCE=y is enabled, like we do for modules?  I run my
systems like that, and just "warning" isn't probably a good idea for
systems that want to enforce that everything is signed properly?

Other than that, one minor question:

> @@ -1745,7 +1745,9 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	sched_exec();
>  
>  	bprm->file = file;
> -	if (fd == AT_FDCWD || filename->name[0] == '/') {
> +	if (!filename) {
> +		bprm->filename = "/dev/null";

Why the use of "/dev/null" for the filename here, and elsewhere in the
code?  While I'm "sure" that everyone really does have /dev/null/
mounted in the root namespace, what is the use of it here?

Also, what "namespace" does this usermode helper run in?  I'm guessing
the "root" one, which is fine with me, but note that people have
complained in the past about other UMH running in that namespace and not
in the specific namespace of the "container" that they wanted it to run
in.

Anyway, this is crazy stuff, but I like the idea and have no objection
to it overall :)

thanks,

greg k-h
