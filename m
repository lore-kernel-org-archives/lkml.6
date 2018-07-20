Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEBDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E49F20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pKemrYz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E49F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGTXF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:05:28 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:40990 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbeGTXF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:05:27 -0400
Received: by mail-lf1-f49.google.com with SMTP id v22-v6so2748605lfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MLZBzpWrUrYNKrZxF7gMNyThX+hu0dJmTCDQioJR8I=;
        b=pKemrYz/UPzeh0AkRybI5i0VYI8+wB1JDOo5REeYEJ4nPXLDVJXa5U3b6oeyJkaFi/
         uPQFMK7VY/fAdD7xd4kkhNSdYxN5+MiPIHUAtNzrtIPD5GglgjzEFQbxvbdY6Oq24DJC
         fYGOuGiujm7U7FC5wd1F3JBj67ro5+WHtKUmPZrDmEs+BFutz87CoB4ODUeV2FZUH6A9
         0wSSBg98vVMNJJUCgcPFNpDLLVY23VG8JZcmX3pvMw5bIZutxmAVGwCbialpuXzinaBJ
         cCIDilhZwmvJ2VG3Ir+A3yNU/H0AFcQ5b5vrZExl38ek0480+rQHVutlJdLdwpggazGM
         yv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MLZBzpWrUrYNKrZxF7gMNyThX+hu0dJmTCDQioJR8I=;
        b=UTE7hkY9UyegUoHe8gLlRZvgPsFahpE7p9AZlsr9xe6zCa7IWi4TXh5808QzGzKfcR
         MyJ9Q+DxjIhLZ6rcM3wNHsdd+nm8jkbDgAMIE98tfN43hozUH43zHGKtnSWAkp6obX5r
         R/eCYu3BW2L4vQFAH4xYXn8v49Ho+JEgdFD7RgVMhLN9/yoJJCTR0lG08QTmCFEVGk5S
         GLWI4D1e6ZJOTCysp0i33GLql52oLbtaURAypTAFRUX3SVvaIEuVUroXD/DJDkn3jEqN
         kF2zjJVamMg1BV/416BEKQoFdx6QRMU4qZ1lZK3uL6xwZZqOOnNgK+HXg4AFifD5HEBC
         vnUg==
X-Gm-Message-State: AOUpUlFTqspJ6ka9DeUSJNSzdcEA00u1wxHBBlUJNWNa6iaZ8ytYBSj6
        fc6L6Gfn6DU0NykDNUghs/DkPBu1KzJRX4erMVT9
X-Google-Smtp-Source: AAOMgpdgX8IFSiKx6DZoxDbf7HURUMc0UWhb9VyQqQV8gGPiDzPynSIGG7Zv9VAG+eLRn0ZNcQvtVKx4L1BH0tjKHz8=
X-Received: by 2002:a19:c403:: with SMTP id u3-v6mr2274290lff.87.1532124912009;
 Fri, 20 Jul 2018 15:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <c6b64f6540e2e531636142ced36d51f0744d0e1f.1528304204.git.rgb@redhat.com>
In-Reply-To: <c6b64f6540e2e531636142ced36d51f0744d0e1f.1528304204.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jul 2018 18:15:00 -0400
Message-ID: <CAHC9VhQCxdOzcYHFtJ8eTLkNQxwvdAnuLOEguqHT_zU4V9d0OA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 08/10] audit: NETFILTER_PKT:
 record each container ID associated with a netNS
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 1:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
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

...

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

See my comment in previous patches about changing the function name to
better indicate it's dedicate use for network namespaces.

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

Hmm.  It looks like this will generate multiple audit container ID
records with "op=netX contid=Y" (X=netns number, Y=audit container
ID), is that what we want?  I've mentioned my concern around the "op"
values in these records earlier in the patchset, that still applies
here, but now I'm also concerned about the multiple records.  I'm
thinking we might be better served with a single record with either
multiple "contid" fields, or a single "contid" field with a set of
comma separated values (or some other delimiter that Steve's tools
will tolerate).

Steve, thoughts?

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

See my previous comments in the earlier patches about guessing at
gfpflags; let's just add a gfpflags parameter to audit_log_contid().

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

Move the EXPORT_SYMBOL() to earlier in the patchset when you first
define audit_log_contid().

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6ab5e5e..e2a16d2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1015,6 +1015,7 @@ struct audit_context *audit_alloc_local(void)
>         context->in_syscall = 1;
>         return context;
>  }
> +EXPORT_SYMBOL(audit_alloc_local);

Same as above.

>  void audit_free_context(struct audit_context *context)
>  {
> @@ -1029,6 +1030,7 @@ void audit_free_context(struct audit_context *context)
>         audit_proctitle_free(context);
>         kfree(context);
>  }
> +EXPORT_SYMBOL(audit_free_context);

Same.

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
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit



--
paul moore
www.paul-moore.com
