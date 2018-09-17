Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C38ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9402088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9402088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeIQTT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:19:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQTT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:19:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03BF4DC0;
        Mon, 17 Sep 2018 13:51:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     sameo@linux.intel.com, davem@davemloft.net, netdev@vger.kernel.org
Cc:     allen.pais@oracle.com, keescook@chromium.org, surenb@google.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] NFC fixes for 4.19-final
Date:   Mon, 17 Sep 2018 15:51:39 +0200
Message-Id: <20180917135141.28328-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, these two NFC patches fell through the cracks.  It
looks like sometimes NFC patches go through the wireless tree, and
other times, through the networking tree directly.

I don't care which way they go, but they should get merged through some
way, or, I can take them in my device tree, but that feels a bit odd to
me.

thanks,

greg k-h

Suren Baghdasaryan (2):
  NFC: Fix possible memory corruption when handling SHDLC I-Frame
    commands
  NFC: Fix the number of pipes

 include/net/nfc/hci.h |  2 +-
 net/nfc/hci/core.c    | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.19.0

