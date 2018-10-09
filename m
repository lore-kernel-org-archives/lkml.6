Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B27FC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2C2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cJP2YYMi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aZ3O5Ck8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA2C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJIJXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:23:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJIJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:23:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6AE6360C1C; Tue,  9 Oct 2018 02:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539050922;
        bh=2n9AC0v1eFlw0KQF9w3vTmaH7KwSEZ0C0ty/NAUUOv0=;
        h=From:To:Cc:Subject:Date:From;
        b=cJP2YYMinf1rondRbFnLzTHAJ4J3KgPmaTVHc8EfGgZTy3PSiBgGhRAzgbSEZ9Xl3
         a4O5dYmQpAq4TayzUmlOVSw+loXaxPyzmUxKa7C1V8wrd/PHHhE+dgeiG5xKcEMbTM
         VPM6/L4VBMkDpbH5DbhnnpjMYXqp2fstn84M8/Eo=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3501760249;
        Tue,  9 Oct 2018 02:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539050921;
        bh=2n9AC0v1eFlw0KQF9w3vTmaH7KwSEZ0C0ty/NAUUOv0=;
        h=From:To:Cc:Subject:Date:From;
        b=aZ3O5Ck8MnNCNktTIueOjdF9VpIai2t0dpDmHSo3sTZynkicsmqJTxXE9eMG0W5Bj
         S+sYAQvy9Tgrn7cmFZRgbIdbANAmyUx+wAw3FfUZFg2MVE/rQqAF6r0V4v/jaIItCa
         kfvJN+b87G/082Ih8/PZoUwzQwtHR5aDkJ4f3ppk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3501760249
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
Subject: [PATCH v3 0/3] drivers/qcom: add additional functionality to RPMH
Date:   Tue,  9 Oct 2018 07:38:29 +0530
Message-Id: <1539050912-25749-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
[2] https://lkml.org/lkml/2018/10/3/422


Lina Iyer (2):
  drivers: qcom: rpmh-rsc: return if the controller is idle
  drivers: qcom: rpmh: disallow active requests in solver mode

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh-rsc: simplify TCS locking

 drivers/soc/qcom/rpmh-internal.h |  8 +++-
 drivers/soc/qcom/rpmh-rsc.c      | 92 +++++++++++++++++++++++++++++-----------
 drivers/soc/qcom/rpmh.c          | 84 ++++++++++++++++++++++++++++++------
 include/soc/qcom/rpmh.h          | 10 +++++
 4 files changed, 156 insertions(+), 38 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

