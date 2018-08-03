Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785AA21707
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TOYI1T7/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H02z37/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785AA21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeHCM7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:59:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeHCM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:59:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A97826063A; Fri,  3 Aug 2018 11:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533294206;
        bh=PHe2txKjxfC/gyxVlmOLbzd9/CLzBeWBbBGOgJJNZ4E=;
        h=From:To:Cc:Subject:Date:From;
        b=TOYI1T7/7bkZuRfhIo7S9+Us6fA8lZs7hlBIYExxXeOJ3NB8TBXnYqNFY9INZWHNc
         y8iGTakTJo4/r5yLYEJZNiCyUE/P48HNM5NYrOl4n+5UVPVRTBFbCk9zGX/5EXrDpQ
         dWcvdSNHpdN8npT0ZsT05wsL3cSpbJVBVb15LT8o=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93996601A1;
        Fri,  3 Aug 2018 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533294205;
        bh=PHe2txKjxfC/gyxVlmOLbzd9/CLzBeWBbBGOgJJNZ4E=;
        h=From:To:Cc:Subject:Date:From;
        b=H02z37/b6zm85mLlxW0+btzxcO4aDz3J3JTZGSoWf9RNAHETM/qIff5O7G6MFEO+d
         f62sS/PxDMNHcIfsDQKdJed4sftHKGqdL2cIGmjfID8z8ePk2wrYNX65FgQfqofRzO
         WFedzwFK8KQq303faaBg9aLLMKgdHI9mPlVW1zi8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93996601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v14 0/7] Enable Bluetooth functionality for WCN3990
Date:   Fri,  3 Aug 2018 16:31:24 +0530
Message-Id: <20180803110131.11090-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches enables Bluetooth functinalties for new Qualcomm
Bluetooth chip wnc3990. As this is latest chip with new features, 
along with some common features to old chip "qcom,qca6174-bt".
we have updated names of functions that are used for both the chips 
to keep this generic and would help in future when we would have new 
BT SoC.

The below are difference between new and old chips.

*Power:
 *New chip: we use voltage regulators to turn on/off the chip and we 
  must send a command on Tx line to turn on/off the chip completely.
 *Old chip: We turn on/off by setting a GPIO.

 *Note: Turning on sequence differs between two chips.

*Firmware download:
  Only firmware file name differ from New and Old chip.
  
  So we reused some functions/structure/variables which are used for old 
  chip to New chip by generic naming (may be future chips may use same functions).

 * As we have multiple changes for functions names,we have tested these patches 
   on both chips.

v13:
 * Segregated optional and required properties for wcn3990.

v12:
 * removed iteration loop in qca_init_wcn3990 
 * updated review comments.

v11:
 * removed regulator current from dtbindings
 * addressed review comments.

v10:
 * update current load with actual values of WCN3990.
 * added support  for itterative connect with BT chip if it fails to respond to the HOST.
 * Added regulator current dtbindings.
 * addressed review comments.

v9:
 * removed smps regs.
 * hidded flow control in respective functions.
 * moved qca_soc_ver to qca_setup
 * addressed review comments.
 
v8:
  * Squashed [v7 2/8] and [v7 3/8] to one patch.
  * updated functions to set and get the UART speeds.
  * addressed review comments.

v7:
  * Renamed all the possible function of ROME to generic.
  * updated with review comments for hci_qca and btqca
  * fixed kbuild errors.
  * created wrapper functions for re-usable blocks.
 
v6:
  * Hooked up qca_power to qca_serdev.
  * renamed all the naming inconsistency functions with qca_*
  * leveraged common code of ROME for wcn3990.
  * created wrapper functions for re-usable blocks.
  * updated function of _*regulator_enable and _*regualtor_disable.  
  * removed redundant comments and functions.
  * add code to derive the firmware files based on ROM Version.
  * created new patch for common function of ROME and wcn3990.
  * enables Qualcomm chip to operate at 3.2Mbps.
  * updated names of functions that are used for both the chips to keep this generic. 

v5:
  * updated with review comments for hci_qca and btqca
 
v4:
  * rebased all changes on top of bluetooth-next.
  * addressed review comments.
  * New patch created for firmware download.

v3:
  * Rebased all changes on top of bluetooth-next.
  * dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
    - added dt-binding snippet for bluetooth chip wcn3990.
  * Bluetooth: Add support for wcn3990 soc.
    - updated BT_INFO with bt_dev_info, where ever necessary.

v2:
   * Add support for wcn3990:
    These changes are aligned as per serdev frame work.
          We implemented these changes on top of https://patchwork.kernel.org/patch/10316093/
        As this patch enable serdev for one of the Qualcomm BT chip.

        The changes in the patch include.
        - Adding support to voting up/down regulators for WCN3990.
           - Bluetooth firmware download for wcn3990.

  * Add device tree bindings for Atheros chips:
          These changes are on top of https://patchwork.kernel.org/patch/10316097/.
          - Description of device tree bindings.

Balakrishna Godavarthi (7):
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3990
  Bluetooth: btqca: Rename ROME specific functions to generic functions
  Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
  Bluetooth: hci_qca: Add wrapper functions for setting UART speed
  Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
  Bluetooth: btqca: Add wcn3990 firmware download support.
  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990

 .../bindings/net/qualcomm-bluetooth.txt       |  29 +-
 drivers/bluetooth/btqca.c                     | 117 +++--
 drivers/bluetooth/btqca.h                     |  22 +-
 drivers/bluetooth/hci_qca.c                   | 486 +++++++++++++++---
 4 files changed, 539 insertions(+), 115 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

