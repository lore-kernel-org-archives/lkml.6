Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C028C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FB22081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FB22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeKKD6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:58:10 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:54859 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeKKD6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:58:09 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gLXk0-0007mS-RW; Sat, 10 Nov 2018 11:12:16 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gLXk0-0007No-6O; Sat, 10 Nov 2018 11:12:16 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>
Date:   Sat, 10 Nov 2018 12:12:12 -0600
Message-ID: <87pnvcls3n.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gLXk0-0007No-6O;;;mid=<87pnvcls3n.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19qjDJhAPh4w1xmFrcKzVidinARQfrUDjs=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] namespace fixes for v4.20-rc2
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD: 9c8e0a1b683525464a2abe9fb4b54404a50ed2b4 mount: Prevent MNT_DETACH from disconnecting locked mounts

I believe all of these are simple obviously correct bug fixes.  These
fall into two groups.  Fixing the implementation of MNT_LOCKED which
prevents lesser privileged users from seeing unders mounts created by
more privileged users.  Fixing the extended uid and group mapping in
user namespaces.

As well as ensuring the code looks correct I have spot tested these
changes as well and in my testing the fixes are working.

I have let these changes sit on my branch for a few days as well and
none of the automated testing has found any problems either.

Eric W. Biederman (3):
      mount: Retest MNT_LOCKED in do_umount
      mount: Don't allow copying MNT_UNBINDABLE|MNT_LOCKED mounts
      mount: Prevent MNT_DETACH from disconnecting locked mounts

Jann Horn (1):
      userns: also map extents in the reverse map to kernel IDs

 fs/namespace.c          | 22 +++++++++++++++++-----
 kernel/user_namespace.c | 12 ++++++++----
 2 files changed, 25 insertions(+), 9 deletions(-)

Eric
