Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B301F2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhN2Qols"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B301F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbeITJNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:13:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54413 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeITJNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:13:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id c14-v6so8295682wmb.4;
        Wed, 19 Sep 2018 20:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfOMuRjv8r4pEoEs0YPr0UYr7mAMda2bFMBq9QFspuo=;
        b=MhN2Qolsqolo9OFq92udDlqMX8XY3Wr+Hk797M6rmGwAJcvDc7+EEInVOAUdVaJ0Sb
         acdYcEJHsjUhS0WbvnM5y9bapKGm4RDU33FEhFuj3BkZbFu7VNIBqvaEG9BE1u/zCs9a
         EmVdTsFEEeltvHYcHUrEa3A0BFZcgkp0Qz72SzLTUrlvopEvsbIofS1jE5/bn99gJWym
         8M2qLXbQjL4m8fcg/0J8eBqvcB5rWyzVay6kmAyYvYNsW4+O/Qfq7w6FpjkIqKm8Y+Jv
         zse0JgYm/4Z+dpJ3Xs57RsSuv2nUWquevEL4Wx5Q1D6QtYqCAnjwP5oHDYPqJjrcfM0Z
         hmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfOMuRjv8r4pEoEs0YPr0UYr7mAMda2bFMBq9QFspuo=;
        b=YXqA5fxnpLgNIGRXaiy3KuWdCE6dfG23P1zoMS6F79F4pNJmGEsdxcxctcuIe48AYL
         Oen3Shle6WDTqkJvs0YmhkDAylkbiace2bPUJa5mfz1QCv25NJ6A34qw/XlbAudUDfrA
         /5wEOSt/5KzhbdL7HNpgNGJkd9iTGoGmAtWe+2MOF84Dw8aWN8qjKFMtmPp/XWGo4vQY
         qeGqZUit2Y/AkBdmtoWFo/4rgpofGOByQlKD0y7V4PtRHWbRfCU02sQsZCkWCxL4Hofj
         ipUKr3BdqXZfcLgQd4WEZU0z1CjZG/zLbPLGkm6wapzagHdlITNq/hwfKTzy15EJqDK/
         K9PA==
X-Gm-Message-State: APzg51B+0Jk8KkF4fZqZIDE6UczwVXOgff1c/afX2ZqsEcG1bfWde3tu
        R0P51bzx9tQ0PhDxtBFka84=
X-Google-Smtp-Source: ANB0Vdb/mVEbgnqVUyUZ2vnE5IA2VXkvx4pRAhrjkfbnV3uf+VeOmwu+S7yHrzrnC/qBylz+ibwMug==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr590766wmy.11.1537414361162;
        Wed, 19 Sep 2018 20:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id n14-v6sm448878wmc.14.2018.09.19.20.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 20:32:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] IB/mlx4: Remove unnecessary parentheses
Date:   Wed, 19 Sep 2018 20:32:29 -0700
Message-Id: <20180920033229.15102-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when more than one set of parentheses are used in single
conditional statements.

drivers/infiniband/hw/mlx4/mcg.c:676:16: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
                        if ((method == IB_MGMT_METHOD_GET_RESP)) {
                             ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/mlx4/mcg.c:676:16: note: remove extraneous
parentheses around the comparison to silence this warning
                        if ((method == IB_MGMT_METHOD_GET_RESP)) {
                            ~       ^                         ~
drivers/infiniband/hw/mlx4/mcg.c:676:16: note: use '=' to turn this
equality comparison into an assignment
                        if ((method == IB_MGMT_METHOD_GET_RESP)) {
                                    ^~
                                    =

Remove the unnecessary parentheses to silence this warning.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/hw/mlx4/mcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/mcg.c b/drivers/infiniband/hw/mlx4/mcg.c
index 81ffc007e0a1..d844831179cf 100644
--- a/drivers/infiniband/hw/mlx4/mcg.c
+++ b/drivers/infiniband/hw/mlx4/mcg.c
@@ -673,7 +673,7 @@ static void mlx4_ib_mcg_work_handler(struct work_struct *work)
 			if (!list_empty(&group->pending_list))
 				req = list_first_entry(&group->pending_list,
 						struct mcast_req, group_list);
-			if ((method == IB_MGMT_METHOD_GET_RESP)) {
+			if (method == IB_MGMT_METHOD_GET_RESP) {
 					if (req) {
 						send_reply_to_slave(req->func, group, &req->sa_mad, status);
 						--group->func[req->func].num_pend_reqs;
-- 
2.19.0

