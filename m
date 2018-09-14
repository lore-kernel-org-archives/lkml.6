Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715B6FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6630420861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6630420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeINVkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:40:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeINVkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:40:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75AD4AFB4;
        Fri, 14 Sep 2018 16:25:34 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.19-rc4
Date:   Fri, 14 Sep 2018 18:25:31 +0200
Message-Id: <20180914162531.16740-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.19c-rc4-tag

xen: fixes for 4.19-rc4

It contains some minor cleanups and fixes and:

- a new knob for controlling scrubbing of pages returned by the Xen
  balloon driver to the Xen hypervisor to address a boot performance
  issue seen in large guests booted pre-ballooned

- a fix of a regression in the gntdev driver which made it impossible
  to use fully virtualized guests (HVM guests) with a 4.19 based dom0

- a fix in Xen cpu hotplug functionality which could be triggered by
  wrong admin commands (setting number of active vcpus to 0)

One further note: the patches have all been under test for several days
in another branch. This branch has been rebased in order to avoid merge
conflicts.


Thanks.

Juergen

 .../ABI/stable/sysfs-devices-system-xen_memory     |  9 ++++++++
 Documentation/admin-guide/kernel-parameters.txt    |  6 +++++
 drivers/xen/Kconfig                                | 10 ++++++---
 drivers/xen/cpu_hotplug.c                          | 15 +++++++------
 drivers/xen/events/events_base.c                   |  2 +-
 drivers/xen/gntdev.c                               | 26 +++++++++++++---------
 drivers/xen/manage.c                               |  6 +++--
 drivers/xen/mem-reservation.c                      |  4 ++++
 drivers/xen/xen-balloon.c                          |  3 +++
 include/xen/mem-reservation.h                      |  7 +++---
 10 files changed, 61 insertions(+), 27 deletions(-)

Josh Abraham (1):
      xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Marek Marczykowski-Górecki (1):
      xen/balloon: add runtime control for scrubbing ballooned out pages

Michal Hocko (1):
      xen/gntdev: fix up blockable calls to mn_invl_range_start

Olaf Hering (1):
      xen: avoid crash in disable_hotplug_cpu

Vitaly Kuznetsov (1):
      xen/manage: don't complain about an empty value in control/sysrq node
