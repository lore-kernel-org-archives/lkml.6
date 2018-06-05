Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeFERFB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753087AbeFERE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 04/61] Revert "pinctrl: msm: Use dynamic GPIO numbering"
Date: Tue,  5 Jun 2018 19:01:25 +0200
Message-Id: <20180605170117.895562304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 0bd77073e693e8f93ff6ddba65a9f426153221cb which is
commit a7aa75a2a7dba32594291a71c3704000a2fd7089 upstream.

There's been too many complaints about this.  Personally I think it's
going to blow up when people hit this in mainline, but hey, it's not my
systems.  At least we don't have to backport the mess to the stable
kernels to give them some more life to live unscathed :)

Reported-by: Timur Tabi <timur@codeaurora.org>
Reported-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -790,7 +790,7 @@ static int msm_gpio_init(struct msm_pinc
 		return -EINVAL;
 
 	chip = &pctrl->chip;
-	chip->base = -1;
+	chip->base = 0;
 	chip->ngpio = ngpio;
 	chip->label = dev_name(pctrl->dev);
 	chip->parent = pctrl->dev;
