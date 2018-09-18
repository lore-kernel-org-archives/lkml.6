Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E40AECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5757A2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="VEBX5VKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5757A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeIRNep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:34:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35485 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbeIRNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so1131801edq.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwFrTRwqcZheB46+CYp0QBZLe0++Nso4ZveGciYkTPE=;
        b=VEBX5VKRc+6TdmBBlCV3rTfOGdu0j7Up8/nera208nk9yqjOMGDDP9tfCoiIJMmLcf
         d/H1JFGTL3tixjCGJ95EjmbOCS23XmYits7GWIcGfoEG0Tz5ouJO/H0wP3+znl4j2dSP
         +ke65OUqvBfQd8ehInDmA1Qa5pvnR08zaDlShoWSrj0Kh0uJvwAH1SdiVT6w1wiuZKio
         9HkFFa6Cp3XMCh1rHOPXTuf+wE7jpIIZm57aorgYQcisZ+or1GF1Q4CoucOWpvk8Bklk
         Mw9RqUJpOOGd1WKCOX5D9PYvh8MTJO5acqKExQGa4FhNCR0dPJ73qz6Pt+fTesvNbCVb
         57kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwFrTRwqcZheB46+CYp0QBZLe0++Nso4ZveGciYkTPE=;
        b=nchx0jWPTnl/9atZ5FzxOWadvlYsCZfwBDyQMSNmaXhjcd+JKux5hDLZ8wtbAthGLa
         PXgSvmyoN/vJ8Lr4xmCwZzzlLWwaR4s4BHWXRPRyUjOKTjnzwrmFZUtikGKgfdFWhVSC
         /oqL30h0PC2Q8azmPkeHqrhwAeUQ7iV1xIQzraCm8kEIkQa5mSYlizCEwhkKmVfBZ1qW
         TlXZB3G5OuFbT2ItU4NKbJ6NAyk+Am/wnZX16dEuAv2yvSf9r5xozmLNYcsWgPCZWvJD
         8y7lq/z1Tg/Gt08XewKEanEQ4KLDuy1CzoSDiLHISBrYw5L95Mle4jf33irQh96mGzWE
         XfgQ==
X-Gm-Message-State: APzg51Cn7jdwT4dESWrOlNkB19e3kG29fJacAKDEXALpOjO6sU1tcg+t
        iSe/YQuvMIfsW/zHxp9l5YAvRQ==
X-Google-Smtp-Source: ANB0VdaVCtCkWshMrV0SyLBwXPSU9HEKazenWfTL1gzT9lWNzUlbIPMSNoWMbaXelykS0NpxDxVFgg==
X-Received: by 2002:aa7:c40a:: with SMTP id j10-v6mr48344154edq.134.1537257796601;
        Tue, 18 Sep 2018 01:03:16 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id l48-v6sm7221062eda.94.2018.09.18.01.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 01:03:15 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 4/4] lightnvm: pblk: guarantee mw_cunits on read buffer
Date:   Tue, 18 Sep 2018 10:03:05 +0200
Message-Id: <1537257785-31630-5-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OCSSD 2.0 defines the amount of data that the host must buffer per chunk
to guarantee reads through the geometry field mw_cunits. This value is
the base that pblk uses to determine the size of its read buffer.
Currently, this size is set to be the closes power-of-2 to mw_cunits
times the number of parallel units available to the pblk instance for
each open line (currently one). When an entry (4KB) is put in the
buffer, the L2P table points to it. As the buffer wraps up, the L2P is
updated to point to addresses on the device, thus guaranteeing mw_cunits
at a chunk level.

However, given that pblk cannot write to the device under ws_min
(normally ws_opt), there might be a window in which the buffer starts
wrapping up and updating L2P entries before the mw_cunits value in a
chunk has been surpassed.

In order not to violate the mw_cunits constrain in this case, account
for ws_opt on the read buffer creation.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 549f13a58b33..604bb743b92b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -195,7 +195,8 @@ static int pblk_rwb_init(struct pblk *pblk)
 	unsigned long buffer_size;
 	int pgs_in_buffer;
 
-	pgs_in_buffer = max(geo->mw_cunits, geo->ws_opt) * geo->all_luns;
+	pgs_in_buffer = (max(geo->mw_cunits, geo->ws_opt) + geo->ws_opt)
+								* geo->all_luns;
 
 	if (write_buffer_size && (write_buffer_size > pgs_in_buffer))
 		buffer_size = write_buffer_size;
-- 
2.7.4

