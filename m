Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8721479
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CfCD72PY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V5GbNlXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F8721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeK3Shu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:37:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Shu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:37:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6AC5C6079C; Fri, 30 Nov 2018 07:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543562968;
        bh=rW0iKAE/RMiEwTs4dj9cdKKF0bx5IiNP3mzcVSkkXUg=;
        h=From:To:Cc:Subject:Date:From;
        b=CfCD72PYptFVhOXuTQLAWTHYAlsfu8BUpHX6787Oj3vrgeosRmjJ0dIMkHoXCy9cw
         OoTf3gm/mVaWLL+siWZSHt7RrkhT+zNobpZgtJhNcWXXYfuhKeUwpfk2m6iDFbEILH
         xt+MG86ITvYOaaepA8+LT9UZGzSjkcjKt1JiH6vM=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BBE26079C;
        Fri, 30 Nov 2018 07:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543562967;
        bh=rW0iKAE/RMiEwTs4dj9cdKKF0bx5IiNP3mzcVSkkXUg=;
        h=From:To:Cc:Subject:Date:From;
        b=V5GbNlXNObHbuSVr/LjhJUCXA9Jzvjf1FyiBrUV+TCoKYfkXNpIrq42XxoSZ6cBzO
         r/o9Cfl+5M9yFPZC1taUb+VqNuGiuvbFE8WQsj3z4323UMRPWrGQOP8YQyPeWwdIer
         oX978GeTl7V7TISttICZYunijL5KtPvD1lo+AJ9k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BBE26079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/2] qcom_adsp_pil: Remove voting for lpass_aon clock
Date:   Fri, 30 Nov 2018 12:59:08 +0530
Message-Id: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPASS Audio Wrapper AON clock is on by default. Remove
voting for it.

Rohit kumar (2):
  dt-binding: remoteproc: Remove lpass_aon clock from adsp pil clock
    list
  remoteproc: q6v5_adsp: Remove voting for lpass_aon clock

 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt | 5 ++---
 drivers/remoteproc/qcom_q6v5_adsp.c                            | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

