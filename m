Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-117643-1520984714-2-1194486207961823459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520984714; b=F68CzKnbpzbekJd437n3KSJcodWDSZqgcdvss5rGnOVrIOw
    QPa4uw3nFoexJb04q/aSD+sne/vqA78RT2nO+7KwD56svRnRe2TGJgynmP0AYb2b
    px1fL8hvMcdBNmFdAgkKGtMmSpuplX5h8+9DHLgEPXaqXXlTLhSxS7vWCwyT+ZJe
    v0OlAHARy7E87eLYD+CJSEBTFNNEOwWE7NgBrDHlk4hIbVfbD+plDGYauvjcu6fG
    rbG1cnnVu0yjFtGgpDA0qWi3tqfSO4Kb9vn4H230rGBMmV+Ejli6sDg9f+u1foGL
    vg4ddOVPej6+7FGZQRH+zbQReDDhOJ+3t9SIC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520984714; bh=z1zTsrXz7lEteyrMAV2AXJir1e
    9Ve/741ZTQtG2a5qI=; b=Q0iXFDh97d/9SJPQi33NykDXCtkmYbFZVuQ4U5myBC
    Q1hHdycyiBBL0S9TXzkLr6neuCam4Fprg0oMXiSzXt6v2j6XUFC47gJJ8eV+/u+3
    V5TgPHJE6QLLTE5sXxnuW2VjBmjUOUHV9NFA7iRfTQVMJAt8+uRdKgTWb9pAK5td
    c3jH7xq5qea6oWvMqil5qD9ibxrvjWzgxDBFANtqvUoTmjQ93gAbkdyBx3p0w1YF
    YwM0i2oklHsumKtQ+5uF+jXDbIYu9MUXQxgha2AlkUCdEyZb7hqdYeeDhSLL5H3H
    PhjLvTjzdhMQVUyT2xWNxAHgehAqGDJtsm2MuY5poraA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b=E3lTkc3N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=osandov.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RiGYWXSH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osandov.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b=E3lTkc3N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=osandov.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RiGYWXSH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osandov.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeCMXpM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:45:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37058 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeCMXpL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 19:45:11 -0400
X-Google-Smtp-Source: AG47ELu1XrxZoHCJRSOcaLMECfBNHEqVb94XjRM89CPbkrT7L+vDKCrXA4tzm9Qi5jYabJ2V6k/b/Q==
Date: Tue, 13 Mar 2018 16:45:09 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Howard McLauchlan <hmclauchlan@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>, kernel-team@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
Message-ID: <20180313234509.GA4981@vader>
References: <20180313231627.1247-1-hmclauchlan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313231627.1247-1-hmclauchlan@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:16:27PM -0700, Howard McLauchlan wrote:
> Error injection is a useful mechanism to fail arbitrary kernel
> functions. However, it is often hard to guarantee an error propagates
> appropriately to user space programs. By injecting into syscalls, we can
> return arbitrary values to user space directly; this increases
> flexibility and robustness in testing, allowing us to test user space
> error paths effectively.
> 
> The following script, for example, fails calls to sys_open() from a
> given pid:
> 
> from bcc import BPF
> from sys import argv
> 
> pid = argv[1]
> 
> prog = r"""
> 
> int kprobe__SyS_open(struct pt_regs *ctx, const char *pathname, int flags)
> {
>     u32 pid = bpf_get_current_pid_tgid();
>     if (pid == %s)
>         bpf_override_return(ctx, -ENOENT);
>     return 0;
> }
> """ % pid
> 
> b = BPF(text = prog)
> while 1:
>     b.perf_buffer_poll()
> 
> This patch whitelists all syscalls defined with SYSCALL_DEFINE for error
> injection.
> 
> Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
> ---
> based on 4.16-rc5
>  include/linux/syscalls.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a78186d826d7..e8c6d63ace78 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>  
>  #define SYSCALL_DEFINE0(sname)					\
>  	SYSCALL_METADATA(_##sname, 0);				\
> +	asmlinkage long sys_##sname(void);			\
> +	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
>  	asmlinkage long sys_##sname(void)
>  
>  #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
> @@ -210,6 +212,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>  #define __SYSCALL_DEFINEx(x, name, ...)					\
>  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>  		__attribute__((alias(__stringify(SyS##name))));		\
> +	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
>  	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
>  	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
>  	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
> -- 
> 2.14.1
> 

Adding a few more people to Cc
