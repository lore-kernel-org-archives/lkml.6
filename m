Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9801CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B77D2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JNkmfZgm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JNkmfZgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfBUMk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:40:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBUMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:40:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ADA0C60918; Thu, 21 Feb 2019 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550752857;
        bh=tdhGgBJNasfxKOTqY0uGlm58t6SuF3V0o+puWs6LtGk=;
        h=From:To:Cc:Subject:Date:From;
        b=JNkmfZgmGMF6s3UbwXYrg054QJCoubqPtGgZ/lAqaHYtI+B0timZ74wa1nVOrXTzk
         PQn9zZfkbHF9f8CuKb5yWvCiS5IMq8vmkLajIlsEVpMx0Y9aLiqLTceGwA3q4d9J/s
         bPga/lb9r+C8aEqdJxoQT3Ny6WC2E1epfMdKUGlg=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C807605FC;
        Thu, 21 Feb 2019 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550752857;
        bh=tdhGgBJNasfxKOTqY0uGlm58t6SuF3V0o+puWs6LtGk=;
        h=From:To:Cc:Subject:Date:From;
        b=JNkmfZgmGMF6s3UbwXYrg054QJCoubqPtGgZ/lAqaHYtI+B0timZ74wa1nVOrXTzk
         PQn9zZfkbHF9f8CuKb5yWvCiS5IMq8vmkLajIlsEVpMx0Y9aLiqLTceGwA3q4d9J/s
         bPga/lb9r+C8aEqdJxoQT3Ny6WC2E1epfMdKUGlg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C807605FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 0/2] drivers: qcom: Fixes in RPMh driver 
Date:   Thu, 21 Feb 2019 18:10:34 +0530
Message-Id: <20190221124036.30535-1-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series consists of couple of fixes identified in RPMh driver.
Please consider reviewing the patches.


Maulik Shah (1):
  drivers: soc: qcom: rpmh-rsc: Correct check for slot number

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh: avoid sending sleep/wake sets immediately

 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 drivers/soc/qcom/rpmh.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

