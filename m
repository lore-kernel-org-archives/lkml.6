Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54E2208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFdsU97f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54E2208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGPLJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:09:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44972 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbeGPLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:09:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so28909763ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HWcd1G6r9p9kCRPU0tLTFlXzSWrJMHrOxw63Y5SOkIw=;
        b=JFdsU97fbs+i5ytgtf+w0mQtlmRIh2HSahl/kIoj1Tfk7w9Ipa0wPbVsLk3vMDyWwG
         Z/SbczLpzuizIrkSuWfNGYMXzugq0ouVDsAqN4Nw0tq1ko4sGtxEg7ENaxLRcClCNFKP
         a/EFEYUA946X9Orc8ykhW6Bff2a3kMEzItIGJZs9XU+VYFOmhvDZalQZ0G5Zy2vy9eQP
         tp0EKGrd4cGVKJ3gTa3VRWOqsXTKj47a439aF5WPt2y7kER5CrnDitdrlx/9DfoD2EA1
         AZipzaxxasgTvPPjdqucwrGqmqH9gV6Qa0z/1I2AFo/Hg3THJdz/vksHalNhFb+Zv1of
         ufXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=HWcd1G6r9p9kCRPU0tLTFlXzSWrJMHrOxw63Y5SOkIw=;
        b=qTKDwomrfdH9MhfsZJccmv7vP8RYJMHSuPynqOc0kRY3p8v/9wwUk1AOreNoJ/KpfN
         F4DY/4bTK/PRU1v2JnBeKnq0ScvBFe80Yx+cJWIomAAn9Qcn91CtYM+QVfD4xDJ7Yc3X
         Xe331Xh9qNC83lD9A8dkzZCkyg8gpPH8Wi30Qj6ASUVCFmq3phdThBAQ49Xqgn6PBP1O
         8BM197+NpgBP71tlyGVGTF2iuFsTbYDnowFBKDgaIqKntGbyFzVoLphVsKINtzZ+pop/
         nrauI4+eRrzvSyi9cXL9ZkL4o4RquB8V3sgy3Br5AKPeRHPeaBcBWViFCE1CCZMFhO8k
         ID0g==
X-Gm-Message-State: AOUpUlH0WAzR4D/X88OxH4pnUJ7b2Wa0rp0AP0jTgUMjsLs70k9BWXms
        yvbBzWi+2AntlHFqRQogS5Y=
X-Google-Smtp-Source: AAOMgpfs0WzFSI88w373ofeHZB8oRqTybtjBjphrrE6Uzt4OyPyB46Ib6QKr3vqTtTXSj3w0JBLSvQ==
X-Received: by 2002:a2e:1715:: with SMTP id l21-v6mr10264657lje.1.1531737745949;
        Mon, 16 Jul 2018 03:42:25 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id q72-v6sm1701109lja.6.2018.07.16.03.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 03:42:24 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1ff0xM-0007Pc-EO; Mon, 16 Jul 2018 12:42:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] gnss: fix potential error pointer dereference
Date:   Mon, 16 Jul 2018 12:42:03 +0200
Message-Id: <20180716104203.28440-3-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716104203.28440-1-johan@kernel.org>
References: <20180716104203.28440-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The gnss_allocate_device() function returns a mix of NULL and error
pointers on error.  It should only return one or the other.  Since the
callers both check for NULL, I've modified it to return NULL on error.

Fixes: 2b6a44035143 ("gnss: add GNSS receiver subsystem")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index f30ef8338b3a..4291a0dd22aa 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -235,7 +235,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
 	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
 	if (id < 0) {
 		kfree(gdev);
-		return ERR_PTR(id);
+		return NULL;
 	}
 
 	gdev->id = id;
@@ -270,7 +270,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
 err_put_device:
 	put_device(dev);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(gnss_allocate_device);
 
-- 
2.18.0

