Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2121535-1517567269-2-12592317229205648792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517567266; b=u55TtCLKWjCRjFZArxclawqLTnFgRJdd2Cd6pb8tlRaxnQu
    EoK2JiD/qYKvga+q6yCq7HtGU3xIOKdKcWHKNdvFmZ4zjzlOd/VyA6hrlOksDzEb
    bc8zfH+qSso/EeYwsfN7FnpSyu/zYjSkPw1XubRA/IZi21/7kZHzp+ywwm4hOVto
    XyofVYB4QSxYYakTmyXXfwBDNjjq62m6f6uCoj6Ims3Gkd8VM05ys44lpFmvhpbb
    oe2WRtVc++MAILhEVkkXp/SBWhoisdOLNUWexg9vxHqMkmQM3pDzyrATZyq4CQ7Y
    4y5yDEQaD8BpbOtJfQeIustLJ3cmKSabJxhqtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517567266; bh=vMnHsR7vcw+Tw00Ih0oBTOh33G
    /cY1VedyTIwBCtFb4=; b=loWMzUYWLln2AZE5r2aBs+2NTJLpsVxWZL0u9Tdthr
    RIPMRAMvLoLrBkPFiGudQYx9EKhNVzRtLn4tOxdszJrSyvDoApMsSAU7ZV/gNpGo
    OQePVyZroF7esUFJz7W99GnlWHM923+Lv1wN4IvwJCHN3qsMl0j0l0DJRYxUzqQs
    SwnFM2zEYQMFDMNYJYjzs9IYA6M0xcE4B10aPzT1pN4OiS8gwFhJ8Jg1z1xbesE+
    1Eu8P9qS6LeajXHx5b5uiC4kYVbKxZkgQdq8fg0y6uzv/nteDCHV+hwQ0ncXdTfv
    umTk40ZK9ms8QWjmL7vaCMS6Ewkv77SW5MM8YwqzwOEw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBBK12 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 05:27:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBBK1Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 05:27:25 -0500
Date: Fri, 2 Feb 2018 11:27:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org,
        Paul Moore <paul@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        stable <stable@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
Message-ID: <20180202102721.GB22855@kroah.com>
References: <20180201153708.63506-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201153708.63506-1-salyzyn@android.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 07:37:04AM -0800, Mark Salyzyn wrote:
> In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
> flag") and all the associated infrastructure changes to take advantage
> of a RCU grace period before freeing, there is a heightened
> possibility that a security check is performed while an ill-timed
> setsockopt call races in from user space.  It then is prudent to null
> check sk_security, and if the case, reject the permissions.
> 
> Because of the nature of this problem, hard to duplicate, no clear
> path, this patch is a simplified band-aid for stable trees lacking the
> infrastructure for the series of commits leading up to providing a
> suitable RCU grace period.  This adjustment is orthogonal to
> infrastructure improvements that may nullify the needed check, but
> could be added as good code hygiene in all trees.
> 
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 14233 Comm: syz-executor2 Not tainted 4.4.112-g5f6325b #28
> task: ffff8801d1095f00 task.stack: ffff8800b5950000
> RIP: 0010:[<ffffffff81b69b7e>]  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
> RSP: 0018:ffff8800b5957ce0  EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 1ffff10016b2af9f RCX: ffffffff81b69b51
> RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000010
> RBP: ffff8800b5957de0 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000000 R11: 1ffff10016b2af68 R12: ffff8800b5957db8
> R13: 0000000000000000 R14: ffff8800b7259f40 R15: 00000000000000d7
> FS:  00007f72f5ae2700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000a2fa38 CR3: 00000001d7980000 CR4: 0000000000160670
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Stack:
>  ffffffff81b69a1f ffff8800b5957d58 00008000b5957d30 0000000041b58ab3
>  ffffffff83fc82f2 ffffffff81b69980 0000000000000246 ffff8801d1096770
>  ffff8801d3165668 ffffffff8157844b ffff8801d1095f00
>  ffff880000000001
> Call Trace:
> [<ffffffff81b6a19d>] selinux_socket_setsockopt+0x4d/0x80 security/selinux/hooks.c:4338
> [<ffffffff81b4873d>] security_socket_setsockopt+0x7d/0xb0 security/security.c:1257
> [<ffffffff82df1ac8>] SYSC_setsockopt net/socket.c:1757 [inline]
> [<ffffffff82df1ac8>] SyS_setsockopt+0xe8/0x250 net/socket.c:1746
> [<ffffffff83776499>] entry_SYSCALL_64_fastpath+0x16/0x92
> Code: c2 42 9b b6 81 be 01 00 00 00 48 c7 c7 a0 cb 2b 84 e8
> f7 2f 6d ff 49 8d 7d 10 48 b8 00 00 00 00 00 fc ff df 48 89
> fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 83 01 00
> 00 41 8b 75 10 31
> RIP  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
> RSP <ffff8800b5957ce0>
> ---[ end trace 7b5aaf788fef6174 ]---
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Signed-off-by: Paul Moore <paul@linuxfoundation.org>
> Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: selinux@tycho.nsa.gov
> Cc: linux-security-module@vger.kernel.org
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: stable <stable@vger.kernel.org> # 3.18, 4.4
> Cc: linux-kernel@vger.kernel.org
> ---
> v2: return -EFAULT for null sk_security instead of 0

Now queued up, thanks.

greg k-h
