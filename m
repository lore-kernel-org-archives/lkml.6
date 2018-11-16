Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3432089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FOI802+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3432089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbeKQB2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:28:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34414 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeKQB2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:28:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so25251434wre.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLJ1ADnzINm5MjG5ShisqkYqeXmeVPABmXgx3B/VbiI=;
        b=FOI802+Y6dZjqvmOdnVFLUBQX6PH04QZDojl3snG5sHJAOaZrHJBMRXp1g5ba3qHbp
         PfpFM31uSedDXT57ZhZQxY5dm+EYUzqTh1EKBEax5oS+SUoUsxyrh2RCcHd4aWogg3uQ
         /DodwHjdBwDEFRAVehu0WWJ9wWxqQgTcR1iu9BZba00TZdT8UT9enfVkhM64CkrY6QXM
         +zYyqP24axgEL8WwpkKFbrrqkL9YQWEccmBO2+ELUqfDkiHs0Y1BH3rwUoaQeDqu0P4E
         7glGIIdSiOkm/eaVYkkVdEt270HtQHby+LvnOrt34lPdJZfMZVihxX8MqZsuOiPXjWhr
         mtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLJ1ADnzINm5MjG5ShisqkYqeXmeVPABmXgx3B/VbiI=;
        b=bcmB9SwzJkyvjQ81YPgT3/QZm8lUzrVahkIj2Qis8yRz/b+UqEXc8/C1vk1MFh7o2e
         OLk/F91ho4EAi6Rh0315+BVL9X/YLJ2To5csKbn0u7QI9pYcflgm/NxgcpZMiWXQfY3R
         1ObUSCTq93WE9abTg4CwKE7jkKMM6amXaxkdRJdpWEIwrCSFGzeaAcOhzNwtYh++Y7/e
         V+rhwqhXNV17jQGi4qJnQ1lM2qAUjKQe5CCK/SEv91AHvqy/kvmLxm2QStvRCGzu+UDd
         Q7sJh08f/rSlG2v0IUbJCeDoIPVscm+CRvhXqwMr+W90dy3GMhxrbX9nf8KVGPseTxSp
         QlWA==
X-Gm-Message-State: AGRZ1gJs/mARSSGDyyzakrfnnPoFmlwok7X+nEMelOT8Zl0ict2JvqI+
        qBB44pbmzd/ZzopN0CEUWOyaEg==
X-Google-Smtp-Source: AJdET5cQW4YjRFRYOfKV0lmFz9oA7klCjub2+bSS6xdy89nf9VaneLPIeRpESKYrm+JU/3HlpeDvdQ==
X-Received: by 2002:adf:9022:: with SMTP id h31-v6mr9742649wrh.297.1542381344560;
        Fri, 16 Nov 2018 07:15:44 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h125-v6sm13937816wmf.48.2018.11.16.07.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:15:43 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH RESEND v2 0/2] arm64: dts: meson: add Libretech aml-s805x-ac support
Date:   Fri, 16 Nov 2018 16:15:37 +0100
Message-Id: <20181116151539.18501-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the libretech aml-s805x-ac, aka 'La Frite'

Changes since v1: [0]
 * Update gpio line names to align on Neil's recent series [1]
 * (really) fix typo in comment

[0]: https://lkml.kernel.org/r/20181114101925.10526-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/1541587550-17842-1-git-send-email-narmstrong@baylibre.com

Jerome Brunet (1):
  dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings

Neil Armstrong (1):
  arm64: dts: meson: add libretech aml-s805x-ac board

 .../devicetree/bindings/arm/amlogic.txt       |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  | 248 ++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts

-- 
2.19.1

