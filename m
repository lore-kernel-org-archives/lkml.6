Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46516208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeuAxScY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46516208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJPDbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:31:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36515 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeJPDbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:31:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id d4-v6so15027514lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i3xUaXG+1kGQsQJJ9XMptJa94waHMLew9MuT9BmQ3i0=;
        b=IeuAxScYsl04F4M+pL1LvkyVleWMqK/SraVIfjAYsTGHYqTEdYN8q+GBDRa206pdF7
         xwOu4xIzcfh4qrdVIfTs3RTctLsOEOIPHTY8uGt9TCNCOFUZu146FCTT9Seks0Wv53g+
         1MKeIF6tp+6bDj5rxZNrOAl3PJyCtnuqnexuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i3xUaXG+1kGQsQJJ9XMptJa94waHMLew9MuT9BmQ3i0=;
        b=kgmNNTIOBqhhZ2L/UOAahdPNHpANhR0ESgf8+CHxTeZu/qLNMkHhNUA0Grx91gKNqP
         HfjXEnoUZxq9VqQVIn0OU9YbvkjFcs9GzctG7fzfg/CXkspKJ/GRtMtU4Il3sIoJzlAx
         Ga//IuG2ipf55zJ3lo4lK0FGu4zdZboVaWrBQqelPjueYlKTTSPkG7FFSG0CsQ8YFIVU
         52nu/eJ6hJTOoZLyn2zrzBEVM6TTJOyYhQukxgXZGhc4g2xaPZXCcdarnVWFhVYN2WjV
         NW700dHGDEzfiq/jE1/v0+OeAkHAnNYk6Y9xBwga9kPfWaWa9ExoOJMAgGklcNzYKnmq
         m+hg==
X-Gm-Message-State: ABuFfohi0gxx/RTtSjthw0e1QH1oG2It9XAZu4sxDdpCfa+bCQHAQCVf
        rVoXrHLuTdEPOZKuPpwgGdTXNCZqi+E=
X-Google-Smtp-Source: ACcGV62mAfPb6whGiqma7LJdVuQe0sQinfBqSAOzUPSgR0xQX3VEurDUwLggS34x8afTMK26/LEl+A==
X-Received: by 2002:a19:a686:: with SMTP id p128-v6mr10323260lfe.42.1539632698114;
        Mon, 15 Oct 2018 12:44:58 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id i16-v6sm999681lfj.18.2018.10.15.12.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 12:44:57 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v2] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Date:   Mon, 15 Oct 2018 21:44:41 +0200
Message-Id: <20181015194441.10475-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181015183218.GA16900@kroah.com>
References: <20181015183218.GA16900@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
to select it, not depend upon it.

Because of this change, we now also need to depend on the same
Kconfigs as QCOM_QMI_HELPERS depends on.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Hello Greg, Srini,

I'm sorry for this.
(Although I'm a bit curious why 0-day test bot didn't catch this.)

Considering that I've just changed QCOM_QMI_HELPERS in:
ccfb464cd106 ("soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs")
which is currently in linux-next, and that this Kconfig should
depend on the same Kconfigs as QCOM_QMI_HELPERS depends on,
I chose to have this Kconfig match the QCOM_QMI_HELPERS that is
currently in linux-next.

 drivers/slimbus/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 9d73ad806698..8cd595148d17 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,8 +22,9 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on QCOM_QMI_HELPERS
-	depends on HAS_IOMEM && DMA_ENGINE
+	depends on HAS_IOMEM && DMA_ENGINE && NET
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_QMI_HELPERS
 	help
 	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
 	  Component is programmed using Linux kernel.
-- 
2.17.2

