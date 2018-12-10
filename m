Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB611C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BCF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BCF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbeLJVAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:00:01 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50355 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeLJVAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:00:00 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MnWx3-1hDX7B0wuj-00jatI; Mon, 10 Dec 2018 21:59:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: msm: mark PM functions as __maybe_unused
Date:   Mon, 10 Dec 2018 21:59:45 +0100
Message-Id: <20181210205955.3254660-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xGnY+Tz4mS0nI0F6dcf1GCsrhPj67IExbLpe9y/GFJxfpEnAMqx
 76oAA7L0SxJS7k2Zz/MfCziSdX/jtTn/ieutpTt++oMmsmhhiOKaBC/fBjJBbqiGaukXXLG
 g5lyeLZg/jVWWrIFgwgWA5gD6k9GEyMpxHT18l6ltpSsfDkJUY3MEQyZ9fdr3b/AuS1KFoP
 kctMdQ9DnZBC2au/bDdfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hn4ltawq2Mc=:cVi0eOPx6XbQ5n0O33f9rI
 t28ZbvMJco+LyPJi0Xih9J7+PTQPafUcpEOVQzOL5D2xDQJq6Id/ev1UWzwUdvCDF9ZOMjR64
 TGjr5uV9/UGAYyK39BX5GVEQFtJoAWTGX1CCbN6OLr2N/UbUjKRhVhrlCNav3G2x5b2XF9jwp
 1zgJJiJT0YpwwgnA5Xi4qwhmIJyKOfkupm5WtaVEk2DUJC2c9SL2DotddohMq6wKi2zPC8ja5
 EJJZRr/n987qa7lCl0U4f12qJ/sODMwUV0bNXbERellyyPlyYNAdsLha6YAFdmOihwIn8iXmB
 LtTQWpon6FoZPQzIh5KrY4H7lHdCQNCrpgczPr09kplZyuizpwTGbGPKaqpthVSpDI/+Nw0c9
 J109Wk/+1y6HV6ZWcgf5S0NnUsTZjOUXnuQVxIQyOU4NDnBxjlSqDSr0PWo1vGr/L36hpwyRO
 9JVsHp3Iq8Llsqk0C/PcrD0azTXxFcSTAwH6MdNlpyAl5hVku7gxIndl3GUsOB2rnsxV442Pq
 quMnuugzKDfWQ/4vSqwennyPLR26q1uU8wCOdaw/9LGXkuinPSqVUgcV4uk1Mkm0gami0cZvq
 VcCn+yRFRpPrn1Bot0GNxClc8o/bnbE4fFmmOuFy1NN4cKnL9AM8NYG/b8qDrUG0zS6jPzRNf
 dLvaZhrqdxiSvNJN7XDx00vG0JUSeEPzEWjuOwM6epmexmfB9IiDitnWqsFLsDeF/To6BXuob
 J1ID8lFS8uITRUgm4IWU12IpknFW1g5aSZbQFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_PM_SLEEP, we get annoyting warnings about unused functions:

drivers/pinctrl/qcom/pinctrl-msm.c:1082:12: error: 'msm_pinctrl_resume' defined but not used [-Werror=unused-function]
 static int msm_pinctrl_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~
drivers/pinctrl/qcom/pinctrl-msm.c:1075:12: error: 'msm_pinctrl_suspend' defined but not used [-Werror=unused-function]
 static int msm_pinctrl_suspend(struct device *dev)

Mark them as __maybe_unused to shut up the warning and silently drop
the functions without having to add ugly #ifdefs.

Fixes: 977d057ad346 ("pinctrl: msm: Add sleep pinctrl state transitions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 87cbebe217fd..ee8119879c4c 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1072,14 +1072,14 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 		}
 }
 
-static int msm_pinctrl_suspend(struct device *dev)
+static __maybe_unused int msm_pinctrl_suspend(struct device *dev)
 {
 	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
 
 	return pinctrl_force_sleep(pctrl->pctrl);
 }
 
-static int msm_pinctrl_resume(struct device *dev)
+static __maybe_unused int msm_pinctrl_resume(struct device *dev)
 {
 	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
 
-- 
2.20.0

