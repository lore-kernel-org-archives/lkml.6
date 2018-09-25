Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE54AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770AB206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cft5lIQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770AB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIZAiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:38:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38111 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:38:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id x8-v6so6333760eds.5;
        Tue, 25 Sep 2018 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ew3UB5iGIEVarqh/xfuTh5MOhr5YJg/GwftQajokxqA=;
        b=Cft5lIQBFr1fG+/rkLuQWTnEGVeTaHtv867URzcv8kDkD0T4PrLE9MWOqG1XQ4p6q1
         KEQrzbi2naZwVLu2i7/jv9It/Ln+tNqIca9wPaq+GKNaHtdHSqo18QLm4aGYS9dbTiUs
         yMm8cOUK8Gg6ExskPp2dBqzaQ4t1eo/qXFUZJf0+T/3csgwO+Zu1HtjBZ2lTNAKTEpGa
         IUrVwSQ51/pnh0k0Nnir5nOIrTHapzgh4M2W/XG7p+jQa8YrX8M6HtGqbUN8rd52wNnl
         uPKUS+m0K4inRnPqyvE+p1tkRxrZASOY7VGoSxix81CsPSVPPQNHqR7Au0VRc376gbcv
         3Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ew3UB5iGIEVarqh/xfuTh5MOhr5YJg/GwftQajokxqA=;
        b=hzPoqAXsGREiJIWsZm998h3ka2+F77pouD1rp2nfrTcv3Al+BNoNGjQoAySqW9Q71f
         PLY5rG5x7u79BYXFZuQhT6VfHj0TKlWe31ur6drzKRBuSYIj8b+gK/oWn6hG9+5m3Mdw
         nnNch0RntGdCJOY/MoV2r4iHCMJwaElc9P192kphPNeR7+JTqQsM1u+vJ8QHnLk0VKRa
         q9yfiLfTlUvEe4hQoVI3wvHX1+2k6JiO+Z/yvsvEef8Ui7wk9ybWoGchyWL+KXYO1py3
         ebE92RARuYt008A474GPoFjHh2QVDcrsBhU9hTz7P1LFp4ZPblZv/BJZ0nKqirdxzIPK
         6Vaw==
X-Gm-Message-State: ABuFfoh86NAVOJZX/mHBEoXSHkdBDwYqmpvxBCIRk6TYIjNsenY9ERqL
        2LJLHyw0A5i+Au29nnrLwjCp/06Z
X-Google-Smtp-Source: ACcGV60ZUBuVCrMeSDCVh/OkBVJdDva0M18A0apH7xZqwhR49wzKI+iQNirjVlHJwHoijSzqUcbBog==
X-Received: by 2002:a50:a6c7:: with SMTP id f7-v6mr3338707edc.225.1537900171336;
        Tue, 25 Sep 2018 11:29:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g38-v6sm7834882edc.40.2018.09.25.11.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:29:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list),
        dongsheng.wang@hxt-semitech.com, cphealy@gmail.com,
        clemens.gruber@pqgruber.com, hkallweit1@gmail.com, nbd@nbd.name,
        harini.katakam@xilinx.com
Subject: [PATCH net-next 0/2] net: phy: Eliminate unnecessary soft
Date:   Tue, 25 Sep 2018 11:28:44 -0700
Message-Id: <20180925182846.30042-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series eliminates unnecessary software resets of the PHY.
This should hopefully not break anybody's hardware; but I would
appreciate testing to make sure this is is the case.

Sorry for this long email list, I wanted to make sure I reached out to
all people who made changes to the Marvell PHY driver.

Thank you!

Changes since RFT:

- added Tested-by tags from Wang, Dongsheng, Andrew, Chris and Clemens

Florian Fainelli (2):
  net: phy: Stop with excessive soft reset
  net: phy: marvell: Avoid unnecessary soft reset

 drivers/net/phy/marvell.c    | 63 ++++++++++++------------------------
 drivers/net/phy/phy_device.c |  2 --
 2 files changed, 21 insertions(+), 44 deletions(-)

-- 
2.17.1

