Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56162087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1uPN4Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfARJv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:51:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35297 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:51:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so6151490plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kc6c6efxImewljOaGu2CqyRgqK12PBrb2Hc5TZetNmw=;
        b=O1uPN4DbXfw5OBNp8kZA+lz6f/PZK+GhzvzKGxFslK5C2fPp5gQFPF1uGQH/L4bctb
         1LuD/peC0+7NYDFKTqOXsVFSDrBogtvQV375YaMevtexMKzZMIVpSuCTvzbsVacPkgc4
         9E3owT/dHH1MUWolagcTh9UG0G6RyU4LJC3B6Nl4FS8s4h8cFlBqW0+gwoatqEUGCcA3
         SFB6VZ2yQXWQUOdil7x8FGIbLwdP1i166zSdGtPhJDygyYpz9daf14wByAzytDDIbGk2
         aX7vrgcsLlNwWEUU0P1M3ywd97YWVsF9LwibNaVHZQG1d1YQIbo2WyEqnhshdxQGL2GA
         X4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kc6c6efxImewljOaGu2CqyRgqK12PBrb2Hc5TZetNmw=;
        b=YgOznONZK+oWPglzAl+n3njadzo3Xkw6RhjZpG4Q9Vy7GrE271UdJr47qD6q6RH4Dn
         asPwa9QoU7rJAhg9srZ+Xa7d8U8Xe+W4bN0v1ED++i9PmU/RnvV3AOGxJNvFf7eyNaIw
         FuXVvez2nAEImKaWL9RRmbwwIv7Nm79EgtGQzAnrCtnkLESdeOKXO2yAIHjxeDdD+YTg
         hQzjPr+BgBdH0Qh0AtEdfVgZ7bjRcGwXHY394qle44JbpKws9GuXeVm+XxFfPMXXhAq+
         ehVZmObCJUe5QuRgnAm8HCeRfV+OQbFLS+ZcmkVXTtvAqq7JZPQbUzMBKdQe2TkEQE3R
         HGZA==
X-Gm-Message-State: AJcUukdgKjfdwJpBGzs9gymd1DoeLr8MyoOgtBPRDN4mbAC7IIvCjRtj
        bx8dJfuO96rtOTnbY0OFJbs=
X-Google-Smtp-Source: ALg8bN6BFeABZZs38uKFKbds0y6rCx+3KtdHczpPr4bA4x1tpR7x8drO8nkKu6vTFKga8AvorceadA==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr18636135plx.232.1547805116945;
        Fri, 18 Jan 2019 01:51:56 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:4009:bb5f:cae:6988:9c9d:282])
        by smtp.gmail.com with ESMTPSA id f62sm6947042pgc.67.2019.01.18.01.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 01:51:56 -0800 (PST)
Date:   Fri, 18 Jan 2019 15:21:52 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     ren_guo@c-sky.com, arnd@arndb.de, brajeswar.linux@gmail.com
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] arch/csky/mm/fault.c: Remove duplicate header
Message-ID: <20190118095152.GA2563@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/kernel.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/csky/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 7df57f90b52c..16d8378cf12d 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -15,7 +15,6 @@
 #include <linux/smp.h>
 #include <linux/version.h>
 #include <linux/vt_kern.h>
-#include <linux/kernel.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 
-- 
2.17.1

