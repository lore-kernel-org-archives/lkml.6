Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC42BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F7D2156D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="hXV4OIf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F7D2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeHOAiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:38:01 -0400
Received: from bosmailout02.eigbox.net ([66.96.189.2]:55635 "EHLO
        bosmailout02.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeHOAiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:38:01 -0400
X-Greylist: delayed 1835 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2018 20:38:00 EDT
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
        by bosmailout02.eigbox.net with esmtp (Exim)
        id 1fpghp-0003nZ-P8; Tue, 14 Aug 2018 17:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3DLQQ0dgE9jXwrVBfESSYaofwNgGRQhZUje4J+kBpd0=; b=hXV4OIf8BMCe3s1R95MuOqhit
        LptYYI38i3Ygz5lPtBK/ET0rK8LB68osvVmSTINThHq7C+ceYLuMrxXEqQzrWTZcdsMavh397YRvS
        +TQ2YcNp446UqH4Fi7f2zWAFYSLw8CA5G0fc9JZb2Z0R7CNJ/h9WE2BKxn69YSzltPcMSEtp9xT4b
        fe1lO5Y++IW4jKaa9SccSJFioYmJd+tLRhNOWRN10QLBc9oT6fG2F7MgDw+mGxHlrpHTmThBuCAdZ
        rdlCWWB+0LC0aM6UFITWkQAthZC5dVGEfttX7VZqFV+gXqIQMNRuFaGRnr7ZAHzH47Ksg95/oa7i+
        /NmLHHDTA==;
Received: from [10.115.3.33] (helo=bosimpout13)
        by bosmailscan06.eigbox.net with esmtp (Exim)
        id 1fpghp-0005YJ-M6; Tue, 14 Aug 2018 17:18:21 -0400
Received: from bosauthsmtp13.yourhostingaccount.com ([10.20.18.13])
        by bosimpout13 with 
        id P9JE1y00H0GvDVm019JH1N; Tue, 14 Aug 2018 17:18:21 -0400
X-Authority-Analysis: v=2.2 cv=MK0QoIRl c=1 sm=1 tr=0
 a=UH8/iCWBfdUmbm4Ft4Vi3Q==:117 a=WFC+M0LbvcyalcFcVaxzsg==:17
 a=dapMudl6Dx4A:10 a=I7kt_hwf06sA:10 a=dSbym95GAAAA:8 a=9g-_d_dQlnLGK2Ik3bAA:9
 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [77.139.214.119] (port=50384 helo=localhost.localdomain)
        by bosauthsmtp13.eigbox.net with esmtpa (Exim)
        id 1fpghi-0000xX-EI; Tue, 14 Aug 2018 17:18:14 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, corbet@lwn.net,
        liushuoran@jd.com, mitsuo.hayasaka.hu@hitachi.com,
        linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     amir73il@gmail.com, Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH v3 2/3] fuse: add max_pages option
Date:   Wed, 15 Aug 2018 00:17:15 +0300
Message-Id: <20180814211717.22170-2-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814211717.22170-1-const@MakeLinux.com>
References: <20180814211717.22170-1-const@MakeLinux.com>
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 77.139.214.119
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 Documentation/filesystems/fuse.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fuse.txt b/Documentation/filesystems/fuse.txt
index 13af4a49e7db..d4e832fe9ce6 100644
--- a/Documentation/filesystems/fuse.txt
+++ b/Documentation/filesystems/fuse.txt
@@ -108,7 +108,10 @@ Mount options
 
   With this option the maximum size of read operations can be set.
   The default is infinite.  Note that the size of read requests is
-  limited anyway to 32 pages (which is 128kbyte on i386).
+  limited anyway to max_pages (which by default is 32 or 128KB on x86).
+
+'max_pages=N'
+   Maximal number of pages per request. The default is 32 or 128KB on x86.
 
 'blksize=N'
 
-- 
2.17.1

