Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37B9C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F20206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7HANBpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F20206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeJAFYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34548 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJAFYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:24:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10-v6so8490074lfj.1;
        Sun, 30 Sep 2018 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2c98Tmu2l8jmhHJU4ytb75/uaQfd+wCBkBD0T1jKcvo=;
        b=o7HANBpUJJG/JeAonxa1a9eUgkXeRvVuagsb+dGvxLkUQK1bEbbaTy6Z0l/LIjhQ7e
         Rktegkw05DkaJGoxl+Mxme16lWbrsnMR7otEqgZyV1smA85c7A42mV0RAqBWwtm/0k+/
         kD5br2DQfXaLacUtaEgXxpBaYmUXGY/J4UJEKdohG8JvLIv9Y36g0IVZdDXKu3TLWMWx
         ADR4PdUmGkGmmA1gwGCver6seF7jxnxcvz381hmcJHXecSsTO4hbW5Q+Amkjt6tcencc
         KgMPpfXD4xhRGBD0nUYsDDSZgCPfbaGPhM3lCaOeQw6XPtZ56gzkpF2oLK9OEh1c7igh
         Ww8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2c98Tmu2l8jmhHJU4ytb75/uaQfd+wCBkBD0T1jKcvo=;
        b=JyGjBEUve55oQPBXzhVERgIB49Y6oJ67sibxoIy0exV8qw4siz8VjVSy3jaTr5qfLr
         nS01GrbquQ6b06EKyzowwx5F55h/SXhsMHAwWBLuoFw09Jf0BgwrwvycJHGE2NJfWuoQ
         MeUduAkThTJzRxef0w2UdhRa0pa/SphekVyGbKDQiGjgdBu28p5myg8zrgFZIlJLCwQT
         eohPag8TRmzL+uCTUn07oXHwty1MDsNIK+NZdl6IO6HbfPAy5oKFpyITdlw1rEK69cdh
         +AAl4tLzho2J/PGWRdYbHm9saOLt+iJMB3SjuGtguYXYlHkV0SdlQzMgZ39xcahSOv/S
         YJ7Q==
X-Gm-Message-State: ABuFfojVV/1mf48CZ9K81Yufvvj59dRou3vStAc/uPIPy/U38K86IoVn
        5vT0kO6cMSKvkq575h9IMrPugFN5
X-Google-Smtp-Source: ACcGV633UyXUJ03Rep0NHAuW9Ig/rIist8zedN6zqLuETOStoiYQVlT3GvK+YjcYAYvWU7xzi2/Neg==
X-Received: by 2002:a19:940c:: with SMTP id w12-v6mr3877936lfd.0.1538347751517;
        Sun, 30 Sep 2018 15:49:11 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 18/21] iommu/tegra: gart: Prepend error/debug messages with "gart:"
Date:   Mon,  1 Oct 2018 01:48:30 +0300
Message-Id: <20180930224833.28809-19-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART became a part of Memory Controller, hence now the drivers device
is Memory Controller and not GART. As a result all printed messages are
prepended with the "tegra-mc 7000f000.memory-controller:", so let's
prepend GART's messages with "gart:" in order to differentiate them
from the MC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index d019ae8ecfc9..79e364406c40 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -17,6 +17,8 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#define dev_fmt(fmt)	"gart: " fmt
+
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
-- 
2.19.0

