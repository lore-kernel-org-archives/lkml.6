Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184B620859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6eZq2/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfAQWBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:01:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46207 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfAQWBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:01:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so5339709ply.13;
        Thu, 17 Jan 2019 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mGFwHTwiNrNJ37mDbThlTGJdz4ynU/m6ZeNIEInEMT4=;
        b=G6eZq2/ggRGY70yN8WH/6PiF6nrV5K5f5TonBE4H4pVBguANmKXxeWLGUKAn852jr1
         yNN2luiV2kdtulYqkAu5cDsDGv7vSC0af5fwkVfrF7DCfARnlyWX6SP4rHpxgLaW5G0k
         cWhC+BVT4eLSHd1+7RY2cX2vBfGY6TWrgnjYFJGw8h2wkCkP6pW5iL14+DcEnSnBCABF
         YGC+nrWTm8qn/iS8/RbVoYzWvKYoRw9+mhoDo/+pIJMxeegD/YbcNFkG7Y8oO7gWivdl
         GvzUYuKLbNXsw23eqgeJsEDqcnr2mzu40SADpfKDp8FU0sa2gnFLrQ2j8/Fupz4RI54x
         PZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mGFwHTwiNrNJ37mDbThlTGJdz4ynU/m6ZeNIEInEMT4=;
        b=Tx6/rNRbjAqxkS/DyqpssO4qXU79tFgOF9qoxzTMNkmgrpju/ETZjeHunI4aOyyjYE
         8Mce4ap6uodYZOCDFq1e7ltsosILoLgKmF2Ph/9mCVKN0GTn8O6xX58OAte7VhNvGoS8
         fodiFxDNyieZ8ikspGXxyDvEtOMLEIP6hPyf1qLw36pSAeaMM5EW32iSsXPE/O8FAjsv
         hDJzQeQVtwz+P+XGpCdQelEr0ZorRqtYkJ6lWLmgvuj3rUtMNEVpiTS0XmmU0NeJDCqs
         PMdXxuP1g2UmQVVzmWNb+9wVIDihwylLR+z9zqO/8UhraadKC/cCVO30YgRqh+TKG5dy
         Bthw==
X-Gm-Message-State: AJcUuke/UvNQjLgZvG8JiTIFRmGgiSfkYT+4oS9XR6tsd2/b2MpblS1y
        2A+44sTuW7HYXbSr5Ue32rQ=
X-Google-Smtp-Source: ALg8bN46FNp6BtGn0xtX7T+7iZQsSYm+yjBFz5y+t5QHara/2IhfdhKgl0ZARt5vHXo7ZMuIVMz/NA==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr16035125pln.224.1547762508833;
        Thu, 17 Jan 2019 14:01:48 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id o4sm8155801pgs.12.2019.01.17.14.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 14:01:48 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH RESEND] of: add dtc annotations functionality to dtx_diff
Date:   Thu, 17 Jan 2019 14:01:14 -0800
Message-Id: <1547762474-7832-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Add -T and --annotations command line arguments to dtx_diff.  These
arguments will be passed through to dtc.  dtc will then add source
location annotations to its output.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

If dtx_diff is provided with a single devicetree source file then
that source file will be compiled, with all appropriate includes
and pre-processing, and the result will be output as source.  This
provides a convenient mechanism to see what the devicetree looks
like after all processing and replacements occur.  The
--annotations argument will cause dtc to report information about
where the source was located for each line of the output.

 scripts/dtc/dtx_diff | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
index 8c4fbad2055e..0d8572008729 100755
--- a/scripts/dtc/dtx_diff
+++ b/scripts/dtc/dtx_diff
@@ -21,6 +21,7 @@ Usage:
         diff DTx_1 and DTx_2
 
 
+      --annotate    synonym for -T
        -f           print full dts in diff (--unified=99999)
        -h           synonym for --help
        -help        synonym for --help
@@ -28,6 +29,7 @@ Usage:
        -s SRCTREE   linux kernel source tree is at path SRCTREE
                         (default is current directory)
        -S           linux kernel source tree is at root of current git repo
+       -T           Annotate output .dts with input source file and line (-T -T for more details)
        -u           unsorted, do not sort DTx
 
 
@@ -174,6 +176,7 @@ compile_to_dts() {
 
 # -----  start of script
 
+annotate=""
 cmd_diff=0
 diff_flags="-u"
 dtx_file_1=""
@@ -208,6 +211,14 @@ while [ $# -gt 0 ] ; do
 		shift
 		;;
 
+	-T | --annotate )
+		if [ "${annotate}"  = "" ] ; then
+			annotate="-T"
+		elif [ "${annotate}"  = "-T" ] ; then
+			annotate="-T -T"
+		fi
+		shift
+		;;
 	-u )
 		dtc_sort=""
 		shift
@@ -327,7 +338,7 @@ cpp_flags="\
 DTC="\
 	${DTC}                                     \
 	-i ${srctree}/scripts/dtc/include-prefixes \
-	-O dts -qq -f ${dtc_sort} -o -"
+	-O dts -qq -f ${dtc_sort} ${annotate} -o -"
 
 
 # -----  do the diff or decompile
-- 
Frank Rowand <frank.rowand@sony.com>

