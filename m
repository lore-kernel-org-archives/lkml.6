Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FA520873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hj1HJfbJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZqErE8H/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FA520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeGIQRL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:17:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:17:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F36EC6078C; Mon,  9 Jul 2018 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531153029;
        bh=3wGCmHy3TUz0gFAJy7iexXw0SZ3N0BdxDLaBjIvPVc4=;
        h=From:To:Cc:Subject:Date:From;
        b=hj1HJfbJ4dV71Klylzij3tTBbSL20q9lTIBzJZQee/WLJEcxWET4zgz3zbl2RRV1u
         GFaBA/0V8mrqV1+aeOOj4JuqfLjbGs9pT4joGE8hl51Wxpxw2v3i4+WZ/grR+xFOjp
         mLZznzL0XVpkv4ZVjmA7o3uojhzhDhcd2ovXlidk=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D55F0600C1;
        Mon,  9 Jul 2018 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531153028;
        bh=3wGCmHy3TUz0gFAJy7iexXw0SZ3N0BdxDLaBjIvPVc4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZqErE8H/aHFE1d54zVQvhwoNMeJdlNwz5BkygL+eB9eGyDWuho06ITOyI5Mqd9UYt
         EE3JFbR9FxMQ2WuceJVZ9FQ9FNHslZXJLJOmVmKCcNG/wbyn9OeY7ApjrzR1lzcnGq
         Z4Wb1max0t1MShbwyjJ7X7fSFg9uGqJLK00f/v10=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D55F0600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        c-hbandi@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 0/1] Enable subsystem restart for Qualcomm bluetooth chip wcn3990.
Date:   Mon,  9 Jul 2018 21:46:56 +0530
Message-Id: <20180709161657.26609-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many platforms Bluetooth chip wcn3990 is a discrete chip connected 
via UART lines to app processor. if the chip goes into bad state 
i.e. into hard fault exception routine, which will not further respond 
to any commands from HOST via UART. In that case wcn3390 will intimate 
HOST by generating hardware error. Host stack will initiate a close 
and reopen of the hci driver. Prior to sending hard ware error, wcn3990 
has a capability of sending the RAM dump i.e. memory dump of the BT chip. 
this will help us to fix stability issues of the SoC. We at QCA driver 
read the dump packets and store via devcoredump(). 
We perform restart after collecting the ram dump of the SoC.


Harish Bandi (1):
  Bluetooth: hci_qca: Sub system restart support for WCN3990

 drivers/bluetooth/btqca.h   |   8 ++
 drivers/bluetooth/hci_qca.c | 261 ++++++++++++++++++++++++++++++++++++
 2 files changed, 269 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

