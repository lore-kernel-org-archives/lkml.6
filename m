Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6FAC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F8B2070C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THHsl9Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAERIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:08:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45882 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfAERIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:08:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so27427735lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLPa3xKGpW8/0FX3x95ylh5RgDcDPow8i/xa7be4nHU=;
        b=THHsl9DwKuz/1KlAQQgK0rJ38kcB9mnjyLIvISX8puNZLqVJwGYUV3NPBuytA8JQab
         JkPrN+Zd9BjFDW0KE1DmpHrG0hYKNRx77gY+/RqGdpTEIfyinsOUlsmB2JN+gfRthHL/
         D9a5wTSdX0PrA5Z7JTUi+8KKLUdDrx1DYNTj+vJOzx5DJ7vMDJH/QxscURmrhseUxsK1
         mSEL/Q2EkolnkdHZMjZInqIbqWhDRQm5spVy6NkCoeH91EQV14a9n35KLezFo0NBjrW6
         +ksZ69UBYN3iPv6+WpBiU1lP6AjrKtg6QjaALKP4sP/5lE57c/fhCr3yzsnO/ZFAm7nW
         nRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLPa3xKGpW8/0FX3x95ylh5RgDcDPow8i/xa7be4nHU=;
        b=rYfqGVp3knEUgtuC7KytY9Ix+rc66BmwIA0aiMLrPxaYg7G2o1/CBdvIfGFp1Sf91i
         woP2xDnIzDSmkhpWvOh6SMYPcx/JX4e3H4iN8+vdmTGGDoBz7ao5fW3GxQGbAZOEBFfC
         c4/ZnT6qa+GcCh31OVajTLDxUptlRVGV0qiXcCe3e6qMtRgte5AJHbFzQRcIiX3iCyyk
         g/Ioaniww6VvH/jFPu5vQoKEo7hK87CWIlyC1awOlVUgU9a/yKWbg/lkpBUTkdfbOM32
         rPp/RyMm0h8w1AHx8IzPyzn8h9MyqZKevvh9phkfqpzSRQAJ0L0hA5txVfBKrEzf5qho
         vhtA==
X-Gm-Message-State: AA+aEWbrsaDxPVEi4WVpSvcUGTSLKtHcLIqeHUIW3NTBP6/LKZG4chdu
        EGxH1ES+FjO9BWvCzVvMDuIVZGCr
X-Google-Smtp-Source: AFSGD/XZCL27/onqsrN/WPRoM0zAH6dl2gxbMRm7oaXMvMl3moLoIr4sz2SUp+Lm13R94Ti4grNaJQ==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr29748906lfd.9.1546708117729;
        Sat, 05 Jan 2019 09:08:37 -0800 (PST)
Received: from pc-sasha.localdomain (78-25-2-156.static.vega-ua.net. [78.25.2.156])
        by smtp.gmail.com with ESMTPSA id j9sm8825lfk.74.2019.01.05.09.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 09:08:36 -0800 (PST)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, alexander.kapshuk@gmail.com
Subject: [PATCH] ver_linux: Assign constant RE to variable name for clarity
Date:   Sat,  5 Jan 2019 19:09:23 +0200
Message-Id: <20190105170923.6424-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regular expression that matches the version number of a utility
being queried is used as a constant expression in the current
implementation. Assigning the RE in question to a variable gives it a
meaningful name that clearly expresses the intended use of the expression
without having to think about the details of implementation.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 scripts/ver_linux | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index a6c728db05ce..810e608baa24 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -13,6 +13,8 @@ BEGIN {
 	system("uname -a")
 	printf("\n")
 
+	vernum = "[0-9]+([.]?[0-9]+)+"
+
 	printversion("GNU C", version("gcc -dumpversion"))
 	printversion("GNU Make", version("make --version"))
 	printversion("Binutils", version("ld -v"))
@@ -34,7 +36,7 @@ BEGIN {
 	while (getline <"/proc/self/maps" > 0) {
 		if (/libc.*\.so$/) {
 			n = split($0, procmaps, "/")
-			if (match(procmaps[n], /[0-9]+([.]?[0-9]+)+/)) {
+			if (match(procmaps[n], vernum)) {
 				ver = substr(procmaps[n], RSTART, RLENGTH)
 				printversion("Linux C Library", ver)
 				break
@@ -70,7 +72,7 @@ BEGIN {
 function version(cmd,    ver) {
 	cmd = cmd " 2>&1"
 	while (cmd | getline > 0) {
-		if (match($0, /[0-9]+([.]?[0-9]+)+/)) {
+		if (match($0, vernum)) {
 			ver = substr($0, RSTART, RLENGTH)
 			break
 		}
-- 
2.20.1

