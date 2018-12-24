Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145E0C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D2F21736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hTJ+ds8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLXQ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:26:54 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:39373 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:26:54 -0500
Received: by mail-lf1-f53.google.com with SMTP id n18so8457319lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IYdaz0t6Pp5TSyj0Xbid44GL9kcPpmz5mHyD9H1JGXo=;
        b=hTJ+ds8kXYMk+BleYtvJGfxJGYXTPMNWaQvurekbGnQxxKxsGjYWS1st9/AU9yY8FG
         ziTaC7hmTEXHzuvg2HE8IcCb9Htzv5bgw2yheY4Xu6YxmEJQbrt3wwvoyRRnhHXqRzXn
         wyEz6XeUJ/HJpG8p8hM+qiPOTIr+6hPY9+ZLAnG2ayrG/81ADDbskG0U4Q5WKa45ODij
         AXw3holWEeaEb4YkCToKFM4eoJrl8kP9BK7va8M2XwtAl0wsmuLlNFqITjw9Pk0yDaAV
         7K+3hN+pVL87qJhjT75sDM8HgOHJ0C2D4eVdQk8zSUhTO45KkvMKmAYz307wj7Earvl9
         Eoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IYdaz0t6Pp5TSyj0Xbid44GL9kcPpmz5mHyD9H1JGXo=;
        b=LGPxjJIgbA2BDK3AzwTQZ1pcvjZ8ewnl8my2KSX84j4xJgpqk31eecxiD3FsBgeBSn
         0UvKY3LNYlPYiPnK+fx0p5woX9LXLRFwy1r2CuwG31T9/RESwejUci2FJbOJLYrwdA10
         byqP2Y2Fm3Mm0BmOYQ+XShK6rHp2ofWEFNHPmmqXySiEGxKGiLcbra4TpY7LZuF8qgo2
         oB7nL7BKh1FEsmb/tyzR2a5NZf8iYvKXaCN0ycSeo6c+yTQ8/2EuWgKOvoBlvCzXxMt7
         XQNC41/t+zrbbNPz4Czh38R5khNZefsUDiRTDL13C/oDt1MkLgs4tvVhO+oa8ZWuXQP2
         qxAA==
X-Gm-Message-State: AA+aEWZ7RyL3KjPx/NMtNjG3OQvToKZDcVNgzKP6gyW/2LYZC3ztdqmh
        hrGRP1sURN8mcbC55DWmKLBYh/bjfEwCMMoMZE+8/s+2dKzc
X-Google-Smtp-Source: AFSGD/WDqIVy8qDjjqOPDh62r1S9TMA+cgMTMf+xtut+oGFvObJY1mpsrO8RCdXJQLaNrgB0GysX+otOq2y+jvhQCOw=
X-Received: by 2002:a19:6719:: with SMTP id b25mr6352678lfc.38.1545668811673;
 Mon, 24 Dec 2018 08:26:51 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Dec 2018 11:26:40 -0500
Message-ID: <CAHC9VhTBp2XO4nDuJTe+tkALokHY+Ly-1fkD_Wubsci+vOp=Sg@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

In the finest of holiday of traditions, I have a number of gifts to
share today.  While most of them are re-gifts from others, unlike the
typical re-gift, these are things you will want in and around your
tree; I promise.

This pull request is perhaps a bit larger than our typical PR, but
most of it comes from Jan's rework of audit's fanotify code; a very
welcome improvement.  We ran this through our normal regression tests,
as well as some newly created stress tests and everything looks good.
Richard added a few patches, mostly cleaning up a few things and and
shortening some of the audit records that we send to userspace; a
change the userspace folks are quite happy about.  Finally YueHaibing
and I kick in a few patches to simplify things a bit and make the code
less prone to errors.

Lastly, I want to say thanks one more time to everyone who has
contributed patches, testing, and code reviews for the audit subsystem
over the past year.  The project is what it is due to your help and
contributions - thank you.

Thanks,
-Paul

--
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

 Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20181224

for you to fetch changes up to d406db524c32ca35bd85cada28a547fff3115715:

 audit: remove duplicated include from audit.c (2018-12-14 12:09:30 -0500)

----------------------------------------------------------------
audit/stable-4.21 PR 20181224

----------------------------------------------------------------
Jan Kara (14):
     audit_tree: Remove mark->lock locking
     audit: Fix possible spurious -ENOSPC error
     audit: Fix possible tagging failures
     audit: Embed key into chunk
     audit: Make hash table insertion safe against concurrent lookups
     audit: Factor out chunk replacement code
     audit: Remove pointless check in insert_hash()
     audit: Provide helper for dropping mark's chunk reference
     audit: Allocate fsnotify mark independently of chunk
     audit: Guarantee forward progress of chunk untagging
     audit: Drop all unused chunk nodes during deletion
     audit: Simplify locking around untag_chunk()
     audit: Replace chunk attached to mark instead of replacing mark
     audit: Use 'mark' name for fsnotify_mark variables

Paul Moore (2):
     audit: minimize our use of audit_log_format()
     audit: use current whenever possible

Richard Guy Briggs (5):
     audit: print empty EXECVE args
     audit: localize audit_log_session_info prototype
     audit: use session_info helper
     audit: remove WATCH and TREE config options
     audit: shorten PATH cap values when zero

YueHaibing (1):
     audit: remove duplicated include from audit.c

drivers/tty/tty_audit.c          |  13 +-
include/linux/audit.h            |   8 +-
init/Kconfig                     |   9 -
kernel/Makefile                  |   4 +-
kernel/audit.c                   |  62 ++---
kernel/audit.h                   |  10 +-
kernel/audit_fsnotify.c          |   6 +-
kernel/audit_tree.c              | 498 ++++++++++++++++++++----------------
kernel/audit_watch.c             |   6 +-
kernel/auditsc.c                 | 150 ++++++------
security/integrity/ima/ima_api.c |   2 +-
11 files changed, 395 insertions(+), 373 deletions(-)

-- 
paul moore
www.paul-moore.com
