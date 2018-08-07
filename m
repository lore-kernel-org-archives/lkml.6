Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E12172A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0E12172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbeHGVw3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:52:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52382 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388581AbeHGVw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:52:29 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 62C24CF2AF;
        Tue,  7 Aug 2018 21:43:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v10 0/3] add support for Bluetooth on MT7622 SoC
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cover.1533663928.git.sean.wang@mediatek.com>
Date:   Tue, 7 Aug 2018 21:36:32 +0200
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <69A04F99-C0B8-4571-8A0C-2DAFDAB51D86@holtmann.org>
References: <cover.1533663928.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> v10 and changes since v9: 
> - Add a fixup that is __be16 is required instead of dlen1 + dlen2 in STP header.
> - Align a few one-line comments style as they're made in v9
> - Fix two warnings catched by checkpatch.pl
> 	WARNING:TYPO_SPELLING: 'specifc' may be misspelled - perhaps 'specific'?
> 	at 248: FILE: drivers/bluetooth/btmtkuart.c:186:
> 
> 	WARNING:MEMORY_BARRIER: memory barrier without comment
> 	at 260: FILE: drivers/bluetooth/btmtkuart.c:198:
> 
> v9 and changes since v8:
> - Marcel Holtmann helps to add v9, which includes did a bunch of cosmetic minor cleanup,
>   spelling correction and added __hci_cmd_send and its event synchronization scheme.
>   For details, they can be found in [1].
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014587.html
> 
> v8 and changes since v7:
> - add updates per these suggestions mentioned in [1][2]
> - remove the hack atomic_inc(&hdev->cmd_cnt) mentioned in [2] because it should
>   be better to be considered in the core
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014516.html
> [2] http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014518.html
> 
> v7 and changes since v6:
> - drop already applied patches
> - move clk_* and pm_* operation to ->open and ->close 
> - label this driver as BT_MTKUART
> - make code style aligned with the other drivers and code better to read
>   as these suggestions and fixes are mentioned in [1]
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2018-July/014458.html
> 
> v6 and changes since v5:
> - make btmtkuart become a separate driver.
> - drop already applied patches and the patch for btuart driver
> - refine comments in driver allowing people know that mtk extra header
>   + length doesn't indicate a full H:4 frame, things can fragment.
> - enhance dt-binding document with removing mistaken added " and improve
>   English sentence.
> - remove unnecessary '\n' with bt_dev_err.
> - refine code style.
> - set hdev->manufacturer as mtk id.
> 
> v5 and changes since v4:
> - add Reviewed-by Tag from Ulf Hansson for patch 2
> - remove default y in Kconfig for btmtkuart selection to avoid overkill for
>   users which would like to have less an amount on stuff in kernel.
> - list header declarations in alphabetical order and add a proper blank line
>   within.
> - remove unused macro.
> - use sizeof to calculate structure size instead of an aextra macro to hardcode.
> - use struct hci_dev * as input paraments for mtk_hci_wmt_sync and mtk_setup_fw
>   for that can be reused in mtk bluetooth with other interfaces.
> - remove unused local variabled in mtk_btuart_recv.
> - remove superfluous :8 for dlen2 in struct mtk_stp_hdr definition.
> - give a reasonable naming for these labels and add a pm_runtime_put_noidle()
>   in the path undoing failing pm_runtime_get_sync().
> - Turn __u8 into u8 in struct mtk_stp_hdr.
> 
> Really thanks for these reviews by Johan Hovold and Andy Shevchenko
> 
> v4 and changes since v3:
> - refine patch 2 based on commit 919b7308fcc4 to allow that
>   dev_pm_domain_attach() will return better error codes. 
> 
> v3 and changes since v2
> * all changes happen on patch 6
> - fix up SPDX license style for btmtkuart.h.
> - change firmware download from in ACL data to in HCI commands
>   and then remove unused mtk_acl_wmt_sync and related code.
> - add a workaround replacing bad vendor event id 0xe4 with 0xff every
>   vendor should use.
> - add a sanity check for mtk_hci_wmt_sync to verifying if
>   input parameters are valid.
> - add an atomic_inc(&bdev->hdev->cmd_cnt) for __hci_cmd_sync_ev.
> - be changed to use firmware with a header called mt7622pr2h.bin.
> 
> v2 and changes since v1
> - Dropped patches already being applied
> - Rewirte the whole driver using btuart [1], and add slight extension
>   of btuart to fit into btmtkuart driver. Beware that [1] is also pulled
>   into one part of the series for avoiding any breakage when the patchset
>   is being compiled.
> 
> [1] btuart 
> 	https://www.spinics.net/lists/linux-bluetooth/msg74918.html
> 
> v1:
> 
> Hi,
> 
> This patchset introduces built-in Bluetooth support on MT7622 SoC.
> And, it should be simple to make an extension to support other
> MediaTek SoCs with adjusting a few of changes on the initialization
> sequence of the device.
> 
> Before the main driver is being introduced, a few of things about
> power-domain management should be re-worked for serdev core and MediaTek
> SCPSYS to allow the Bluetooth to properly power up.
> 
> Patch 2: add a generic way attaching power domain to serdev
> Patch 3 and 4: add cleanups with reuse APIs from Linux core
> Patch 5: fix a limitation about power enablement Bluetooth depends on
> Patch 1, 6 and 7: the major part of adding Bluetooth support to MT7622
> 	
> 	Sean
> 
> Sean Wang (3):
>  dt-bindings: net: bluetooth: Add mediatek-bluetooth
>  Bluetooth: mediatek: Add protocol support for MediaTek serial devices
>  MAINTAINERS: add an entry for MediaTek Bluetooth driver
> 
> .../devicetree/bindings/net/mediatek-bluetooth.txt |  35 ++
> MAINTAINERS                                        |   8 +
> drivers/bluetooth/Kconfig                          |  11 +
> drivers/bluetooth/Makefile                         |   1 +
> drivers/bluetooth/btmtkuart.c                      | 629 +++++++++++++++++++++
> 5 files changed, 684 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> create mode 100644 drivers/bluetooth/btmtkuart.c

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

