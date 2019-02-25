Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE19C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF821734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfBYMTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:19:33 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:46634 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfBYMTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:19:32 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id B1D7C13F892;
        Mon, 25 Feb 2019 13:19:05 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v5 0/3] UFS on APQ8098/MSM8998
To:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Message-ID: <43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr>
Date:   Mon, 25 Feb 2019 13:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for the UFS host controller on APQ8098/MSM8998-based boards.

This should be the final rev ;-)

Differences between v4 and v5:
- Drop patches that have already been accepted or spun off

Differences between v3 and v4:
- Rebase on top of -next
- Pick up Douglas Anderson's UFSHC doc fix
- Document 8998 UFSHC binding
- Improve UFS PHY binding doc
- Put the UFS DT patch at the end of the series

Difference between v2 and v3:
- Add qcom,msm8998-qmp-ufs-phy compat string and match it in the PHY driver
- Drop vdd-hba-fixed-regulator
- Write the reg addresses with full 32-bit width
- Set regulator-allow-set-load only on the 3 rails used by UFS.
- Revert the patch introducing ufshcd_set_vccq_rail_unused

Difference between v1 and v2:
- New patch to add 'regulator-allow-set-load' prop to all vreg nodes
- Rename rpmcc node to 'clock-controller' + Add Review tags
- Drop UFS pinctrl gymnastics (not required, probably left enabled in bootloader)
- Delete GCC_UFS_ICE_CORE_CLK (ICE not used upstream, I think)
- Fix sizes of ufsphy register areas based on Jeffrey's feedback
- Hack ufshcd_set_vccq_rail_unused into a NOP to work around lock up + reboot


Marc Gonzalez (3):
  dt-bindings: ufs: Add msm8998 compatible string
  arm64: dts: qcom: msm8998: Allow UFSHC driver to set-load
  arm64: dts: qcom: msm8998: Add UFS nodes

 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  1 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 22 +++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 65 +++++++++++++++++++
 3 files changed, 88 insertions(+)

-- 
2.17.1
