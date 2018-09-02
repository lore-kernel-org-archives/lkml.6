Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B500DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD232077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdngF5EU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD232077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeIBRrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:47:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42875 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbeIBRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id g13-v6so4177502qki.9;
        Sun, 02 Sep 2018 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OK8L0r4jWktr0wJtQe+hs0IrHtJsh/CXnxjerZrKC5Q=;
        b=pdngF5EUasITiHaW/j/i/TJqMSGg0JIJNNihkA1jjCOAV9SEU3ayWo5KLGBhyVPe70
         rqYuncOmzVR/JTcwr22ZWX0jPeehu7ISuTlddjXv2cRb7MKOrXO/qrPb8MTYompd/v7N
         qOr6qntxg5b5VdquND7LWO76+mNkFPyofJ3mk638qXRML1yJykiehzO/ebWZSwvfuhoZ
         iSfgX2Lh9vMCIrUYf9z5hKP+BIo+opNuJsJ8WAo/medkxQVlC5txPwcdpOYsued1Bt5F
         j1m6FWF6RKBC5GLD49ke2IG0czVpnBXFzI0Iuobh5vEhxnTs7cXqFvs9CB6bbQv1/Aba
         CuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OK8L0r4jWktr0wJtQe+hs0IrHtJsh/CXnxjerZrKC5Q=;
        b=L7t2lrJy2WRG+ndkoEqG0AMb74vHi+y4Fb2EOcwkOXuUd9GogJtfIDDAiuYKrBJgRj
         05hfVPu92ZhSBLGunbDK3/dL+kUz2bVXGKEwDnOIwPl4FXqq61RNYT28ig5r2aziYvqj
         e+bVxlZBJ34OtB0pLYJphrohoYjrD8tWVtegDRyrBW6WEeLyT7JZUf6iAge5uSEeLjkJ
         BCAboBLrT842AvYTW0YlS25RlQtdFlx41hOQvrxNydENYXRXcU+6oFwKxye++IHgRcuh
         YM9GLbnZdK9u4UGEmE0st/Lj/VtviXZKjoR1XHeYZbYQrvveOPn8+61gQpqYldbrcZsx
         /NKA==
X-Gm-Message-State: APzg51A5grs9Ui+kBfRv9AQ7VEm4M04IDAezKaWx0WDoXayAHvSun+8A
        VFtI0bWKLKDb06mMxqO6nEAC8DeoFxV7NUytjA==
X-Google-Smtp-Source: ANB0VdZvBqx88EZ9bI7y1GF9CZwLsfXvqs0GEVbZ4/07gCfl70gqW5G9Q/Cmz5M+M17mRn5A9rdU8bJ6CAhvQ7wRjEQ=
X-Received: by 2002:a37:169c:: with SMTP id 28-v6mr21202105qkw.184.1535893509958;
 Sun, 02 Sep 2018 06:05:09 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Sun, 2 Sep 2018 09:04:58 -0400
Message-ID: <CAL_JsqLtOfYc9i-K+RGz9Aacq_YKEpbyjG_dv6sRX7wLLw5qVA@mail.gmail.com>
Subject: [GIT PULL] Devicetree update for 4.19-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please consider pulling this DT update for rc2. I'm sending these new
helpers now for rc2 in order to simplify the dependencies on
subsequent cleanups across the tree in 4.20.

Rob

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.19

for you to fetch changes up to 0413bedabc886c3a56804d1c80a58e99077b1d91:

  of: Add device_type access helper functions (2018-08-31 08:30:42 -0400)

----------------------------------------------------------------
Devicetree updates for 4.19-rc2:

A couple of new helper functions in preparation for some tree wide
clean-ups.

----------------------------------------------------------------
Johan Hovold (1):
      of: add helper to lookup compatible child node

Rob Herring (2):
      of: add node name compare helper functions
      of: Add device_type access helper functions

 drivers/of/base.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
