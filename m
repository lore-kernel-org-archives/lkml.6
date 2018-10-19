Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E1ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF3221476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF3221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJSQZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:13 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36159 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbeJSQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:12 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3A11Di3hwkVF+LyUrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uMVIJqq85mqBkHD//Il1AaPAd2Eraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HRbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDwULs6Wy?=
 =?us-ascii?q?mt771zRRHolikJKjA3/mLQhMNygqJWuw6tqwBlzoLIeoyZKOZyc6XAdt0aX2?=
 =?us-ascii?q?pBWcNRWjRBDIymdIQPDvAOPeBFpIf9vVsBswaxChe2BOPu1jBIhWL90Ko00+?=
 =?us-ascii?q?s7Cg7G0hctH8kNsHXUqtX6KrsSXfquw6bW1DjOae5d1zTl6IXQcR0so+uAUL?=
 =?us-ascii?q?NxfMbLy0QiExnJgkiTpIHrOT6ey/4DvHKB7+V6UOKik2snqwZsrTex3soskY?=
 =?us-ascii?q?zJhp4NylDD6CV53J45Jd2mR05/Zt6pCJ9QtyaGOIRsRsMiQ2ZouD0myrEcvZ?=
 =?us-ascii?q?67ezQFx44jxxHCbPyHdpKH4hPlVOqJIDd4gmxqeK6nihux80Ws0OzxW8iu3F?=
 =?us-ascii?q?tIqidJiMTAu3MD2hDL78iIUPp9/kOv2TaV0ADT7/lJIU4umqXAJZ4s2aUwlp?=
 =?us-ascii?q?kTsETFACD2hF/6g7SIeUk84Oin9/znYqn6pp+bL4J7kAL+MrwrmsGkBeQ4Mw?=
 =?us-ascii?q?4OX3WU+Oil2r3j+lD5QLNXgfIsjqnZsZfaJcIBqq6+GQ9V3Z4p6wyjADe+zN?=
 =?us-ascii?q?QYgX4HIUpHeB2dj4jmIUvOIPPmAvekmFmjjCxry+raMb3kH5XBNGbMn6r8fb?=
 =?us-ascii?q?xl8U5T1BIzzcxD55JTErwOPPXzVVLru9HDEhA5KBa4zPriCNVgzI8RR3+AAr?=
 =?us-ascii?q?KBOqPIrVCI/v4vI/WLZIINvDb9Kv4l5+PhjHMgl18dZrSm0oUJaH+mGvRrOF?=
 =?us-ascii?q?uZYXXyjdcbC2sKvRQxTPbsiFKcVT5ffXGyX7gz5jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q7GpxWZmZbClGDCHvodJuLW+0KaC2MJs9siSIEVbe/RI87zx2utxH1y6BhLu?=
 =?us-ascii?q?XK/i0Ur5Xj1MJ65+fLjxE96SR0D9iB02GKV2x0kHkHSCQ43K1kukx9yVeC0a?=
 =?us-ascii?q?5mjPxED9Bc/O1GAU8GMsvVzPR/I9TzXB/RO9mOVVCqS8mnBjd3Scg+kPEUZE?=
 =?us-ascii?q?MoNdyojxnFlwSwDrMYjb2AB9Rg/KvW0VDqJNd7xmqA3qR33ApueddGKWDz3v?=
 =?us-ascii?q?03zAPUHYOcy0g=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgQh8gVMSKIwNX41+AYhQjgmBejgBhDoEAgKFAyI0DQ0BAwE?=
 =?us-ascii?q?BAgEBAgFsKII2IoJiBicvIxBROR4ZgyGBdRGnWjODfYYnhyyEOoFBP4hqgQS?=
 =?us-ascii?q?FDQKeQQmGIYpLAhWBQI5pmBU4gVVNIBiDJ5BZPTCBAwE9AYdlgk0BAQ?=
X-IPAS-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?Qh8gVMSKIwNX41+AYhQjgmBejgBhDoEAgKFAyI0DQ0BAwEBAgEBAgFsKII2I?=
 =?us-ascii?q?oJiBicvIxBROR4ZgyGBdRGnWjODfYYnhyyEOoFBP4hqgQSFDQKeQQmGIYpLA?=
 =?us-ascii?q?hWBQI5pmBU4gVVNIBiDJ5BZPTCBAwE9AYdlgk0BAQ?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:20:09 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 3/7 linux-next] coda: use SIZE() for stat
Date:   Fri, 19 Oct 2018 10:19:29 +0200
Message-Id: <1539937173-26260-4-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1539937173-26260-1-git-send-email-fabf@skynet.be>
References: <1539937173-26260-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_t expression was already defined in coda sources

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/coda/upcall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index d0d0fed..1323793 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -553,7 +553,7 @@ int venus_statfs(struct dentry *dentry, struct kstatfs *sfs)
         union outputArgs *outp;
         int insize, outsize, error;
         
-	insize = max_t(unsigned int, INSIZE(statfs), OUTSIZE(statfs));
+	insize = SIZE(statfs);
 	UPARG(CODA_STATFS);
 
 	error = coda_upcall(coda_vcp(dentry->d_sb), insize, &outsize, inp);
-- 
2.4.11

