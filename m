Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABC0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB072085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxrU4uLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB072085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbeJYWth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbeJYWth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:37 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433C720873;
        Thu, 25 Oct 2018 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477000;
        bh=uFi8++aud9pMcidOyNDhqivN9zE51COICqxdCsz/wEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxrU4uLAaC5Kk6huljRB0F9nqgsye9yJwKzBcV3o1Wdxe5A0Tw+2MlVOex1TTTEG+
         IwYsBM8q8PhH5n6tQiXJa996QXpvZqxATdJ/7ccPibqGx+fIOGL9Fa6dvsG+ZkpzVv
         u9NtXbI8yU7SuIu1/a4B07vl812xSzv7r+5hYr7Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Phil Reid <preid@electromag.com.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 93/98] iio: buffer: fix the function signature to match implementation
Date:   Thu, 25 Oct 2018 10:14:18 -0400
Message-Id: <20181025141423.213774-93-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Reid <preid@electromag.com.au>

[ Upstream commit 92397a6c38d139d50fabbe9e2dc09b61d53b2377 ]

linux/iio/buffer-dma.h was not updated to when length was changed to
unsigned int.

Fixes: c043ec1ca5ba ("iio:buffer: make length types match kfifo types")
Signed-off-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/iio/buffer-dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 767467d886de..67c75372b691 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -141,7 +141,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	char __user *user_buffer);
 size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
 int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
-int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length);
+int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);
 
 int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-- 
2.17.1

