Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541E720862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIys24FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541E720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeKZWzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:55:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42785 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeKZWzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:55:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so13767401pln.9;
        Mon, 26 Nov 2018 04:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=otYbq0C9LVqp27elVROsGPtmHiho10hG3fe3tncFiVU=;
        b=OIys24FNf70xWYrzu/YZdIPresKoHAK37iPkHMg2p9DZA94CTZL3QIUC5D0U1P8jE+
         vBs9iEhHTArO651EfqLzKW5YnEy88W8oVJmMWSOpzEhKQczUnen/ihCsw5gWdDgELvIx
         l7HDQ6fCZnuVWa0SmNm91POx1bQqWCsIJR6s5Q4fkXR94KxDochfmywX//q2x+zwGFjr
         E6QgkRpFHRhza2hx6hhe8vq5xGzVorKCNf1wKzyYl3hLPOGrdty7JVhVSbuL3LBkEPP0
         8FdS5LYSF5zYvBBUN2kKaH33P2YpvxMenTnI9Xe607DUjzjl0dMorwMqp9hy4+E37kQe
         Gw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=otYbq0C9LVqp27elVROsGPtmHiho10hG3fe3tncFiVU=;
        b=RlDPrf81adb+OC0K+s0Fw4X3uP/lGiGzYtqQuA1YGwLOwndLpIdeD+MtfXkWTWCPnt
         lTJ4rB1SrjRqRRVr18w5Yl5Z0M+AkpltKqlBJn+ny44QFMdtceaUWsFognYOd+NLmUgy
         f1/n0ilyX5jKcHGyqUTbkKl8xCtqEa4HsamYelKEXxv7IuAa8Mvpq6RVssKcLTQIM++v
         K9vW+d0zv5c8lFX430PLmJmNKjmFJ0b1AOuKlD0641cwB+0+ErqUjJ9fMUQPXd3tB6CC
         UcwtszHkFJP9iKf8WrJbF+uPho2wfDnYL4gylUPI4y2o0xE7iXm9EpHAYEgzt0fED4Lj
         4sUA==
X-Gm-Message-State: AA+aEWaGzL007nrqBf57IXNWB8pKzVKVa61XZt/dPQibSAHOpXgoqMsa
        ExadIXr7dKnp2yZe6cZg3ttBI627
X-Google-Smtp-Source: AFSGD/U8TTkQtKaDAPDsZBvgeHrwrJwAeVklW9+OyPOI2Ib0e344uLSpvNpP1E8cnh8C1lpatPRpdw==
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr27122536plb.24.1543233682079;
        Mon, 26 Nov 2018 04:01:22 -0800 (PST)
Received: from localhost.localdomain ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id h64sm146219pfj.186.2018.11.26.04.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 04:01:21 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] of: add dtc annotations functionality to dtx_diff
Date:   Mon, 26 Nov 2018 04:01:09 -0800
Message-Id: <1543233669-8696-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 2.7.4
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

This feature depends upon commit 5667e7ef9a9a ("annotations: add the
annotation functionality") in the dtc git repository.  To use the
new flags before the new version of dtc is imported to the linux
kernel, download the dtc repository, compile dtc with the make command,
then add the path of the dtc repository to the shell PATH variable.

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

