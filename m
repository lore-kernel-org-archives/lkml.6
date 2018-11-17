Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26120C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02AA2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgntyweZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02AA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbeKQMP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:15:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39041 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:15:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so11951900pla.6;
        Fri, 16 Nov 2018 18:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QuaZ10CE8HGdzTccgCZx9peVir7Fdm3ETaTF69Nqu5M=;
        b=HgntyweZ2C0vx0LnvWNjak2ID8qaPffyYje0RS0VmcFb1zNFJQdXBQsUszXtQgJHvr
         IambeJ6hEgpIM0WDc463aoHVEJNfqLBRwTOijG3YiHQRrIYH4ZUUEBTY81uTaxw1s1P4
         +uMtf/N4iBZ/GNS16OHuBaq6OTGlmwU09/iC+rb1/QmRyF7pjpCqhaK3vG8CKBGjQlg6
         u+NjLN6YinFvjoRypQvj4+QYH5NZCNWPddaS9sswOAtdkjmnW0ufbuJlmhPjWmgomIUB
         BPSkvosPboZI00QrrdpyKwpy5EwmvkEJdrq8/ZAxbS0B0+AVeM5gESdyq9qs8iW2508/
         QipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QuaZ10CE8HGdzTccgCZx9peVir7Fdm3ETaTF69Nqu5M=;
        b=OmTL8jfPCbe82xBXl9B3P/MVITEs/Jgml0L1TfSBZOMbMMhEm9D/4Fhw4YMLGhyyz7
         6wyU5jVTCbaGjGs1JKLbfnZR99QZHzZlNo6g2zQ22pjLeWJTD63UMc/p5S7WZ8aGwovS
         1TB1yAiOUjC9xetZc97Us6JSRXwAe1PIvXJqLhvUxTsSTwm1/FwSkJ5SeIR1pUqztgrw
         bb/G2KIkKTHgUJJO3I3gMdiloUF3gN5BQTWmxew1R/qVzEoALYuLcT8BCdEvLL6lwgdI
         MpKrxrbtJ2zPWLzE5wYQBiPSoJbQE7zg/O5rLwJdpzweY1ZYeVcjiTQStCtiMqMYGwpg
         9/lw==
X-Gm-Message-State: AGRZ1gIDx0+GD7CBjSwhOhxBaj9wyqI74ikgaTF0bdmfx+QRzOfI01kK
        1GoPsLcpRJAmLdaO/Ynxyfs=
X-Google-Smtp-Source: AJdET5e8sQ7gz9mhtLSzXE2WEzJCWBGl+ztXwbp3TZXg5+Oyh1C0jHa9ltf3m8x903R1jCctfqYK2w==
X-Received: by 2002:a17:902:868b:: with SMTP id g11-v6mr10377636plo.96.1542420065055;
        Fri, 16 Nov 2018 18:01:05 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b14-v6sm47535498pgn.49.2018.11.16.18.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 18:01:04 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 0/2] net: bcmgenet: fix aborted suspend
Date:   Fri, 16 Nov 2018 18:00:20 -0800
Message-Id: <1542420022-30251-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not enough to return an error code from the driver suspend
routine. The driver must also restore the device functionality.

This commit corrects the issue introduced by commit 0db55093b566 
("net: bcmgenet: return correct value 'ret' from bcmgenet_power_down")
by calling the driver resume function if the suspend function returns
an error.

Doug Berger (2):
  net: bcmgenet: code movement
  net: bcmgenet: abort suspend on error

 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 63 +++++++++++-----------
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  6 +++
 2 files changed, 39 insertions(+), 30 deletions(-)

-- 
2.7.4

