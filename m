Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE6ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7C2083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9YSg6ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB7C2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeJVFP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:15:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47038 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbeJVFNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so35083412lji.13;
        Sun, 21 Oct 2018 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44oqZ+/ierfmo+WnNgcOmoD3+bTEhxntht5wx9v7/wQ=;
        b=h9YSg6caMoRrfFgwFvXBEf4ntIdLWOof+X4/5J1Nhdp1ONnyrQL1/flUG/axx1V2NU
         gDCW/uNNGPh9cb8r9Hu6oiKDtUBF9H1Z8VNWAKYjEiyoGuxfYlWS1oYE+NNgnX6HWXo/
         4qzI6aWbMKR9sL5dOUybiBDJrTYaDvSPyc3QhaMCwfbXf2KXk6tYP8zcJdwZrVLE8O3d
         qTLKnmNTPDPb1XB8czWWa/6hysP9n3xq8Gj4AephCfT5ZNjyEyH0dA7mifOwwJzWmR70
         IkFjhgl3Ugy0tywsCfAWhSg3ANxZgAd845yi0+3m+d6lCVcaIjbPU7jX7zQUMyS4ejzs
         /MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44oqZ+/ierfmo+WnNgcOmoD3+bTEhxntht5wx9v7/wQ=;
        b=hLk1dIpUKz1Jd5PQU3tXJ74pLWQ68eehZhyyCB1ivb/K+ZCSxiXSd0IdtQ3HpeaC4a
         t1Iojc0vTFJqzoJEnZ2bxKchEwjTqyG3rkV2KjRgJGilKz/MPIq2Nims3fTBUIBN039j
         819/ZUQWMHVyTtCHis0OzUJt13HH/fK2Xd9+MnuvlpE7Nfg/27hnO9uncL6Gxvq7iXC8
         9YDqpPtm0AdJKIEeMvYpVK34vYc/UGl95wu9EsQnMriR7yNnt/cMnNvmp4q59ehoeGGW
         rTVSyK805Sv/WgBuMIjOlLmHOjbRiC0OtD59d/FoKjdzPmJJK7N3B4Z5XNDfQPlYEJnj
         ZzjQ==
X-Gm-Message-State: ABuFfohucKtxY8rCYZDqsMI+O6J+9GK9ebxVhvSRBC3FvL9givJijbtG
        2r0kXQIAgLScX0oN1rlqnDk=
X-Google-Smtp-Source: AJdET5fvlhz47jSPgay3gUnpOReV5eU/kOtYRlmANeI5QqRQs/pd31szTpnkuz/uzYXsaij2yILVZw==
X-Received: by 2002:a2e:4794:: with SMTP id u142-v6mr3914213lja.8.1540155486000;
        Sun, 21 Oct 2018 13:58:06 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 02/17] soc/tegra: fuse: Export tegra_get_chip_id()
Date:   Sun, 21 Oct 2018 23:54:46 +0300
Message-Id: <20181021205501.23943-3-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used by tegra20-cpufreq driver which can be built as a
kernel module.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index e5a4d8f98b10..c94dccf3eb30 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -51,6 +51,7 @@ u8 tegra_get_chip_id(void)
 {
 	return (tegra_read_chipid() >> 8) & 0xff;
 }
+EXPORT_SYMBOL_GPL(tegra_get_chip_id);
 
 u32 tegra_read_straps(void)
 {
-- 
2.19.0

