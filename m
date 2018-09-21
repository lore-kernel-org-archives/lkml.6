Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072ECECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CDC21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSS+POlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CDC21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbeIUSzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:55:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35855 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeIUSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:54:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id j192-v6so3214348wmj.1;
        Fri, 21 Sep 2018 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=m3a2xktoMXO/I633rPSU+tzFGyBigyIoXTYgwP1b8Dg=;
        b=tSS+POlCIPCSi5TNVDeFPPu88q1TfTKyjkqVmX3t4wCtW2kkfoQWe3ScQHYqlNQDOV
         1VJG9EAWL9o3nCAOnrFt0GRCRCgBHZVC1cxSXf0g5FVZRMXXJjF8jQBc5I4p2zdELtEX
         dm/5Hl6rAGUT8NAwAXNicvv5yBND8gPMhpxRBYydcpua3gGlIlmkDVvOU5DuIGHSJzgx
         e34k/kL3VmiYrvmAlhb+wBgJC9DhATSZLk+M+zseH9sxpbUc8N1+vWBZFUyexaBtXrt7
         kfPtb2BIbS4dUzt5gq0RDP+Vpe5swpgC3JXzhjRQD3wWvspKIcNMCjy/bwg2nLs56dmT
         zk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m3a2xktoMXO/I633rPSU+tzFGyBigyIoXTYgwP1b8Dg=;
        b=r3ZprdDd7AeTRE692sYM5F6w9o4nwb3kzdm5GzL2oUOYy3xcqDml+CD0dU2k0yqPuS
         zzq1gFJTgzPgpVkYENZAWbQRPAZ4CPcjfTWLBgxNu3pQJbIWER0ccEm156t79GyAfz+l
         aIdcSB92inAP4pPQroeAerK07cOdB1a3inJq3+wd6zTpKPPBFBZ2d5281GwEwf0nbC/b
         HvpKAoDJvovvuAiHIT8nVkt6DK/r6FD4CuzZ50OOXLzRUw5CFVYS6/SbSa25c5pSuV0F
         ObjnyrGgW1azcI3fR5QnDucf/391TScpkyqPLqpYihTUh0MqyDbUf6fRqqQOOeEG7LfM
         lqew==
X-Gm-Message-State: APzg51Bk9OwBLXyU7YZq7ZyAfMMrHQCzQFksheQjPLYGj4bcmMNBGga9
        E3G1GwXCQXRPvARlcQAmN5fAP6YU
X-Google-Smtp-Source: ANB0VdYgDvJXVQsLVqHp0w06J07wJ68IZytOlorX1J8BGr8hjrEOO5fkqbrNaVprZzcqE1OvI8aRlw==
X-Received: by 2002:a1c:8e04:: with SMTP id q4-v6mr7389406wmd.150.1537535170683;
        Fri, 21 Sep 2018 06:06:10 -0700 (PDT)
Received: from inc028000032.lancs.ac.uk (inc028000032.lancs.ac.uk. [148.88.228.92])
        by smtp.gmail.com with ESMTPSA id c15-v6sm3278702wmb.2.2018.09.21.06.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 06:06:10 -0700 (PDT)
Date:   Fri, 21 Sep 2018 14:06:09 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: power_allocator: remove early break
Message-ID: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a trip of type critical is defined before any trip of passive
or active type, power_allocator governor will not switch on.

Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
---
 drivers/thermal/power_allocator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 3055f9a12a17..6544b68e3ebf 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -496,8 +496,6 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 			}
 		} else if (type == THERMAL_TRIP_ACTIVE) {
 			last_active = i;
-		} else {
-			break;
 		}
 	}
 
-- 
2.11.0

