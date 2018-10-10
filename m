Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7791EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3C2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB3C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJJVzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:55:44 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJVzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:55:43 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8Qme-1g5rpl2mp6-004QN4; Wed, 10 Oct 2018 16:33:09 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8Qme-1g5rpl2mp6-004QN4; Wed, 10 Oct 2018 16:33:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lianbo Jiang <lijiang@redhat.com>, Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] kdump, proc/vmcore: fix building without CONFIG_ARCH_HAS_MEM_ENCRYPT
Date:   Wed, 10 Oct 2018 16:32:45 +0200
Message-Id: <20181010143306.2051406-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:sIUV+97GrudqYGbBnJuyCQ9m6bGa09gdyaFHCyeBSnNLf0H4KnG
 dOXBTJ377FgjGApQGHr3zkTNErPFgPJU4HKHz+Hf7K93LnUcQgToplKo0W6GHScsOGXS3ya
 kQv9mGg4EGIzaQI6qW3A8csyuhSGK5dm1gzmVMUDW+7FcP2SCIe0Z+pJMs3jpPobsRWUlTp
 6C2xg+T+PzNJVtS9thqKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9T8bIs8l1Jk=:fMxJ3iEpO8t0+DQk9bh0F0
 PWK8PTkEKUQtkiHnMB6gCLAoxkz2qxNCB7DdmVmi5xdh9DjYLwOMtw2UUgMBsBz/+dFOz+3cg
 MVufjxTqA/kF9l1fAwKQn3hr/PJ0o+3XQC0xBYwNZ9UZOkVZ7M5FPjrl2T6SLHII51K+ltoHp
 iFNCYshyd7PkjWfzx8bAjFwaOLMPF5zBG9VFVS4wQVEp27we4Z2O5aL3h+2/7wQJef6eHLisZ
 2L0S101W7ALqajL93AVtxW5UZcXOy9r66Tk21Uv6Dygg7fuCY1vpMjYlUvO/tQJejumjdQyM+
 DeBxTnajdvoZpUolEUZwOTHI93m+QFdk9xoxVgnJpCTe3NtYmDWqekd85RfXKpf0rMxPFbRsc
 a0l7gqCye5WRybK8+mpbV9F0aaAFTIloxjbmqMUfU5NIiva0jnsvRimN09oc4fV+T4V/oXBPm
 YHXSWKLfAdrpp9uokXO1buSvk9K6KunmlLxZJnzUPXP4lK19nlrbtOqahTq/rnL5VFM6026ZV
 wFkh2IR8XKaQHv6xBTyyxrWgy3r759gAur0tLRrb360E2WqF9bm5RoZFewH8wEuq3j4PZRtjl
 71coBAc5vxUyrqrsAivnVSJ5ZDwRQznlZC+qfbluZFZXMUKMcoduwpRkCC1y9kLiaA2j91qCz
 FMF01gJXk20+O1BXZMW6TqsTEps5HL4qcffyjtsNpM35/aDPwH0tr4AOon4jVSNGenoM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a link failure when calling copy_oldmem_page_encrypted()
when the compiler fails to do constant-propagation of the
sme_active() result into read_from_oldmem:

fs/proc/vmcore.o: In function `read_from_oldmem.part.0':
vmcore.c:(.text+0xb7): undefined reference to `copy_oldmem_page_encrypted'

Adding an IS_ENABLED() check means the compiler will always
know when it cannot be enabled.

Fixes: 992b649a3f01 ("kdump, proc/vmcore: Enable kdumping encrypted memory with SME enabled")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There may be a better way of doing this, not sure what kinds
of assumptions we want to make here.
---
 fs/proc/vmcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index d469ce9d8c0c..92e1e520a52d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -123,7 +123,9 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 		if (pfn_is_ram(pfn) == 0)
 			memset(buf, 0, nr_bytes);
 		else {
-			if (encrypted)
+			if (IS_ENABLED(CONFIG_X86_64) &&
+			    IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
+			    encrypted)
 				tmp = copy_oldmem_page_encrypted(pfn, buf,
 								 nr_bytes,
 								 offset,
-- 
2.18.0

