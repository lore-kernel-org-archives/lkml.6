Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D77C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBC1214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dALIpecy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBC1214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJQKaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:30:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45635 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeJQKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:30:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so11757287pgd.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 19:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zo+uTcaLv2tMz+5Q+UWNd2ScdrGHG0OABhpM3/RdxD4=;
        b=dALIpecy0DnNzOi9CGPcUIzrk4j6qDDwBagmkAm/beBkfeL99n+s5v2ZrQk3SZlJvM
         svXtXUf87iZOofjWmmWiuRFQM4+nvOb1A5b66EXBWgbB3W1rru1hCFq2WcMbt6L/Imcb
         RPCNlZwiUoz77D+9tX2q8qR0aqkijWED+iqOXMo1Eh21THbhO3IGrbgKEkcLofrlirwg
         FDLLRYoi43ejjIpd9sWcPgadXCq2roZnnrrhPeB2qgeVNzsnwopPW83o72hmNt5eCXzq
         43Vl+2vt5rbHB2RNseD91GkmEfSuhy87gtyN9Ukp1NgcB22cOvei+MzjqGOAg+7x6i3a
         I21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zo+uTcaLv2tMz+5Q+UWNd2ScdrGHG0OABhpM3/RdxD4=;
        b=OHyAwgrRRmd+p8AxSlxBtJbriDAdtz5NnXZEMbQtPk4k2zQisGbX2FB0jp7x2UEXmJ
         /74mZGJt8c0YdEs6VLxrLjYLhXgSN73EpwJPwum1lHaoTKIGjkhcGNFmEGawyIAViI1c
         TIH48uAJn+Rvjhqd8IflvXQnXx/IoXYbqbvLisqQfnyLvhorP+M4AUItrAIlYyt5+/f4
         /6i7uPsdGk3+a0Ku6Ot26Txusm87V04KnUtyVN/iIWNpL7g5hiQgdwbGq/FQTs7zXdG6
         b29vGW6XEYmC8stIOzfpb1nH/+0iJTzCbSTEZf4wXdg7oOTDY6f21S+/LtJ90DqeA6fE
         DyOA==
X-Gm-Message-State: ABuFfohjUfy83B+ZxqUzj4Px0m5pMnKwLZWKXG5GBtrCuIv0Rgi7rLRX
        ccgH0xNx3Rtzxug1yT92+ao=
X-Google-Smtp-Source: ACcGV63Kxd0g6Rg5N9myb9eajvwM5nC0V69KBH15iR/Iq28gSAg2Igqih2GA0M3MkEVVmh+Z9s31ag==
X-Received: by 2002:a62:204a:: with SMTP id g71-v6mr24651840pfg.70.1539743816091;
        Tue, 16 Oct 2018 19:36:56 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id a14-v6sm18460079pgi.75.2018.10.16.19.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 19:36:55 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Du Changbin <changbin.du@gmail.com>
Subject: [PATCH] scripts/gdb: fix lx-version for gdb 7.3-
Date:   Wed, 17 Oct 2018 02:36:52 +0000
Message-Id: <20181017023652.6867-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gdb version less than 7.3, lx-version only one character.
(gdb) lx-version
L(gdb)

This can be fixed by casting 'linux_banner' as (char *).
(gdb) lx-version
Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018

gdb 7.4 seems to be no such issue.

Signed-off-by: Du Changbin <changbin.du@gmail.com>
---
 scripts/gdb/linux/proc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 086d27223c0c..0aebd7565b03 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -41,7 +41,7 @@ class LxVersion(gdb.Command):
 
     def invoke(self, arg, from_tty):
         # linux_banner should contain a newline
-        gdb.write(gdb.parse_and_eval("linux_banner").string())
+        gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
 
 LxVersion()
 
-- 
2.17.1

