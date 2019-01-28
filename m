Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3167320881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IOptOgFu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fCDokJqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfA1TPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:15:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfA1TPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:15:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B55D60F8E; Mon, 28 Jan 2019 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548702948;
        bh=JpF7V+JuY+CgwGKWsywfk4F8hvetL4pl7KsYcYF/Ivc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOptOgFuAcxT+n2JmsRs5SsTwQsEda6iH2m8no9UcYmP2mzMgGlPK8POH7emRbpY/
         eMOh4VlnesXfSKhJ7SfBnHTSB8SF0fv7ywW97QKFmnzQqxd288TCaq5NRPFfLbytl7
         fx8vq+WrYmaTelV+aBPAnGpkT9Ut+sQ93lRmaloQ=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4097160ECC;
        Mon, 28 Jan 2019 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548702920;
        bh=JpF7V+JuY+CgwGKWsywfk4F8hvetL4pl7KsYcYF/Ivc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCDokJqcv4s6XUkktjlpY277buqghs3B5ipc5EjF1CAO3GoY0MMI5TPaMXUtpZ8/5
         90IGDIbiy1CKE2aatImRM4hAtrCyUJOu4D/uvAJd6PYiG112xDQSznQyvhm6a8psKp
         BuJO8hF+nQD40wxEVnchIX/UiXberYkzm1hLY6k0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4097160ECC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv5 5/7] coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
Date:   Tue, 29 Jan 2019 00:44:02 +0530
Message-Id: <cb7d3e715f154942fba1597b91d5b13c25f607e7.1548419933.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of overriding the peripheral id(PID) check in AMBA
by hardcoding them in DT, add the PIDs to the ETM4x driver.
Here we use Unique Component Identifier(UCI) for MSM8996
since the ETM and CPU debug module shares the same PIDs.
SDM845 does not support CPU debug module.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---
This patch depends on UCI support by Mike Leach in below link:
 https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index fe76b176974a..17731a8ae787 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1080,6 +1080,10 @@ static const struct amba_id etm4_ids[] = {
 	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
 	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
 	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	ETM4x_AMBA_UCI_ID(0x000f0205),		/* Qualcomm Kryo */
+	ETM4x_AMBA_UCI_ID(0x000f0211),		/* Qualcomm Kryo */
+	ETM4x_AMBA_ID(0x000bb802),		/* Qualcomm Kryo 385 Cortex-A55 */
+	ETM4x_AMBA_ID(0x000bb803),		/* Qualcomm Kryo 385 Cortex-A75 */
 	{},
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

