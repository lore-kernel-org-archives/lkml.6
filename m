Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E516CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9582A208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt1ydTio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9582A208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeGPLJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:09:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36811 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeGPLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:09:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id b22-v6so19454867lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYwOnIiF6OugSIC8wuXxJ0Xp8DmUo1+ibIF9CapofdA=;
        b=bt1ydTioaM6tBmi5DugYE6yGUZXmdT3GTRRYYerDnXs929KkfZrILTic0FpsqATwHT
         OeotKLnjjydAxxZ//ox4uWEc+vf1PKPDW5K5P+/KdtH7jaFX0yqQlstyZnroAlh7JvVr
         KQ391865/LNYORxCVpYN2yfdTkYSo8NOxljb/DCEh4sXDmgYiYE3js24G8AQPpLwpk4R
         Lda82AlX1qsyYA0WbyrFM6g/pnfwadFhLOFYjheC5miR17UebnL6M/oNZrlTDSfe6JzU
         NJzqCv6n+qxTMMUFSLmnCOJEHN+Xc+CUyeLJj9B36Id8ZRg/4rnWUNvm2U8zMXa7uxQf
         qpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zYwOnIiF6OugSIC8wuXxJ0Xp8DmUo1+ibIF9CapofdA=;
        b=FVxZFVBj23goT0xU3CgiwurbYqJ4plVysGMEjz6s70NlMXkyQhe8s5Fd+ySP8TUk5G
         JLhxW2R5cSaHHALZX23wPO0d6AEDb/o6IzYN9UJnFP6MBy4A5ND/RySjFKyzlDxO8oXZ
         lZ008hMD3SdYcuBM78lrH6bHPqfDJP5bcznJH2h8mGyMw5ArM4fwuSIfNXY3ikntUSUH
         OBDdRwqQHfm7v0G6qC5hO4VFc2sU0rxEuoOma5NGXWRffp61pYuI8YzGr6i5CpXLr4zM
         xF2H2NWN6a8+oAsAAf86E9X5+h/p4314xhPkUXI8Ge+kjl/4qUeL+IFYMU+g6PZGGlEK
         Z8RQ==
X-Gm-Message-State: AOUpUlFoNMgZRsZX3hMRKpUHPoulKv/JNhAROkuc0vR1wwCsjBJvXxPd
        HLhrhxDMYSt05+Aun9h95Zs=
X-Google-Smtp-Source: AAOMgpcFFVo/8jKhPVDM9NABUQLWFJC7qrgzPqnKuz8fvgbu3mJ8FQANw7ysYu/mbxwUGPsqUWL4Bw==
X-Received: by 2002:a19:fc3:: with SMTP id 64-v6mr11562580lfp.46.1531737745442;
        Mon, 16 Jul 2018 03:42:25 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id q19-v6sm4836430lje.29.2018.07.16.03.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 03:42:24 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1ff0xM-0007PX-B8; Mon, 16 Jul 2018 12:42:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] gnss: ubx: make struct ubx_gserial_ops static
Date:   Mon, 16 Jul 2018 12:42:02 +0200
Message-Id: <20180716104203.28440-2-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716104203.28440-1-johan@kernel.org>
References: <20180716104203.28440-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The structure ubx_gserial_ops is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
symbol 'ubx_gserial_ops' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/ubx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 902b6854b7db..12568aebb7f6 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -59,7 +59,7 @@ static int ubx_set_power(struct gnss_serial *gserial,
 	return -EINVAL;
 }
 
-const struct gnss_serial_ops ubx_gserial_ops = {
+static const struct gnss_serial_ops ubx_gserial_ops = {
 	.set_power = ubx_set_power,
 };
 
-- 
2.18.0

