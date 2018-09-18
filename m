Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C08FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC38821471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HPFA4Iev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC38821471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeIRNEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:04:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52529 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeIRNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:04:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id y139-v6so1252491wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TqtAYMZ/AtdBXjpiq1JpN0C5LlS7NOUtlzpC7xJ3q/Q=;
        b=HPFA4IevDAB36khcj7+3+U2pRayhZ7hWw4fgTt1q61SaGG3lDC6eEwkk5zdl9+e3kW
         W3Bvwbz67ptrgglgtPHThrTUtZXAJxNYB3JUpFVe/WM1TQBlCKq0DfF9EdhZfRJ7Ma5s
         oXZQmo5nQ+92r+1kk2bjNYyY7VKPocKBGMI+KF7PuVgjVkiznsM5EyQNFVQxmTTUSQjL
         WkC1YWZgSIUhgp1raVWNclnCILARlD9+Q4ANb0TcpDhm/F5Oqubi0B5DPmzknyQoOjx8
         arcKIuXcSeghScFyTw9VzYvwTdaggTLJMs0HbMdA0JuYFkI/M/PFwMC9uY80RCDp6+xq
         34zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TqtAYMZ/AtdBXjpiq1JpN0C5LlS7NOUtlzpC7xJ3q/Q=;
        b=YFVXugnnY14HIzRreAA5vn8HJdda5Nhdx76s2h65Nc3h1n4u8DeiZxe8HLyFKmAauC
         xmYHqXtaMtTxPfxUdgmVBYD/QuDrj+oYXQ3R2lUHRCK4b8QMtaartAhOQImN2/9HlFEu
         NM4KYq0f89c1jFj2IYMsGHME5PBw4xnB6Awneg2abmaKC3f1loEm1v1jFkeLPyCHTajD
         hEuqrM16cnwV73VRvSANhpG7TefnUS4wxrywI6v5F/ePPTSBjR8FZpnZ9e0Z10f/7VGc
         n/fuGLefwtvROE25C0ecx4GJVZnwCbQ9D8q5ycwvkVkS/l0Una9lZ4peorn/4166U0m0
         r+xw==
X-Gm-Message-State: APzg51CYHMNl9OFWfSd3TOTcazkU6QVjYMFyqXxUlFEFMJjZeb6eOo6H
        L6smsS8QHpumFmp2ghxrjEiIog==
X-Google-Smtp-Source: ANB0VdbmJOdvaA9Izy97UvhfD8UpyJa8OyxmazJaEKl0yXkC9RE9Qdtyu99tysAvE0x3LX55cnoyNw==
X-Received: by 2002:a1c:65c5:: with SMTP id z188-v6mr14336140wmb.57.1537256008870;
        Tue, 18 Sep 2018 00:33:28 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r13-v6sm1138842wmf.35.2018.09.18.00.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 00:33:28 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, jdmason@kudzu.us
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/2] net: ethernet: neterion: use linux/io-64-nonatomic-lo-hi.h
Date:   Tue, 18 Sep 2018 07:33:12 +0000
Message-Id: <1537255994-39517-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This serie remove usage of custom writeq/readq in favor of ones defined in linux/io-64-nonatomic-lo-hi.h

This serie is only compile tested.

Regards

Changes since v1:
- rebase on net-next

Corentin Labbe (2):
  net: neterion: s2io: Use linux/io-64-nonatomic-lo-hi.h
  net: neterion: vxfe: Use linux/io-64-nonatomic-lo-hi.h

 drivers/net/ethernet/neterion/s2io.c              |  1 +
 drivers/net/ethernet/neterion/s2io.h              | 22 +---------------------
 drivers/net/ethernet/neterion/vxge/vxge-config.c  |  1 +
 drivers/net/ethernet/neterion/vxge/vxge-config.h  | 20 --------------------
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c |  1 +
 5 files changed, 4 insertions(+), 41 deletions(-)

-- 
2.7.4

