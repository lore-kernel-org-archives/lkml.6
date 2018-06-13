Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D561C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C357208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C357208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935617AbeFMSS6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:18:58 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13031 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935315AbeFMSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:18:55 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 11:18:29 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 642184099E;
        Wed, 13 Jun 2018 11:18:54 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 0/7] vmw_balloon: addressing bugs and issues
Date:   Wed, 13 Jun 2018 04:03:52 -0700
Message-ID: <20180613110359.109033-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set addresses minor issues and bugs in the VMware balloon
driver. Patches 3-7 address bugs that were not reported by customers,
but we would like to get them to 4.18 if possible.

We will send separately later a patch-set with new features to be set on
top of this set. 

Nadav Amit (7):
  vmw_balloon: update copyright message
  vmw_balloon: update maintainers list
  vmw_balloon: fix inflation of 64-bit GFNs
  vmw_balloon: do not use 2MB without batching
  vmw_balloon: VMCI_DOORBELL_SET does not check status
  vmw_balloon: fix VMCI use when balloon built into kernel
  vmw_balloon: remove inflation rate limiting

 MAINTAINERS                |   2 +-
 drivers/misc/vmw_balloon.c | 167 ++++++++++++-------------------------
 2 files changed, 56 insertions(+), 113 deletions(-)

-- 
2.17.0

