Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5259C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600CD27A19
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lNoQsQnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600CD27A19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967301AbeF1WK5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:10:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42012 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966704AbeF1WK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:10:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so5344225lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPQKNXDgKjxs4VpSMVhmyYh2WWXJfsx19qHpfo1V9hA=;
        b=lNoQsQnKPc8Dsi4YnA4pQAycTmSH0Qx5R+BbZ0bGGidNagBCpuiJ+RuWOt+bn38/nr
         EVt3ranWjlVIPsAK/JfjRC3jabZ1hUVdfZeNbORXH0pv+HE4pIwQ+Rt01YlTiiBd9q8s
         IXX2k5ezlVQdzqorzeRvurXlyDIg0nj4Rrwvx+sEnZ54MHFL5+4y9Oy0+taWfZw1MU37
         mqfYKdq06P0jIcwPUZgYrt+yU6FIErFOjKIlftTZuoBveCsQHy7T4PdxdXqxNShjq4LF
         PEpBUWsvqHAdV6oSJRP1s+bEI9vWqcukcL/8a+5/dOU7mV+5fmklrUjAorxRmbSzB8uc
         gohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPQKNXDgKjxs4VpSMVhmyYh2WWXJfsx19qHpfo1V9hA=;
        b=t8H9IHego9D/Rgk24iDi8WTtaZFNABOqfKDTuZJiYcOmBKtrNksWlcS8D4IxwDX157
         +0GxZMd/kWUgBWj3kaj5R71cdSbkl3ag4E1oCvW11XoOFz7TnIDsCytCiqbwA0RI34PI
         9oTFCAD1IDbQJF1noeOAGPcKd9b3LXNDoSyg3fmNkXKOq4mWwG7RtumCDSaOfBhmfRHv
         PoFGcT1ycpdAfa0+zvY41d1GlFxR2ceAKUzTAznN2ZnjrOIlLILxSUJL7W/pFvrSBWBg
         5V8IfZGhlDwbCWI+BZFuZL8dKvKatLFYhwz96ilF+Kgw/DrnFA0grL14MXxK5w6Ky4r/
         iIeg==
X-Gm-Message-State: APt69E2eGoF4ZSUCwxpKLdIH4YIyBOhvezg33rCxItIXS77YoArMHeuD
        N6bxTeo1AqmDl+RBuq74BXwjyKJ6EzpXy5nCPPB0
X-Google-Smtp-Source: AAOMgpcO8OomWM0ZckuZ3Ud0ThDGx4Nzua4iRlC91sB9SjZrp7Uw6JBxa13P5l3vnZaUMpZjZJPWV45768K9ZJEAEI0=
X-Received: by 2002:a19:c1c4:: with SMTP id r187-v6mr8389981lff.90.1530223854977;
 Thu, 28 Jun 2018 15:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <244a8049197a23b0cee37dc3f00d070e646fd1b7.1529003588.git.rgb@redhat.com>
 <CAHC9VhTNOgpOAhi893v7EsMiYXDP47YYXUEcEnpexO+t1i7BgA@mail.gmail.com>
In-Reply-To: <CAHC9VhTNOgpOAhi893v7EsMiYXDP47YYXUEcEnpexO+t1i7BgA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 18:10:44 -0400
Message-ID: <CAHC9VhQB+mRmtwu6fN=bqwp9mX7bkqEaE6NAbXhbffc_EDSLgQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 2/6] audit: add syscall information to
 CONFIG_CHANGE records
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        aviro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 5:47 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Tie syscall information to all CONFIG_CHANGE calls since they are all a
> > result of user actions.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/59
> > See: https://github.com/linux-audit/audit-kernel/issues/50
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.c          | 4 ++--
> >  kernel/audit_fsnotify.c | 2 +-
> >  kernel/audit_tree.c     | 2 +-
> >  kernel/audit_watch.c    | 2 +-
> >  kernel/auditfilter.c    | 2 +-
> >  5 files changed, 6 insertions(+), 6 deletions(-)
>
> Merged, thanks.

Actually, I take that back (good thing I hadn't pushed yet).

Why don't you squash this patch with 3/6 so that a bisect or
cherry-pick backport doesn't end up splitting 2/6 and 3/6 and causing
a regression with the AUDIT_USER_* records.

> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index ad54339..e469234 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -400,7 +400,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
> >         struct audit_buffer *ab;
> >         int rc = 0;
> >
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> >         if (unlikely(!ab))
> >                 return rc;
> >         audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
> > @@ -1067,7 +1067,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> >                 return;
> >         }
> >
> > -       *ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
> > +       *ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
> >         if (unlikely(!*ab))
> >                 return;
> >         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > index 52f368b..1640eb6 100644
> > --- a/kernel/audit_fsnotify.c
> > +++ b/kernel/audit_fsnotify.c
> > @@ -127,7 +127,7 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
> >
> >         if (!audit_enabled)
> >                 return;
> > -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
> >         if (unlikely(!ab))
> >                 return;
> >         audit_log_format(ab, "auid=%u ses=%u op=%s",
> > diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> > index 5e9d1e5..a01b9da 100644
> > --- a/kernel/audit_tree.c
> > +++ b/kernel/audit_tree.c
> > @@ -499,7 +499,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
> >
> >         if (!audit_enabled)
> >                 return;
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> >         if (unlikely(!ab))
> >                 return;
> >         audit_log_format(ab, "op=remove_rule");
> > diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> > index 9b4836b..da2978b 100644
> > --- a/kernel/audit_watch.c
> > +++ b/kernel/audit_watch.c
> > @@ -242,7 +242,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
> >
> >         if (!audit_enabled)
> >                 return;
> > -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
> >         if (!ab)
> >                 return;
> >         audit_log_format(ab, "auid=%u ses=%u op=%s",
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index eaa3201..6e19acb 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1093,7 +1093,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
> >         if (!audit_enabled)
> >                 return;
> >
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> >         if (!ab)
> >                 return;
> >         audit_log_session_info(ab);
> > --
> > 1.8.3.1
> >
>
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
