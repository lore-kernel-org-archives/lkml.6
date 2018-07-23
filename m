Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FC920671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FC920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbeGWX1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbeGWX1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9214F308625E;
        Mon, 23 Jul 2018 22:24:17 +0000 (UTC)
Received: from gimli.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AEA086EF4;
        Mon, 23 Jul 2018 22:24:14 +0000 (UTC)
Subject: [PATCH 0/2] PCI: NVMe reset quirk
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Mon, 23 Jul 2018 16:24:14 -0600
Message-ID: <20180723221533.4371.90064.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 23 Jul 2018 22:24:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in the 2nd patch, at least one NVMe controller sometimes
doesn't like being reset while enabled and another will timeout during
a subsequent re-enable if it happens too quickly after reset.
Introduce a device specific reset quirk for all NVMe class devices so
that we can try to get reliable behavior from them for device
assignment and any other users of the PCI subsystem reset interface.

Patches against current PCI next branch.  Thanks,

Alex

---

Alex Williamson (2):
      PCI: Export pcie_has_flr()
      PCI: NVMe device specific reset quirk


 drivers/pci/pci.c    |    3 +
 drivers/pci/quirks.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 
 3 files changed, 115 insertions(+), 1 deletion(-)
