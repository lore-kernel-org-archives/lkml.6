Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE378C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15572064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuOtnuw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15572064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJFBgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:36:43 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50931 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeJFBgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:36:42 -0400
Received: by mail-qk1-f202.google.com with SMTP id g131-v6so13046344qke.17
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2kmVx36xgoYV8gF3d/5zwoKOskweja3Ogv6Zox+9+CQ=;
        b=JuOtnuw+ibkCh6EdCaECniMNpzlgwaEgavMkV1uIrrEkGudrO0jT01tH7/yTiDPQt/
         oT9V/Xxi58sChxA0gaj3O61BKtHtRuvAvIU3jso4fAuLekkMWAKZlpfE5M1EC/JwFjKM
         h/5TsPdScY8zYLjCCHUPHY63VGZ2comdnTu2MqcT13nqq2hi+Pcnyl8Yb+3yvZ9elpU6
         fC8DZGscjZXREaohn2xk0uKPh/8cQWyMkWgps/JmfGyL/2RO9vQe7VPhM5kF2pcYk1jg
         5N1bWSTHBgVuCcH2qs5LT918JOMYwK+u75X6AAtMUgEVUnmnpjPPMBnSPPduJjs5jr68
         IZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2kmVx36xgoYV8gF3d/5zwoKOskweja3Ogv6Zox+9+CQ=;
        b=p/7SjrxDKuRo8HpFkGzKTmJwOEpW5tvqHbQsbljQTFIW3juyWyAe7R4+0mLZvfmLPI
         iKJWXN8TigiV++Esx8Smn0jnytusW9uIWTGewzZ+FwVKeoGeLszuRPuvQvd1AMVLuSUM
         BI0bZMtiJl49D4ivLUo8XBg0HnFOfVY+A3qGoJCVOXJCQO7KMATtuqEZVdhKaNkgyXu8
         SM1oMOlPO8ZfcZFxv+IxgHYWOsEnzcC9oEznNlPBehnkGsBoZ0OOfw9MjRgkDoaFLTwj
         gQUyky7mj/hHS4k3MPSObClAMwKgG8D4CHs1gPYJ6SNAoL7/q9byDEpXiRQM6M9RsypF
         PXbA==
X-Gm-Message-State: ABuFfojnTcPmWjeDZn1aNOicjh3T5AGAJAeEt1cdh7nLo133FVN97qj3
        QWSLilmWoe74hBhCJP1t8Ztu9Q2L7VsiuLdfHBXqbQ==
X-Google-Smtp-Source: ACcGV62JoeFcEEaUZfAcd2Uzsc3x94SKj0hSIO7XWGfsDAlYUztq58yJ7wfn4B9/Mmc9KC9GFdSuGpZSDkdX5rg+J4Fk8w==
X-Received: by 2002:ac8:550c:: with SMTP id j12-v6mr9308158qtq.59.1538764605743;
 Fri, 05 Oct 2018 11:36:45 -0700 (PDT)
Date:   Fri,  5 Oct 2018 11:33:00 -0700
Message-Id: <20181005183301.10329-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] MAINTAINERS: fix bad pattern in ARM/NUVOTON NPCM
From:   Brendan Higgins <brendanhiggins@google.com>
To:     joe@perches.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the process of upstreaming architecture support for ARM/NUVOTON NPCM
include/dt-bindings/clock/nuvoton,npcm7xx-clks.h was renamed
include/dt-bindings/clock/nuvoton,npcm7xx-clock.h without updating
MAINTAINERS. This updates the MAINTAINERS pattern to match the new name
of this file.

Fixes: 6a498e06ba22 ("MAINTAINERS: Add entry for the Nuvoton NPCM architecture")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf4..771378e82de8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1730,7 +1730,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm/mach-npcm/
 F:	arch/arm/boot/dts/nuvoton-npcm*
-F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
+F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 F:	drivers/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*/*npcm*
-- 
2.19.0.605.g01d371f741-goog

