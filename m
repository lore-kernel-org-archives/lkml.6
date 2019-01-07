Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964D6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2637920854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="M2HQPvzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfAGDkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:40:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44737 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfAGDkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:40:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so20093160pgr.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 19:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX21yON0u8Ix3zPbHV7fPi4zXEU1WcLvjU1z/+vfVo8=;
        b=M2HQPvznR2OY3k57lM/CPyl1D2xNPz0t+g3dmoRUXX7oIXf093eRQiYENkddqB3OcP
         Xg6fL7fv3uNsH8cpr/6HGYxdUfGKGsZhfLsW+CCdjpARveUABVwykJ1JGJgp6IX1Mofy
         E5lYlH2+neHtrZUp/dvyzI2S8HKjB0kEhW66+YOdtVCG7MXVyiJ+n5UUi/rc0UN9OIwu
         IKgUBVx2+I1IrKWcMnHvPgXszd+HzOSZ14Uv1gbbX8bE5mFJDcx90sZ3r7yWDaVELUtT
         jpZaz4FjxeNNUvfyyWx5jhRGNfJGg5uwby2aDseP3jejZdl9WNMH6cXhmhvFVSWuf26u
         QaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX21yON0u8Ix3zPbHV7fPi4zXEU1WcLvjU1z/+vfVo8=;
        b=XXFmEOhowTwN06YhRWAmynte3C98SO0pwBFQ1rTB8HaJt7QzQji5iYi8oyJHD55g1I
         /x8lX5PZu2vxCoCLzP8cMNp2aIkh4bOrBz29jR1XNazG5s0BBnOtBsMeJbD+QXeq6Mbh
         c6k9TEID7jCxtIISUEXSQN8rIE5fhzfZEyDXj9QBvPjxOV3kBSQEGd7pXAPVf63vWmRt
         kBOQU6pwkOFxDTt2WfM0DtKR7mpDl5Lh1DmSMx2JGSeWDZ+WhRehBQNCQq6dNr2OPRUF
         Exer2KhCTyp5vzK7kFKnowgsdc3CgU63TEnpHjZnv2W0Kom/zlpQhA1u8sb9gVuTo4tz
         PPYQ==
X-Gm-Message-State: AJcUukev/mxTH/9kKH4zkgavK1u5OSbauygq6D/diVMP9OLSbC7iS3ES
        Ykv8aBQPJ6V28YqroQX2bwg6nA==
X-Google-Smtp-Source: ALg8bN4DxM1oR4GniuzCwGg5xsz8lTyFFJwrdZi9wsHc3C2sjcKop9oEdgnjlbea6o5U9jAyIV9arw==
X-Received: by 2002:a62:6ac8:: with SMTP id f191mr55616255pfc.13.1546832434147;
        Sun, 06 Jan 2019 19:40:34 -0800 (PST)
Received: from limbo.local (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id a4sm74120468pgv.70.2019.01.06.19.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 19:40:33 -0800 (PST)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH] kaslr: fix incorrect i8254 outb parameters
Date:   Mon,  7 Jan 2019 11:40:24 +0800
Message-Id: <20190107034024.15005-1-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The outb call takes parameters value and port, in that order.
Fix the parameters used in the kalsr i8254 fallback code.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 arch/x86/lib/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index 79778ab200e4..a53665116458 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -36,8 +36,8 @@ static inline u16 i8254(void)
 	u16 status, timer;
 
 	do {
-		outb(I8254_PORT_CONTROL,
-		     I8254_CMD_READBACK | I8254_SELECT_COUNTER0);
+		outb(I8254_CMD_READBACK | I8254_SELECT_COUNTER0,
+		     I8254_PORT_CONTROL);
 		status = inb(I8254_PORT_COUNTER0);
 		timer  = inb(I8254_PORT_COUNTER0);
 		timer |= inb(I8254_PORT_COUNTER0) << 8;
-- 
2.19.1

