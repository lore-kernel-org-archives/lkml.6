Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92051ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A4A21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOekZOYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A4A21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeIUEC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:02:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35843 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeIUEC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:02:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so10933704wrt.3;
        Thu, 20 Sep 2018 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tAnAbHRm0su3LRGAwzwYznQMEOxM6N+/bf16rgWa8Y=;
        b=jOekZOYr0z9bJB8IvmrLK8yGO/Ax7MX7GqBHhSoj3Sm3sTQ2FXmCaSBv2MspRDZIFY
         rgMlc9BOvX8cwHg0nD+9OOPmZeBUVY7b9NJdAKn415h7gbKbXDELjmVreX2gB3OHtr4n
         Y1SE9zlbI/40T+JAjz6Xp/OZaLwrGiVMf5HHauiioz5KfY/fE9XoizAmIbxBbXgvAe2B
         XxA2Roudgmj37fm4sG0TiDmwthfCjSNxrmik1PCaY5FovSVi3qbz0uPRgAl67bjVdNnH
         VMKRZfPRmFa5j974Timi0qFQvddYEr0YdYg9XqTCe7FyWGl3gRJSop4hFI/7gduKgqtb
         NwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tAnAbHRm0su3LRGAwzwYznQMEOxM6N+/bf16rgWa8Y=;
        b=d1T6o/VWgMq/B4LT3QGirpK8ebkoP3rQz8t+M0xAVVoFGBI0O7P47u+Ip9aIT0i+Gw
         T9jY7/C6NAsj9/XGWTlcDgWb+m1l5v9yy4T9a47AXOLcK6pEs0dO86ctGX0qxYjU2K9G
         6Zp5gpQYGlNAhubofIyPxEWQ72dl7QHL/G3BAbs9oif7rZgPXAV5p7SF5Yy6HA6fKzfK
         elkg12rWwKpAnglhgTNMr+TWVkaAM/WLO4iB+aXreN0yPzm0tgHACC58A73xzzMSBb0r
         ZTkTKEVlnoMUeNGP9y8Zy9Qny+5VYotNUcoHHsRVlsbu8QErD2mjZGPyCr+8g71hr3eT
         B3hA==
X-Gm-Message-State: APzg51A7t5kFyuM6UfkjZaz0Flizj7fdnomCNurgyYjvsZawNwa3sOPb
        Ai66HqgAvCf5sK5Iuo857sY=
X-Google-Smtp-Source: ANB0VdazF3X8Fzrx9q5ZNG9r3oHxZgvVgZ++hXJgoz/i7hn5tQ1JxlVI2KhVvgQnbDtIBZT29ub9YA==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr34552029wrg.249.1537481837532;
        Thu, 20 Sep 2018 15:17:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k34-v6sm32839167wre.18.2018.09.20.15.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:17:16 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: qla2xxx: Remove unnecessary self assignment
Date:   Thu, 20 Sep 2018 15:17:06 -0700
Message-Id: <20180920221706.4948-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/scsi/qla2xxx/qla_mbx.c:1514:4: warning: explicitly assigning
value of variable of type 'uint64_t' (aka 'unsigned long long') to
itself [-Wself-assign]
        l = l;
        ~ ^ ~
1 warning generated.

This construct is usually used to avoid unused variable warnings, which
I assume is the case here. -Wunused-parameter is hidden behind -Wextra
with GCC 4.6, which is the minimum version to compile the kernel as of
commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6").
Just remove this line to silence Clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/83
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index e016ee9c6d8e..f801aae84cef 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -1511,7 +1511,6 @@ qla2x00_abort_target(struct fc_port *fcport, uint64_t l, int tag)
 	struct req_que *req;
 	struct rsp_que *rsp;
 
-	l = l;
 	vha = fcport->vha;
 
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x103e,
-- 
2.19.0

