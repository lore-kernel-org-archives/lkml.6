Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56431C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCB72450D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCB72450D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934426AbeFZJue (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:50:34 -0400
Received: from osg.samsung.com ([64.30.133.232]:50565 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934194AbeFZJtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:49:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 11C0E30BC4;
        Tue, 26 Jun 2018 02:49:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d1R8S4fih8D9; Tue, 26 Jun 2018 02:49:19 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id B7A7730B90;
        Tue, 26 Jun 2018 02:49:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkb4-0000li-03; Tue, 26 Jun 2018 06:49:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 1/9] scripts/documentation-file-ref-check: remove some false positives
Date:   Tue, 26 Jun 2018 06:49:03 -0300
Message-Id: <6ef23af10506e6491e0d9184b709aa1ea0201cfd.1530005114.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several false positives at tcm_mod_builder.txt:

    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000/tcm_nab5000_base.h
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../include/target/target_core_fabric_ops.h
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000/tcm_nab5000_fabric.c
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000/tcm_nab5000_fabric.h
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000/tcm_nab5000_configfs.c
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000/Kbuild
    Documentation/target/tcm_mod_builder.txt: mnt/sdb/lio-core-2.6.git/Documentation/target/../../drivers/target/tcm_nab5000/Kconfig

Ignore them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 078999a3fdff..857eb0d7458d 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -75,6 +75,9 @@ while (<IN>) {
 		# Remove URL false-positives
 		next if ($fulref =~ m/^http/);
 
+		# Discard some build examples from Documentation/target/tcm_mod_builder.txt
+		next if ($fulref =~ m,mnt/sdb/lio-core-2.6.git/Documentation/target,);
+
 		# Check if exists, evaluating wildcards
 		next if (grep -e, glob("$ref $fulref"));
 
-- 
2.17.1

