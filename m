Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538CEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E144421501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kg21ZREk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E144421501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbeHBMdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:33:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55377 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731938AbeHBMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:33:00 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180802104223epoutp022d6dd129a3007c23cf64f98175ce0b35~HCzpty1ox2739427394epoutp02H
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 10:42:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180802104223epoutp022d6dd129a3007c23cf64f98175ce0b35~HCzpty1ox2739427394epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533206543;
        bh=Id4jwfz0q9isMi9biP7BRMmBaBZoQPc4/jgv8eLGMSk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kg21ZREkuEQgvcoUdm1wCp+fJ5PXi3HjwAtXes6nZlzlBF1R42CZhVhWLAKwptVq8
         Qat+LnfqviwUnGoVt5O0ISLMP3kVRl3lOgg/NxxOO/Y7gJ5+bBlVd4XAk7r7EL9Tfc
         GP/USTMg3s8Q1ZfA2xY878jksnQu8ULH/Ms/sbs4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.194]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20180802104223epcas5p1e8b115131b504228e67f9c2502ffbdfc~HCzpO6sXm2544725447epcas5p1x;
        Thu,  2 Aug 2018 10:42:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.C0.04304.F00E26B5; Thu,  2 Aug 2018 19:42:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0~HCuTv0d7l2131721317epcas5p4u;
        Thu,  2 Aug 2018 10:36:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180802103616epsmtrp12b664f70b8e33259f1d83c5321d8ca72~HCuTuWgDJ3158831588epsmtrp1W;
        Thu,  2 Aug 2018 10:36:16 +0000 (GMT)
X-AuditID: b6c32a4b-221ff700000010d0-50-5b62e00f1fa6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.BB.03759.0AED26B5; Thu,  2 Aug 2018 19:36:16 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180802103614epsmtip21aeee95e8a78119d4071356c6daf4bfb~HCuR6Btw80115701157epsmtip2U;
        Thu,  2 Aug 2018 10:36:14 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     davem@davemloft.net, shuahkh@osg.samsung.com
Cc:     netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] selftest/net: fix FILE_SIZE for 32 bit architecture.
Date:   Thu,  2 Aug 2018 16:01:36 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmhi7/g6Rog6XPuCwu7k61mHO+hcXi
        6bFH7Babv3ewWVzeNYfN4vD8NhaLYwvELO692cpkMfXLBxaLQyfnMjpweWxZeZPJY8GmUo8t
        /XfZPfq2rGL0+LxJLoA1KtUmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrShoZGeoYG5npERkDaN
        tTIyBSpJSM1Ycv05e8F6noptEz4wNTC+5+xi5OSQEDCROHjnLVsXIxeHkMBuRomDKyazQDif
        GCXeNixlhHC+MUr8Xr6WEably/oPrBCJvYwSu58/har6wijR/LIRrIpNQE9i1a49LCC2iICB
        xL2Vc5hBipgF3jBKPD+/jwkkISzgKbH15n+g7RwcLAKqEp8fl0BskJM4eWwy2AYJgSlsEm1P
        m8DqeQXKJHZNO8sCUeQi0XZ3NhOELSzx6vgWdghbSuJlfxs7RHM7o8T1mddYoCYxSnS+XwlV
        ZS/x4MZRdpDNzAKaEut36UOEZSWmnloHNpRZgE+i9/cTqAW8EjvmwdiqEi03N7BC2NISnz9+
        hDrIQ2L9rW9gNUICsRKr3l1nnsAoOwthwwJGxlWMkqkFxbnpqcWmBcZ5qeV6xYm5xaV56XrJ
        +bmbGMHJTMt7B+Omcz6HGAU4GJV4eG8wJEULsSaWFVfmHmKU4GBWEuFt9gAK8aYkVlalFuXH
        F5XmpBYfYjQFhuBEZinR5Hxgos0riTc0NTIzM7A0MDW2MDNUEuf94BccLSSQnliSmp2aWpBa
        BNPHxMEp1cCoslkr90bPxDOTxXwPR56w9qwS/bbU/FvmM3HGnUKunabzoxdzh/rcTstOSv5V
        F5L4oHrjnuj5zodmX5OPdfvw5AX/l/0OmdOf7ug9evBko917qQ2Ke6U/OGXOnLmKUblU0ERb
        Wszvz5TKjxvkL9tsVI3+tPKQruGZKGdxbY33thveT1+p2n9FiaU4I9FQi7moOBEAvsLSmnwD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvO6Ce0nRBou/S1pc3J1qMed8C4vF
        02OP2C02f+9gs7i8aw6bxeH5bSwWxxaIWdx7s5XJYuqXDywWh07OZXTg8tiy8iaTx4JNpR5b
        +u+ye/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGkuvP2QvW81Rsm/CBqYHxPWcXIyeHhICJ
        xJf1H1i7GLk4hAR2M0rsPPOFHSIhLfHz33sWCFtYYuW/5+wQRZ8YJV53XGADSbAJ6Ems2rUH
        rEhEwEii6+ohsDizwBdGidZ2XxBbWMBTYuvN/0BxDg4WAVWJz49LQExeAXeJCX3OEOPlJE4e
        m8w6gZFnASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4NDS0tzBeHlJ/CFGAQ5G
        JR7eGwxJ0UKsiWXFlbmHGCU4mJVEeJs9gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQS
        SE8sSc1OTS1ILYLJMnFwSjUwLmnfa5Ijwl6Xecho3u3Lbv0T57xR4th2O06U+WLgiQkd25bZ
        ntity/wymDstwPJGq+XOJ47Bp6YuWSQSM/f45ITmjq3315TMPXGuu2Y+J9PCDVue8P6Ze+ad
        x1b7fXeYGtje9Dzbk6zYku/ZIeZ2etIRqZiqkgq+vqxe/frjNWZmF9Yd3uTLocRSnJFoqMVc
        VJwIALxeisopAgAA
Message-Id: <20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0~HCuTv0d7l2131721317epcas5p4u@epcas5p4.samsung.com>
X-CMS-MailID: 20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0
References: <CGME20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FILE_SZ is defined as (1UL << 35), it will overflow
for 32 bit system and logic will break.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 tools/testing/selftests/net/tcp_mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index e8c5dff..1d6ca12 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -85,7 +85,7 @@
 #define MSG_ZEROCOPY    0x4000000
 #endif
 
-#define FILE_SZ (1UL << 35)
+#define FILE_SZ (1ULL << 35)
 static int cfg_family = AF_INET6;
 static socklen_t cfg_alen = sizeof(struct sockaddr_in6);
 static int cfg_port = 8787;
@@ -134,7 +134,7 @@ void hash_zone(void *zone, unsigned int length)
 
 void *child_thread(void *arg)
 {
-	unsigned long total_mmap = 0, total = 0;
+	unsigned long long total_mmap = 0, total = 0;
 	struct tcp_zerocopy_receive zc;
 	unsigned long delta_usec;
 	int flags = MAP_SHARED;
@@ -316,7 +316,7 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage listenaddr, addr;
 	unsigned int max_pacing_rate = 0;
-	unsigned long total = 0;
+	unsigned long long total = 0;
 	char *host = NULL;
 	int fd, c, on = 1;
 	char *buffer;
@@ -431,7 +431,7 @@ int main(int argc, char *argv[])
 		zflg = 0;
 	}
 	while (total < FILE_SZ) {
-		long wr = FILE_SZ - total;
+		unsigned long long wr = FILE_SZ - total;
 
 		if (wr > chunk_size)
 			wr = chunk_size;
-- 
1.9.1

