Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA882081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfBFX5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:57:14 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:7669 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbfBFX5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:57:13 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 6 Feb 2019 15:56:24 -0800
Received: from ubuntu.localdomain (unknown [10.33.115.182])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 87F0C40FB0;
        Wed,  6 Feb 2019 15:57:11 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>,
        Nadav Amit <namit@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, <linux-mm@kvack.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH 0/6] vmw_balloon: 64-bit limit support, compaction, shrinker
Date:   Wed, 6 Feb 2019 15:57:00 -0800
Message-ID: <20190206235706.4851-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various enhancements for VMware balloon, some of which are remainder
from a previous patch-set.

Patch 1: Drop the version number
Patch 2: Adds support for 64-bit memory limit
Patches 3-4: Support for compaction
Patch 5: Support for memory shrinker - disabled by default
Patch 6: Split refused pages to improve performance

This is sort of a resend, since patches 2-6 have not been sent (the mail
server rejected since Xavier, whose email address was deactivated, was
mistakenly cc'd). Patch 1 was changed according to Greg's feedback.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: linux-mm@kvack.org
Cc: virtualization@lists.linux-foundation.org

Nadav Amit (5):
  vmw_balloon: remove the version number
  mm/balloon_compaction: list interfaces
  vmw_balloon: compaction support
  vmw_balloon: add memory shrinker
  vmw_balloon: split refused pages

Xavier Deguillard (1):
  vmw_balloon: support 64-bit memory limit

 drivers/misc/Kconfig               |   1 +
 drivers/misc/vmw_balloon.c         | 510 ++++++++++++++++++++++++++---
 include/linux/balloon_compaction.h |   4 +
 mm/balloon_compaction.c            | 139 +++++---
 4 files changed, 565 insertions(+), 89 deletions(-)

-- 
2.17.1

