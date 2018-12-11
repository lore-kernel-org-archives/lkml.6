Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CC8C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF132084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VVoq/4u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF132084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeLKWbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:31:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41673 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKWbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:31:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so11998514lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCfBf9iPBwqAS9oUw0LpkftI5ePe20LCu22ZfdQAFHg=;
        b=VVoq/4u6h4g5xkNRBfrHjwTRWXNom+L+lr2PsdBuHv7opMvwBvTUa7TvUqVevCtlAp
         K+aZDLA0UT/noNxyWyPxd0dXee9PLRPOn5uUrqMdo/mrq4G7wuGt5wQeUs6qkIzd4Zwv
         ZxS2OUtEVDJ440l7jviaXgGShTupt4MYeDU1T40X7wAUpTzD5AbUbsBaYfoLS+vMxA7d
         OG0SoBoM4OMM6wepW10OTfIBQLH0q3Xh+sEWPubYNjGRByfY7wVQ72xpmv3wHjT5TlA/
         pfo4/dNzA5PMBSpB9z97R+/xcdqMPKo1dmKLYt2Fwiu/O5LKy5WgaVHNxkKXcxSRDC7R
         UOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCfBf9iPBwqAS9oUw0LpkftI5ePe20LCu22ZfdQAFHg=;
        b=JC92Iu7pFIvx5zPCujsWPYWW6VeAUYhIFqRQ+CDMYYYM8yltCJ2XMXcWaoB0yllaM0
         RPTNnCyZr5beZClz+OFYOL/5sN0YT1JQ9mQ62mVkkRQEPyYLcYl8kOE3wYjO6Z/ybIUu
         BMKEp8FCt4JbZsqV/xy4R1fMbWz9ItkCn8oahPihGdY+A0gMP303i/XIufTYsbixdL/L
         P94pWuq4dzBL4Ji2f33r4cCNXvvUt/S0DudEo4ASTD1JwnvIfal8QZaN1gUmwYW6gZqt
         XMbCoDwYQZwSXXwlNltkmyCu7lqNFFHRUxz/nxrbEdEicfPzsnQWE2JkMPiISW07Y9tv
         S2iQ==
X-Gm-Message-State: AA+aEWaAlsTW2y6FLBuWA9wT0wcWd6ZGsDepZOLVGfDL2d1p2aIJjlwk
        6zOJbS4AgP4NcXdmur0Ji9WgUXDHYP71AXoeAZiq
X-Google-Smtp-Source: AFSGD/WLY7Q2tvUjxm9Hosu3mRgRBFKVsEN0bFyxKD4mT49trMIzkVctUQtKTHuRV7o5rjk0wSSA4yp6ABjIOMBNatQ=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr9764663lfe.4.1544567492490;
 Tue, 11 Dec 2018 14:31:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com>
In-Reply-To: <cover.1544477629.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Dec 2018 17:31:20 -0500
Message-ID: <CAHC9VhRqMt2k+pL7YF0MaZQfXZzttyHAXBJhHH56Mvswii4EKg@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 0/4] audit: config_change normalizations and
 event record gathering
To:     rgb@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, viro@zeniv.linux.org.uk,
        sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Make a number of changes to normalize CONFIG_CHANGE records by adding
> missing op= fields, providing more information in existing op fields
> (optional last patch) and connecting all records to existing audit
> events.  The user record needs special-casing since its content isn't
> directly related to the call that logs it.
>
> Since tree purge records are processed after the EOE record is produced,
> the order of operation of the EOE record and the purge will have to be
> reversed so that the purge records can be included in the event.
>
> The last patch is included for completeness understanding it may be more
> information than necessary.
>
> For reference, here are the calling methods and function tree for all
> CONFIG_CHANGE events with fields:
> - audit_log_config_change()
>         - add "op=set" to fields: "[op] <param-name> old auid ses subj res"
>         - AUDIT_SET:AUDIT_STATUS_PID
>         - AUDIT_SET:AUDIT_STATUS_LOST
>         - audit_do_config_change()
>                 - AUDIT_SET:AUDIT_STATUS_FAILURE
>                 - AUDIT_SET:AUDIT_STATUS_ENABLED
>                 - AUDIT_SET:AUDIT_STATUS_RATE_LIMIT
>                 - AUDIT_SET:AUDIT_STATUS_BACKLOG_LIMIT
>                 - AUDIT_SET:AUDIT_STATUS_BACKLOG_WAIT_TIME
> - audit_log_rule_change()
>         - fields: "auid ses subj op key list res"
>         - AUDIT_ADD_RULE -F dir=...
>         - AUDIT_DEL_RULE -F dir=...
> - audit_log_common_recv_msg()
>         - fields: "pid uid auid ses subj ..."
>         - AUDIT_*USER* events (not CONFIG_CHANGE like all the rest)
>         - AUDIT_LOCKED add "op={add,remove}_rule" to "[op] audit_enabled res"
>         - AUDIT_TRIM "op=trim res"
>         - AUDIT_MAKE_EQUIV: "op=make_equiv old new res"
>         - AUDIT_TTY_SET: "op=tty_set old-enabled new-enabled old-log_passwd new-log_passwd res"
> - audit_mark_log_rule_change()
>         - add ":mark" to op in fields: "uid ses op=autoremove_rule[] path key list res"
>         - audit_autoremove_mark_rule()
>                 - audit_mark_handle_event()
>                         - audit_mark_fsnotify_ops.handle_event
> - audit_tree_log_remove_rule() called from kill_rules()
>         - add to op ":tree:%s" to fields: "op=remove_rule[] dir key list res"
>         - from trim_marked()
>                 - AUDIT_TRIM: audit_trim_trees() "trim"
>                 - audit_add_tree_rule() iterate_mounts err "add"
>                         - audit_add_rule()
>                                 - audit_rule_change()
>                                         - AUDIT_ADD_RULE -F dir=...
>                 - AUDIT_MAKE_EQUIV: audit_tag_tree() iterate_mounts err "equiv"
>         - from audit_kill_trees()
>                 - __audit_free() "free"
>                         - do_exit()
>                         - copy_process() err
>                 - __audit_syscall_exit() "exit"
>         - from evict_chunk() "evict"
>                 - audit_tree_freeing_mark()
>                         - audit_tree_ops.freeing_mark
> - audit_watch_log_rule_change()
>         add to op ":watch:%s" to fields "auid ses op={updated,remove}_rule[] path key list res"
>         - audit_update_watch() "updated_rules:watch:inval" : "updated_rules:watch:set"
>                 - audit_watch_handle_event() FS_CREATE|FS_MOVED_TO, FS_DELETE|FS_MOVED_FROM
>                         - audit_watch_fsnotify_ops.handle_event
>         - audit_remove_parent_watches() "remove_rule:watch:parent"
>                 - audit_watch_handle_event() FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF
>                         - audit_watch_fsnotify_ops.handle_event
> - audit_seccomp_actions_logged()
>         - fields: "op actions old-actions res"
>
>
> See: https://github.com/linux-audit/audit-kernel/issues/50
> See: https://github.com/linux-audit/audit-kernel/issues/59
>
> Sources of AUDIT_CONFIG_CHANGE records and their current and proposed
> fields are listed here
>         https://github.com/linux-audit/audit-kernel/issues/59#issuecomment-445055154
>
> Changelog:
> v3:
> - un-clever %s_rule to not break up op values
> - create audit_log_user_recv_msg() and squash into record connection
> - squash kill_trees context handling with kill-trees before EOE
> - rebase on audit/next (v4.20-rc1) with 2a1fe215e730 ("audit: use current whenever possible")
> - remove parens in extended format
>
> v2:
> - re-order audit_log_exit() and audit_kill_trees()
> - drop EOE reordering patch
> - rebase on 4.18-rc1 (audit/next)
>
> Richard Guy Briggs (4):
>   audit: give a clue what CONFIG_CHANGE op was involved
>   audit: add syscall information to CONFIG_CHANGE records
>   audit: hand taken context to audit_kill_trees for syscall logging
>   audit: extend config_change mark/watch/tree rule changes
>
>  kernel/audit.c          | 33 +++++++++++++++++++++++----------
>  kernel/audit.h          |  4 ++--
>  kernel/audit_fsnotify.c |  4 ++--
>  kernel/audit_tree.c     | 28 +++++++++++++++-------------
>  kernel/audit_watch.c    |  8 +++++---
>  kernel/auditfilter.c    |  2 +-
>  kernel/auditsc.c        | 12 ++++++------
>  7 files changed, 54 insertions(+), 37 deletions(-)

In order to make sure expectations are set appropriately, as we are at
-rc6 right now this is not something that would go into audit/next now
(assuming everything looks okay on review), it would go into
audit/next *after* the upcoming merge window.

-- 
paul moore
www.paul-moore.com
