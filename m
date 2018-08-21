Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA427C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A002F214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9J05Zo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A002F214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeHUFC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:02:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40474 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeHUFC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:02:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so7993409plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5ysyXaVYNignwY7u48JrARSlBXLwOqyEQtmfSRg4HOg=;
        b=s9J05Zo0ESzXeJjm8XiAtdjFw9B3nKjQU7RotSqUT5t1Wg8fROmF2huoUbT4uYGNDd
         2/scis5ygg9i3qSiCaNb6eLaRq0sh5fSh96vg17lw5fE8xLHzaQSl0RyOpq6pGoASgls
         Sn76fc5r2YtJ9ZLJDmll9dgJ7wvkGDtBZ0fhjaXE/ry9Hb6WFWe0R3+RqhMyzCCt15pB
         vx2WFjyMtBZ/m5iZxc9sM4Xy+RANUSq6GAotBq79UXcQDz0uGGsn4uxOZZwa16o/orN7
         /zmyVQ+QyTyVU0PTA6x3aV6A41cB4/1I/gmL4w1D6MejCpr2iAX4GfRxfWveXFeTpx7z
         VH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5ysyXaVYNignwY7u48JrARSlBXLwOqyEQtmfSRg4HOg=;
        b=B5Q8csjNAHhYhMv4kGVap0RzoDRZxCsrg9UyulJWaemhAEcw8B1OkwYfWaRJedyM8f
         GbUgUdZ6BJ70EUGUtTQhgAdHLTzQMoat4lBEtFeQuZzQSU99eCetNArNEdYjj1teqn7F
         SoAEa6ynG5QuS1ZfR1EwOdKf29nNd/QIEZw4BEyvIiztGRXpb+4gz5OW4L3romGxU4mD
         9gXVtv+NMSYBGoD6SdWTWVKgIjRpjWawJQLCCupb3iAaHS2IC/wYzWvrVU0rj3HltaaS
         wmFHyOtf1Nw8SOyN7beFvr5ZUEhVMxlRZb3cgmgOVesMopDuVzoooImBFisGsal9dz54
         iecA==
X-Gm-Message-State: AOUpUlEbEcOFVN/kSJ2igwOe+q5/A7kWd0t+i43wdW0QFMF9pW34mN73
        75J+pPpscr+fKNvPq+UyW8E=
X-Google-Smtp-Source: AA+uWPzN3fVrGFKi5cKAx0rDk853tnMPmAJmqq7PKltd+AFidHPN2qXEPBcBxBktvmpeImb0ASao7g==
X-Received: by 2002:a17:902:8697:: with SMTP id g23-v6mr47715704plo.292.1534815866375;
        Mon, 20 Aug 2018 18:44:26 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id m4-v6sm14487393pgn.82.2018.08.20.18.44.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 18:44:25 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:14:28 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bhaskar.kernel@gmail.com
Subject: [PATCH] staging: rtl8188eu: Fix spelling mistake
Message-ID: <20180821014428.GA7914@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix spelling mistakes in TODO.

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---
 drivers/staging/rtl8188eu/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/TODO b/drivers/staging/rtl8188eu/TODO
index 7581e25f231d..5faa0a9bba25 100644
--- a/drivers/staging/rtl8188eu/TODO
+++ b/drivers/staging/rtl8188eu/TODO
@@ -1,5 +1,5 @@
 TODO:
-- find and remove remaining code valid only for 5 HGz. Most of the obvious
+- find and remove remaining code valid only for 5 GHz. Most of the obvious
   ones have been removed, but things like channel > 14 still exist.
 - find and remove any code for other chips that is left over
 - convert any remaining unusual variable types
-- 
2.16.4

