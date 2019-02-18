Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E84AC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C982175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfBRKsY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:48:24 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50840 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:48:22 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4BF78CF2C7;
        Mon, 18 Feb 2019 11:56:14 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH RESEND 0/3] Add quirk for reading BD_ADDR from fwnode
 property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190131221021.176809-1-mka@chromium.org>
Date:   Mon, 18 Feb 2019 11:48:21 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D45CF782-148F-4076-911B-50AC28718701@holtmann.org>
References: <20190131221021.176809-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> [initial post: https://lore.kernel.org/patchwork/cover/1028184/]
> 
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
> drivers/bluetooth/btqcomsmd.c | 29 +++--------------------
> drivers/bluetooth/hci_qca.c   |  1 +
> include/net/bluetooth/hci.h   | 12 ++++++++++
> net/bluetooth/hci_core.c      | 43 +++++++++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c          |  6 +++--
> 5 files changed, 63 insertions(+), 28 deletions(-)

I am getting compiler warnings when trying to apply this set:

  CC      drivers/bluetooth/btqcomsmd.o
drivers/bluetooth/btqcomsmd.c: In function ‘btqcomsmd_setup’:
drivers/bluetooth/btqcomsmd.c:120:6: warning: unused variable ‘err’ [-Wunused-variable]
  int err;
      ^~~
drivers/bluetooth/btqcomsmd.c:118:20: warning: unused variable ‘btq’ [-Wunused-variable]
  struct btqcomsmd *btq = hci_get_drvdata(hdev);
                    ^~~

Regards

Marcel

