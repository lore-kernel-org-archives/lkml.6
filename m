Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF00C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AEF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfBRNKc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:10:32 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42989 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfBRNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:10:31 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8E053CF2C7;
        Mon, 18 Feb 2019 14:18:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 0/6]Bluetooth: mediatek: add support for MediaTek MT7663U
 and MT7668U UART devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
Date:   Mon, 18 Feb 2019 14:10:29 +0100
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B7EBA86E-B6C2-4301-BA01-004EA83A50A9@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
> function running on the top of btmtkuart driver.
> 
> We are through several patches to reach the goal and also wish applied
> the same flow in MediaTek btusb [1] for the transport independence.
> Once [1] and the series is being merged and then in next step I will
> consider to add a btmtk.c to hold these independent operations among
> various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.
> 
> Firstly,
> in patch 1/6 to update the dt-binding document for the kind of devices.
> in patch 2/6, 3/6 to fix the common error issues in the current code.
> in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
> MT7668U USB devices also utilize.
> 
> Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
> Bluetooth and enable MT7663U and MT7668U device.
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 
> 
> Sean Wang (6):
>  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
>    MT7668U UART devices
>  Bluetooth: mediatek: trivial typo fix
>  Bluetooth: mediatek: fix up an error path to restore bdev->tx_state
>  Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
>  Bluetooth: mediatek: update the common setup between MT7622 and other
>    devices
>  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
>    devices
> 
> .../bindings/net/mediatek-bluetooth.txt       |  64 +++
> drivers/bluetooth/btmtkuart.c                 | 538 ++++++++++++++++--
> 2 files changed, 569 insertions(+), 33 deletions(-)

please re-send 1/6 and 6/6 when the DT changes are ACKed by Rob.

Regards

Marcel

