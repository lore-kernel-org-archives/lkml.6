Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79618C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3240B26A4B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="02YnKuRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3240B26A4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934841AbeFZMLh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:11:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37780 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933794AbeFZMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:11:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so1044976wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blGSAXvb6m1ltzBycnx+sDMdWZjSk8/OFDstVHZEjF8=;
        b=02YnKuRkBu3/885gnnD6Cq7DRLzZ0OvPG+EFh4oze4MIKQnwDnLGecMmR0K09XaQ2s
         NQNYe0kjEeBL8/o9BO90lg4+lX5mSJK/1pvUD7N+a/UaIodWwQlcZg+ssHi71S+/QY07
         e222x5wObe3vi4dopgpzuHjUrhGQK+QAJsWHiuA+7VU9hCmr05UTy2PLBSGIvB9zHz3r
         fb3BxvDooaRAw69kKKYSEezjXXaMRyjfXqCvrpssiUHb/NsteQgbL7RH/qrXIHPQPqdR
         cDD/elbsKKpAv9ggKa4+ABO0Fon2QsqeDHmFR1bXGmRp+J7TLj4W9Lc8b1/rZ1RvzyP4
         YVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blGSAXvb6m1ltzBycnx+sDMdWZjSk8/OFDstVHZEjF8=;
        b=GD2cXKFdM/+c7wC92eaK7Cy/dD3fM9s/LmwOeoBJZvSJN20amv4HBpNBqITpl4a0X5
         f6nPhfFOqrJmBJR22R7ClpJAII8pBKpOMU4elBHd1c0oagU9uSXnCWfsjSLZRwtZ3bDG
         mLbOwhXhlZfZhg/pzawYth1nAmSDHeahijlfJqN2X3i+AOzrLc3RKUKPMIydVFCvbUo3
         50aDEL1SM5U42rPAvsx9Oe7mtfbrHCpwIH0peomUpNrNh2b9a7zdYqQvQ1jyAEwpNcDx
         2mXFdyH4A5SZ+quxSxNhyzrHnQN1bHNE9CTK5ilfrXZ1zNvKi4OYj8o4OWMXTKT/GSo4
         4W3w==
X-Gm-Message-State: APt69E1pfUZD+jHRdf6/Ea5AyJwkh9CjTOBNBuhBu46sQ3fi+uBxTSlo
        XZVUb2TFtHgS7UZ7p0LHTwTMaQ==
X-Google-Smtp-Source: AAOMgpdq2R+XaH2B8e7Za2+U7G9/pAoWgPj7DeS+MtgUO4YO9SOrtVNpozzBrbVDIFfAigjFmYDh2w==
X-Received: by 2002:a1c:14cc:: with SMTP id 195-v6mr1374317wmu.48.1530015093869;
        Tue, 26 Jun 2018 05:11:33 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l15-v6sm1917865wrs.95.2018.06.26.05.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 05:11:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: add simple-amplifier
Date:   Tue, 26 Jun 2018 14:11:25 +0200
Message-Id: <20180626121128.28564-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discuss here [0], this patchset rename the dio2125 driver to
simple-amplifier in order to make it more discoverable.

The last patch adds simple-audio-amplifier as new compatible

[0]: https://lkml.kernel.org/r/20180625114445.GG9413@sirena.org.uk

Jerome Brunet (3):
  ASoC: simple-amplifier: remame dio2125 documentation
  ASoC: simple-amplifier: rename dio2125 to simple-amplifer
  ASoC: simple-amplifer: add simple-amplifier compatible

 .../devicetree/bindings/sound/dioo,dio2125.txt     | 12 -------
 .../devicetree/bindings/sound/simple-amplifier.txt | 12 +++++++
 sound/soc/codecs/Kconfig                           | 10 +++---
 sound/soc/codecs/Makefile                          |  4 +--
 sound/soc/codecs/{dio2125.c => simple-amplifier.c} | 42 +++++++++++-----------
 5 files changed, 41 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt
 create mode 100644 Documentation/devicetree/bindings/sound/simple-amplifier.txt
 rename sound/soc/codecs/{dio2125.c => simple-amplifier.c} (68%)

-- 
2.14.4

