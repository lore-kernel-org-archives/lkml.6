Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE38C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D75D20656
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfACD0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:26:35 -0500
Received: from hermes.aosc.io ([199.195.250.187]:54751 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACD0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:26:35 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 47F4C15E6BB;
        Thu,  3 Jan 2019 03:26:30 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 0/2] USB Storage quirk for SMI SM3350
Date:   Thu,  3 Jan 2019 11:26:16 +0800
Message-Id: <20190103032618.9237-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMI SM3350 UFS-USB bridge controller cannot handle REQUEST SENSE command
with long sense (96-bytes) well, and will even trap the controller into
a state that refuses to do read/write command.

Currently Linux uncondintionally set US_FL_SANE_SENSE for devices
claiming SPC3+, which makes simply add US_FL_BAD_SENSE for SM3350 fail
(as it claims SPC4).

Fix this conflicting quirk issue, and add the quirk for SM3350.

Icenowy Zheng (2):
  USB: storage: don't insert sane sense for SPC3+ when bad sense
    specified
  USB: storage: add quirk for SMI SM3350

 drivers/usb/storage/scsiglue.c     |  8 ++++++--
 drivers/usb/storage/unusual_devs.h | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.18.1

