Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A507C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076B220869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546011374;
	bh=KNF+WmjO9FVn1kUkZBwLiwALL8fvc5RKsqQbAjIpPkk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gJ0pd9oLSx3nrjynIXaOvzJpZMeBRWpkL4JWo698qFkFzPuIrLINqkLVekowqk6UP
	 7k03HUgMiGeQzEpAzsUhCIjqD+txdwpG2so/kJDkD/SF+Cj5+d+VzQXhGCm5Cn6oIW
	 iVkVeRvbpR/bw+Xq5mgVVT3dH/WWtIZ8bSBaKtQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbeL1PgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeL1PgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:36:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D7A20869;
        Fri, 28 Dec 2018 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546011371;
        bh=KNF+WmjO9FVn1kUkZBwLiwALL8fvc5RKsqQbAjIpPkk=;
        h=Date:From:To:Cc:Subject:From;
        b=cjb/qyrQ7usfli+h1bHH9N5EpuDfWVj4n4M4qptm5JV/tT2N5p+dJW4xaTKI8UCLP
         qyksPq7DDidlLGoTE8zNtRF3A8IfzBfUuete75jw0kO6lEyQk8p5CcyJSZWBkj8bND
         5pyAVF6MyR4CwNvDnA3K1dT+rAiRZn6PN18vxT+g=
Date:   Fri, 28 Dec 2018 16:36:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core patches for 4.21-rc1
Message-ID: <20181228153609.GA23789@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.21-rc1

for you to fetch changes up to 16df1456aa858a86f398dbc7d27649eb6662b0cc:

  mm, memory_hotplug: update a comment in unregister_memory() (2018-12-20 16:33:18 +0100)

----------------------------------------------------------------
Driver core patches for 4.21-rc1

Here is the "big" set of driver core patches for 4.21-rc1.

It's not really big, just a number of small changes for some reported
issues, some documentation updates to hopefully make it harder for
people to abuse the driver model, and some other minor cleanups.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Duyck (1):
      driver core: Move async_synchronize_full call

Andy Shevchenko (1):
      driver core: platform: Respect return code of platform_device_register_full()

Bo YU (2):
      kobject: drop unnecessary cast "%llu" for u64
      kobject: Fix warnings in lib/kobject_uevent.c

Dan Carpenter (1):
      mm, memory_hotplug: update a comment in unregister_memory()

Daniel Vetter (1):
      sysfs: Disable lockdep for driver bind/unbind files

David Hildenbrand (1):
      drivers/base/memory.c: Use DEVICE_ATTR_RO and friends

Ezequiel Garcia (1):
      kref/kobject: Improve documentation

Greg Kroah-Hartman (1):
      Merge 4.20-rc5 into driver-core-next

Kaitao cheng (1):
      driver core: Replace simple_strto{l,ul} by kstrtou{l,ul}

Muchun Song (1):
      driver core: Replace simple_strtol by kstrtoint

Peter Rajnoha (1):
      kobject: return error code if writing /sys/.../uevent fails

Radu Rendec (1):
      kernfs: Improve kernfs_notify() poll notification latency

Rafael J. Wysocki (1):
      driver core: Add missing dev->bus->need_parent_lock checks

Randy Dunlap (1):
      driver core: fix comments for device_block_probing()

Yangtao Li (1):
      component: convert to DEFINE_SHOW_ATTRIBUTE

 Documentation/kobject.txt | 10 ++++--
 drivers/base/bus.c        | 19 +++++++----
 drivers/base/component.c  | 12 +------
 drivers/base/core.c       | 32 +++++++++++++------
 drivers/base/dd.c         | 19 ++++++-----
 drivers/base/memory.c     | 81 ++++++++++++++++++++++-------------------------
 drivers/base/platform.c   |  4 +--
 fs/kernfs/file.c          | 23 +++++++-------
 include/linux/kref.h      |  5 +--
 kernel/module.c           |  6 ++--
 lib/kobject.c             |  2 +-
 lib/kobject_uevent.c      |  4 ++-
 12 files changed, 113 insertions(+), 104 deletions(-)
