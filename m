Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D94C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A873E21874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JDI7wunY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfAEIJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:09:18 -0500
Received: from m12-17.163.com ([220.181.12.17]:33382 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfAEIJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4VaFiFqOkgWJdHA7QR
        iSfEpKWikzmJwZ/RmE87/NYN4=; b=JDI7wunYZRQ8e1EtGYNr3BckdGkk7mMHih
        MHULJsUGV/YPwq9VGWr5ixh0CwaPWMBrRP1cKo/7vuA0g3NO5YTJBetU0HGcc7C+
        KDT2EiGLTiRYfkzf64KCopAtsVaA5LLNUpzm6W0qR+YgMX0gHPKqdYrvAo2zuEep
        i4x8raZdc=
Received: from localhost.localdomain.localdomain (unknown [36.102.4.74])
        by smtp13 (Coremail) with SMTP id EcCowAAHPHgSZjBcv9QcCQ--.13624S2;
        Sat, 05 Jan 2019 16:08:51 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH] ACPI/nfit: delete the function to_acpi_nfit_desc
Date:   Sat,  5 Jan 2019 16:08:37 +0800
Message-Id: <1546675718-31174-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: EcCowAAHPHgSZjBcv9QcCQ--.13624S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUf6wZUUUUU
X-Originating-IP: [36.102.4.74]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbiNhczQFWBc2RLZwACs-
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

The function to_acpi_nfit_desc and function to_acpi_desc
do the same things,So delete the function to_acpi_nfit_desc,
and keep the inline function to_acpi_desc.

The calling function to_acpi_nfit_desc,have been changed 
to the calling function to_acpi_desc.

Xiaochun Lee (1):
  ACPI/nfit: delete the function to_acpi_nfit_desc

 drivers/acpi/nfit/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
1.8.3.1


