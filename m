Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E32C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70E82087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="li8Atc8o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KCHXwUmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70E82087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933415AbeGIQ5W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:57:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:57:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81B8C6063F; Mon,  9 Jul 2018 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531155439;
        bh=Bp6Ns7Ws+V28MbXBykJIrny789ogRSgYcKG1LELbzOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=li8Atc8oP+nWhcQhd3eS4WTxpBKtMOgjEEeO43zX9zSWPKwR4DH+yCe+66BMAjL/u
         tIVhhpri8IxkZoUfDLwoVk2FDEdCtYBvKvtXEryU+dVsT9pvaREfr6HnGV0R/UG6pW
         zjkYh6N7+MgWobaf+snANI0ePMRoliy3vMSloVQY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DC6236063F;
        Mon,  9 Jul 2018 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531155438;
        bh=Bp6Ns7Ws+V28MbXBykJIrny789ogRSgYcKG1LELbzOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KCHXwUmvKv4X5Im2QCuQnZ5Y9s1MCf8IQOtoP+rEnKzQVefzqrwiVy8zXWW4XoTKZ
         Cig98mzQdwBS91Q5ajJwjPcOXPhc5Fj/U3XugHL/MJOEdS6NvOiotguU7vl19QsfO7
         RlFsq4zxV8HhEbQZSfIBWLJR/kElblC2/3f4drhs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Jul 2018 22:27:18 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        c-hbandi@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 0/1] Enable subsystem restart for Qualcomm bluetooth
 chip wcn3990.
In-Reply-To: <20180709161657.26609-1-bgodavar@codeaurora.org>
References: <20180709161657.26609-1-bgodavar@codeaurora.org>
Message-ID: <813ada2b431a86d4d4e59ac2dfb845b8@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add this patch is on top of
Following patches. Which are under review

https://patchwork.kernel.org/patch/10510029/
https://patchwork.kernel.org/patch/10510031/
https://patchwork.kernel.org/patch/10510037/
https://patchwork.kernel.org/patch/10510045/
https://patchwork.kernel.org/patch/10510033/
https://patchwork.kernel.org/patch/10510051/
https://patchwork.kernel.org/patch/10510047/

On 2018-07-09 21:46, Balakrishna Godavarthi wrote:
> In many platforms Bluetooth chip wcn3990 is a discrete chip connected
> via UART lines to app processor. if the chip goes into bad state
> i.e. into hard fault exception routine, which will not further respond
> to any commands from HOST via UART. In that case wcn3390 will intimate
> HOST by generating hardware error. Host stack will initiate a close
> and reopen of the hci driver. Prior to sending hard ware error, wcn3990
> has a capability of sending the RAM dump i.e. memory dump of the BT 
> chip.
> this will help us to fix stability issues of the SoC. We at QCA driver
> read the dump packets and store via devcoredump().
> We perform restart after collecting the ram dump of the SoC.
> 
> 
> Harish Bandi (1):
>   Bluetooth: hci_qca: Sub system restart support for WCN3990
> 
>  drivers/bluetooth/btqca.h   |   8 ++
>  drivers/bluetooth/hci_qca.c | 261 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 269 insertions(+)

-- 
Regards
Balakrishna.
