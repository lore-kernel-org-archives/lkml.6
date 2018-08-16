Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78746C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A0D21477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2ndkyj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A0D21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbeHPFkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:40:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41676 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPFkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:40:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so1315553pfn.8;
        Wed, 15 Aug 2018 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F2lUfS2qMObMXB1Iowh/bq7TdSASYc3dbif4z8CD7hU=;
        b=P2ndkyj3vvGWwRNSixRpkXslvL8MMGPtqsvra5P06SZKIiE+FzGnhesd6ejsprncPn
         O2rY4CGxWlrFfzXxzyR15Y9fVMznu41PqTGZFokHvwpXfTVD8ghn96ZgzWvLPPnX1vVl
         e+4WYj8kxjU+prsBlmsOkR5gwjIHtah+AFGyMD/c7E9qpXD9AzMtfyvqlE2c2QuDYk5Z
         RMqLxhFnwqsXfMj8quCyENLQ25Kv2PpFrQ0tGvnamPasuX03TSBsnam7YV8LDYrX3hlx
         pRS6H+5lclKT0SfS9uIerQsMUSLjsEJKJqgLAUi8NtgY+aFeEQOJFkg8EC92n45pBcUL
         bSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2lUfS2qMObMXB1Iowh/bq7TdSASYc3dbif4z8CD7hU=;
        b=Hn907JE0Oz2FGh7wwWIKdqED492jhOc9DWItgh3elHY7Xuf34FmKl6sObKLSpJ3q7S
         ez4wVBe97baS7Jp1KFKAk5gOFxgLS0gb0Jt20GyIeD5Q/3GfjWN5R1OBqkM4mknCSMuC
         iK9aYq0ax7OQJhaBPJijFFdLGIUl/qkmlc9Ch44ZpBztqKuWVTUQ5yiCj8GedG41zWLV
         sz+MU7BLyal+laRsxXBKVNkOcWwddIjctkbsJXEq3WW0GMpvPygXNuHpZJXEKdjv587z
         uVO+p1kULhcB9KZ1F7clxVqy2KQKniGT1ZlD3Mw4nWymVzsEgEfo/1hM/0cEM6tMqGXM
         m1mA==
X-Gm-Message-State: AOUpUlGEfi1vbbAn2OHWxVJq2sn/sdijTGcWKK7kc7+bXwhRQo4+Xavd
        1Ojw2xEAv/rr25WMmB32vaE=
X-Google-Smtp-Source: AA+uWPwv7QKnMJ/Xn5y3z/LPP+xW+4UAiLsQXcd+yx6gR29blHHLp9cpoKNvC7M0gc+Cz7erOfelSQ==
X-Received: by 2002:a63:d80f:: with SMTP id b15-v6mr27628317pgh.347.1534387507257;
        Wed, 15 Aug 2018 19:45:07 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t15-v6sm37823323pfa.158.2018.08.15.19.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 19:45:06 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Subject: [PATCH v2 0/2] Rumble support for Xbox One S controller
Date:   Wed, 15 Aug 2018 19:44:08 -0700
Message-Id: <20180816024410.29218-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This is v2 of the patches adding support for rumble for Xbox One S
controller connected over Bluetooth. Hopefully all of the changes are
pretty straightforward and self-explanatory.

Feedback is wellcome!

Changes since [v1]:

    - code converting the driver to use struct ms_data is split into a
      separate patch

    - CONFIG_MICROSOFT_FF removed

    - explicit PID comparison replaced with MS_QUIRK_FF

    - ms_init_ff() converted to be a no-op for devices that don't have FF

    - all FF cleanup actions moved into ms_remove_ff()

    - struct xb1s_ff_report declared to be packed, magic 4 replaced
      with MAGNITUDE_NUM, output_report_dmabuf converted to be void *
      to avoid the need to typecast it.

Thanks,
Andrey Smirnov

[v1] lkml.kernel.org/r/20180810001714.14659-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  hid: microsoft: Convert private data to be a proper struct
  hid: microsoft: Add rumble support for Xbox One S controller

 drivers/hid/hid-ids.h       |   1 +
 drivers/hid/hid-microsoft.c | 142 ++++++++++++++++++++++++++++++++++--
 2 files changed, 138 insertions(+), 5 deletions(-)

-- 
2.17.1

