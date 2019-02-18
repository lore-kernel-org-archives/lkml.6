Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE4C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DD120842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LqctZWWb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g5hL1h5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbfBROCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:02:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389379AbfBROC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CEDFB60A60; Mon, 18 Feb 2019 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550498548;
        bh=ZuiU6M9d1gqQQGliAvJ7hzbJ5st1q1MdkREAqir+ey0=;
        h=From:To:Cc:Subject:Date:From;
        b=LqctZWWbF66ZgPc3o0bPayoJjBkcvkHp+dzoiB742suZSxUaIniFiIXzJLCTrcctX
         C8qVYJu14JJ079yULvVNxpm64LAsWz3V6zWNN//gGehXGIVGjl1v0CE7lpNQ0QEMfH
         2SlmVESaSrr67NCBIOXJ7owrws/O4DugmDHxIoCA=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3F7660A60;
        Mon, 18 Feb 2019 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550498546;
        bh=ZuiU6M9d1gqQQGliAvJ7hzbJ5st1q1MdkREAqir+ey0=;
        h=From:To:Cc:Subject:Date:From;
        b=g5hL1h5if2FMLbd2cJQw1tuqHUU+c+TZOAN3aGQypvGZ0+Z99BskDxpHeyLW4gl2k
         dLQJRNt9sYb6SZzwtdfPAyYNpLlVAvt0AO85NuPfcSqLqYwKYTDelgBykNqqfDXyL4
         GVvKWkxG1vxJfv592NmflJsz+Hk+IcZ10XkP1Vng=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3F7660A60
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
Subject: [PATCH RESEND v1 0/2] drivers/qcom: add additional functionality to RPMH 
Date:   Mon, 18 Feb 2019 19:32:08 +0530
Message-Id: <20190218140210.14631-1-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patches which were reviewed befeore.

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

Lina Iyer (1):
  drivers: qcom: rpmh: write PDC data

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh-rsc: clear active mode configuration for wake TCS

 drivers/soc/qcom/rpmh-internal.h |   4 +-
 drivers/soc/qcom/rpmh-rsc.c      | 112 +++++++++++++++++++++++--------
 drivers/soc/qcom/rpmh.c          |  28 ++++++++
 include/soc/qcom/rpmh.h          |   7 ++
 4 files changed, 121 insertions(+), 30 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

