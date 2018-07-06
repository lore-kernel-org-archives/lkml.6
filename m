Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EC321A5C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffOgNZ+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EC321A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeGFSpD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:45:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45373 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934538AbeGFSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:44:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so9817719ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s2bgLLlhLyHW7qceKFyXMqYp88Ub3JuO1EFI33PSEf0=;
        b=ffOgNZ+4CcKQLlIQi5vrnKhm0RQx7pWZzI+lXynpsJ22Vip4ab2RfIQCYcGdW38eKZ
         xypiHwWAx+xTSFaTjOgtxbQ6kexCHhHQTB76bkkkyXr+vFn7k6+mViuFyidSDqj2enZl
         tPy2m6ezcg3PqYc6EVoOtBmRlFyP4LOhQAdlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s2bgLLlhLyHW7qceKFyXMqYp88Ub3JuO1EFI33PSEf0=;
        b=qe1a2ytCsHkD370YAwt7UkwddxYgPn0/ZJW6tcnC8tSAItAiiqHNd6DLeewoU0vrd4
         JiYzDru7CjyHKO4K3AdivubAdSUAbAOSjM9rhiJKyQIasaINlNxcSRXsclw1UKGA1wcn
         jEyP/jJhMIhli1RAgKGH4MioJH9+majtXHHp9ktHj/PwvNjk22QbeJLa1MR0Zw8/ERfz
         13BL3PEmbbsS7lJmwe6YQJKGobhsRWHcn7d0qVUBBRwD3Qg97lDMnppE64w6jIh+qoH6
         nnfpOn1faJ5UviI1hBXaXCS+HNbBXPzYoMQJiIYhYI1Wkus4C69HZWztzIgS+ptd38zb
         0OqA==
X-Gm-Message-State: APt69E3uXC7DK6tW1yLqDm9o9GskyrxI3W3A/r2cO8ZlfVZaK/sKKdrf
        F9tQotOJsHoRKS7yqHRyaiwIKI18rvE=
X-Google-Smtp-Source: AAOMgpf1dh/wn/j2v5HqnhAVCxHzENwv+DBvgOXZNvo01YWhQLi5P+b9s52BLGaW2MUDvyF25Kux1Q==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr6958879ljc.71.1530902692874;
        Fri, 06 Jul 2018 11:44:52 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h65-v6sm2312063lfb.22.2018.07.06.11.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 11:44:52 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 2/2] net: ethernet: ti: cpsw: allow PTP 224.0.0.107 to be timestamped
Date:   Fri,  6 Jul 2018 21:44:45 +0300
Message-Id: <20180706184445.29111-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
References: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on AM572x with cpsw v1.15 for PTP sync and delay_req messages.
It doesn't work on cpsw v1.12, so added only for cpsw v > 1.15.

Command for testing:
ptp4l -P -4 -H -i eth0 -l 6 -m -q -p /dev/ptp0 -f ptp.cfg
where ptp.cfg:

[global]
tx_timestamp_timeout     20

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index f355e65323f3..00761fe59848 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -257,6 +257,7 @@ struct cpsw_ss_regs {
 #define VLAN_LTYPE2_EN      BIT(21) /* VLAN LTYPE 2 enable */
 #define VLAN_LTYPE1_EN      BIT(20) /* VLAN LTYPE 1 enable */
 #define DSCP_PRI_EN         BIT(16) /* DSCP Priority Enable */
+#define TS_107              BIT(15) /* Tyme Sync Dest IP Address 107 */
 #define TS_320              BIT(14) /* Time Sync Dest Port 320 enable */
 #define TS_319              BIT(13) /* Time Sync Dest Port 319 enable */
 #define TS_132              BIT(12) /* Time Sync Dest IP Addr 132 enable */
@@ -281,7 +282,7 @@ struct cpsw_ss_regs {
 
 
 #define CTRL_V3_TS_BITS \
-	(TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
+	(TS_107 | TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
 	 TS_TTL_NONZERO | TS_ANNEX_F_EN | TS_ANNEX_D_EN |\
 	 TS_LTYPE1_EN)
 
-- 
2.17.1

