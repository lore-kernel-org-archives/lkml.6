Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB23C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D642520645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rF9oQLhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfBYRyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:54:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfBYRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:54:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id bj4so4824864plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gzq6vfQHzGWyeLb0TiRQKsKtzM247mh6zsfOdLM3MNQ=;
        b=rF9oQLhP90GEfr0vq+e2lst76ilKM4iL70dyP4NE/mU02+65uDyhTG1zCQrQZ2zmkT
         NwZsYlRyyQOQlYc5s7mRl+QiCWLDmdlHlwMJoF/Pmf4oTcadKD92+IKQVvn2BMmtoZtv
         jU06q14WYfnx5nMPV5SxACUIkNyYjQzCtEYL0TIceTGKWA7KD00ZuHH/1emCl7K+6cVc
         OSc35Uv2lSqnsVIcoMC3imDQbKNwuCqRxq0Cq9O7q+p7yfqS6ViTvd25N/iS1zPcQGPl
         GJv/SYtdOaA15QUrX6ykUznfniHVpes/xoUixAuQizPV5C/svM/RSh9zoYk8iysbhGvv
         ia/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gzq6vfQHzGWyeLb0TiRQKsKtzM247mh6zsfOdLM3MNQ=;
        b=PedoB1bKbTjmj64UeGuK8ou7Ys4rH62prFM8y3c1BCcDGNrne4yUBqsoDeAKQHmbPz
         h8+mcTj+nl85bo/0BjYJ9UBgWvCfF3YTPWBH3kmTtkr9DMYJaFmHPlnbTtEtZJhN9Jmq
         ZE/GQ2djMhWkjleZy6b+WqNwawf/Lqi8745gn6WfdoOGS9+3z2dJ1l2VRORVyRYLyA0R
         cedTMXWbXSOEFUtlBdgaAVRSpoCA1uNOspyyMRTrANHYyNnWbt3TFYWWwcVv3K6AYlxm
         U3/YTa4SRiW+p0czW17XMJJKb7B/47eRHu79UguwNiNo/StMF1RpAsIFmsI/6pUKe002
         2xlw==
X-Gm-Message-State: AHQUAuapRouSDeNkTJgf1jFGT1iFS8GwYZKElnGyBWephXiUQGijZlCa
        pp9JPLz+pQmCUz8GtAawUwBphu91raw=
X-Google-Smtp-Source: AHgI3IbvDJnWJuN+Q/1tM5cJoSVVT18nUiZ/7O1aGknZJ8SorMPp2XwcLlm0GbpdqWxi07yuIkj8bQ==
X-Received: by 2002:a17:902:850a:: with SMTP id bj10mr21421508plb.91.1551117244186;
        Mon, 25 Feb 2019 09:54:04 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v9sm15398997pfg.144.2019.02.25.09.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:54:03 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] coresight: etm4x: Add support to enable ETMv4.2
Date:   Mon, 25 Feb 2019 10:54:01 -0700
Message-Id: <20190225175401.26467-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225175401.26467-1-mathieu.poirier@linaro.org>
References: <20190225175401.26467-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

SDM845 has ETMv4.2 and can use the existing etm4x driver.
But the current etm driver checks only for ETMv4.0 and
errors out for other etm4x versions. This patch adds this
missing support to enable SoC's with ETMv4x to use same
driver by checking only the ETM architecture major version
number.

Without this change, we get below error during etm probe:

/ # dmesg | grep etm
[    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
[    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
[    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
[    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
[    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
[    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
[    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
[    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22

With this change, etm probe is successful:

/ # dmesg | grep etm
[    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
[    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
[    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
[    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
[    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
[    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
[    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
[    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..fe76b176974a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -55,7 +55,8 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 
 static bool etm4_arch_supported(u8 arch)
 {
-	switch (arch) {
+	/* Mask out the minor version number */
+	switch (arch & 0xf0) {
 	case ETM_ARCH_V4:
 		break;
 	default:
-- 
2.17.1

