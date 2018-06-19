Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F4F2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pYrRHoc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F4F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966582AbeFSPLO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:11:14 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:41150 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966525AbeFSPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:11:08 -0400
Received: by mail-lf0-f54.google.com with SMTP id d24-v6so25844lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7it/1vgt7FFsKAfDeansaV7+RE9G1bF51+ZRYeZlSuU=;
        b=pYrRHoc2TC2pgUGTKI7dRyTsWXc1s7LrmtV9gKqPXQSBP+Mphe2x9w+x9ZsoTqWJek
         JPkXRt6y10ETqZ4+BdQwdM84JxX6+T1qFfB1RzMY70vjoFV/HSOYw3s2RnnPPEnLTcUF
         NF0xgnKLomYtvosE8BSkkLErtTcjx/co/POTZlb5TL2IhcRMheTgu2eH6L00S7l2mndD
         deiZwUr3v1yyTvLIGi7A94Yk8OO29vtvRu3adwGPZKjMw5bZFozMOsSpTC0oeptLM3CX
         rYIM+XC8P/0vGRfKOiIalx/gFmf7LgJ8bibmaFTjJaB7s1cINFd7c5Rj8geuAKsCwghN
         DSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7it/1vgt7FFsKAfDeansaV7+RE9G1bF51+ZRYeZlSuU=;
        b=Al0PK8mBMFozBpPmxfVRVYJXE4j3qkKFxzd4EuWrxFak+8C/Z1/KGJUugC8RcW+1/7
         1VU7wesQKt8SAzXuzc28aeDk9jQTmruIJ0Bv9f+sDmM75Rcj082z5kQytx/V7aFhRVtk
         mW0zuRJlBTPo+Ul9kX/NvK3q6+r1Vrsu233gET2rB8N+4bszqDbqmww6G+4MW2Hl843t
         xzdelCoCuic87MXfFffLDatt79uUjb8Lo32OZfrpLJ9tdRnnJsH9iEj6dYQxPl+U934w
         hzoCH6l3/PlkE37iJpkgkyD0JRqsVeFGqK6q9jNYJ+Bu0FOsU+ix8CSg2oT/Gv1u7rWD
         2NrQ==
X-Gm-Message-State: APt69E2kQOwllID50aM/5bno7VndCtc37/IITw5+r9bi/vlqj2JgcQcN
        570f4GDIMbNKKrkpP8fAHrW7aArqE1j2dxAMring
X-Google-Smtp-Source: ADUXVKLuHijgKrm79pC7fiR0speWkRs2MHsT2zXzk6o6tHZZ/DCBSRL01ls2qErdkGX97sbnvfzWtioDrhpxZ2ZrHFg=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr11460605ljd.72.1529421066526;
 Tue, 19 Jun 2018 08:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <490a00a7902582823fe8c532f5dd995a1da61fb1.1528214962.git.rgb@redhat.com>
In-Reply-To: <490a00a7902582823fe8c532f5dd995a1da61fb1.1528214962.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 11:10:55 -0400
Message-ID: <CAHC9VhQRv6CzChWvayOK7Zm+pciFh80_u2Whx9-XpdFjNwO_PQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak86 V1] audit: eliminate audit_enabled magic number comparison
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Remove comparison of audit_enabled to magic numbers outside of audit.
>
> Related: https://github.com/linux-audit/audit-kernel/issues/86
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  drivers/tty/tty_audit.c      | 2 +-
>  include/linux/audit.h        | 5 ++++-
>  include/net/xfrm.h           | 2 +-
>  kernel/audit.c               | 3 ---
>  net/netfilter/xt_AUDIT.c     | 2 +-
>  net/netlabel/netlabel_user.c | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

Merged, thanks.

> diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> index e30aa6b..50f567b 100644
> --- a/drivers/tty/tty_audit.c
> +++ b/drivers/tty/tty_audit.c
> @@ -92,7 +92,7 @@ static void tty_audit_buf_push(struct tty_audit_buf *buf)
>  {
>         if (buf->valid == 0)
>                 return;
> -       if (audit_enabled == 0) {
> +       if (audit_enabled == AUDIT_OFF) {
>                 buf->valid = 0;
>                 return;
>         }
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 69c7847..9334fbe 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -117,6 +117,9 @@ struct audit_field {
>
>  extern void audit_log_session_info(struct audit_buffer *ab);
>
> +#define AUDIT_OFF      0
> +#define AUDIT_ON       1
> +#define AUDIT_LOCKED   2
>  #ifdef CONFIG_AUDIT
>  /* These are defined in audit.c */
>                                 /* Public API */
> @@ -202,7 +205,7 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
>  static inline void audit_log_task_info(struct audit_buffer *ab,
>                                        struct task_struct *tsk)
>  { }
> -#define audit_enabled 0
> +#define audit_enabled AUDIT_OFF
>  #endif /* CONFIG_AUDIT */
>
>  #ifdef CONFIG_AUDIT_COMPAT_GENERIC
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 7f2e31a..ce995a1 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -734,7 +734,7 @@ static inline struct audit_buffer *xfrm_audit_start(const char *op)
>  {
>         struct audit_buffer *audit_buf = NULL;
>
> -       if (audit_enabled == 0)
> +       if (audit_enabled == AUDIT_OFF)
>                 return NULL;
>         audit_buf = audit_log_start(audit_context(), GFP_ATOMIC,
>                                     AUDIT_MAC_IPSEC_EVENT);
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e7478cb..8442c65 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -83,9 +83,6 @@
>  #define AUDIT_INITIALIZED      1
>  static int     audit_initialized;
>
> -#define AUDIT_OFF      0
> -#define AUDIT_ON       1
> -#define AUDIT_LOCKED   2
>  u32            audit_enabled = AUDIT_OFF;
>  bool           audit_ever_enabled = !!AUDIT_OFF;
>
> diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> index f368ee6..af883f1 100644
> --- a/net/netfilter/xt_AUDIT.c
> +++ b/net/netfilter/xt_AUDIT.c
> @@ -72,7 +72,7 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
>         struct audit_buffer *ab;
>         int fam = -1;
>
> -       if (audit_enabled == 0)
> +       if (audit_enabled == AUDIT_OFF)
>                 goto errout;
>         ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
>         if (ab == NULL)
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 2f328af..4676f5b 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -101,7 +101,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>         char *secctx;
>         u32 secctx_len;
>
> -       if (audit_enabled == 0)
> +       if (audit_enabled == AUDIT_OFF)
>                 return NULL;
>
>         audit_buf = audit_log_start(audit_context(), GFP_ATOMIC, type);
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
