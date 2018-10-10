Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CA3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6AC2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6AC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJJVut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:50:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeJJVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:50:48 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXpQA-1gBSIF3kzM-00Y75n; Wed, 10 Oct 2018 16:28:16 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXpQA-1gBSIF3kzM-00Y75n; Wed, 10 Oct 2018 16:28:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: avoid unused variable warning
Date:   Wed, 10 Oct 2018 16:27:58 +0200
Message-Id: <20181010142813.1918180-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:2Ddw13HeTrQQBUtKVjTSl/urr2EjV8KBDC1s+JJ7P21ofjDeJZv
 EcjMlb3eMYy7QG0x/alBZL6+fGGdWuY91LiI7DbPBN3NiHbH+fCmvPFWfiiOZZWltERXVfg
 JFH64PH/HxFzsvza5cFZd79z0QFkQ0O2LAFreECxN1yvL3bm6KacX6cTQQB77W+I55OMes2
 rQycT/vW4vaqHRmgFCI9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zq2JKL5SPsE=:zw8u89C2XDlw0s0KYO9iUf
 TkjdKfb5gzT3uTQOxuuFF7KL7SqIphRstwZ/TJDJY9bQIPLxCQHZMFU3F6kz5WQnXoZ3aCm5c
 OwW1r+bqx1rbbeL8nxPzxEc2TZg8ikbM+ia5wBariGQDNgITBopksUrNkDmn+QbFzP3kFiIOe
 PKfy0KF9LhnMqO6argGAPaCG77tLJhbszXeFbI/VsaDiD0jJefLlz3p1oPIDZO16zOTir6cpy
 pnHlKsejUpXenDF2GAy0B44WUM5vRafPdHmEldCpO+lu+RFMAvjmB7Ffd8v/uNipaB1SDiaHn
 /pxQ0JMjpCebd+vOm+bTqT7u8GnNhGbRtsmfuDKHIw+vGB1qzvFAQ689S9b7CYvrxwtRi2Qny
 rhUJT4JrfOmw+yQJ3SlCVMkn9xWLV5ARkhpFIb6PJJhsMtacdOOOjy1W2h1CsQD+AX8fxnt4Y
 XNH34xBi2bGq0ouQpmJ0Ce4GpE+bBDSj1uDHxhIpABifWgJPNFPxkuYNX4ONIHdytuzweJtyF
 NZz7UCKmoIjbx5slUD0BeN40nKC1b+dJ3aGdv0VYctRVJaM0Eruwp7omfesB9iIwG+ZzUvsJ6
 41ICwcm3wnFjn8L7fQAy/wBBf81QodM/AJRRMden3v33JMyeV+8weNFQS5Vdkn3kluosQdU/M
 LfbjnLh/C24CBiTKibCvXhLYwGHfMDx2jXq1CfbY7AgQ+hdc1KyUYfMuo599dep/XAVM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two new variables are only used in an #ifdef, so they cause a
warning without CONFIG_QUOTA:

fs/ext4/super.c: In function 'parse_options':
fs/ext4/super.c:1977:26: error: unused variable 'grp_qf_name' [-Werror=unused-variable]
  char *p, *usr_qf_name, *grp_qf_name;
                          ^~~~~~~~~~~
fs/ext4/super.c:1977:12: error: unused variable 'usr_qf_name' [-Werror=unused-variable]
  char *p, *usr_qf_name, *grp_qf_name;

Fixes: 20cefcdc2040 ("ext4: fix use-after-free race in ext4_remount()'s error path")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e9ca8312457b..d60199510c94 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1974,7 +1974,10 @@ static int parse_options(char *options, struct super_block *sb,
 			 int is_remount)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *p, *usr_qf_name, *grp_qf_name;
+	char *p;
+#ifdef CONFIG_QUOTA
+	char *usr_qf_name, *grp_qf_name;
+#endif
 	substring_t args[MAX_OPT_ARGS];
 	int token;
 
-- 
2.18.0

