Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B482080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B482080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeKRWz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 17:55:56 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55340 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726287AbeKRWzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 17:55:55 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wAIC581G005944;
        Sun, 18 Nov 2018 14:05:08 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 6A76762EDE; Sun, 18 Nov 2018 14:35:06 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/1] npcm: fix uninitialized 'val' warning in receive function 
Date:   Sun, 18 Nov 2018 14:35:03 +0200
Message-Id: <20181118123504.83082-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed comments from:.
 - kbuild test robot : drivers/spi/spi-npcm-pspi.c:226:17: warning:
  'val' may be used uninitialized in this function.
  
Fix uninitialized 'val' warning receive function.
Send function has been modify to be aligned with 
the receive function.

The NPCM PSPI driver tested on NPCM750 evaluation board.

Tomer Maimon (1):
  spi: npcm: fix uninitialized 'val' warning in receive function

 drivers/spi/spi-npcm-pspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.14.1

