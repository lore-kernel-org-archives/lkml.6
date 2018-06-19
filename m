Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE8C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CF320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CF320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTGPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:15:20 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:14595 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751579AbeFTGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:15:16 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 Jun 2018 23:14:41 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 797BEB0C12;
        Tue, 19 Jun 2018 23:15:15 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 0/7] vmw_balloon: addressing bugs and issues
Date:   Tue, 19 Jun 2018 16:00:23 -0700
Message-ID: <20180619230030.112906-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of these patches are intended for 4.18:

- Patches 1-5 are bug fixes.
- Patch 6 changes the GPL comment. It is actually required just to
  remove the maintainers list from the source file (since it has
  changed).
- Patch 7 is an update to the maintainer list.


This patch-set addresses minor issues and bugs in the VMware balloon
driver. Patches 1-5 address bugs that were *not* reported by customers,
but we would like to get them to 4.18 if possible.

Patches 1-4 are cc'd to stable. Patch 5 might be too big to be
considered for stable.

We will send separately later a patch-set with new features to be set on
top of this set, which will be intended for 4.19.

v2->v3:	* Removing empty lines (Greg)
	* Removing the GPL message entirely (Greg)

v1->v2:	* Reordering patches to have bug fixes first (Greg)
	* Fixing SPDX tag
	* Cc'ing stable when appropriate

Nadav Amit (7):
  vmw_balloon: fix inflation of 64-bit GFNs
  vmw_balloon: do not use 2MB without batching
  vmw_balloon: VMCI_DOORBELL_SET does not check status
  vmw_balloon: fix VMCI use when balloon built into kernel
  vmw_balloon: remove inflation rate limiting
  vmw_balloon: update copyright message
  vmw_balloon: update maintainers list

 MAINTAINERS                |   2 +-
 drivers/misc/vmw_balloon.c | 181 +++++++++++--------------------------
 2 files changed, 55 insertions(+), 128 deletions(-)

-- 
2.17.0

