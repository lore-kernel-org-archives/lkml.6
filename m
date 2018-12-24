Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E73C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442422184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qrJXXl52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbeLXSZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:25:00 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:53432 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXSY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:24:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 132B3A3D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 18:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DsbeK_LQj1f2 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 12:24:57 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id D629D9FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 12:24:57 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id t133so13935495iof.20
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z8jGH7OSy10Xmp7FOooJUxOZZUuJDengHhk/566HuLA=;
        b=qrJXXl52/cpFpfAOhol/UGOVfoaW7qVYnL6f4GFaDXbnk59nEj+AmG/OEOgYnDC2JA
         F846oy3gBXcIEFh7Sp0caTAwZjw2mZT5V2Eidt3R3kIfL9Ew6q79/qQzyAiGO9Svhf/8
         mvXlUXw1QcnM4D+0mZ9IDBOEB6hw/D24dR8W/lnZkRsmMJXPkBBG9/yy8DHKbzcgrDpz
         /KRcj8Ib7JntCZoiWuQJJqhwHX6J8zo/khXzEJ4MsPFFt9E0Yci5O1uMIQW0B6BTq4kX
         68eTodR2nqNIqoWYEy74ZePlJo3Mr7jIWyagz/OuNeAJjEEFqBve022glA1uR78p0bi8
         0bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z8jGH7OSy10Xmp7FOooJUxOZZUuJDengHhk/566HuLA=;
        b=hGsx/H4flRiU1q9xTyq3RORJWMhF29VCayaH7wp8WTkTFrCBXn30TPEcpjj+2iW2vb
         Xwg7sQO2sIU3yxveNWZ6EnAHvp8OgyqqRAxgbg1W9WQ5rkFOvFzG4WDqcJdzRubYiTdU
         1QYpZ2ldxtpeE2AeM7KB+O0VDiSwe6+7XFKQj6VnqfoHRns2CkZ7I0trJGnK9LH8J9Bp
         S7gjqzcUccaSoK3I3JzNkHwgqQhlXNtZPAY0tRl9O8OXbYNWhG41naZ7dPPeBavrMXQi
         WXujapCeL5e5p2BhNiDP+e8SiLItEklXv/ejjR3/Z0Rh/eFqPBLqte/X30zuEhFhISo+
         +y9Q==
X-Gm-Message-State: AJcUukeq8Wd7/abZItXu0AO/ekisJ3q1ffSlkZmCHmffsE/yrb0hMY0l
        JPa28SzX45EDBumMDbj8gds1di3S+6HJGaZ+lbesFY4AaaGVZa7ReU/ZfVU+7BDhtkikDBlfhum
        PysYPEvCrxfu+cj43Pc49Og53SXw8
X-Received: by 2002:a6b:3bc8:: with SMTP id i191mr10076693ioa.23.1545675897474;
        Mon, 24 Dec 2018 10:24:57 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4PQ88JqfkuhrMVAkrAprFOaq4pR5llOk/NYl6CC8cSSxQR8gwaDlazbETr0VLFf90Vm0LkGw==
X-Received: by 2002:a6b:3bc8:: with SMTP id i191mr10076686ioa.23.1545675897246;
        Mon, 24 Dec 2018 10:24:57 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id u25sm13894605iob.23.2018.12.24.10.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 10:24:56 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband/qedr: Potential null ptr dereference of qp
Date:   Mon, 24 Dec 2018 12:24:45 -0600
Message-Id: <20181224182445.21256-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_find() may fail and return a NULL pointer. The fix checks the
return value of the function and returns an error in case of NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 505fa3648762..93b16237b767 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -492,6 +492,8 @@ int qedr_iw_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	int i;
 
 	qp = idr_find(&dev->qpidr.idr, conn_param->qpn);
+	if (unlikely(!qp))
+		return -EINVAL;
 
 	laddr = (struct sockaddr_in *)&cm_id->m_local_addr;
 	raddr = (struct sockaddr_in *)&cm_id->m_remote_addr;
-- 
2.17.1

