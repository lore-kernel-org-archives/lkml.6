Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930D42150B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930D42150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeI0Qs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:48:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37815 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeI0QsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:48:25 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id C05D1CF170;
        Thu, 27 Sep 2018 12:38:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Add poweroff support during hci
 down for wcn3990
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180924144445.3857-1-bgodavar@codeaurora.org>
Date:   Thu, 27 Sep 2018 12:30:47 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9032220F-6F66-4364-9C7F-038C06097658@holtmann.org>
References: <20180924144445.3857-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> This patch enables power off support for hci down and power on support
> for hci up. As wcn3990 power sources are ignited by regulators, we will
> turn off them during hci down, i.e. an complete power off of wcn3990.
> So while hci up, will call vendor setup which will turn on the regulators,
> requests BT chip version and download the firmware.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> v3:
>  * addressed reviewer comments.
> v2:
>   * Removed vendor specific hdev->open and close functions.
>   * Added hdev->shutdown function to turn off the regs.
> 
> v1:
>   * initial patch.
> ---
> drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

