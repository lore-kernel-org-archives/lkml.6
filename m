Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB10C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7E7206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7E7206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeI2EQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:16:38 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:40453 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725266AbeI2EQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:16:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AE9E4182CED5B;
        Fri, 28 Sep 2018 21:50:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cord13_424602b389563
X-Filterd-Recvd-Size: 2708
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:50:55 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Bad MAINTAINERS pattern in section 'ACPI'
Date:   Fri, 28 Sep 2018 14:50:53 -0700
Message-Id: <20180928215054.28561-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	308	ACPI
	309	M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
	310	M:	Len Brown <lenb@kernel.org>
	311	L:	linux-acpi@vger.kernel.org
	312	W:	https://01.org/linux-acpi
	313	Q:	https://patchwork.kernel.org/project/linux-acpi/list/
	314	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
	315	B:	https://bugzilla.kernel.org
	316	S:	Supported
	317	F:	drivers/acpi/
	318	F:	drivers/pnp/pnpacpi/
	319	F:	include/linux/acpi.h
	320	F:	include/linux/fwnode.h
	321	F:	include/acpi/
	322	F:	Documentation/acpi/
	323	F:	Documentation/ABI/testing/sysfs-bus-acpi
	324	F:	Documentation/ABI/testing/configfs-acpi
	325	F:	drivers/pci/*acpi*
	326	F:	drivers/pci/*/*acpi*
-->	327	F:	drivers/pci/*/*/*acpi*
	328	F:	tools/power/acpi/

Commit that introduced this:

commit 15fd830dd310e6cf589478e5e1e7733caf68e777
 Author: Bjorn Helgaas <bhelgaas@google.com>
 Date:   Wed Jun 26 13:38:37 2013 -0600
 
     MAINTAINERS: Add ACPI folks for ACPI-related things under drivers/pci
     
     Add file patterns so get_maintainers.pl reports both PCI and ACPI folks
     for ACPI-related things in drivers/pci.
     
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
  MAINTAINERS | 3 +++
  1 file changed, 3 insertions(+)

Last commit with drivers/pci/*/*/*acpi*

commit 256a459370930bed087f92bb763517f8b09407eb
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jun 8 08:39:45 2018 -0500

    PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
    
    Squash aerdrv_acpi.c into aerdrv.c.  No functional change intended.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Keith Busch <keith.busch@intel.com>

 drivers/pci/pcie/aer/Makefile      |   1 -
 drivers/pci/pcie/aer/aerdrv.c      | 122 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv_acpi.c | 141 -------------------------------------
 3 files changed, 122 insertions(+), 142 deletions(-)
