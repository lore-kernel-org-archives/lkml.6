Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E4AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778492152D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778492152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbeHCOmc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:42:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57962 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeHCOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:42:32 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id A9622CEF96;
        Fri,  3 Aug 2018 14:53:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v15 0/7] Enable Bluetooth functionality for WCN3990 
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180803121632.30689-1-bgodavar@codeaurora.org>
Date:   Fri, 3 Aug 2018 14:46:19 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9348C715-71AE-416B-8460-55135FFDAC7E@holtmann.org>
References: <20180803121632.30689-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> These patches enables Bluetooth functinalties for new Qualcomm
> Bluetooth chip wnc3990. As this is latest chip with new features, 
> along with some common features to old chip "qcom,qca6174-bt".
> we have updated names of functions that are used for both the chips 
> to keep this generic and would help in future when we would have new 
> BT SoC.
> 
> The below are difference between new and old chips.
> 
> *Power:
> *New chip: we use voltage regulators to turn on/off the chip and we 
>  must send a command on Tx line to turn on/off the chip completely.
> *Old chip: We turn on/off by setting a GPIO.
> 
> *Note: Turning on sequence differs between two chips.
> 
> *Firmware download:
>  Only firmware file name differ from New and Old chip.
> 
>  So we reused some functions/structure/variables which are used for old 
>  chip to New chip by generic naming (may be future chips may use same functions).
> 
> * As we have multiple changes for functions names,we have tested these patches 
>   on both chips.
> 
> v15:
> * fixed nit issue in hci_qca.
> 
> v13:
> * Segregated optional and required properties for wcn3990.
> 
> v12:
> * removed iteration loop in qca_init_wcn3990 
> * updated review comments.
> 
> v11:
> * removed regulator current from dtbindings
> * addressed review comments.
> 
> v10:
> * update current load with actual values of WCN3990.
> * added support  for itterative connect with BT chip if it fails to respond to the HOST.
> * Added regulator current dtbindings.
> * addressed review comments.
> 
> v9:
> * removed smps regs.
> * hidded flow control in respective functions.
> * moved qca_soc_ver to qca_setup
> * addressed review comments.
> 
> v8:
>  * Squashed [v7 2/8] and [v7 3/8] to one patch.
>  * updated functions to set and get the UART speeds.
>  * addressed review comments.
> 
> v7:
>  * Renamed all the possible function of ROME to generic.
>  * updated with review comments for hci_qca and btqca
>  * fixed kbuild errors.
>  * created wrapper functions for re-usable blocks.
> 
> v6:
>  * Hooked up qca_power to qca_serdev.
>  * renamed all the naming inconsistency functions with qca_*
>  * leveraged common code of ROME for wcn3990.
>  * created wrapper functions for re-usable blocks.
>  * updated function of _*regulator_enable and _*regualtor_disable.  
>  * removed redundant comments and functions.
>  * add code to derive the firmware files based on ROM Version.
>  * created new patch for common function of ROME and wcn3990.
>  * enables Qualcomm chip to operate at 3.2Mbps.
>  * updated names of functions that are used for both the chips to keep this generic. 
> 
> v5:
>  * updated with review comments for hci_qca and btqca
> 
> v4:
>  * rebased all changes on top of bluetooth-next.
>  * addressed review comments.
>  * New patch created for firmware download.
> 
> v3:
>  * Rebased all changes on top of bluetooth-next.
>  * dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
>    - added dt-binding snippet for bluetooth chip wcn3990.
>  * Bluetooth: Add support for wcn3990 soc.
>    - updated BT_INFO with bt_dev_info, where ever necessary.
> 
> v2:
>   * Add support for wcn3990:
>    These changes are aligned as per serdev frame work.
>          We implemented these changes on top of https://patchwork.kernel.org/patch/10316093/
>        As this patch enable serdev for one of the Qualcomm BT chip.
> 
>        The changes in the patch include.
>        - Adding support to voting up/down regulators for WCN3990.
>           - Bluetooth firmware download for wcn3990.
> 
>  * Add device tree bindings for Atheros chips:
>          These changes are on top of https://patchwork.kernel.org/patch/10316097/.
>          - Description of device tree bindings.
> 
> Balakrishna Godavarthi (7):
>  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
>    wcn3990
>  Bluetooth: btqca: Rename ROME specific functions to generic functions
>  Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
>  Bluetooth: hci_qca: Add wrapper functions for setting UART speed
>  Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
>  Bluetooth: btqca: Add wcn3990 firmware download support.
>  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990
> 
> .../bindings/net/qualcomm-bluetooth.txt       |  29 +-
> drivers/bluetooth/btqca.c                     | 117 +++--
> drivers/bluetooth/btqca.h                     |  22 +-
> drivers/bluetooth/hci_qca.c                   | 486 +++++++++++++++---
> 4 files changed, 539 insertions(+), 115 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

If we need to fix things, we fix them with additional patches instead of respinning the series.

Regards

Marcel

