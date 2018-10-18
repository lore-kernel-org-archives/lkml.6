Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4742145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4742145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJRP4e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:56:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60349 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeJRP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:56:34 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id C98D2CEF8D;
        Thu, 18 Oct 2018 10:04:08 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Add support for controller debug
 logs.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181016142135.16480-1-bgodavar@codeaurora.org>
Date:   Thu, 18 Oct 2018 09:56:45 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        c-hbandi@codeaurora.orhg, Harish Bandi <c-hbandi@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CE79934F-718A-4941-830C-C179F96B0425@holtmann.org>
References: <20181016142135.16480-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> This patch will prevent error messages splashing on console.
> 
> [   78.426697] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> [   78.436682] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> [   78.446639] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> [   78.456596] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> 
> QCA wcn3990 will send the debug logs in the form of ACL packets.
> While decoding packet in qca_recv(), marking the received debug log
> packet as diagnostic packet.
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> v3:
>  * used get_unaligned_le16() instead of checking individual bytes
> v2: 
>  * Addressed reviewer comments.
> v1: 
>  * initial patch
> ---
> drivers/bluetooth/hci_qca.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

