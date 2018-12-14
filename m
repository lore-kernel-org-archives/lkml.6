Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF712C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715A0208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cz0SWphR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DVqQFBrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715A0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbeLNM3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:29:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeLNM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:29:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F08206083E; Fri, 14 Dec 2018 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790583;
        bh=wdwD9q6nzxphHLklpvou1TOQSsZBZnL3RQtg8ajXVJA=;
        h=From:To:Cc:Subject:Date:From;
        b=cz0SWphRLcHOW+UY6KYvxIAdALIqgU3jmFhE4APtBK/1JEuBVx2lROQtWFZwI4y8s
         ANV5qm4t+Fv0VFb7nAcmlZWz71gGDT1VhK/qw0+fDtTSgsOU1ruXzTd6dq7/khGU9L
         rb+Yka+EvJ4wBHRmU/pqhwtN4kxr/H0NjyS3SweM=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA7E7601C3;
        Fri, 14 Dec 2018 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790581;
        bh=wdwD9q6nzxphHLklpvou1TOQSsZBZnL3RQtg8ajXVJA=;
        h=From:To:Cc:Subject:Date:From;
        b=DVqQFBrqT89+oAF2aQD6VW0AP9hT+U9lHjc6uXutAopmANwSSEAB0vkfV0qPYhR0d
         QD5EgiC9SePyVrr1a7VV22a+YP7TqJiXwpV64R2iWFEVqECftIt1NSUNQ5vYWNsNEA
         SqkcLC5yfHl/u3FObaVeihfMUfMolbKq8YcPB84A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA7E7601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org,
        asishb@codeaurora.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/4] ASoC: qdsp6: Add support for audio over DP
Date:   Fri, 14 Dec 2018 17:59:25 +0530
Message-Id: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Audio over display port AFE port

Rohit kumar (4):
  ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding
  ASoC: qdsp6: qdafe: add support for display_port_rx
  ASoC: qdsp6: q6afe-dai: add support to Display port RX dais
  ASoC: qdsp6: q6routing: add display_port_rx port routing

 include/dt-bindings/sound/qcom,q6afe.h |  1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c       | 22 ++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.c           |  4 ++++
 sound/soc/qcom/qdsp6/q6routing.c       |  9 +++++++++
 4 files changed, 36 insertions(+)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

