Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E372C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458A924A8E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDkqYcDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458A924A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934602AbeFWCIS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:08:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46179 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934307AbeFWCIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:08:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id d2-v6so3689044pga.13;
        Fri, 22 Jun 2018 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPvY1MDqn4aCUMUwdeifiAc6SZjpV3XiIvjaQxgYHjw=;
        b=pDkqYcDqEkPInEeBGLnkYtk+0j3Nyn17z4pDqFlJH9oBAnF2Lj2oEUIyfcdnaTIw9f
         OC5qrjPevwRLEJxBliTuHRkkjlwyT6IDzxdNLy05Y69V1iroq4F9oLtFeUR/e45CsCV+
         3zqBILltSqBZLina4rOQBLZKuAI2CAclht6OExkOUyxaFOOY3PSMBO9c4hBxTVkyXfV/
         On4yXVx8SUBypykoL4CZ1jqz4G0t7Dw5pHAlwixgtahQ4yCiefsvl/SvHIrXvDR8GBSb
         ThoDR7d9CYQqzahLenVGKVxOswxfwHKSIrJpToUEfBbHqNgFU0ia8p7+MTvSoGb3knzr
         Hh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPvY1MDqn4aCUMUwdeifiAc6SZjpV3XiIvjaQxgYHjw=;
        b=t2hiRwmxMrTpcHjr+LVNl9lEb0FI07ckmvz+6omUnHKwdZlXUHKmZhDGd+iw7NrnK1
         90mH0wW/6R9pwe6+e9RsOnSpnN9ep02LvJWYLq20YLuKWv6ma7HaqfW4qjpO1mvnVKsh
         dGXOquSCymCgonp61mQteyT9q9AuZTlNo5xF7tagG+qGbCB//W9nlFO00vIeKl0ISfUK
         aOSM4nAGfxBTDNK2qIELZ4Ppcv+JCWmCbdVgxVYYsvLUVIkfo29Huwx41A7nxLvbgDPa
         aWdE61noGtT4BlfXXZlb7ff5C+W5SMrMEyJGnYRgFHj9IBtotLmsDNZZKYJpncjFRMgP
         G1nQ==
X-Gm-Message-State: APt69E36Bu4C9vDrn7u913qreRners7mySMd6ZveTmBlbPy18riQDNZC
        RncRbJ67Db2gllLFdPmgi23G2A4+
X-Google-Smtp-Source: ADUXVKJCw8tqOnqdSRzWAgW7SQrXNR3ht+qjiAPrspxm0jGicWSHzCxyUoJLMlVgFisrWlFbkD/xpw==
X-Received: by 2002:a62:211a:: with SMTP id h26-v6mr4038315pfh.133.1529719695889;
        Fri, 22 Jun 2018 19:08:15 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id a27-v6sm15239202pfc.18.2018.06.22.19.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 19:08:15 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org, Stafford Horne <shorne@gmail.com>
Subject: [RFC PATCH 0/2] Fix GCC -Wstringop-truncation warnings
Date:   Sat, 23 Jun 2018 11:07:51 +0900
Message-Id: <20180623020753.27266-1-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When compiling OpenRISC kernels with our new toolchain based on 9.0.0 I am
seeing various -Wstringop-truncation warnings.  There might be more as I am not
compiling all drivers/modules yet, if someone thinks thats helpful let me know.

I discussed this with Greg KH at the OSS Summit Japan yesterday and it seems no
one has pointed these out yet, so here are the patches.

Please let me know if I should keep these on the OpenRISC tree (which I can do
for 4.18) or if the maintainers will pick them up separately.

-Stafford

Stafford Horne (2):
  crypto: Fix -Wstringop-truncation warnings
  kobject: Fix -Wstringop-truncation warning

 crypto/ablkcipher.c | 4 ++--
 crypto/blkcipher.c  | 2 +-
 lib/kobject.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.0

