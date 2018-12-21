Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0510DC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE6921907
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378895;
	bh=oj5I8bS5Or8V5NX5hkVnrC3sZ7uuuKb+2k2HuCVm1JU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TdX27YEXqX/r+vye9s89/BS12+uqe1CiaX7E+MeYv2sMPIxeyfH4W0huuX3ukrkmg
	 quZfZ+UUyBmaHSxSlRdIQrsIYAdvDVfV62RSyCvjzjhf7E2TX8ddXZPOE9DrE2wTDK
	 xmLLCnsjRfLwoS3+ali+dB7JTjgy/t1Ibv6jM5hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeLUHyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbeLUHyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:54:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B375E21909;
        Fri, 21 Dec 2018 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378891;
        bh=oj5I8bS5Or8V5NX5hkVnrC3sZ7uuuKb+2k2HuCVm1JU=;
        h=From:To:Cc:Subject:Date:From;
        b=lObh48NIbos/60g0PTn6q+NriMCfcutB5Ozn9Tq6N+dm9wZbUL0X4b/uO08r7ghFh
         CMYUEWO24sYIOlblh6MlDHsTh5ukl1ZrVc80/wOne06Zj6Y5sdkuB4p4GzEFmKXZpv
         jTvzbBrsmC/3RUrQ9tXiSu4ejvMBlH33HtjFVoNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Elder <elder@kernel.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, Sage Weil <sage@redhat.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 00/10] Driver core: remove BUS_ATTR()
Date:   Fri, 21 Dec 2018 08:54:32 +0100
Message-Id: <20181221075442.17109-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to get rid of the need to specify any sysfs mode
attributes, let's get rid of BUS_ATTR() and move the few remaining users
of it over to use the "read write" and "write only" versions of the
macro.

Greg Kroah-Hartman (10):
  PCI: pci.c: convert to use BUS_ATTR_RW
  PCI: pci-sysfs.c: convert to use BUS_ATTR_WO
  SCSI: fcoe: convert to use BUS_ATTR_WO
  pseries: ibmebus.c: convert to use BUS_ATTR_WO
  rapidio: rio-sysfs.c: convert to use BUS_ATTR_WO
  block: rbd: convert to use BUS_ATTR_WO and RO
  driver core: bus: convert to use BUS_ATTR_WO and RW
  Documentation: driver core: remove use of BUS_ATTR
  driver core: drop use of BUS_ATTR()
  driver core: remove BUS_ATTR()

 Documentation/driver-model/bus.txt       |  8 ++---
 Documentation/filesystems/sysfs.txt      |  4 ++-
 arch/powerpc/platforms/pseries/ibmebus.c | 10 +++---
 drivers/base/bus.c                       | 20 +++++++----
 drivers/block/rbd.c                      | 45 ++++++++++--------------
 drivers/pci/pci-sysfs.c                  |  5 ++-
 drivers/pci/pci.c                        |  7 ++--
 drivers/rapidio/rio-sysfs.c              |  5 ++-
 drivers/scsi/fcoe/fcoe_sysfs.c           |  4 +--
 drivers/scsi/fcoe/fcoe_transport.c       |  7 ++--
 include/linux/device.h                   |  2 --
 include/scsi/libfcoe.h                   |  6 ++--
 12 files changed, 56 insertions(+), 67 deletions(-)

-- 
2.20.1

