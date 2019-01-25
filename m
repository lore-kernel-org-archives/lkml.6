Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84616C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A9C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RbeugIKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAYV4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:56:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38461 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:56:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so9596766lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jt4vl8osisPMAQwZv39VShU2mhjV/0o4kJ0Fbd+I+60=;
        b=RbeugIKxTixYuZUc3WO3nYL9fsSvFRnxPjrpvHuxmSG/7SWtJOWOX+lHC28kLTAN0p
         qWu63nq8W6VKInjS6N4DmAu3yOKW5vBF7gQhrUEDuknVcKrLv3Vrp2uXXngalLiVLjvP
         P4fhhu6xgmB5eoq30s46SBCHclQY8zF7AMhmoYERnnpcVkLfNKFuy4AhEVssyy0xgqcn
         GTZbkmlQEHGzR99gcDOEAHbLoA1i3Chn49/0X4qzcnNU2zpkEPfEYW3nSNWdQr0dlYcv
         jum2Kk4aL2Ky1deFHjUAnGzTca8b0I/RJGsspOQwT/JDPuf3fFmAXgkyj6gIQwjC3DFb
         Rvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jt4vl8osisPMAQwZv39VShU2mhjV/0o4kJ0Fbd+I+60=;
        b=Xctk3YyQgGDRZuCmYq5LcE1wV08mkzqU6140OpUIxakzJYPARphGHaa8RWr3JKZmiA
         4selZTSida+45587xO1Ekkw+nn/ewqhK2aezvr9cthMeavbrZXhcq4bztl3NXEsA1Ciz
         SclzxsTyWIxWnDLhc2cG97VBjzIH1RqgoQOuVYg8ICQmOcqkVge3c2+jEJE5ge5iJoit
         iW3jRM9NQh2l4fr5LIHiZibde9/kWQUnccn0RS2jearE7Cbhs+Kl+cvKr2VUVPRhc2kO
         SKqbQTlPfX9HVcbUpVl0qfVMnmWPdof0E9hla9TZUuZAdp7594Fy+1A/rkx2zj56O4xo
         piVA==
X-Gm-Message-State: AJcUukcTUd+hE2Qkqnu+HEd/ZfmjQsQo24AbnfSA8gMwqait/W8+/YJt
        94gy19gqYxAunU4uuTzx9o/CC3EsXso4O4oQtLaW
X-Google-Smtp-Source: ALg8bN4zijxD62U+k9vs65QuqiBlBJzi8BAltQnFY0R6UfHPKxw6sRy3qw5dv2iVpT3oPnkxj5A4S24cBj0/mKOq0Xs=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr10251290ljj.161.1548453390589;
 Fri, 25 Jan 2019 13:56:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548192740.git.rgb@redhat.com> <782bf5adb2b08369b9f98d3283c520847ea315a1.1548192740.git.rgb@redhat.com>
In-Reply-To: <782bf5adb2b08369b9f98d3283c520847ea315a1.1548192740.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 16:56:19 -0500
Message-ID: <CAHC9VhTvMpUEPum=T9sUxJ4J7sPEWn1uQJJsx-ptggOhWH7tGA@mail.gmail.com>
Subject: Re: [PATCH ghak105 V1 1/2] audit: clean up AUDITSYSCALL prototypes
 and stubs
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 5:08 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Pull together all the audit syscall watch, mark and tree prototypes and
> stubs into the same ifdef.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h | 64 ++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 33 insertions(+), 31 deletions(-)

Looks good, merged.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 6ffb70575082..22ef49b76daa 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -267,25 +267,47 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  extern struct tty_struct *audit_get_tty(void);
>  extern void audit_put_tty(struct tty_struct *tty);
>
> -/* audit watch functions */
> +/* audit watch/mark/tree functions */
>  #ifdef CONFIG_AUDITSYSCALL
>  extern void audit_put_watch(struct audit_watch *watch);
>  extern void audit_get_watch(struct audit_watch *watch);
> -extern int audit_to_watch(struct audit_krule *krule, char *path, int len, u32 op);
> +extern int audit_to_watch(struct audit_krule *krule, char *path, int len,
> +                         u32 op);
>  extern int audit_add_watch(struct audit_krule *krule, struct list_head **list);
>  extern void audit_remove_watch_rule(struct audit_krule *krule);
>  extern char *audit_watch_path(struct audit_watch *watch);
> -extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev);
> +extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino,
> +                              dev_t dev);
>
> -extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname, int len);
> +extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
> +                                                   char *pathname, int len);
>  extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
>  extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
>  extern void audit_remove_mark_rule(struct audit_krule *krule);
> -extern int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_t dev);
> +extern int audit_mark_compare(struct audit_fsnotify_mark *mark,
> +                             unsigned long ino, dev_t dev);
>  extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
> -extern int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark);
> +extern int audit_exe_compare(struct task_struct *tsk,
> +                            struct audit_fsnotify_mark *mark);
>
> -#else
> +extern struct audit_chunk *audit_tree_lookup(const struct inode *inode);
> +extern void audit_put_chunk(struct audit_chunk *chunk);
> +extern bool audit_tree_match(struct audit_chunk *chunk,
> +                            struct audit_tree *tree);
> +extern int audit_make_tree(struct audit_krule *rule, char *pathname, u32 op);
> +extern int audit_add_tree_rule(struct audit_krule *rule);
> +extern int audit_remove_tree_rule(struct audit_krule *rule);
> +extern void audit_trim_trees(void);
> +extern int audit_tag_tree(char *old, char *new);
> +extern const char *audit_tree_path(struct audit_tree *tree);
> +extern void audit_put_tree(struct audit_tree *tree);
> +extern void audit_kill_trees(struct audit_context *context);
> +
> +extern int audit_signal_info(int sig, struct task_struct *t);
> +extern void audit_filter_inodes(struct task_struct *tsk,
> +                               struct audit_context *ctx);
> +extern struct list_head *audit_killed_trees(void);
> +#else /* CONFIG_AUDITSYSCALL */
>  #define audit_put_watch(w) {}
>  #define audit_get_watch(w) {}
>  #define audit_to_watch(k, p, l, o) (-EINVAL)
> @@ -301,21 +323,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  #define audit_mark_compare(m, i, d) 0
>  #define audit_exe_compare(t, m) (-EINVAL)
>  #define audit_dupe_exe(n, o) (-EINVAL)
> -#endif /* CONFIG_AUDITSYSCALL */
>
> -#ifdef CONFIG_AUDITSYSCALL
> -extern struct audit_chunk *audit_tree_lookup(const struct inode *inode);
> -extern void audit_put_chunk(struct audit_chunk *chunk);
> -extern bool audit_tree_match(struct audit_chunk *chunk, struct audit_tree *tree);
> -extern int audit_make_tree(struct audit_krule *rule, char *pathname, u32 op);
> -extern int audit_add_tree_rule(struct audit_krule *rule);
> -extern int audit_remove_tree_rule(struct audit_krule *rule);
> -extern void audit_trim_trees(void);
> -extern int audit_tag_tree(char *old, char *new);
> -extern const char *audit_tree_path(struct audit_tree *tree);
> -extern void audit_put_tree(struct audit_tree *tree);
> -extern void audit_kill_trees(struct audit_context *context);
> -#else
>  #define audit_remove_tree_rule(rule) BUG()
>  #define audit_add_tree_rule(rule) -EINVAL
>  #define audit_make_tree(rule, str, op) -EINVAL
> @@ -324,7 +332,10 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  #define audit_tag_tree(old, new) -EINVAL
>  #define audit_tree_path(rule) ""       /* never called */
>  #define audit_kill_trees(context) BUG()
> -#endif
> +
> +#define audit_signal_info(s, t) AUDIT_DISABLED
> +#define audit_filter_inodes(t, c) AUDIT_DISABLED
> +#endif /* CONFIG_AUDITSYSCALL */
>
>  extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
>
> @@ -334,14 +345,5 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>
>  extern int audit_filter(int msgtype, unsigned int listtype);
>
> -#ifdef CONFIG_AUDITSYSCALL
> -extern int audit_signal_info(int sig, struct task_struct *t);
> -extern void audit_filter_inodes(struct task_struct *tsk, struct audit_context *ctx);
> -extern struct list_head *audit_killed_trees(void);
> -#else
> -#define audit_signal_info(s,t) AUDIT_DISABLED
> -#define audit_filter_inodes(t,c) AUDIT_DISABLED
> -#endif
> -
>  extern void audit_ctl_lock(void);
>  extern void audit_ctl_unlock(void);
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
