Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F988C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3231B20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHB3wOd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3231B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeGXXr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:47:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47023 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbeGXXr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:47:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so5545516wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f+MgZzw5Ux7MdErReYsPxHPNO4xcYfhBpeim1XLKRbE=;
        b=GHB3wOd2KEbECsKPmtFRzXsS5jdS2Fz0s7r3D8kjtTdf2IvcRxVyRJJJz/3hJwSdTY
         cfHCDlzWuP07WpkT8sdDSkkVETogQUDuN6LW9GxuFbqxpxgChahpE1NTYZkjF473jV6m
         sTmt+x1ShXBR6BKbj65xohVJInm0VF83MCxlvCo1yn7ffs1XVzJPaUPQpNGLaAIDwUrZ
         nQrHC8zQTkwbRnBwGlu0NOwGNbDZGdBsVKKvUVdpbTfbrBaEPkiRCjSkIL5ZW/yCT+PT
         a2ZAByl4WY9QO30+bNmqZDJujSjUjgQrQPp+11w+n+jtlv6I5Ahm1nHSZeLCZaETMf6m
         b7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f+MgZzw5Ux7MdErReYsPxHPNO4xcYfhBpeim1XLKRbE=;
        b=O00uh2/M4Z6sSSf5Ln8/RlmnzlJLh6QoFMNE4bnyZw5qlgyaL44x3CUSgxsDwIVKmG
         T9Al5Xn2fkLOtKyQmqQgwAWAYoslD3+C3jyC+JctArYrasQsNqgc12Yt0+6Vp+b+oxeS
         F1IW9z4aXG8luvViPJWPuAWSwGjNzuuXi3oE1nzNNYXpDTsP/pfrOEpKAkqirpVw5gQW
         2QekbZg+ZQJLvUkBNMlfVqeWYbhTH+enApap1nC/hY8g1tAxNzyF2AUV2be920vNJmjR
         b6C0hNZ0UKmUxCe/Gd+4xdatissi5jUfdQEreMJPKjs2ZZngqqjrGt+p9sde533cRP84
         wtDQ==
X-Gm-Message-State: AOUpUlFfvHXjLoCQBNBSBNLXboeacSwTi9NeZj2eOg8gvvwpQiVsTrob
        C7ipjxSf1SjhVT9vOe9IL4o=
X-Google-Smtp-Source: AAOMgpeiC+jtJWpnfjPIJlaJCrsPgv8X3rAQp4M9HBu1I19CtO0BLhn4tI2fzp+XfaA/GSBb61w36g==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr13657649wro.195.1532471958015;
        Tue, 24 Jul 2018 15:39:18 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id q70-v6sm229575wmd.39.2018.07.24.15.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:39:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 20C78640816;
        Wed, 25 Jul 2018 01:39:16 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XnHuuNRzzEiy; Wed, 25 Jul 2018 01:39:15 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id AA50364081F; Wed, 25 Jul 2018 01:39:15 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Staging: octeon-usb: Fixes and Coding style applied. 
Date:   Wed, 25 Jul 2018 01:38:49 +0300
Message-Id: <20180724223853.10198-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

Previously patches were sent with wrong cover format, please ignore.

I am sending four patches which trying to resolve TODO list requirements 
no 45 about octeon-usb. 
There are SPDX licence additions on c and header files. 
Checkpatch warnings are resolved,also a notice about CVMX_WAIT_FOR_FIELD32 macro.
It could improve readability and maintenance of this module if function
cvmx_usb_poll_channel() break down (and probably some others too)

Georgios Tsotsos (4):
  Staging: octeon-usb: Adds SPDX License Identifier
  Staging: octeon-usb: Applying coding style for column width.
  Staging: octeon-usb: Change coding style for CVMX_WAIT_FOR_FIELD32 marco.
  Staging: octeon-usb: Adds SPDX License Identifier for header file

 drivers/staging/octeon-usb/octeon-hcd.c | 55 ++++++++++++++++++---------------
 drivers/staging/octeon-usb/octeon-hcd.h |  1 +
 2 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.16.4
