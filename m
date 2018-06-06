Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VmfkTfkW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LOcXF0nE"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8B056070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeFFIzt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:55:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeFFIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:55:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F7B0601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From: Rohit kumar <rohitkr@codeaurora.org>
To: plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, rohkumar@qti.qualcomm.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: qcom: apq8096: set card as device drvdata
Date: Wed,  6 Jun 2018 14:25:24 +0530
Message-Id: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_card is retrieved as device drvdata during unbind().
Set it as drvdata during bind() to avoid memory corruption during
unbind().

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/apq8096.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 561cd42..239b8cb 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -140,6 +140,7 @@ static int apq8096_bind(struct device *dev)
 
 	component_bind_all(dev, card);
 	card->dev = dev;
+	dev_set_drvdata(dev, card);
 	ret = apq8096_sbc_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
