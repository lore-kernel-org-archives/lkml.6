Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5B22082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5B22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJ3Qgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:36:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbeJ3Qgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:36:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4203ACE5;
        Tue, 30 Oct 2018 07:44:20 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.20-rc1
Date:   Tue, 30 Oct 2018 08:44:20 +0100
Message-Id: <20181030074420.17905-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.20a-rc1-tag

xen: fixes for 4.20-rc1

It contains only several small fixes and cleanups this time.


Thanks.

Juergen

 MAINTAINERS                        |  1 +
 arch/x86/xen/platform-pci-unplug.c |  4 ++++
 arch/x86/xen/spinlock.c            | 33 ++++++++++++---------------------
 arch/x86/xen/xen-pvh.S             |  2 +-
 drivers/xen/Kconfig                | 13 ++-----------
 drivers/xen/xen-balloon.c          | 13 ++++++++-----
 drivers/xen/xenbus/xenbus_client.c |  6 ++----
 7 files changed, 30 insertions(+), 42 deletions(-)

Bartlomiej Zolnierkiewicz (1):
      xen: remove redundant 'default n' from Kconfig

Boris Ostrovsky (1):
      xen/balloon: Support xend-based toolstack

Geert Uytterhoeven (1):
      xen/balloon: Grammar s/Is it/It is/

Jason Andryuk (1):
      xen: Make XEN_BACKEND selectable by DomU

Juergen Gross (4):
      xen: fix race in xen_qlock_wait()
      xen: make xen_qlock_wait() nestable
      xen/pvh: don't try to unplug emulated devices
      xen: drop writing error messages to xenstore

Roger Pau Monne (1):
      xen/pvh: increase early stack size

Stefano Stabellini (1):
      add myself as reviewer for Xen support in Linux
