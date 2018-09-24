Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B9AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6450D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPU8lIaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6450D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIYCBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:01:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41075 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIYCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:01:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id j15-v6so16850597wrt.8;
        Mon, 24 Sep 2018 12:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slynOfZh8/YpEh4u3Pbm3hOCrbiS9AiZ0fFnoV25FiM=;
        b=RPU8lIaaA/BfEb8jM0kcz7gaMUaGZ7r8MMVqURISWu5omO/392r3++G7dn6orM8AiC
         PLjUim+SpZQWla1GREmpTwJuewTyqclc7GtCt5LOCuwjUZ1ala007plsFDE4mi5OqwXy
         MkohPSjF37k3Vh0z0XcTMgHm3Aq+FQEFpeS8qEhW3xXV/hS48HC9d1Hx0LoR5LZ1aqs1
         FZlkkV00KwDC/FL+qEKp3UA2Td9myLttn8fyGdNon+1zDPvUxsyawdca13TBH+BcKQSy
         tkQsHekiE+EQDb8yJfw9tf5H+8U1q8E5QAQTv1N9MgGJf71sNBisLy6tA7ienuPsNiXh
         QSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slynOfZh8/YpEh4u3Pbm3hOCrbiS9AiZ0fFnoV25FiM=;
        b=hvsYVxBHgXL6AHV0hldNWcS6OuzfFJoTFIGSrkNgRVi7POKbLY46zntEKJYyt1JJ7H
         x1FziHURrfj6KGWlh5cdbIlflsu0XOL8VVNHbdbiPntwB3mBQgKJrAUX9YZxG0+ded0B
         3b8RymNYgUjQjgvlhKl6KGV66OjNNoRrkBHjw8Yi3YaVv20hKQv1yc7IAU/Q/x+ZYzRz
         cEahO1GmWaPM0bR6gtvJuRJ8oyyRb6h/ai+izGsiKnsr4Q6bW5m0xfoxYPZfXxkHZyla
         dwg1sz9Rk1nC5VUAytt5rj/obVN4cqLVNQ6t4t4ECmxcTr/wVQ/bGhpLSEUhxlZJIQ52
         G2VA==
X-Gm-Message-State: ABuFfoiwHILMDzgdTPaQIWbACBP5G9h7Y85lH5V5HYDxXgvTr/REYSdO
        xsscoSmH0+7IvmaYl5kSdTY=
X-Google-Smtp-Source: ACcGV63vPYSxKV2fUY0kVYbQjpxMbBqMmusAJYOajWoKSGonF5th7f+eSHqJz4LUMVwYIplN+lUCiA==
X-Received: by 2002:adf:b2b5:: with SMTP id g50-v6mr256954wrd.218.1537819042137;
        Mon, 24 Sep 2018 12:57:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t4-v6sm305155wrb.45.2018.09.24.12.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:57:20 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Date:   Mon, 24 Sep 2018 12:57:16 -0700
Message-Id: <20180924195716.30848-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
type 'enum ib_qp_create_flags' [-Wenum-conversion]
                qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
                                                    ~ ^~~~~~~~~~~~~~~~~~~~~~~

drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
type 'enum ib_qp_create_flags' [-Wenum-conversion]
                qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
                                                    ~ ^~~~~~~~~~~~~~~~~

The type mlx4_ib_qp_flags explicitly provides supplemental values to the
type ib_qp_create_flags. Make that clear to Clang by changing the
create_flags type to u32.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e463d3007a35..f6f4d9e3c8ed 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
 	struct ib_qp_cap	cap;
 	enum ib_sig_type	sq_sig_type;
 	enum ib_qp_type		qp_type;
-	enum ib_qp_create_flags	create_flags;
+	u32			create_flags;
 
 	/*
 	 * Only needed for special QP types, or when using the RW API.
-- 
2.19.0

