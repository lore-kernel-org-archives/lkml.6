Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F474C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EDF20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EDF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJCEBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:01:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCEBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:01:16 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2lzA-1fk7qi15n2-0132JH; Tue, 02 Oct 2018 23:15:56 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2lzA-1fk7qi15n2-0132JH; Tue, 02 Oct 2018 23:15:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: fix 'const' pointer handling
Date:   Tue,  2 Oct 2018 23:15:44 +0200
Message-Id: <20181002211555.2779637-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:N1yk+wGgiUoOnCenGGs2KZwDO64dbHyATk86wvmaNJb8DLuNVmY
 MA65ouDKSevON/KJtCGI/G3wadpSDFZskAL/w0Ev9iSRw1ouNa7Kk88zafZlL9UliNFhGaa
 ykVdd+J7LmZx+NMWq1nP4VjO8J0e9k+IPxtObvubb/wcHS877RXw8OprJz+evpA9w4aRI77
 X8Ug8ogw6RM+aWk8bqvkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eg8LwGmNVs0=:iANhTafTIqA0FhhIqqIWvh
 InNZCNgKYyBGyC4zGOrmzUnsFtAPgFrMlyR97f9ccKqopkdB2TLNxb/0TLKK1VNLCaKsmgNYX
 unWoprjhIFMhfeLsMQB7oLcDo+J3qCbkcmnZ/y2CHXgSIFIPVJ2zQ18fP/3dvOO5EJ3PyAanH
 AqjnQRnW3cqDbQRZSRVQhryCxA0G47D8eAci+APtrlO6WWTgteNJstuw4QwGCpvGAM8BK4hv5
 yEVpISEJBj/eVgho7WrFGKgs+qEZGqFVmMTmNdm5EPeIU7Gwgqq/RH3TOFS4zyi48wIUSA6mL
 ISBZesiO8d9xdxCIYaVfYlom6xcJ5Qr1wmlWsSzl4MYs9E2WHikSwpfeb4cVjNFiSoWRg+2/x
 698nbfTE2eKQZpfV7+DmnhfaoCAb6WC3krvJARbBvmH/uZ6op2qcFuFsoJdF44QmR2RSOn7Q2
 KSIFgbtskzD2qU1boM/a06Q9lLIrF0sisbgO/ZpENr3nX/P9Vj2VRQ+QxfT/9vvElg+S50LUQ
 c0QvokVi/+aVVfjWXEaHH4zRT2z4omfZOvYsIWMhvh+ImhggSCCJ4WgXQkfUqHyhSqRfVlFxU
 d7sHzd6dh9JtjC3p/nh5IqwGRjwKbMKJZkVzuIn6Fzx+Ml0zFY+NQ6WJzuLTsnYZGQnErYiGa
 m6k2Vq7X7a6W24G6icQjZbothRQMenSI/I/dS+PRYtF0XK58ORFoiUe0nFRZpfoPQZt8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'tiles' array is initialized to a constant pointers to constant
strings, but the declaration is only half as constant:

drivers/pinctrl/qcom/pinctrl-qcs404.c:1660:11: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
drivers/pinctrl/qcom/pinctrl-sdm660.c:1417:11: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

Let's make it more constant.

Fixes: 22eb8301dbc1 ("pinctrl: qcom: Add qcs404 pinctrl driver")
Fixes: a46d5e98190d ("pinctrl: qcom: Support dispersed tiles")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/qcom/pinctrl-msm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 0ad4bc55e2e1..29172fdf5882 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -119,7 +119,7 @@ struct msm_pinctrl_soc_data {
 	unsigned ngroups;
 	unsigned ngpios;
 	bool pull_no_keeper;
-	const char **tiles;
+	const char *const *tiles;
 	unsigned int ntiles;
 };
 
-- 
2.18.0

