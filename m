Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424750AbeE1LST (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424718AbeE1LQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
Date: Mon, 28 May 2018 12:05:02 +0200
Message-Id: <20180528100302.722883806@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit a7aa75a2a7dba32594291a71c3704000a2fd7089 ]

The base of the TLMM gpiochip should not be statically defined as 0, fix
this to not artificially restrict the existence of multiple pinctrl-msm
devices.

Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
Reported-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -818,7 +818,7 @@ static int msm_gpio_init(struct msm_pinc
 		return -EINVAL;
 
 	chip = &pctrl->chip;
-	chip->base = 0;
+	chip->base = -1;
 	chip->ngpio = ngpio;
 	chip->label = dev_name(pctrl->dev);
 	chip->parent = pctrl->dev;
