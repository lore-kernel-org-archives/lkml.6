Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8256AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7952086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="i++1umOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7952086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbeFLUdm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:33:42 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:39042 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934330AbeFLUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:33:29 -0400
Received: by mail-lf0-f53.google.com with SMTP id t134-v6so441247lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Omvdc8fttaCWopWYdaj39AeDGSEVvoWz3xaJjlTJ03I=;
        b=i++1umOgWzQbWJiLLectffqLkx/XmhDvXL7T3JDe7XWFT04ZDRxBNMMfmZD8+9ERHE
         Ln73xLQ0W1X/j+XsQBzaknx6CyHvgFchGsX7BnxI5/wtVlJMlfsEQOOLI8m2fs/fg3ej
         GPk0QdkgMPfAPoG0i//h36DhNRtGTwqImHPhZtA7i/LrHSW1ciZy5m2oO1WR+MeTCaQ7
         Q4lpnJi/y986MRHNXC+/Hkpy2EYN/eptBLfdEWD1BpXXMaAyqjmIC245XPT8ocxeeoab
         ayM47R8MC9Shjt31awCJsu5Fn0rNlxLj3h02gMR5rYEpIAxMb8l/jBdWDlbBt+TSmZlS
         xQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Omvdc8fttaCWopWYdaj39AeDGSEVvoWz3xaJjlTJ03I=;
        b=SfVZwy9LOXSD09VFBaCHfW+nNXZvCFFGQ3PEdHTKWVoKnnQDZypygNg8IR1yX1ft3R
         jVYGf89zoEm5Iib1ScmAqMpDW8TMhdAdkkeKVtCrE1apD537jHR1ZQyRpdKUdPOe+rnd
         OaONajoSKOpQfI25mH7Do7zNhHFtqrO/a804g7jsKpsjWw1s1PFHVL9Z2wmqd2cwQDBp
         7oONQIS3GUxMuxcamv/EtsR3IJ9Oa+nCd+SwvyEwIsf1uzToif/cZ3Vo1mPgMt/SKQkX
         chFzDipDdCu6Dfb7vmS0U9C7CnNIRg0Gl+9IbmTSwzXkDS38Id8wxMQ9GrSp2PlKUNpS
         xkoQ==
X-Gm-Message-State: APt69E1zrV0y/1prn6lfIgHZgA7b53xBdFUrVe4rMOCK3QLdTt4FfbZ7
        lySnlLOgwDAQlsMiq8/qNY2WS2ayrCl7qXQFsLH1
X-Google-Smtp-Source: ADUXVKLse2+BJ6uzRKMTgZ4WJ4BVAgKJKiaGRYpIUu/hxxZJf/7JUL4q/I5pav8S/7scjaGuNTm19CA7THPs46YbxBg=
X-Received: by 2002:a19:1204:: with SMTP id h4-v6mr1085726lfi.12.1528835607787;
 Tue, 12 Jun 2018 13:33:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a911:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 13:33:27
 -0700 (PDT)
X-Originating-IP: [108.20.156.165]
In-Reply-To: <490a00a7902582823fe8c532f5dd995a1da61fb1.1528214962.git.rgb@redhat.com>
References: <490a00a7902582823fe8c532f5dd995a1da61fb1.1528214962.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jun 2018 16:33:27 -0400
Message-ID: <CAHC9VhQuLbbRp4ETzonD0XYQ3oQP9fuq-f7zrytQY7BQ0ANCZA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak86 V1] audit: eliminate audit_enabled magic number comparison
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:20 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
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

An improvement, thank you.  Thankfully there are no tariffs on patches
so I've queued this up for after the merge window.

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
