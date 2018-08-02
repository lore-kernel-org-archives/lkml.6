Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8681921501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="QoP0SQU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8681921501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbeHBPjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:39:02 -0400
Received: from services.gouders.net ([141.101.32.176]:40543 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbeHBPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:39:01 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w72DlNTF022507
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 2 Aug 2018 15:47:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1533217654; bh=6doC/sd8l061rczdxawkStAjUXxwr9ImfRsYfXGRZFw=;
        h=From:To:Cc:Subject:Date;
        b=QoP0SQU1t3IiniOneepEYhfWSD6R4H5rZ+E6pC4i6aLt9NIF7uNi/7HpbgM5deA6B
         wiZpfmzdfvlpnFNWLDPMiiTkyAn45Zxo2oKPU0MrsV2O9Rj4uiulFC3YiAmDTj0tKf
         SmkQpSLBfQDm+YVIs8VxOev74Z2T9Q11uPV8R898=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Dirk Gouders <dirk@gouders.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Kbuild: Makefile.modbuiltin: include auto.conf and tristate.conf mandatory
Date:   Thu,  2 Aug 2018 15:47:08 +0200
Message-Id: <20180802134708.26456-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files auto.conf and tristate.conf are mandatory for building
modules.builtin files, therefore include them as such.

Usually, the top-level Makefile ensures that those files exist but we
want to make sure we get noticed if they are missing for whatever
reason.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 scripts/Makefile.modbuiltin | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
index 40867a41615b..a072a4267746 100644
--- a/scripts/Makefile.modbuiltin
+++ b/scripts/Makefile.modbuiltin
@@ -8,10 +8,10 @@ src := $(obj)
 PHONY := __modbuiltin
 __modbuiltin:
 
--include include/config/auto.conf
+include include/config/auto.conf
 # tristate.conf sets tristate variables to uppercase 'Y' or 'M'
 # That way, we get the list of built-in modules in obj-Y
--include include/config/tristate.conf
+include include/config/tristate.conf
 
 include scripts/Kbuild.include
 
-- 
2.16.4

