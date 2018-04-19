Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625563-1524098589-2-13003501796693454101
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
    1524098588; b=XvnicqcJjuzDy+DuBjVkN/MtAgZwJyxsdTYF4jTNc69/qcRVR1
    c4H4wZc9jTPoA57vv8H4ELu5c+vzM78Rt3SbUtrDQ72Uf2k4MTuOQbUCbxnaZP08
    JrB8cMTO9ET0luJOYxzgJNmdpnUL/GnuPW6yOTUBl+vqqLHmtx4F7+LMjfs1S5Sf
    Mi2B6DxE/pK46jWWntGNG0X4ftt4vNI/VuY/xyNFr/KO75Ai9ON5oaFPTO7xKC4W
    XTUiDr4x2DqMVHfCysGcx6Bv2+4uazaSbBO7G0bEgukEcAXKoTGLdLuPBuuwTiGr
    mFHComjrMOD8V9wc1/8Vfe0nKjFGMMNCekZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524098588; bh=CPbu/Hl8EQcfIrQj2BH4I+XxYmGp+LGG4zPUIFbFu8
    k=; b=h5bDFG8X3E7IidI8LMYV8Kd0zh/UiC/SqUM2gU1D7bS2kmRQAaVcqcByRO
    BK1+N+SJgXSTPnP5lgWGHRJJjzvs9f3hcjGXULnmPXQmVEsScAag2tLmhKm2VCqI
    artY7BrfkIbqcyoIcqlWPL5c78ahzPxDZEmMXDtBy9yer4BtX+zH7AW48Mrf4C3G
    wdCtAMmmhSVj/SIY6Z0BjfDLA4mX6FNFNFRJDaSYPlyEGQHZVnm7Kc76anRe1U7Z
    bhD1xL7Sv3urR7d7wAi+4VLp+XY2h5JXnH05MpeJxwMRYmTmKvAkJKDJp2qJK04/
    PsjGML2MWPFkBijSq87+V00PZSzQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=Jfo2FwDH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fjW0T4MI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=Jfo2FwDH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fjW0T4MI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMCq941N1m64uuVqExoCOBMT3g8N6J0W7pUda7WSvwtimRAecA8B3lHG3Z4a6RPHURR71NfzTdv+G3/+JFipWFFpptGv+gu2s77E6RLxPYv+FGrSaG2s
    2vSk1yUUP5x3qmZF6IvTtCfucGd+i7hsEXF1NKXZI0HXBWG5yXqP9vkRf/SULxjVoq/CQnwBwG18vTs+nn7sRxigtwY7olUCS0XiTqnjRJKgJP+O+gbZpJ35
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=gTG7XdVZ9SXG49LLNZIA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDSAmr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:42:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36674 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbeDSAmp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 20:42:45 -0400
X-Google-Smtp-Source: AIpwx49Ogs+TZJ0h/05e9A3P3kF8kNpUyxvfiZ6mNRAOrpbr3MpS0IihkhXHEquICkleHrRldV4vbZnfVDgSgOxlgCk=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <737f914a88d048b9985984c0ce1f946c30ca374c.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <737f914a88d048b9985984c0ce1f946c30ca374c.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 20:42:43 -0400
Message-ID: <CAHC9VhTzp-r2TFytt1zTEpeGK=O5dEnLPFw-CdsM1ttpY0a30g@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 07/13] audit: add container aux record to watch/tree/mark
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
> Add container ID auxiliary record to mark, watch and tree rule
> configuration standalone records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit_fsnotify.c |  5 ++++-
>  kernel/audit_tree.c     |  5 ++++-
>  kernel/audit_watch.c    | 33 +++++++++++++++++++--------------
>  3 files changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 52f368b..18c110d 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -124,10 +124,11 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
>  {
>         struct audit_buffer *ab;
>         struct audit_krule *rule = audit_mark->rule;
> +       struct audit_context *context = audit_alloc_local();
>
>         if (!audit_enabled)
>                 return;

Move the audit_alloc_local() after the audit_enabled check.

> -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(context, GFP_NOFS, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
>         audit_log_format(ab, "auid=%u ses=%u op=%s",
> @@ -138,6 +139,8 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
>         audit_log_key(ab, rule->filterkey);
>         audit_log_format(ab, " list=%d res=1", rule->listnr);
>         audit_log_end(ab);
> +       audit_log_container_info(context, "config", audit_get_containerid(current));
> +       audit_free_context(context);
>  }
>
>  void audit_remove_mark(struct audit_fsnotify_mark *audit_mark)
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 67e6956..7c085be 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -496,8 +496,9 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
>  static void audit_tree_log_remove_rule(struct audit_krule *rule)
>  {
>         struct audit_buffer *ab;
> +       struct audit_context *context = audit_alloc_local();

Sort of independent of the audit container ID work, but shouldn't we
have an audit_enabled check here?

> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
>         audit_log_format(ab, "op=remove_rule");
> @@ -506,6 +507,8 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
>         audit_log_key(ab, rule->filterkey);
>         audit_log_format(ab, " list=%d res=1", rule->listnr);
>         audit_log_end(ab);
> +       audit_log_container_info(context, "config", audit_get_containerid(current));
> +       audit_free_context(context);
>  }
>
>  static void kill_rules(struct audit_tree *tree)
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 9eb8b35..60d75a2 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -238,20 +238,25 @@ static struct audit_watch *audit_dupe_watch(struct audit_watch *old)
>
>  static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watch *w, char *op)
>  {
> -       if (audit_enabled) {
> -               struct audit_buffer *ab;
> -               ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> -               if (unlikely(!ab))
> -                       return;
> -               audit_log_format(ab, "auid=%u ses=%u op=%s",
> -                                from_kuid(&init_user_ns, audit_get_loginuid(current)),
> -                                audit_get_sessionid(current), op);
> -               audit_log_format(ab, " path=");
> -               audit_log_untrustedstring(ab, w->path);
> -               audit_log_key(ab, r->filterkey);
> -               audit_log_format(ab, " list=%d res=1", r->listnr);
> -               audit_log_end(ab);
> -       }
> +       struct audit_buffer *ab;
> +       struct audit_context *context = audit_alloc_local();
> +
> +       if (!audit_enabled)
> +               return;

Same as above, do the allocation after the audit_enabled check.

> +       ab = audit_log_start(context, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> +       if (unlikely(!ab))
> +               return;
> +       audit_log_format(ab, "auid=%u ses=%u op=%s",
> +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> +                        audit_get_sessionid(current), op);
> +       audit_log_format(ab, " path=");
> +       audit_log_untrustedstring(ab, w->path);
> +       audit_log_key(ab, r->filterkey);
> +       audit_log_format(ab, " list=%d res=1", r->listnr);
> +       audit_log_end(ab);
> +       audit_log_container_info(context, "config", audit_get_containerid(current));
> +       audit_free_context(context);
>  }

-- 
paul moore
www.paul-moore.com
