Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id P+jJBPUUG1sgDwAAmS7hNA
	; Fri, 08 Jun 2018 23:45:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DEDC6607E7; Fri,  8 Jun 2018 23:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528501518;
	bh=AjRUXevwG/euX9sG4pk6V0lPwvAVHhHEX+4hv65lZNg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N71CNqcWveaMMckPR/wJR7ob0zYU+PuJ19r1s7+G98cjjj92nHvQHe4+RwWCcStBA
	 T/RUD7N5wHCE5N4yWHTbtFqed4ErvUHAPAh6quoZrYhGbyEpGXnFN+eF3rQWpGR4tu
	 PcwTeE3g7Qz6WzyNeSl8/AIiuFrK7eAGNrVLRzuc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C83D2607E7;
	Fri,  8 Jun 2018 23:45:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AxwmGR2e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gxqwpqgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C83D2607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeFHXop (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:44:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeFHXom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:44:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35BAF608CD; Fri,  8 Jun 2018 23:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528501482;
        bh=AjRUXevwG/euX9sG4pk6V0lPwvAVHhHEX+4hv65lZNg=;
        h=From:To:Cc:Subject:Date:From;
        b=AxwmGR2e/xHdijEm89q4rHP7KSmDrTuaEtmKkaUrqVkd2SbbFRUuRC8G2qcC6cD3a
         Zwbhr8OGWLneC509mASLX0Gg3sDyw6WVYZG7epK8StEx2mWp2f8w302T/zEj1CPtEd
         /YZKmcSOTneG6rAvd3ndxXxfFq3hlCmvFQcUeNgg=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 529B6601B4;
        Fri,  8 Jun 2018 23:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528501480;
        bh=AjRUXevwG/euX9sG4pk6V0lPwvAVHhHEX+4hv65lZNg=;
        h=From:To:Cc:Subject:Date:From;
        b=gxqwpqgSGjN+IFNV2Gpopfx7gdhmKmdUDX7oMW2YY5guAzPb5bprG7mBYzwEPUa65
         +cu0b732w2lyDnGPeCrs2njWaX6De/I/bnMHGRiE4XrL04jt4m1rb58m1eJdG93LP9
         /P4MTETIIxCyBhaOdiuG/AKJecfbnTx5ZXnAVvF4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 529B6601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org, mka@chromium.org
Subject: [PATCH v7 0/2] regulator: add QCOM RPMh regulator driver
Date: Fri,  8 Jun 2018 16:44:13 -0700
Message-Id: <cover.1528498807.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver and device tree binding documentation for
PMIC regulator control via Resource Power Manager-hardened (RPMh) on some
Qualcomm Technologies, Inc. SoCs such as SDM845.  RPMh is a hardware block
which contains several accelerators which are used to manage various
hardware resources that are shared between the processors of the SoC.  The
final hardware state of a regulator is determined within RPMh by performing
max aggregation of the requests made by all of the processors.

The RPMh regulator driver depends upon the RPMh driver [1] and command DB
driver [2] which are both still undergoing review.  It also depends upon
three recent regulator changes: [3], [4], and [5].

Changes since v6 [6]:
 - Removed 'count' parameter from rpmh_regulator_send_request() since
   it is always 1
 - Fixed _rpmh_regulator_vrm_set_voltage_sel() return value
 - Added a helper function to capture common code between
   rpmh_regulator_enable() and rpmh_regulator_disable()
 - Added an iterator for pmic_rpmh_data in rpmh_regulator_init_vreg()
 - Added Reviewed-by tag for both patches

Changes since v5 [7]:
 - Removed unused constants
 - Added Reviewed-by tag for DT patch 1/2

Changes since v4 [8]:
 - Removed support for DT properties qcom,regulator-drms-modes and
   qcom,drms-mode-max-microamps
 - Specified fixed DRMS high power mode minimum limits for LDO type
   regulators
 - Removed DRMS support for SMPS and BOB type regulators
 - Simplified voltage caching logic

Changes since v3 [9]:
 - Removed support for DT properties qcom,regulator-initial-microvolt
   and qcom,headroom-microvolt
 - Renamed DT property qcom,allowed-drms-modes to be
   qcom,regulator-drms-modes
 - Updated DT binding documentation to mention which common regulator
   bindings can be used for qcom-rpmh-regulator devices
 - Added voltage caching so that voltage requests are only sent to RPMh
   after the regulator has been enabled at least once
 - Changed 'voltage_selector' default value to be -ENOTRECOVERABLE to
   interact with [5]
 - Initialized 'enabled' to -EINVAL so that unused regulators are
   disabled by regulator_late_cleanup()
 - Removed rpmh_regulator_load_default_parameters() as it is no longer
   needed
 - Updated the mode usage description in qcom,rpmh-regulator.h

Changes since v2 [10]:
 - Replaced '_' with '-' in device tree supply property names
 - Renamed qcom_rpmh-regulator.c to be qcom-rpmh-regulator.c
 - Updated various DT property names to use "microvolt" and "microamp"
 - Moved allowed modes constraint specification out of the driver [4]
 - Replaced rpmh_client with device pointer to match new RPMh API [1]
 - Corrected drms mode threshold checking
 - Initialized voltage_selector to -EINVAL when not specified in DT
 - Added constants for PMIC regulator hardware modes
 - Corrected type sign of mode mapping tables
 - Made variable names for mode arrays plural
 - Simplified Kconfig depends on
 - Removed unnecessary constants and struct fields
 - Added some descriptive comments

Changes since v1 [11]:
 - Addressed review feedback from Doug, Mark, and Stephen
 - Replaced set_voltage()/get_voltage() callbacks with set_voltage_sel()/
   get_voltage_sel()
 - Added set_bypass()/get_bypass() callbacks for BOB pass-through mode
   control
 - Removed top-level PMIC data structures
 - Removed initialization variables from structs and passed them as
   function parameters
 - Removed various comments and error messages
 - Simplified mode handling
 - Refactored per-PMIC rpmh-regulator data specification
 - Simplified probe function
 - Moved header into DT patch
 - Removed redundant property listings from DT binding documentation

[1]: https://lkml.org/lkml/2018/5/9/729
[2]: https://lkml.org/lkml/2018/4/10/714
[3]: https://lkml.org/lkml/2018/4/18/556
[4]: https://lkml.org/lkml/2018/5/11/696
[5]: https://lkml.org/lkml/2018/5/15/1005
[6]: https://lkml.org/lkml/2018/6/4/879
[7]: https://lkml.org/lkml/2018/6/1/895
[8]: https://lkml.org/lkml/2018/5/22/1168
[9]: https://lkml.org/lkml/2018/5/11/701
[10]: https://lkml.org/lkml/2018/4/13/687
[11]: https://lkml.org/lkml/2018/3/16/1431

David Collins (2):
  regulator: dt-bindings: add QCOM RPMh regulator bindings
  regulator: add QCOM RPMh regulator driver

 .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-rpmh-regulator.c            | 753 +++++++++++++++++++++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +
 5 files changed, 959 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 drivers/regulator/qcom-rpmh-regulator.c
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
