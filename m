Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6677C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3820673
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="o2qnddsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA3820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLHR7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:59:01 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49816 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeLHR7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:59:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 927F11F988;
        Sat,  8 Dec 2018 18:58:58 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1544291937; x=1546883938; bh=G5QwKzUmfswHW9
        YLZ+Yzc8ERDk73qgg6V6ZPWLvN6yk=; b=o2qnddsvqfp8vtgoWqo+ena94uPcFg
        0vmgHnr1RzhpMcibLESNlmO7oeXepfrz++K1R8FuyJUR4FkhU4HWe7lqRqIY6+0U
        Qs5AcnZn72aY1G1qsvwvVsLIVxG2B2yJh0AaAJtufQHIrErs7rk0LLrq9csUAPvc
        6BWA5cfR5Y8cqvGVfCwVFNhTCkj4ZvT6CjHJfv/X6jo+60lS0gSYiVg878/LgvQL
        KAVOZfAd3KUJo9GRAscp3JVNrwmfI68luFNClCxqLAO5A+ilOs4qPKmd3SIWS3xu
        xGv3Ekx/SMz8tJJ1yzKfuksvOjySqYqpZlZrMLM7nmR3A+ZX96w9xPDpph72XmbZ
        8iuo6FzA3VCOzxV+Ad7Mw+ud0Qa3NExjD/mNxdzEJQzua+sGlrYVLPOMBKAfv31l
        +YVopMUC+tnxtA6STb3/joxiIbrD7erHwAonLTbafBimaTQVBgCBcv6R0pHdP1Gx
        SNL0TmxJLe7NDy0MK1xWzzfKxW2i+fJ7xXcAuXk/gI8/J6fBYb3d+wxBF0apeg0C
        r1lfQl1SkbO6k/2tKvGmhUF9YKhfcESw4byrdVPUyKsAcPQ2QCyxBWB7Y8LHTyBf
        2mPEw7Bfr4IGbYQNlRY+UYOGaf7fJirZ95l1B7sKhmdEThqNWNfCHFT83WfWjG3T
        sWRrz91e2admo=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 3RvThkDe7PIA; Sat,  8 Dec 2018 18:58:57 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 610891F965;
        Sat,  8 Dec 2018 18:58:57 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org, Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v8 0/2] AXP8x3 AC and battery power supply support
Date:   Sat,  8 Dec 2018 19:58:45 +0200
Message-Id: <20181208175847.32068-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

Changes in v8:
* Fixed SOB in "Re-align mfd cell entries" patch
* Send only last two commits which are pending merging

Changes in v7:
* Added re-align patch for mfd cells

Changes in v6:
* Collected tags
* Rebase to master
* Dropped AXP803 compatible patches

Changes in v5:
* Return correct input current limit for values 0x6 and 0x7
* Add specific compatibles for AXP803
* Change commit messages
* Add Vasily Khoruzhick Pinebook DTS patch

Changes in v4:
* Change order of axp20x-gpio in axp20x.c
* Fix indentation and spaces to tabs in axp20x.c

Changes in v3:
* Reorder ac_power_supply DT node
* Rename axp20x_ac_power_set_property function
* Split mfd commit 

Changes in v2:
* Reuse axp813 compatibles for axp803
* Refactor axp20x_ac_power.c

Chen-Yu Tsai (1):
  mfd: axp20x: Re-align mfd cell entries

Oskari Lemmela (1):
  mfd: axp20x: Add supported cells for AXP803

 drivers/mfd/axp20x.c | 121 +++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 56 deletions(-)

-- 
2.17.1

