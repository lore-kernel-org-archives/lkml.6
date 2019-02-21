Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930A92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CDRX1uSf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jAfhoU6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfBUMSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:18:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUMSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:18:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E9DB604A6; Thu, 21 Feb 2019 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550751517;
        bh=NPiqqxNGjJW2ZcjWQQHEoe1l5fMW+ee0OtzFav+KfFU=;
        h=From:To:Cc:Subject:Date:From;
        b=CDRX1uSf3PLV99OaI2Hvd6e5BCWfhe+iZNiXPXwDMcdUdOsv28PjCFla1Pyn3qFN2
         dtd/KJtu7frNYw7Li6sOfiTryx7tJhHcg5Is57MIw5i8sKnQqwNPpmj1d2t+qJhRvc
         cADnhlZwPbOaxXRKGc7Hpmw9tuT/Nl6PPbCNS65Y=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DE4C604A6;
        Thu, 21 Feb 2019 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550751515;
        bh=NPiqqxNGjJW2ZcjWQQHEoe1l5fMW+ee0OtzFav+KfFU=;
        h=From:To:Cc:Subject:Date:From;
        b=jAfhoU6z4//Dd06ItW+lc98G9VEO7Zlz82KlGh5yA3vVuNs9bQtOqsxkbd9+0bfHY
         dQcFSHjkG+n/2AwZQsrz8dBn9HIsQmFu51cJt1R1hyBAXdMgXVF+o4wRpoKAzZaJfh
         tS1T3HD7ViFqsRW82kYoWJSEbPNxMB4waVN831SQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DE4C604A6
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
Subject: [PATCH RESEND v3 0/3] add some more functionality to RPMH 
Date:   Thu, 21 Feb 2019 17:48:24 +0530
Message-Id: <20190221121827.32427-1-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patches. Kindly review.

Changes in v3:
 - Simplify TCS locking - added a new patch
 - Add lock check to avoid potential race as suggested by Matthias
 - Add functionality to RSC controller to disallow active requests
   if solver mode is not set 
 - Removed independent patches and posted as separate series[2]

Changes in v2:
 - Remove unnecessary EXPORT_SYMBOL in rpmh-rsc

This set of patches add additional functionality to RPMH drivers[1].

PM drivers can choose to disallow idle modes when RSC controller is busy
sending or processing requests. The patches add necessary functions to
query the controller status.

The controllers may be in 'solver' state, where they could be in autonomous
mode executing low power modes for their hardware and as such are not
available for sending active votes. Functionality to get notified about
such state and disallow requests for state change in that case is added
in these patches.

Please consider reviewing this patchset.

This series is based on other patchset[2] 


v1:https://lkml.org/lkml/2018/7/19/213
v2:https://patchwork.kernel.org/cover/10546863/


[1] https://lkml.org/lkml/2018/6/20/519
[2] https://lkml.org/lkml/2019/2/18/714


Lina Iyer (2):
  drivers: qcom: rpmh-rsc: return if the controller is idle
  drivers: qcom: rpmh: disallow active requests in solver mode

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh-rsc: simplify TCS locking

 drivers/soc/qcom/rpmh-internal.h |  8 ++-
 drivers/soc/qcom/rpmh-rsc.c      | 91 +++++++++++++++++++++++---------
 drivers/soc/qcom/rpmh.c          | 84 ++++++++++++++++++++++++-----
 include/soc/qcom/rpmh.h          | 10 ++++
 4 files changed, 155 insertions(+), 38 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

