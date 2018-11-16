Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D145C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E8720818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HsDAgu4x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HsDAgu4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E8720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbeKPRx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:53:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:53:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E874460A33; Fri, 16 Nov 2018 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542354132;
        bh=vGm8VdGQjOw9DRWvYr1pdOEUSFfmKJwdZVXHGnjW9f4=;
        h=From:To:Cc:Subject:Date:From;
        b=HsDAgu4x6WusqOuI1ZZET2aWvtUSg69jIJNq+5eeFwGuLm6L0R7nDIDvIk16boYaK
         Cyw2ob3XmMhlA+F7wpYj4ioctVEkcCAvpn8OLwNpWgxAIpbEI1XsIE3S5d+uwpJgoY
         7xw6YY7Tf4y7+l99jTfpWdH+OrJW+cQEC+JK1/vw=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FF76605A2;
        Fri, 16 Nov 2018 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542354132;
        bh=vGm8VdGQjOw9DRWvYr1pdOEUSFfmKJwdZVXHGnjW9f4=;
        h=From:To:Cc:Subject:Date:From;
        b=HsDAgu4x6WusqOuI1ZZET2aWvtUSg69jIJNq+5eeFwGuLm6L0R7nDIDvIk16boYaK
         Cyw2ob3XmMhlA+F7wpYj4ioctVEkcCAvpn8OLwNpWgxAIpbEI1XsIE3S5d+uwpJgoY
         7xw6YY7Tf4y7+l99jTfpWdH+OrJW+cQEC+JK1/vw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FF76605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/2] ASoC: SDM845: Update MI2S and TDM configuration
Date:   Fri, 16 Nov 2018 13:11:56 +0530
Message-Id: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update bit clock rate, slot width for TDM and MI2S
interfaces. Also add support for secondary MI2S TX
interface in SDM845 machine driver.

Rohit kumar (2):
  ASoC: sdm845: Update slot_width for Quaternary TDM port
  ASoC: sdm845: Add support for Secondary MI2S interface

 sound/soc/qcom/sdm845.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

