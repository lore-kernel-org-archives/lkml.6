Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61AC2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahm4/vIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61AC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeIZBnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:43:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41521 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeIZBnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:43:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id e18-v6so25662713oti.8;
        Tue, 25 Sep 2018 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsGpWWTeUDtt/5CSi2ElbnCpwkfUbf9Nyypq9yAPzAU=;
        b=ahm4/vIvc7lwCbWdPomN0Cg4tRyzlEXCotu0GbmH8FE8oqdb8B09nTzU1DkStVCKfp
         tbE4Lvu0dj4OiiNZCEF4i93G6WTbD5GFzmjrDYlcZ2RExz7oriSSTePumVjmkvE79QZ7
         Rru4bPKzm1xHjBrECakHYUbAsxDmdGRB/k9L+auyXhuM9a5ARn6cXBKbzbWoRaQFrtAa
         jSxzllXGuIAJ/cibiHvDeHLbTkDe6FpxCBKVegMekxd9WleTdLXfgOQmhBIpQ8O29tqs
         l89nDRUhiLpzjYroU76F++i/gT2DgJUqjLMvOa9a29VmZGAMcOq3ASTooRqmO7r6FPBm
         ODww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsGpWWTeUDtt/5CSi2ElbnCpwkfUbf9Nyypq9yAPzAU=;
        b=jTlv1LoViJ1QPA/nxjatl923VBxGqD4HgX6GOaeQArCn1H3qrU52geg0pr3b9Z07vz
         7i2/6U42R8J2JbEqM+jpGX0mMWm9urwSqPhKgeObI2pfXQ1PLzXOMDgYjDQAzR/QpjLD
         l6Zec67A3KKQ8nhGww1nkGTUl00xVQAqTElm3FfwscDQWWoONzr7YrpNV6pQezQlTprs
         ci6iAuP3RPi+L7jHf3XDevFjDAAqX7DGEJUV8SzdX36UHWmProxdb/zNto8XJELD0eQb
         h4x9pNEJZZW1BvlNh/NdpsbCVOIxJCgFab5yBL3EEPm1JpCvWtylRybjr0AuJOmXBpe6
         gtjw==
X-Gm-Message-State: ABuFfojZek1ENpbb7YJLiAlHpj+xk1jaFWejxo32Es8x1njZycYVhoXc
        hXnrD0wYsj7tsPxnqAjTe08=
X-Google-Smtp-Source: ACcGV61fJZCKpw2sXJgX6rMbJKr9/fBE5Ykns+jf49wya9auM5Y8kWTIiPQf3VXcCrra87IjkMGzKg==
X-Received: by 2002:a9d:44ee:: with SMTP id p46-v6mr1672424otg.25.1537904069922;
        Tue, 25 Sep 2018 12:34:29 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1049193otl.43.2018.09.25.12.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:34:28 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
X-Google-Original-From: Stuart Hayes <stuart.hayes@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH 0/5] Update and move Dell drivers dell_rbu and dcdbas
Date:   Tue, 25 Sep 2018 14:34:13 -0500
Message-Id: <20180925193418.28493-1-stuart.hayes@dell.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayes <stuart.w.hayes@gmail.com>

The dell_rbu and dcdbas drivers need some changes, and should be moved to
drivers/platform/x86.  Additionally, dell_rbu needs a maintainer, and the
listed maintainer for dcdbas is inactive and needs to be changed.

Stuart Hayes (5):
  firmware: dell_rbu: Make payload memory uncachable
  firmware: dcdbas: Add support for WSMT ACPI table
  firmware: dell_rbu: Move dell_rbu to drivers/platform/x86
  firmware: dcdbas: Move dcdbas to drivers/platform/x86
  MAINTAINERS: Update maintainer for dcdbas and dell_rbu

 MAINTAINERS                                   |  11 +-
 drivers/firmware/Kconfig                      |  28 ----
 drivers/firmware/Makefile                     |   2 -
 drivers/platform/x86/Kconfig                  |  28 ++++
 drivers/platform/x86/Makefile                 |   2 +
 drivers/{firmware => platform/x86}/dcdbas.c   | 123 +++++++++++++++++-
 drivers/{firmware => platform/x86}/dcdbas.h   |  10 ++
 drivers/platform/x86/dell-smbios-smm.c        |   2 +-
 drivers/{firmware => platform/x86}/dell_rbu.c |   8 ++
 9 files changed, 175 insertions(+), 39 deletions(-)
 rename drivers/{firmware => platform/x86}/dcdbas.c (82%)
 rename drivers/{firmware => platform/x86}/dcdbas.h (93%)
 rename drivers/{firmware => platform/x86}/dell_rbu.c (98%)

-- 
2.19.0.221.g150f307af

