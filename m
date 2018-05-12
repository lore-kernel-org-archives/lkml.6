Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeELBq5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 21:46:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeELBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 21:46:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36E1460712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: [PATCH 0/2] regulator: of: add device tree property for allowed modes
Date: Fri, 11 May 2018 18:46:45 -0700
Message-Id: <cover.1526088289.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently no accepted way to configure constraints->valid_modes_mask
for regulators defined in device tree.  This patch series defines a new
common regulator device tree property, regulator-allowed-modes, which can be
used to specify the set of modes that the regulator is allowed to use.
It also implements parsing for this new property inside of the
of_get_regulation_constraints() function.

David Collins (2):
  regulator: of: add property for allowed modes specification
  regulator: of: add support for allowed modes configuration

 .../devicetree/bindings/regulator/regulator.txt    |  5 ++++
 drivers/regulator/of_regulator.c                   | 29 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
