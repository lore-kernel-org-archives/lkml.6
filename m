Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F73A217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD91lDlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390948AbeLUPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43732 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeLUPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so5048692lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffmZcVfSfeQA3nmlJnD8pY5wfE+gHGqpjgHkWfO9544=;
        b=SD91lDlOM/WdjbURKKFSIHqQ0g0Gza3k7dVUJuwxrVD9duJAgtW3/Br9SYYSinDk0o
         skLAClHMdQVoxMtT4oYo1BwQiUs7+29V9GeZg1Xxf2JAXVGHCEgfpQagwJL3wSeDFobU
         k4lHJocQY3Zy9n9n1RQ4sPQDxPEAZ0LCfnlBO+frO9XOTJqddKA0KN/WNWUH9/8T6NWl
         U/bp/XG86ixxNN1aCGvZVwfBNnVUnUaiIAh6JOPhY1q6RyqepS52LPtUv7nusrfMQ0vE
         DBl3U+8b2WXVtwSz1jOOsGDII7pHRxvzQCqqSy4sdrqyeHxAKzOz/kwx3tSLdRpxddXM
         brUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffmZcVfSfeQA3nmlJnD8pY5wfE+gHGqpjgHkWfO9544=;
        b=aJZqBbmDKFepJ6l6UBB/Ht1pgJoqmV7ldN2pXyppLZ0x4suZTheYVxVzYssQoJOgzR
         hsKKYNOepgekLvFFc8pUGzkTar4rQsyVA4sumCy7IyPpJz9x3SxDiIq1wSWmwS5qV/NC
         xQalkonX7EXB6kZ4CgRn7s5kOP22YuOBBawAC/7I+PoQ8+4TkG2ND6P32hv12s8e+qMC
         kqQfTuLpw5KKn7oM7QJ7dc9oYxgBD71BzxCFip1GGLYCHqqC6YFUdllsv0cDfP5VXUem
         QkZpmdV03S80TZsckiEy4rNB7MJsDSsEIAswQSiq0e5TQXARN2qk+j2kVfi8MBw8Lkkw
         u3Iw==
X-Gm-Message-State: AJcUukeVAye31vtv60iWbN+Qv9+zA2dvMg3/tdplYPX3oI2XVILreE7Z
        9DnThaDeAIn6x/fjetuTLng=
X-Google-Smtp-Source: ALg8bN6aGwsBuFCCEliK6zyyS9ARcHvGGy/zL+6jGizSb7I2yBBOhhkBUQo0Pxs7Kzj0EMUKRsOZAQ==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr2099630ljj.18.1545405672729;
        Fri, 21 Dec 2018 07:21:12 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:11 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 0/9] ASoC: sun4i-i2s: Updates to the driver
Date:   Fri, 21 Dec 2018 16:21:01 +0100
Message-Id: <20181221152110.17982-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
found whilst getting slave clocking and hdmi audio working on the newer
SoCs. Since the last push there has been some activity getting surround
sound working and this is included.

The functionality included with the new patch set has been extended to
cover more sample resolutions, multi-lane data output for HDMI audio
and some bug fixes that have been discovered along the way.

I can see more usage of the tdm property since I last attempted to push
these patches and the examples currently in mainline sort of the opposite
to what I'm trying to achieve. When we first started looking at the i2s
driver, the codecs that we were using allowed for the frame width to be
determined based on the sampling resolution but in most use cases it
seems that a fixed width is required(my highest priority should be to get
HDMI audio support in). We're using the tdm property to override the old
way to calculate the frame width. What I've seen in what has already been
mainlined is that the i2s driver has a frame width that is fixed to 32
bits and this can be overridden using the tdm property.

Anyway, I've moved the more controversial patches to the top of the stack
as I'm expecting feedback.

Have a great Xmas and New Year,

BR,
CK

---

v3 changes compared to v2 are:
 - added back slave mode changes
 - added back the use of tdm properties
 - changes to regmap and caching
 - removed loopback functionality
 - fixes to the channel offset mask

v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.

---

Marcus Cooper (9):
  ASoC: sun4i-i2s: Adjust regmap settings
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
  ASoC: sun4i-i2s: Fix offset mask
  ASoC: sun4i-i2s: Correct divider calculations
  ASoC: sun4i-i2s: Add multi-lane functionality
  ASoC: sun4i-i2s: Do not divide clocks when slave
  ASoC: sun4i-i2s: Add set_tdm_slot functionality
  ASoC: sun4i-i2s: Add multichannel functionality

 sound/soc/sunxi/sun4i-i2s.c | 399 ++++++++++++++++++++++++------------
 1 file changed, 267 insertions(+), 132 deletions(-)

-- 
2.20.1

