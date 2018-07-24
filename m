Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C42720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C42720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbeGXBQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:16:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388132AbeGXBQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 355A6308123F;
        Tue, 24 Jul 2018 00:12:57 +0000 (UTC)
Received: from gimli.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86A6A608F3;
        Tue, 24 Jul 2018 00:12:54 +0000 (UTC)
Subject: [PATCH v2 0/2] PCI: NVMe reset quirk
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Mon, 23 Jul 2018 18:12:54 -0600
Message-ID: <20180724000944.7671.64284.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 24 Jul 2018 00:12:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Add bug link, use Samsung vendor ID, add spec references

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
 drivers/pci/quirks.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 
 3 files changed, 121 insertions(+), 1 deletion(-)
