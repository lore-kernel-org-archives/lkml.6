Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8255FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4362B21477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4362B21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeHXWIq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:08:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60271 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeHXWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:08:45 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2D1B6CEF96;
        Fri, 24 Aug 2018 20:40:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v1 0/2] Bug fixes for qualcomm BT chip wcn3990. 
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180822122005.11218-1-bgodavar@codeaurora.org>
Date:   Fri, 24 Aug 2018 20:32:57 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2B1E9B66-FCDD-4851-BE99-8DA452AE9354@holtmann.org>
References: <20180822122005.11218-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> When we set an KASAN flags, we are seeing an crash while removing module hci_uart.
> This is due to dereference of hdev. As in module deinit we are calling function
> hci_free_dev() to free hdev.
> 
> Changes in v1:
> 
>  * removed dereference of hdev in qca_power_shutdown i.e. qca_close.
>  * moved serdev open & close call from qca_open & qca_close.
> 
> 
> Balakrishna Godavarthi (2):
>  Bluetooth: hci_qca: Remove serdev_device_open/close function calls
>  Bluetooth: hci_qca: Remove hdev dereference in qca_close().
> 
> drivers/bluetooth/hci_qca.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)

both patches haven been applied to bluetooth-next tree.

Regards

Marcel

