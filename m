Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tAM9KRIEGlvkeQAAmS7hNA
	; Fri, 08 Jun 2018 04:20:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97BBB606FA; Fri,  8 Jun 2018 04:20:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2016D60275;
	Fri,  8 Jun 2018 04:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2016D60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbeFHEUc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:20:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:49997 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeFHEUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:20:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07F0EAC88;
        Fri,  8 Jun 2018 04:20:29 +0000 (UTC)
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes and features for v4-18-rc1
Date: Fri,  8 Jun 2018 06:20:28 +0200
Message-Id: <20180608042028.16411-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.18-rc1-tag

xen: fixes and features for v4-18-rc1

It contains some minor code cleanups (fixing return types of functions),
some fixes for Linux running as Xen PVH guest, and adding of a new
guest resource mapping feature for Xen tools.


Thanks.

Juergen

 arch/arm/xen/enlighten.c          |  11 ++++
 arch/x86/xen/mmu.c                |  60 ++++++++++++-----
 arch/x86/xen/xen-pvh.S            |  47 ++++++++++---
 drivers/net/xen-netfront.c        |   2 +-
 drivers/xen/privcmd.c             | 135 +++++++++++++++++++++++++++++++++++++-
 drivers/xen/xenbus/xenbus_probe.c |   5 +-
 include/uapi/xen/privcmd.h        |  11 ++++
 include/xen/interface/memory.h    |  66 +++++++++++++++++++
 include/xen/interface/xen.h       |   7 +-
 include/xen/xen-ops.h             |  24 ++++++-
 10 files changed, 332 insertions(+), 36 deletions(-)

Boris Ostrovsky (2):
      xen/PVH: Set up GS segment for stack canary
      xen/PVH: Make GDT selectors PVH-specific

Luc Van Oostenryck (1):
      xen-netfront: fix xennet_start_xmit()'s return type

Paul Durrant (1):
      xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE

Roger Pau Monne (1):
      xen/store: do not store local values in xen_start_info

Souptick Joarder (1):
      xen: Change return type to vm_fault_t
