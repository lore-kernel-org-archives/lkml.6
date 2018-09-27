Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1B2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr4nzpvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D1B2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeI1DFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:05:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35890 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1DFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:05:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10-v6so4076961wrp.3;
        Thu, 27 Sep 2018 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BF8CrtrCKXx+wLwXWB27qB7otQ6mRf3YKy4xcXImqBo=;
        b=Mr4nzpvGTtAq7nXsGEPp4p5dKFpS5/mw5lONaIyFRx3BdE42FU0CE/f+35LxK/651N
         yAG2KQXeHZZsTDFvfIS3ncKi2z2AfPYSqE6HzxaTdLA/BRdX5Vsz/Xt0IiwK4A+HUFz7
         EUAaRGojwJo2ulsUggDxMKkl3Q+AP/OPqBhGRlDU3RkIdPqC5Bs+2cdJsjYwdLEC7uYr
         TluG3l2C3HnBNc+lhCAzoJFcE0fZRHhPa7RSbr2Gbt45c7y/7QTg1X8/XQCwJ5XiFJtC
         hxq8z7nIzkWW070ytafhHTxnnOfUcyYQ7isKdT23y3qPQzRDjvhKp/JjklqFH1oKN3PZ
         ImSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BF8CrtrCKXx+wLwXWB27qB7otQ6mRf3YKy4xcXImqBo=;
        b=b1c49vpHZ7FDrNDZGxnwxEwnP9wwkAeis3opnjmPVBXN2S5BlnBoAgpuvAGhT1AZnX
         gU5ydr9wrnXvurf4iA/8gmgO0aiVroDhJBajJUUZ6SLfsSahb+6+R5vlPJeBKCBur6yn
         /aXhcaUy7ZCEojS1c56bmAKzX2FDfS3Lw6LXSYguyBm0+EptIPpYOjQ672mYQjeA7m6l
         kBM26e3EreYvl4KeADs5/d1XX/Qtktzpf3yti7mvvcLxDdw4jKjRm4/COE7HxkCf3D7S
         kyehoyXk0g4fbQqZAfkzJV2srEbpqfFX34XIUTXSgyzRwsjn31OmCtqRfpSlZJuOfEOH
         qLGg==
X-Gm-Message-State: ABuFfojnor9FIQZhkMxeKJHo9stx1lTDdJU+F6seBf2ZQhY+KAhOQjio
        Byh3nufmc9qlYphpAaHXcEE=
X-Google-Smtp-Source: ACcGV60X+C3KMK0sSiuwvn1pBj0ijPzSDuFtjS9tRTbY/ACpH7EeYpws5DqJbrfguBvW8xGF2FYQ2g==
X-Received: by 2002:adf:e645:: with SMTP id b5-v6mr2037891wrn.324.1538081095693;
        Thu, 27 Sep 2018 13:44:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v10-v6sm2577248wrp.0.2018.09.27.13.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:44:55 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] IB/mlx4: Avoid implicit enumerated type conversion
Date:   Thu, 27 Sep 2018 13:43:53 -0700
Message-Id: <20180927204352.19569-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924195716.30848-1-natechancellor@gmail.com>
References: <20180924195716.30848-1-natechancellor@gmail.com>
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
create_flags type to int.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Use int instead of u32 since enums are restricted to this range, as
  suggested by Nick.

 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0d822a9db300..e5ec04e844cd 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1151,7 +1151,7 @@ struct ib_qp_init_attr {
 	struct ib_qp_cap	cap;
 	enum ib_sig_type	sq_sig_type;
 	enum ib_qp_type		qp_type;
-	enum ib_qp_create_flags	create_flags;
+	int			create_flags;
 
 	/*
 	 * Only needed for special QP types, or when using the RW API.
-- 
2.19.0

