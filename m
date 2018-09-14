Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC8AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3222E20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTxZR4RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3222E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeINP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:27:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeINP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:27:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so1371435wmb.4;
        Fri, 14 Sep 2018 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bBXRIvEcg37kN7GVKevL2wwRAukdIoMLopQmPBUa62g=;
        b=DTxZR4RBGURF9m8w3K8eEMH020dRjZVYP433ZWzgz17vBqrV1fb6ZsrFyon6Sj4fzg
         ruAAunVEzbIU23Q9FABcn5+tKz8jHDGhgOie+NbR2pVs8e8z4PYwh3DDkHVhQHIlVaqE
         du9I7iVz4gN9d3NNjxnSZVXaMK9q8zE1cGyURm0hh3ljQszN9aK7cFARE5z4DGX/ixfo
         KwubpOAMnIYRm2xpAB/hpoYsnIIPqrN0xMwbgHSF5/adVUHmncGeN1VspoEizaaMvKxm
         B2dJrhnID1uZo33JVcmCqEWobqoFU2xhU9er+ufK2uzbDn9LVfFog57jFNTLMjK12pnh
         J0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bBXRIvEcg37kN7GVKevL2wwRAukdIoMLopQmPBUa62g=;
        b=FbXxumdNTMflItjpnf6gchj2QA3S2Bgq/eN4VhvqRJJDx4WQMwJ5PtFsYlUXVjLGfz
         WhIZ0dlzmHjLlHECCME+S18DG/vZAeKN+WVbaPC0QAbGNyaEb+LIGbtBMm5XAS0xVw0Y
         VaQlzey2QXagxKxXFBd30D9fuuh3lvqFyqWeCGLj9iDH5bWAl8b64+eSkW2lMhVwNITV
         GqtTUr204YkLDq92Y19+U4fW6/Adotl0XU6eSx+tAzCMwj1AmqFLXhweUuuRLBq4+hVd
         w3ShfFEUDh1GZfz8OOY2ry0nCC7T2neYEjhQW3p7sSpzBrKJCXi30XQKTXfE0ZUr4ZWl
         YMgg==
X-Gm-Message-State: APzg51AzY/ExJ9SkN5Tqx02Y+Y2wk738Ofnyba8B4/SPKybaE13ysicF
        JcHSDFPbt3BuRGw4NOx26kM=
X-Google-Smtp-Source: ANB0VdbVGrIA6VxqijOb3V4m/hz6F4JS0yiMqjfAe7qdcSQZ4UlNna5UuRYeyd4fn6hy6LaXtCmfPg==
X-Received: by 2002:a1c:7305:: with SMTP id d5-v6mr1700736wmb.53.1536920036315;
        Fri, 14 Sep 2018 03:13:56 -0700 (PDT)
Received: from localhost.localdomain (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id x15-v6sm5618524wrt.53.2018.09.14.03.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 03:13:55 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 0/2] Fixes for the SAMA5D2/SAMA5D4 watchdog
Date:   Fri, 14 Sep 2018 12:13:37 +0200
Message-Id: <20180914101339.7382-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous change of the sama5d4_wdt driver broke the device probing
with the device tree configuration described in existing DTS files,
when no value is set for the "timeout-sec" property.

Moreover, specifying any other value than 16 seconds for "timeout-sec"
leads to a watchdog reset immediately when opening the watchdog device.
Fix this by respecting hardware constraints added in recent versions of
the SAMA5D2 and SAMA5D4 datasheet.

Romain Izard (2):
  watchdog: sama5d4: fix timeout-sec usage
  watchdog: sama5d4: write the mode register in two steps

 drivers/watchdog/sama5d4_wdt.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

-- 
2.17.1

