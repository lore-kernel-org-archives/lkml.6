Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D119C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2880C21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XxnVbW1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLZFvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:51:35 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:39086 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLZFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:51:34 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 51072B87
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 05:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OBfNIA00aIeM for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 23:51:33 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 246B7A08
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:51:33 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id p4so18220314iod.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lKKEtLas4hU7Y09w0xd6on/9B5tosu3jnVozqGRHspg=;
        b=XxnVbW1YNFosZWNdI0zsNQEdViI06q9Ax/6ADLsuDDmCJpUi1yeWJiW2/cwLpwgpf9
         VusaX9zP4zv4ddY1gPCTFs5ShYn6oIfu4ciubaVL4vl9ZMjYO3dBjH4hQd6tm3iai2xt
         B5uWZVe2PhqEFbbbuYDiajmlmzi02E9xhldCChNQizzswMngsttGHMfwkAO4FlinQCSD
         AHLT8IcMMpAjoRwZIxikkbZQQvfemvRGXvKw7W9rNB7OhqJyt60GNa2ithe/lciG1EAq
         wwdS/cdW17yhlGpXnBo2wrCXnlQDE7KySONYv/JuUP8g9zOSQJXWye9vmFw0dTKV/TyN
         xYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lKKEtLas4hU7Y09w0xd6on/9B5tosu3jnVozqGRHspg=;
        b=JLQtImj4VEYhYNwKB0Exkd7o6B5+Qk6GUvKwaTXjkyQGOOMetwxRwJgWx9GNcucifI
         lyGKhZ2RlmcgXqdaURwu4bvEAX1LGvXNbk1i1GD0D0WOZUhx7ppCgklEx7Rw82sdUVmM
         U9CVGv0H1cvcCwLRy47ORGgwWrjRhlZoxTaWyGF7kT7p4NLXPNfCjhskNWaJHwO5S7aa
         SPEq/lPeNXbDKB5Fg4yvKfpkUgAqj0hwWyDVLH4a6amsrdXKtVqnYgclDB2wqxJaWy9C
         FAonw93FNIoOtkc0swjbz50TTeLtAQINxgf7LhBMQIS8JE8G+/+OrJwRSwixNzOQLu96
         +erw==
X-Gm-Message-State: AA+aEWaMo4tmCJeZjocs6fSvnKiSQNbbYyR6zCifgEKr3HMyDmikZiKF
        rj5EompOUzUm15OPdZS6fGKzglotS1yJU77Up/kpyMKHh/Uz+MefKXddhvzjVRgnsHyg7cWVA00
        hTn2aGlXjUdYHHDZzAj8vMPH4ZSFv
X-Received: by 2002:a24:630b:: with SMTP id j11mr11686450itc.28.1545803491754;
        Tue, 25 Dec 2018 21:51:31 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WPdmhp166l5l08aLY+C3EYaZ7X5TqWXcyOftqH6lygyXUMXpzFlbq6MuhLv49Ns1H14sB42Q==
X-Received: by 2002:a24:630b:: with SMTP id j11mr11686440itc.28.1545803491519;
        Tue, 25 Dec 2018 21:51:31 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id n10sm6636174itb.39.2018.12.25.21.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 21:51:30 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aacraid: add a check for aac_fib_send
Date:   Tue, 25 Dec 2018 23:51:03 -0600
Message-Id: <20181226055103.74893-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aac_fib_send could fail, so add a check to its return value: If it
fails, issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/aacraid/dpcsup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/aacraid/dpcsup.c b/drivers/scsi/aacraid/dpcsup.c
index ddc69738375f..0fbdc0dbf9d8 100644
--- a/drivers/scsi/aacraid/dpcsup.c
+++ b/drivers/scsi/aacraid/dpcsup.c
@@ -271,6 +271,8 @@ static void aac_aif_callback(void *context, struct fib * fibptr)
 		FsaNormal,
 		0, 1,
 		(fib_callback)aac_aif_callback, fibctx);
+	if (status)
+		pr_err("failure in aac_fib_send: %d\n", status);
 }
 
 
-- 
2.17.2 (Apple Git-113)

