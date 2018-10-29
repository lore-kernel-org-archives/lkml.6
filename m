Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F332C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F22E2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhingmdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F22E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeJ2TmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:42:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37835 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeJ2TmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:42:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so7436733wmc.2;
        Mon, 29 Oct 2018 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPXBxfEnlIt7HZjlvYg4Q7eUd836xw4DEoiEfVMSaN8=;
        b=fhingmdF6LMnlZCcjrvMYl7v+zlK1IBfEI3SXBiANobyP0vFogYLGrxvFgEvJ8euRS
         u+xliTWwfRI9IP75MahapFK7bJmxBDz6eMfSlM1qpbb8JHpEvMbhG1l86SDP4HJeAj12
         +WQOYashCxzj0uY2Cc9oPKN7qvi4066tZqncbwXJ6w/jtIFmglwg7uyjbcMTtWEWQXZ/
         oVxu3BgMrYfsUJ33RuwN7a0h1HkoYwrcj3BNWZs+onEO8Lor0lU1JUUsV1AL/y3DVeG9
         iaCedfrRHXkcGu73BjkYXIl88UpBhdaGil2g1Do59yx8Ell6SXyBG+7/h1LwAVVxzjpq
         u42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPXBxfEnlIt7HZjlvYg4Q7eUd836xw4DEoiEfVMSaN8=;
        b=i3eqt2nchI4bugtMgYyDegvgn6BA0+plIqP/9dg7/eL5DRhQXINQZKIa1eJo/gsCcM
         gtgDTyCiK2evoHOI6BCx3U2YGVTwq2ePd4c5fXCX5o+WJVlYe7wB2CjYenUlXvKvPk4Q
         C/0fpc6yQy5HIGFDPDOFmW/DV5bjxQdD+F5zORku+o+qwQXNPbMT0bwl5kFlWehUvorp
         1WAKmQiE9XcOcnbLD+k/1MLL0x50GbKHydv+J1Ibyq81l1xL0beSYL/DZCKbm0ShGP4H
         +D56lsMPbKuQC0xF8R5m0gyf7hznBR0opRWDDrxZKKHXJ7eWOtorKDVIQF9MphKdUbaG
         rqDw==
X-Gm-Message-State: AGRZ1gJkiNxR3yteNLEUjEQ7qNbJjSpsodbMn9gPojMaUcD8VM5Nv/c4
        CHJyoWXbxFI5HrZk+uifvEw=
X-Google-Smtp-Source: AJdET5dmf6C1yEYv8DzpOqcRhQKaWDJQprdvzcMqKoilxLdYDt0s+YMYzxsIJVjnBfXhihjWjCQEFA==
X-Received: by 2002:a1c:5890:: with SMTP id m138-v6mr13176333wmb.107.1540810442272;
        Mon, 29 Oct 2018 03:54:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t14-v6sm11009598wra.63.2018.10.29.03.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 03:54:00 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] hinic: Fix l4_type parameter in hinic_task_set_tunnel_l4
Date:   Mon, 29 Oct 2018 03:51:58 -0700
Message-Id: <20181029105158.6340-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/ethernet/huawei/hinic/hinic_tx.c:392:34: error: implicit
conversion from enumeration type 'enum hinic_l4_tunnel_type' to
different enumeration type 'enum hinic_l4_offload_type'
[-Werror,-Wenum-conversion]
                hinic_task_set_tunnel_l4(task, TUNNEL_UDP_NO_CSUM,
                ~~~~~~~~~~~~~~~~~~~~~~~~       ^~~~~~~~~~~~~~~~~~
1 error generated.

It seems that hinic_task_set_tunnel_l4 was meant to take an enum of type
hinic_l4_tunnel_type, not hinic_l4_offload_type, given both the name of
the functions and the values used.

Fixes: cc18a7543d2f ("net-next/hinic: add checksum offload and TSO support")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c | 2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
index 967c993d5303..bbf9bdd0ee3e 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
@@ -532,7 +532,7 @@ void hinic_task_set_inner_l3(struct hinic_sq_task *task,
 }
 
 void hinic_task_set_tunnel_l4(struct hinic_sq_task *task,
-			      enum hinic_l4_offload_type l4_type,
+			      enum hinic_l4_tunnel_type l4_type,
 			      u32 tunnel_len)
 {
 	task->pkt_info2 |= HINIC_SQ_TASK_INFO2_SET(l4_type, TUNNEL_L4TYPE) |
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
index a0dc63a4bfc7..038522e202b6 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
@@ -160,7 +160,7 @@ void hinic_task_set_inner_l3(struct hinic_sq_task *task,
 			     u32 network_len);
 
 void hinic_task_set_tunnel_l4(struct hinic_sq_task *task,
-			      enum hinic_l4_offload_type l4_type,
+			      enum hinic_l4_tunnel_type l4_type,
 			      u32 tunnel_len);
 
 void hinic_set_cs_inner_l4(struct hinic_sq_task *task,
-- 
2.19.1

