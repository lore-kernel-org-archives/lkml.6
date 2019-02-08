Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E721908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCdHANXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBHVD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:03:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35100 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:03:58 -0500
Received: by mail-it1-f195.google.com with SMTP id r6so12514631itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4L5tlZ6jPMg6GKVII0e/PoebbtfS57aOiz+3iNssAGY=;
        b=HCdHANXeySWVhiD/vJvjsr2VMnaE3LrPKr/EH4+vGhpbn6xJE5KM/U4MysOZoHpOrw
         FY2Op7OdxJi/C7wxncCckJ92jCcrmHhSJoGXiZjtkfsuy2/d+vgW2+p8VmsOm7/Acirk
         hnYrUDKXk+rLGbHd6QmREpWOIC0baNfEvztppAjWIRyw0AHXjHIDrJL8aB1N6i7ksTe8
         br3kwdWFu5sXMcnEgXcSfnFpcOc3nlHG0WiNkmKLzzWmJudsTZyaoUoYPkgJQ6mg6JWs
         HsfRq/+Sf2/eJpAa6UP4wV6sU1o/zdmMjPybcvXN4zEsbdyIiOmYngkSLIHTafHwLev6
         hbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4L5tlZ6jPMg6GKVII0e/PoebbtfS57aOiz+3iNssAGY=;
        b=LflB6ZcGT3fX7QOWAZFGzitZxCYzcu0gq9jREDrBXc24kTgI96LlmN9c1lFdKoQ9Fd
         /u6PgGPJnuVDupMycDrMGir9qGA8czEVeXFI6749gpdNJrawz8DqFquLnzb3P79U6/m+
         I9HJQ+z8A9OAEnd62rqzw0jty+7M5FSPnMaPubOkv+tNViJW4Uhx/2rd77GLk0aQ+h2C
         ZlXeAOiduz2lLm7kYRTW7rYdlAV/lxovGZPZJg5fESeGRw5kIzv7WvtalprPpnz7N9eI
         utoDD3V9MP6X9vnFSlmSW/rVfE0917Zu6OyuCXV7uGhyit+IpIySqx92WY0FHpMPDRLt
         StOw==
X-Gm-Message-State: AHQUAuYyeNQ31i7CGPjIsYFUxMHkVZbr5bSiKJgIB64cwjajq51Kr5rq
        0a/uGRJ8ODngrzuJ9INv7TY=
X-Google-Smtp-Source: AHgI3IZSX4dk9pPU5MSb9tM5Wc2O1X8YtcV3U9pEAYxHnv1I+JT7AKMt1cKkMXMVNikhwCzzllE6Vw==
X-Received: by 2002:a24:7351:: with SMTP id y78mr313548itb.12.1549659837927;
        Fri, 08 Feb 2019 13:03:57 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id x17sm1395737iob.11.2019.02.08.13.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 13:03:57 -0800 (PST)
Date:   Fri, 8 Feb 2019 04:57:11 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Drivers: hv: vmbus: Fix sysfs functions that display
 monitor id and page data
Message-ID: <cover.1549619051.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the monitor id and monitor page data sysfs files display
incorrect data. This patchset provides the following changes:

1) Change the monitor_pages index in server_monitor_pending_show() to
'0', which is the correct index for the server.

2) If monitor pages are not allocated to a channel, display nothing in
the channel's monitor id and monitor page data sysfs files. The data
that is currently shown in sysfs is incorrect.


Kimberly Brown (2):
  Drivers: hv: vmbus: Change server monitor_pages index to 0
  Drivers: hv: vmbus: Display nothing in sysfs if monitor_allocated not
    set

 Documentation/ABI/stable/sysfs-bus-vmbus |  9 ++++--
 drivers/hv/vmbus_drv.c                   | 39 +++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.17.1

