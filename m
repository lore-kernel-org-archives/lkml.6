Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E342EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D72C208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbDM8EAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D72C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFTImi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:42:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34491 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:42:31 -0400
Received: by mail-lf0-f66.google.com with SMTP id e13-v6so3401687lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A0sGEtIbwL+y8c9GAebBgcNVhZG9FWOuDcNTW/ZBBuU=;
        b=KbDM8EAdBCP5445A0EWNk4dJ4pKtun8exQA97MK7dyILCVycPASg9Nl0NSiwNJHSF1
         aE04/HO8ha54ew57zdoE24lEIjnceeqxS7+hIFtBdgWzJv5B2eCVzotQaa2LqMtwPEu+
         JGjsPyYpvvFXTd/fiVs1tticepEGFm643Dvok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A0sGEtIbwL+y8c9GAebBgcNVhZG9FWOuDcNTW/ZBBuU=;
        b=p9B/+ndWsQNLXrqHsOktapS5lRHJ0oNzMD9XX+cSmLctSbwFJRL97qtfFp4Can02HZ
         Fd3a8JffTEWhHffpWZAjqRB7jE6RWrkkhtLcqxPyoY2maZZ2D6RqOaLQlDqJlzzuTKHJ
         crPe2oyC/JL39bgfOo0HKd2l17XKte0jNp9YMmchnV+mwuWovS0MgPzeg4d84GB6loAZ
         ooJj65HQEgQ/8Ctv6PfDp28/BchxLkXiGgzSBl6kwuG6m/SaRUUwMxyuhYdfmaZsZoIV
         NEd8lDlbvcJOrK8C4e1/XqO+sPSBWSGBRG3QbtOFBtN/SEGD+Rd1K8wO2msOYIE29Xau
         Iunw==
X-Gm-Message-State: APt69E3G7qhUm8etNLYugLx/4A7QXgRDXJQ5KptQFzWBXsBe9FXo4A+J
        f3MA6KqGJqI/SwvkqaTu4a4crQ==
X-Google-Smtp-Source: ADUXVKIYAPUGu+f5UPM9umRG0O1et3jFk+vR9suNsrI0whzJKpMGWpn+dJ/4jgGPS9UGmNxg6zjkgA==
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr13289510ljc.59.1529484150370;
        Wed, 20 Jun 2018 01:42:30 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id l25-v6sm301267ljj.30.2018.06.20.01.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 01:42:29 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     ath10k@lists.infradead.org
Cc:     alagusankar@silex-india.com,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ath10k: sdio: essential sdio fixes
Date:   Wed, 20 Jun 2018 10:42:19 +0200
Message-Id: <20180620084222.3521-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes were originally embedded in a patch
"ath10k_sdio: virtual scatter gather for receive"
posted by Alagu Sankar <alagusankar@silex-india.com>
https://patchwork.kernel.org/patch/9979579/

However, while that patch implements scatter gather
(without using the proper sg types), it also
includes several other random fixes, including
but not limited to checkpatch.pl fixes.

This patch series is an attempt to extract
the most essential fixes included in that commit.

Each fix is now an individual commit, as upstream
requires that each logical change is self contained.

All of these fixes are essential to get working
sdio support for ath10k.

Other patches are needed to get working sdio support,
including the high-latency patch series from Erik Stromdahl.


Niklas Cassel (3):
  ath10k: sdio: use same endpoint id for all packets in a bundle
  ath10k: sdio: allocate correct size for RECV_1MORE_BLOCK rx packets
  ath10k: sdio: set skb len for all rx packets

 drivers/net/wireless/ath/ath10k/htc.h  | 1 +
 drivers/net/wireless/ath/ath10k/sdio.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1

