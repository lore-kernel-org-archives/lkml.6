Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1694581-1524101552-2-629679632698455477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524101552; b=j9DiYA58+DY2ATfu9azk1UYjzJCuL+Wl2jrqqQ29r+sCGzB+5Z
    eilE1MdYJxAfRiTlcacxs6XcurR0xvopnS1TiQpYF8+f+/HUXf58jovcLr54Lyix
    XTeG1LsDBHLMPS6rM+yXBAKiCKdAsNf9bycrWaaT8j3MnnvfudMipkuSFqPxSeGN
    WVUaV6rSjdcEbUO7cIlKhYjKH8yy+j7i/bsclIyf3zPTL8r4QFlRgXd/j8nXMM8X
    S7dokEh6rJi0RPP7eUJ1cX6/Dramk5SbxlHZYat2D5NAnMw+Xfk3rYKM2p2IIPWl
    lwHiAl7kmC36GR9DWU354J+ACpk+UChK/PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524101552; bh=iqpGladUlQM9GbMWRmEhmU9oedSwE3hwRJqWenxq+5
    E=; b=jSgBSGkD3HU8kJaD5kcIwJpKAfDgQLslOQZMIaa9xSir12d/cqaQ5vZ/Bu
    6B3XKDhSD8taTI8xpQfDoIcZE/UJcrnyxujdSQaU5VZ9Se6TEDM0Kd5B/v0zlqhB
    xaO0Zr4d1MccTcrXjpBiG4DE1A+wziJuZEY9nkE450Q/U4iZYpljKyFJL5uIY9pS
    XcSnWBD0Kbs4wNNh33B0nzO545sUXeS+fbfBwRxzF6uA2YZ6axxp/q4WPJ54DNzp
    d1WQuRD80gl/8NE6M+pLnd9dTi4zE0n7rAB8OVCP+iZ6QD/S/6TNt7IFJU85Sr/P
    utFPW2wiGiIghO6quz0HGZOSEQvQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=RWILuyGj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mBAPXnOK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=RWILuyGj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mBAPXnOK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnE8ZRzGWNnLuN26v3F4Uc8+N0ndyE2une5Yr1sn6wC3GwTJ/ylatnd0c/+KdqseV6EBTwcBpJ8uxWBGse54VDIUY73wJtNJ5BbQZBy1XPaFzfngV/0
    fI4R1w1Oxps+MZzJ/SJzXsJykcASDuva62fxnfBVoBSkH8+uQLadOL8xM6tzdLC9g4Sxdl5Y2/awDCyCgh7E4X+pchefEdRyL9KeieP/l54t+6iQLgxDkp4K
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=JRKRCPwSBRs8gsjyjp0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDSBb4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 21:31:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41369 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeDSBbx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 21:31:53 -0400
X-Google-Smtp-Source: AIpwx49rDGyMSQtV5/9WBxtUjzXb0Lp0SKRF2Gv9H0BL+ASLrIkTOohTXnGqwDpCQfXDRAp6zGx1/TfxiyF09qimaj0=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <11174597083f89352f1d6491ec94e27f882625d9.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <11174597083f89352f1d6491ec94e27f882625d9.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 21:31:50 -0400
Message-ID: <CAHC9VhS6MKoLkzpfcmYBSNnvrtbL2FOF5PX9uOfivSVEWykkQg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 10/13] audit: add containerid support for
 seccomp and anom_abend records
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Add container ID auxiliary records to secure computing and abnormal end
> standalone records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 7103d23..2f02ed9 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2571,6 +2571,7 @@ static void audit_log_task(struct audit_buffer *ab)
>  void audit_core_dumps(long signr)
>  {
>         struct audit_buffer *ab;
> +       struct audit_context *context = audit_alloc_local();

Looking quickly at do_coredump() I *believe* we can use current here.

>         if (!audit_enabled)
>                 return;
> @@ -2578,19 +2579,22 @@ void audit_core_dumps(long signr)
>         if (signr == SIGQUIT)   /* don't care for those */
>                 return;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_ANOM_ABEND);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_ANOM_ABEND);
>         if (unlikely(!ab))
>                 return;
>         audit_log_task(ab);
>         audit_log_format(ab, " sig=%ld res=1", signr);
>         audit_log_end(ab);
> +       audit_log_container_info(context, "abend", audit_get_containerid(current));
> +       audit_free_context(context);
>  }
>
>  void __audit_seccomp(unsigned long syscall, long signr, int code)
>  {
>         struct audit_buffer *ab;
> +       struct audit_context *context = audit_alloc_local();

We can definitely use current here.

> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_SECCOMP);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_SECCOMP);
>         if (unlikely(!ab))
>                 return;
>         audit_log_task(ab);
> @@ -2598,6 +2602,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
>                          signr, syscall_get_arch(), syscall,
>                          in_compat_syscall(), KSTK_EIP(current), code);
>         audit_log_end(ab);
> +       audit_log_container_info(context, "seccomp", audit_get_containerid(current));
> +       audit_free_context(context);
>  }
>
>  struct list_head *audit_killed_trees(void)

-- 
paul moore
www.paul-moore.com
