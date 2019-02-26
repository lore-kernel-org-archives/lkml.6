Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0112C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9499021855
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfBZJKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:10:02 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41154 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:10:01 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id E3643CF2A3;
        Tue, 26 Feb 2019 10:17:54 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 0/3] Add quirk for reading BD_ADDR from fwnode property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190219200559.13079-1-mka@chromium.org>
Date:   Tue, 26 Feb 2019 10:09:59 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C8D5B9EB-916C-4D4E-872D-726E48DAD5B5@holtmann.org>
References: <20190219200559.13079-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
> on the Bluetooth chip itself. One way to configure the address is
> through the device tree (patched in by the bootloader). The btqcomsmd
> driver is an example, it can read the address from the DT property
> 'local-bd-address'.
> 
> To avoid redundant open-coded reading of 'local-bd-address' and error
> handling this series adds the quirk HCI_QUIRK_USE_BDADDR_PROPERTY to
> retrieve the BD address of a device from the DT and adapts the
> btqcomsmd and hci_qca drivers to use this quirk.
> 
> Matthias Kaehlcke (3):
>  Bluetooth: Add quirk for reading BD_ADDR from fwnode property
>  Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
>  Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
> 
> drivers/bluetooth/btqcomsmd.c | 31 +++----------------------
> drivers/bluetooth/hci_qca.c   |  1 +
> include/net/bluetooth/hci.h   | 12 ++++++++++
> net/bluetooth/hci_core.c      | 43 +++++++++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c          |  6 +++--
> 5 files changed, 63 insertions(+), 30 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

