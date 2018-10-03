Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9248FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4148B2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g7xevW9P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g7xevW9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4148B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJCQoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:44:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeJCQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:44:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB6A1601D4; Wed,  3 Oct 2018 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538560603;
        bh=1KB4+R+TPRb9cjfIPHcA1SyPNlqvD5uC3m6Ivo1KGQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=g7xevW9PA6ocMHuZ2zTnbYczMaMyvLhufrnBjvzmvM/1RxsPaOLmyJsBw5wWMzw7n
         noaZXKx3uFu5EY81APAI0pxpibX1o9gInYOt9d8N7O3bJjD59CgpFNIPSstPvkAvse
         oXFS2E18fwe2FzvxSH8+mVYhC/Lm1JEfe86uGpkI=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB73E601D4;
        Wed,  3 Oct 2018 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538560603;
        bh=1KB4+R+TPRb9cjfIPHcA1SyPNlqvD5uC3m6Ivo1KGQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=g7xevW9PA6ocMHuZ2zTnbYczMaMyvLhufrnBjvzmvM/1RxsPaOLmyJsBw5wWMzw7n
         noaZXKx3uFu5EY81APAI0pxpibX1o9gInYOt9d8N7O3bJjD59CgpFNIPSstPvkAvse
         oXFS2E18fwe2FzvxSH8+mVYhC/Lm1JEfe86uGpkI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB73E601D4
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
Subject: [PATCH v1 0/2] drivers/qcom/rpmh: program wakeup timer 
Date:   Wed,  3 Oct 2018 15:26:33 +0530
Message-Id: <1538560595-6275-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this series were reviewed as part of "add additional
functionality to RPMH"[1]. These patches are independent of other
patches in the original series.

Changes done:
  - Minor update to commit text for first patch[2].
  - squashed two related "write PDC" patches[3][4] into single patch.

Please consider reviewing this patch set.

[1] https://patchwork.kernel.org/cover/10546863/
[2] https://patchwork.kernel.org/patch/10546859/
[3] https://patchwork.kernel.org/patch/10546855/
[4] https://patchwork.kernel.org/patch/10546857/

This series is based on https://patchwork.kernel.org/patch/10589385/

Lina Iyer (1):
  drivers: qcom: rpmh: write PDC data

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh-rsc: clear active mode configuration for wake TCS

 drivers/soc/qcom/rpmh-internal.h |   4 +-
 drivers/soc/qcom/rpmh-rsc.c      | 112 +++++++++++++++++++++++++++++----------
 drivers/soc/qcom/rpmh.c          |  28 ++++++++++
 include/soc/qcom/rpmh.h          |   7 +++
 4 files changed, 121 insertions(+), 30 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

