Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B62C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1204126BD0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Psw9Rnl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1204126BD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeFZRlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:41:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46963 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeFZRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:41:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id l14-v6so13023712wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXtqsHhITjNwa9rI9Bpj3HzsftH5uPu7ofohuvSLUF0=;
        b=Psw9Rnl/XarP9zrFntgLywpqmzihTwDy38fh8qANQzHfzW6i6k3oQ9/DfaKC4wQw6U
         PV5bzGHrzXJftHsyv7HGzUJgf6DT6FTR7uj2TfXbLm5Mm4Jy/0uhqLwju5Y6VWj7z9Gb
         jebPffekrq0MjOo9EpQAydIfZSSumbGRzIdj4WJCNNgntKIYgHBDGMM65UsmOmiz8R7b
         smh1fBpH6RkoYIQ22gIpZnIw22wiw15+Ubp03AwSPn5DKchMn8rt2qQQaB0zKpCtd7wC
         +x4DmD20Jq7I+BdSPyQtRCGqP8ab006e4jbRNeMSvMEeAMNCydogrsrvwn3rwrmGKQRc
         /91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXtqsHhITjNwa9rI9Bpj3HzsftH5uPu7ofohuvSLUF0=;
        b=ZEGXX+wvPSVpoGDg6MjuwIltA3oMklft2gM3jykMHL3DfpiV2X0d/MGpgN42gsrjXL
         0QQ5fiO8pjQL3uy3gBJQlWObu3UkOirtMZO7dN2acgq4xozk+sJ5CG2exw48yaT6yIWL
         Pg9a69M/7uBFgVU4at9S4GXspE/WF45EsgDBBIKqLE+hQjyJR6ZZchbyOFapkcaCQERV
         ITT5vGS3WC4pOQDiEkv6Wr8rTXz5B+Ogyn7m/zOz/u3ZDPgHrRYEsxcJOM7IXoP5PYB9
         z4Gd4khJdRA5ZVQKSVRFze6xRBDdvqCRkZ6pLug1kIwcGgxyzK0LFY8hTPxV/dTw6T0s
         A1Cw==
X-Gm-Message-State: APt69E3VxaFsWuODeBh4KznC2qCNP/oLr9u0AiFBz2aqdSy15hVtD2lE
        btDSX/t3ebGKoHZaHoD9+M/bPw==
X-Google-Smtp-Source: AAOMgpelhiAu8xbyVYQk/Z5Zsz70JKXwNTDhk9z38nd0aLNrVW/O/AE/Eoo+3vpIdgWD1gXBc7GFBg==
X-Received: by 2002:adf:aad3:: with SMTP id i19-v6mr2270828wrc.149.1530034869900;
        Tue, 26 Jun 2018 10:41:09 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i4-v6sm1580462wrq.28.2018.06.26.10.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:41:09 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: tas571x: add tas5707 compatible
Date:   Tue, 26 Jun 2018 19:40:55 +0200
Message-Id: <20180626174056.6400-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626174056.6400-1-jbrunet@baylibre.com>
References: <20180626174056.6400-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tas5707 to the available compatibles of the tas571x driver

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/tas571x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
index b4959f10b74b..7c8fd37c2f9e 100644
--- a/Documentation/devicetree/bindings/sound/tas571x.txt
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -7,6 +7,7 @@ powerdown (optional).
 Required properties:
 
 - compatible: should be one of the following:
+  - "ti,tas5707"
   - "ti,tas5711",
   - "ti,tas5717",
   - "ti,tas5719",
-- 
2.14.4

