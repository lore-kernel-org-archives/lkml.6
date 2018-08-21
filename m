Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A055C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4243F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4243F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeHUNO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:14:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeHUNO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:14:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96F4D805A6D7;
        Tue, 21 Aug 2018 09:55:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-147.rdu2.redhat.com [10.10.123.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D65F794644;
        Tue, 21 Aug 2018 09:54:59 +0000 (UTC)
Subject: vfs: Fixes/adjustments for mount API stuff
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Andrei Vagin <avagin@gmail.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 10:54:59 +0100
Message-ID: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 21 Aug 2018 09:55:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 21 Aug 2018 09:55:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Can you add these patches to the mount API stuff?

There are some fixes and some adjustments to the code.

The patches can also be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-2

Thanks,
David
---
Andrei Vagin (1):
      proc: Set correct userns for new proc super created by a new pid_namespace

David Howells (5):
      vfs: Fix vfs_dup_fs_context()
      vfs: Fix fs_context logging when there's no log
      afs: Move the source fs parameter to the first position
      vfs: Pass path info fsinfo and rename get_fsinfo sb op to fsinfo
      vfs: Adjust fsinfo sample output


 fs/afs/super.c              |   29 +++++++++++++++--------------
 fs/fs_context.c             |    4 ++--
 fs/hugetlbfs/inode.c        |    7 ++++---
 fs/kernfs/mount.c           |    8 ++++----
 fs/proc/root.c              |    5 +++++
 fs/statfs.c                 |   15 ++++++++-------
 include/linux/fs.h          |    4 ++--
 include/linux/fsinfo.h      |    2 +-
 samples/statx/test-fsinfo.c |   30 ++++++++++++++++++++++++++++++
 9 files changed, 71 insertions(+), 33 deletions(-)

