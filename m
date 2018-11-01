Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C64C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573DB20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573DB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeKBGxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:53:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58246 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeKBGxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:53:51 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIKpq-0008J0-Iq
        for linux-kernel@vger.kernel.org; Thu, 01 Nov 2018 21:49:02 +0000
Received: by mail-io1-f71.google.com with SMTP id v23-v6so18902279ioh.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pb7alhW/eUNsmXcy3GGi4ATA31uijO6iQjovchu/1f8=;
        b=fu6Dzpl/U3tLgTwO3W+MVHkLclZpHBZIwtpXyh9ACgGrd79rsoaBUGPr5EXNDW0P0J
         rypX3LJdvzTu04chQVu+sZpyJv9nRVo7u8EElvKDTk50sHb7l3qri/U7HOaQAIiDRSt9
         bap+0YSKWGCNfrNBbrZ/NkhOK0BmgsJx+RTpAH+kwxNK9NA0OvANF9NRNKZEt6vunuPi
         e2d2RXWLHNLadFDh21WkHCvX2AEGiRWJwRxKvEMh1y8+qPtt+raneJ5MSPkvJrl1mYa1
         PXwr44GKb16MCB0ewDEYVJ3mR/+a7Qnyjkq8hDGd5XecNmiJqjtiO7n3Mr9wnPd7HFI6
         bMaw==
X-Gm-Message-State: AGRZ1gIa8mZO4zy0ytM4h3jE+0iFJbknYOIJthrMhKsjp9BZ3tV0AQ+K
        iQVZblTn4fyrWehAnD+rqxMYC7Y4OUWh30gVyWGcF4Q3GOb2NaXUv+fl8CAn3ejELbm0o++jnZT
        shkeKrdOZ7bcZYGJYcKboWOrJUnHwrzitNJ3cmvVqGA==
X-Received: by 2002:a6b:b3c6:: with SMTP id c189-v6mr7122800iof.23.1541108940574;
        Thu, 01 Nov 2018 14:49:00 -0700 (PDT)
X-Google-Smtp-Source: AJdET5ddF11HGZXb8FbdojMAsij4Gun36zN1trY7kgZWGaySEEd0onqUa8qi1w3ODeIWrjRPzmA5hg==
X-Received: by 2002:a6b:b3c6:: with SMTP id c189-v6mr7122773iof.23.1541108940115;
        Thu, 01 Nov 2018 14:49:00 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id x67-v6sm9660567ita.3.2018.11.01.14.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:48:58 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [RFC PATCH 0/6] shiftfs fixes and enhancements
Date:   Thu,  1 Nov 2018 16:48:50 -0500
Message-Id: <20181101214856.4563-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've done some work to fix and enhance shiftfs for a number of use
cases, so that we would have an idea what a more full-featured shiftfs
would look like. I'm intending for these to serve as a point of
reference for discussing id shifting mounts/filesystems at plumbers in a
couple of weeks [1].

Note that these are based on 4.18, and I've added a small fix to James'
most recent patch to fix a build issue there. To work with 4.19 they
will need a number of updates due to changes in the vfs.

The features I focused on fixing in or adding to shiftfs in these
patches are inotify, file capabilities, posix acls, and nesting. These
are all now working for at least simple use cases, but further testing
and cleanups are needed before I'd consider these finished. I also kept
all the changes within shiftfs, but some of the code might belong in the
vfs instead (in particular some of the posix acl code).

I've also pushed these patches to:

git://git.kernel.org/pub/scm/linux/kernel/git/sforshee/linux.git shiftfs

Thanks,
Seth

[1] https://linuxplumbersconf.org/event/2/contributions/212/

---

James Bottomley (1):
  shiftfs: uid/gid shifting bind mount

Seth Forshee (5):
  shiftfs: map inodes to lower fs inodes instead of dentries
  shiftfs: copy inode attrs up from underlying fs
  shiftfs: translate uids using s_user_ns from lower fs
  shiftfs: add support for posix acls
  shiftfs: support nested shiftfs mounts

 fs/Kconfig                 |   18 +
 fs/Makefile                |    1 +
 fs/shiftfs.c               | 1075 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h |    2 +
 4 files changed, 1096 insertions(+)
 create mode 100644 fs/shiftfs.c

