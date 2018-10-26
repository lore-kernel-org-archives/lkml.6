Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2802ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E452082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpjRBPb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E452082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJZSj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeJZSj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:39:26 -0400
Received: from localhost (unknown [80.169.156.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13CF2082E;
        Fri, 26 Oct 2018 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540548179;
        bh=9DBnBnzYZtS5qbWTRxKDRUjd+iQO44Wja2LzAWfgCZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=BpjRBPb2M6gD83w52mg7tsENk4tcyNhnFhDm1BEBmV8KoS+ud66nHkFq+NOxlvdQr
         l8wGHMi0hIVINpezusGIp2a3tN5uRv2539W+WfSdC+igz0fTskbMFBNo6BX+CGRXzb
         v5NFReUnFJlP1vNPmRfjWubNqgQ/LZzHbv4bw8Gk=
Date:   Fri, 26 Oct 2018 11:02:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core patches for 4.20-rc1
Message-ID: <20181026100257.GA13209@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.20-rc1

for you to fetch changes up to 09d1ea1c7309c8ca91151778bb3efe514f2e03ed:

  devres: provide devm_kstrdup_const() (2018-10-16 12:53:27 +0200)

----------------------------------------------------------------
Driver core patches for 4.20-rc1

Driver core patches for 4.20-rc1

Here is a small number of driver core patches for 4.20-rc1.

Not much happened here this merge window, only a very tiny number of
patches that do:
	- add BUS_ATTR_WO() for use by drivers
	- component error path fixes
	- kernfs range check fix
	- other tiny error path fixes and const changes

All of these have been in linux-next with no reported issues for a
while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Banajit Goswami (1):
      component: fix loop condition to call unbind() if bind() fails

Bartosz Golaszewski (3):
      devres: constify p in devm_kfree()
      mm: move is_kernel_rodata() to asm-generic/sections.h
      devres: provide devm_kstrdup_const()

Bernd Edlinger (1):
      kernfs: Fix range checks in kernfs_get_target_path

Greg Kroah-Hartman (1):
      driver core: add BUS_ATTR_WO() macro

Konstantin Khlebnikov (1):
      kernfs: update comment about kernfs_path() return value

Rasmus Villemoes (1):
      drivers/base/devtmpfs.c: don't pretend path is const in delete_path

 drivers/base/component.c       |  6 +++---
 drivers/base/devres.c          | 36 ++++++++++++++++++++++++++++++++++--
 drivers/base/devtmpfs.c        |  2 +-
 fs/kernfs/symlink.c            |  5 ++++-
 include/asm-generic/sections.h | 14 ++++++++++++++
 include/linux/device.h         |  6 +++++-
 include/linux/kernfs.h         |  9 +++++----
 mm/util.c                      |  7 -------
 8 files changed, 66 insertions(+), 19 deletions(-)
