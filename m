Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E500C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00048208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00048208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH1FmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:16 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39520 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH1FmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so8248oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=df4YA1yD0p75EKdgC1piIn4MGTBHn53g/vasp3IjE8c=;
        b=WwjnoKQzKoijocrkcbB6PUk95b539yNSGaQ9gGeZXGg4cPlXpA/2iTpXaiX3cJXvRd
         +7G3CWbOgc2RIiwEOIjxysOqbk664rXp1yQr3ILITxWuvJcAydUhBXCOc7evrVQq/zGO
         QHWti6eeQ8EvyYkTV9WAZ1VHHRs8f/RQ0V6kjVGnCeywtHCSMh6/j1d/03Eb9RENYXAW
         L9F8DmsZyuPacFhXGcyURz8cs37kJTbmxMTlo4mIZM5pOx+jQ3dNGf0SCd3PH11rLZQH
         lIJQkiOXdmoNM3ky5HdoNdwdxNnIDwg/9PIrb6jDkSNqvFlX82EEcjs5LvzkpQpN+c3R
         QU3w==
X-Gm-Message-State: APzg51CHJqc6oPPlGIoiI6aPItMp/PtWlLyJ2OobeDppuYwp/9NRLkEL
        l934MXyAkXgjLDoi7L+642hqkqo=
X-Google-Smtp-Source: ANB0VdZbK2e60I5RRopYIAF6cLfLaMV9rM6+Zp3AA2xSMgc17VaCMkc87aGX986XvUPoeNIo7/gA6A==
X-Received: by 2002:aca:2c02:: with SMTP id s2-v6mr1019509ois.305.1535421178334;
        Mon, 27 Aug 2018 18:52:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:52:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH] nios2: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:06 -0500
Message-Id: <20180828015252.28511-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/nios2/kernel/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index ab88b6dd4679..54467d0085a1 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -214,12 +214,12 @@ static int __init nios2_timer_get_base_and_freq(struct device_node *np,
 {
 	*base = of_iomap(np, 0);
 	if (!*base) {
-		pr_crit("Unable to map reg for %s\n", np->name);
+		pr_crit("Unable to map reg for %pOFn\n", np);
 		return -ENXIO;
 	}
 
 	if (of_property_read_u32(np, "clock-frequency", freq)) {
-		pr_crit("Unable to get %s clock frequency\n", np->name);
+		pr_crit("Unable to get %pOFn clock frequency\n", np);
 		return -EINVAL;
 	}
 
-- 
2.17.1

