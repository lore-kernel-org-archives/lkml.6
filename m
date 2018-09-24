Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8856C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815A3214FA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khlcUyuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815A3214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeIYDkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:40:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53195 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeIYDkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:40:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id l7-v6so6421747wme.2;
        Mon, 24 Sep 2018 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQSQYGy0Y8/b2H0+p+26dQBzmvcGnlwZBeyy4L0lTS8=;
        b=khlcUyuCHC5yp3ecrGOiFJRe4YuV6l0kL5a9WHjboJ/rsNSJHlCxYOHRsG6xByWMTB
         ehiiCx/SNea8itv+WF0IBUXZSk+JM5cqifbooG9wlm7AZb7dTTyEJvmeyBduEmR9OSLS
         2ifTNKkf9zPY5GrkLxKOkXMWxBYDBdivJFNZj7F4AlRPGaZ12DFgUz50gicETtPlu72A
         p8wEDZ68OQUA2n6Bo6bTfXF8p0eK9vnv1EzhuQpzlqPFR7MI19OCR8ZnMBPkPFA5Yq8v
         o6q1hjsjwXu8tC7O+jWxYnXzs7E40pZGSTUChr+1OlVDDHQ6MEiNuXKNWz2zmeqjAk59
         +tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQSQYGy0Y8/b2H0+p+26dQBzmvcGnlwZBeyy4L0lTS8=;
        b=D+7OP0A/A45hN5coTe6NxWJL11xEu0jCT69Dst2hIUxcvJHqK0MWTSSjALCQj2wsuq
         AqMHCBZwfmTXmr37K/qcv0PQkRGdbPtuJ6zFXTCkAPew1bFH+x5nZbN0mUocphxsnay9
         qQlCR1BwMgmrEwNKI+I6BXLYZw8BktIuwG2XP479MeKoqFoY+mex2lH0HAw7qv4gNNZ/
         CabSrbD3YrxzxPWPqKcnlAPHWPj27cdriQfrmTCP38OcOcXNNtG8opxdxIJS9WKJjaQ3
         RYhQPYIrIUbR6aG75gyiQiiVUA4IO7D7AW5sxDSuu0D8kg2WhYyyQtgDI+r3OR9wIt5w
         hy5w==
X-Gm-Message-State: ABuFfoiUbDwr2FGGas5zO4QHuyq8FSGZdVrTQmamGfcY/oGXSGv1Aqgg
        IQr63cDDI6S+XV9dKmoqLjvVZJ0/A/3q6g==
X-Google-Smtp-Source: ACcGV61QAsREAwu5vJwreOb73ceChI5eqUahkgP8tRTxwL5EaXJPrkX6gyJzVVJcxeJvm4B3fnxVaQ==
X-Received: by 2002:a1c:1f50:: with SMTP id f77-v6mr188470wmf.52.1537824954535;
        Mon, 24 Sep 2018 14:35:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q5-v6sm271736wmd.29.2018.09.24.14.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:35:53 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
Date:   Mon, 24 Sep 2018 14:34:53 -0700
Message-Id: <20180924213452.19334-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924213120.18979-1-natechancellor@gmail.com>
References: <20180924213120.18979-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_roce.c:153:12: warning: implicit
conversion from enumeration type 'enum roce_mode' to different
enumeration type 'enum roce_flavor' [-Wenum-conversion]
                flavor = ROCE_V2_IPV6;
                       ~ ^~~~~~~~~~~~
drivers/net/ethernet/qlogic/qed/qed_roce.c:156:12: warning: implicit
conversion from enumeration type 'enum roce_mode' to different
enumeration type 'enum roce_flavor' [-Wenum-conversion]
                flavor = MAX_ROCE_MODE;
                       ~ ^~~~~~~~~~~~~
2 warnings generated.

Use the appropriate values from the expected type, roce_flavor:

ROCE_V2_IPV6 = RROCE_IPV6 = 2
MAX_ROCE_MODE = MAX_ROCE_FLAVOR = 3

While we're add it, ditch the local variable flavor, we can just return
the value directly from the switch statement.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* s/if statement/switch statement/ in commit message

 drivers/net/ethernet/qlogic/qed/qed_roce.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_roce.c b/drivers/net/ethernet/qlogic/qed/qed_roce.c
index 7d7a64c55ff1..f9167d1354bb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -140,23 +140,16 @@ static void qed_rdma_copy_gids(struct qed_rdma_qp *qp, __le32 *src_gid,
 
 static enum roce_flavor qed_roce_mode_to_flavor(enum roce_mode roce_mode)
 {
-	enum roce_flavor flavor;
-
 	switch (roce_mode) {
 	case ROCE_V1:
-		flavor = PLAIN_ROCE;
-		break;
+		return PLAIN_ROCE;
 	case ROCE_V2_IPV4:
-		flavor = RROCE_IPV4;
-		break;
+		return RROCE_IPV4;
 	case ROCE_V2_IPV6:
-		flavor = ROCE_V2_IPV6;
-		break;
+		return RROCE_IPV6;
 	default:
-		flavor = MAX_ROCE_MODE;
-		break;
+		return MAX_ROCE_FLAVOR;
 	}
-	return flavor;
 }
 
 static void qed_roce_free_cid_pair(struct qed_hwfn *p_hwfn, u16 cid)
-- 
2.19.0

