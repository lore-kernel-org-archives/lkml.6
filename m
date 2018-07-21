Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBBD2064D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDx4X6pm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBBD2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeGUQZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:25:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37923 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeGUQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:25:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id a4-v6so3693215lff.5;
        Sat, 21 Jul 2018 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D/qi9nYLoA6b0ixx0gNjfIAle99KNw7vIPqMVhX55yU=;
        b=SDx4X6pmx9RYO/2BR4UP81k7M5PraHmh8tLd2eIqcL9LB3u6dEKpfOHJHF3Fn0Ln55
         Klpp2ZjMT3h9U5cwptsUpNBQTv71u/gNSz94rz1ocoGdBM4Q+pFIH59Gy3DhjeE7c780
         903gpfo9RTruqUM8wa8qRA0r/MjGUWNW2BMGBVwrbygKUQVhjGrshkhilo72vg515EHP
         gp1+fN1knRi4UdBdTewsnjGBLB8UAODnOXWxf/8aeq7ZMzwDq32zavnxMp0DDCE/Tfcc
         XTOE8zU5cx62GS3Fp2B8RGDYORxW0m0qwonacZJr+ut7i1y+c/csTRcD7Paw7dksc/YU
         E79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D/qi9nYLoA6b0ixx0gNjfIAle99KNw7vIPqMVhX55yU=;
        b=uDtvIEyevW6ULjwTZtMztolTThLW8+H1NXmfyLiIVN77p0pTyo1EJoaf4pVJT4Ehnk
         Z8JBqgyC2dPhpKEGCjuiehcUCU3ZIlFo6QaNO1EM9+C26s1xkMHzoPWt4z8eurgDKKly
         rss0GPfwLF3DEi7nJtNt30YgT7q1mYtrAY64+DNR+jUm8nMgbrufQZG75oUKFZeH8fbK
         DH+DKU4Q8y1SssDPsI50Axi++K6+LWDOvh/pXzfpjniw5pqaxSSl9gaBxJPxwa4U/JZo
         hWYlj/hwEICctfyDEWJm8qJCmU2fPsKQe7U9S6cokJ6wq2Qr1OlEvSftMyYdIMrCbFYF
         D79w==
X-Gm-Message-State: AOUpUlHc2hNihAWNuzwWbTqfo3JW79Qefo4gzmimJakLdl19NG6WyPtv
        mnoGH2N/qJ1lQS7d3vZhoNunQqsvdxdeSPNzwE8=
X-Google-Smtp-Source: AAOMgpdX8JtfudY0Kapwy17VPHuMIyy6KXGVn+hd/CKpivsVp5V0SrM3tOXZ65iOYCkPRa63Z6gTIO/T9X0W/1SVKLU=
X-Received: by 2002:a19:169f:: with SMTP id 31-v6mr3624041lfw.72.1532187159436;
 Sat, 21 Jul 2018 08:32:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:68c:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 08:32:38 -0700 (PDT)
In-Reply-To: <c6b64f6540e2e531636142ced36d51f0744d0e1f.1528304204.git.rgb@redhat.com>
References: <cover.1528304203.git.rgb@redhat.com> <c6b64f6540e2e531636142ced36d51f0744d0e1f.1528304204.git.rgb@redhat.com>
From:   Laura Garcia <nevola@gmail.com>
Date:   Sat, 21 Jul 2018 17:32:38 +0200
Message-ID: <CAF90-WhFVGKK7pxzRXnA=DGDzp-OZMWvoxfH0c+nm6+-Ao9Jag@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 08/10] audit: NETFILTER_PKT:
 record each container ID associated with a netNS
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, eparis@parisplace.org, serge@hallyn.com,
        ebiederm@xmission.com,
        Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing Netfilter.

On Wed, Jun 6, 2018 at 6:58 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Add audit container identifier auxiliary record(s) to NETFILTER_PKT
> event standalone records.  Iterate through all potential audit container
> identifiers associated with a network namespace.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h    |  5 +++++
>  kernel/audit.c           | 20 +++++++++++++++++++-
>  kernel/auditsc.c         |  2 ++
>  net/netfilter/xt_AUDIT.c | 12 ++++++++++--
>  4 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 7e2e51c..4560a4e 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -167,6 +167,8 @@ extern int audit_log_contid(struct audit_context *context,
>  extern void audit_contid_add(struct net *net, u64 contid);
>  extern void audit_contid_del(struct net *net, u64 contid);
>  extern void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p);
> +extern void audit_log_contid_list(struct net *net,
> +                                struct audit_context *context);
>
>  extern int                 audit_update_lsm_rules(void);
>
> @@ -231,6 +233,9 @@ static inline void audit_contid_del(struct net *net, u64 contid)
>  { }
>  static inline void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
>  { }
> +static inline void audit_log_contid_list(struct net *net,
> +                                       struct audit_context *context)
> +{ }
>
>  #define audit_enabled 0
>  #endif /* CONFIG_AUDIT */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index ecd2de4..8cca41a 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -382,6 +382,20 @@ void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
>                 audit_contid_add(new->net_ns, contid);
>  }
>
> +void audit_log_contid_list(struct net *net, struct audit_context *context)
> +{
> +       struct audit_contid *cont;
> +       int i = 0;
> +
> +       list_for_each_entry(cont, audit_get_contid_list(net), list) {
> +               char buf[14];
> +
> +               sprintf(buf, "net%u", i++);
> +               audit_log_contid(context, buf, cont->id);
> +       }
> +}
> +EXPORT_SYMBOL(audit_log_contid_list);
> +
>  void audit_panic(const char *message)
>  {
>         switch (audit_failure) {
> @@ -2132,17 +2146,21 @@ int audit_log_contid(struct audit_context *context,
>                               char *op, u64 contid)
>  {
>         struct audit_buffer *ab;
> +       gfp_t gfpflags;
>
>         if (!cid_valid(contid))
>                 return 0;
> +       /* We can be called in atomic context via audit_tg() */
> +       gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
>         /* Generate AUDIT_CONTAINER record with container ID */
> -       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER);
> +       ab = audit_log_start(context, gfpflags, AUDIT_CONTAINER);
>         if (!ab)
>                 return -ENOMEM;
>         audit_log_format(ab, "op=%s contid=%llu", op, contid);
>         audit_log_end(ab);
>         return 0;
>  }
> +EXPORT_SYMBOL(audit_log_contid);
>
>  void audit_log_key(struct audit_buffer *ab, char *key)
>  {
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6ab5e5e..e2a16d2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1015,6 +1015,7 @@ struct audit_context *audit_alloc_local(void)
>         context->in_syscall = 1;
>         return context;
>  }
> +EXPORT_SYMBOL(audit_alloc_local);
>
>  void audit_free_context(struct audit_context *context)
>  {
> @@ -1029,6 +1030,7 @@ void audit_free_context(struct audit_context *context)
>         audit_proctitle_free(context);
>         kfree(context);
>  }
> +EXPORT_SYMBOL(audit_free_context);
>
>  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>                                  kuid_t auid, kuid_t uid, unsigned int sessionid,
> diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> index f368ee6..10d2707 100644
> --- a/net/netfilter/xt_AUDIT.c
> +++ b/net/netfilter/xt_AUDIT.c
> @@ -71,10 +71,13 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
>  {
>         struct audit_buffer *ab;
>         int fam = -1;
> +       struct audit_context *context;
> +       struct net *net;
>
>         if (audit_enabled == 0)
> -               goto errout;
> -       ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
> +               goto out;
> +       context = audit_alloc_local();
> +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
>         if (ab == NULL)
>                 goto errout;
>
> @@ -104,7 +107,12 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
>
>         audit_log_end(ab);
>
> +       net = xt_net(par);
> +       audit_log_contid_list(net, context);
> +
>  errout:
> +       audit_free_context(context);
> +out:
>         return XT_CONTINUE;
>  }
>
> --
> 1.8.3.1
>
