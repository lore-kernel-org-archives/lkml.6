Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE9ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03716214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tGp1kLoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03716214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJTH1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:27:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42149 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJTH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:27:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id s10-v6so26377502lfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaCH+Gs7OTWnfEAKahrThZsJnsO3fMpAELLrusoGcF4=;
        b=tGp1kLoURb2UjvU2/YkAZqpv1sKFD+VnJY1lzg3wMf6pbqwVhJmOcq0Tqs6oYObP93
         qaq1EYdOCg3deyxhPwQRzyCYDu4Y4PZ+NcAh4FqhgJEdEidnj4kSCQs5OVkPh88G/EHf
         TV0nmh6l5yvhsTNSTmZu6K7V/xUx6CdtHYkmPSRoVIilVwg/kKJ13pW255ucxuQuaqjS
         fW+nuGYUkYgJeLHAa76lNF+m5zD8dY0yAV6rkTjc1yWAczwDe1ZujV8BQEMg+xhBfXHG
         amIxW0Q8Rnhhfp5Mwa5z3OSr7m+s5mzDvh9yc9unjKF15q8aSNduL84NlHPqKGKvP5RY
         6/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaCH+Gs7OTWnfEAKahrThZsJnsO3fMpAELLrusoGcF4=;
        b=rQlwWV+5Jb/XlzHO3id8rg65Sr2lwC2A3YumOS927L0ICo0ryhgAIHkUHtoVxHzAc+
         Aa+MsMFcN07JiXl2eC0kZvM58yusa0Uy6iKq67MkmA+pLe4UOp3dg3MF8VYTqFkFIZAP
         xEYHB7Q4KeWWY8k0WUbm54ySpaOzK9WJt/jcK+7V5zyGR/VHplU5D5G3hspM00rK4jRw
         uwMtS3lE63ag6nRbrH5815T7iP7YyuqXKZag5FxVzbQ2SoYREzdA4ymG0+D8X7fLO37h
         lbGszFrs/x9UGh9lhOIViysmMy4Rx2FmDjP0vFuBZg2TwXCzvYY8Q8zZ3R3F66b0dITG
         6I9Q==
X-Gm-Message-State: ABuFfojzG5a6VG4VkMw48mU6x4poUIBJHZUtCIrZOzbeSREBpJ4K59wS
        kO+pHwsel4fzqBfoMZmVbR7ht5BYouvToITve4IV
X-Google-Smtp-Source: ACcGV635EpjFAet5L3ah6tToXSdHTZDoe1XaOSOdS21eQ52BjUmyELB7OF/2IBz8odZWkE8Vn+AWuh38vae7Fd3kIl4=
X-Received: by 2002:a19:6719:: with SMTP id b25mr2265681lfc.38.1539991146339;
 Fri, 19 Oct 2018 16:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <3f5edfb0d530d7f0061fe11b817b315b350b9d86.1533065887.git.rgb@redhat.com>
In-Reply-To: <3f5edfb0d530d7f0061fe11b817b315b350b9d86.1533065887.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Oct 2018 19:18:54 -0400
Message-ID: <CAHC9VhT2GJH2cJsrCsxCZMLsdv67oXJhH9mHAgpfMRY4=y43WQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 09/10] audit: NETFILTER_PKT: record
 each container ID associated with a netNS
To:     rgb@redhat.com
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        luto@kernel.org, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add audit container identifier auxiliary record(s) to NETFILTER_PKT
> event standalone records.  Iterate through all potential audit container
> identifiers associated with a network namespace.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h    |  5 +++++
>  kernel/audit.c           | 26 ++++++++++++++++++++++++++
>  net/netfilter/xt_AUDIT.c | 12 ++++++++++--
>  3 files changed, 41 insertions(+), 2 deletions(-)

...

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 9a02095..8755f4d 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -169,6 +169,8 @@ extern int audit_log_contid(struct audit_context *context,
>  extern void audit_netns_contid_add(struct net *net, u64 contid);
>  extern void audit_netns_contid_del(struct net *net, u64 contid);
>  extern void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p);
> +extern void audit_log_netns_contid_list(struct net *net,
> +                                struct audit_context *context);
>
>  extern int                 audit_update_lsm_rules(void);
>
> @@ -228,6 +230,9 @@ static inline void audit_netns_contid_del(struct net *net, u64 contid)
>  { }
>  static inline void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
>  { }
> +static inline void audit_log_netns_contid_list(struct net *net,
> +                                       struct audit_context *context)
> +{ }
>
>  #define audit_enabled AUDIT_OFF
>  #endif /* CONFIG_AUDIT */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index c5fed3b..b23711c 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -392,6 +392,32 @@ void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
>                 audit_netns_contid_add(new->net_ns, contid);
>  }
>
> +void audit_log_netns_contid_list(struct net *net, struct audit_context *context)
> +{
> +       spinlock_t *lock = audit_get_netns_contid_list_lock(net);
> +       struct audit_buffer *ab;
> +       struct audit_contid *cont;
> +       bool first = true;
> +
> +       /* Generate AUDIT_CONTAINER record with container ID CSV list */
> +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_CONTAINER);
> +       if (!ab) {
> +               audit_log_lost("out of memory in audit_log_netns_contid_list");
> +               return;
> +       }
> +       audit_log_format(ab, "contid=");
> +       spin_lock(lock);
> +       list_for_each_entry(cont, audit_get_netns_contid_list(net), list) {
> +               if (!first)
> +                       audit_log_format(ab, ",");
> +               audit_log_format(ab, "%llu", cont->id);
> +               first = false;
> +       }
> +       spin_unlock(lock);

This is looking like potentially a lot of work to be doing under a
spinlock, not to mention a single spinlock that is shared across CPUs.
Considering that I expect changes to the list to be somewhat
infrequent, this might be a good candidate for a RCU based locking
scheme.

> +       audit_log_end(ab);
> +}
> +EXPORT_SYMBOL(audit_log_netns_contid_list);
>
>  void audit_panic(const char *message)
>  {
>         switch (audit_failure) {
> diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> index af883f1..44fac3f 100644
> --- a/net/netfilter/xt_AUDIT.c
> +++ b/net/netfilter/xt_AUDIT.c
> @@ -71,10 +71,13 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
>  {
>         struct audit_buffer *ab;
>         int fam = -1;
> +       struct audit_context *context;
> +       struct net *net;
>
>         if (audit_enabled == AUDIT_OFF)
> -               goto errout;
> -       ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
> +               goto out;
> +       context = audit_alloc_local(GFP_ATOMIC);
> +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
>         if (ab == NULL)
>                 goto errout;
>
> @@ -104,7 +107,12 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
>
>         audit_log_end(ab);
>
> +       net = xt_net(par);
> +       audit_log_netns_contid_list(net, context);
> +
>  errout:
> +       audit_free_context(context);
> +out:
>         return XT_CONTINUE;
>  }
>

--
paul moore
www.paul-moore.com
