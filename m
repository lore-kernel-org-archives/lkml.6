Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5030DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F195D2147E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMRZvkY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F195D2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJQIHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:07:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34826 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:07:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id l17-v6so12259642pff.2;
        Tue, 16 Oct 2018 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XiXPBvpwZyEOdYgHHTrfA/QhSdmg86uDorOtSXr8haM=;
        b=EMRZvkY6BRskYRvtbwX8/MATg9yoAP6hbm6cliY4BpvN6ewwbjcl+WY3MI95wZv1TJ
         TmhWb+HqiWJPtt21P/03Rm6eRVrxYSNqsfifHTKmFB4hL0xMKUFj8TOHEiSZB0Vve66m
         quGGZGp+S+l13vJ2+yWs/vIS0xc+1zHcMcC9hIKL4saQKyL2HJKqiRicivDnUgP8h794
         A6hcfwYgCPk8eHijtBgbXA90E7oX4mfCYzTbq1RfAT+NseqNHVlOb6XPdiziwQIyWUxx
         IBdYIvqYAX2fX6UHt89jKv8g1Ynb9CdKtU2ciHoYoGD771yW1q/QfOg/bstIMlOnhhrh
         z3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XiXPBvpwZyEOdYgHHTrfA/QhSdmg86uDorOtSXr8haM=;
        b=O0bpnRQaPa3DSqWIpP47HVkLilGNnThzi6fcdCMKJjfHC8NlV+Y6EqCTkZABk7Dz/B
         E0b1GPXnm3qYcN93nJE+ExxwkDIU6wFTsoQOjk85688LAIY3q2Ldfyvjg7KskrrgQdSi
         Uo2u0lTkMbKjRoBrnuVOSo9mWwRsaIODNLNp6TlpTY2c2q9QuGpfLFT8pY1m4oUIJZ/T
         yrHBPJNkHjRStoTHk3hPQr4bQoGyMNfu/hS6vQedp8J1vK/VNl621W2Dek1dnI9qXY/m
         rkdAs3AzsnuS32pFfXa6ZIP3n6FwkA3M98RKn792buFV9Yx+jJrMqcHiyFPxpFRB6if2
         2kFw==
X-Gm-Message-State: ABuFfoijRu/O7M6pTK+ECtuwaTLvgYB6jF0Wmayzv5v5zoOxviDuMP7k
        wslsUfEfyXcdX/ldoTarlprZ8NLxTwk=
X-Google-Smtp-Source: ACcGV62RbDTFgWW0iw6rX9/eDIw99en0Gi8Ed5oXqYGWgCUOureZ/QDL/xXhqLlgO81ebMrANPM+uw==
X-Received: by 2002:a62:6801:: with SMTP id d1-v6mr24183237pfc.7.1539735287137;
        Tue, 16 Oct 2018 17:14:47 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t69-v6sm20940240pgd.43.2018.10.16.17.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:14:46 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:14:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics - avoid using uninitialized variable when
 probing
Message-ID: <20181017001443.GA232819@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synaptics_detect() does not check whether sending commands to the
device succeeds and instead relies on getting unique data from the
device. Let's make sure we seed entire buffer with zeroes to make sure
we not use garbage on stack that just happen to be 0x47.

Reported-by: syzbot+13cb3b01d0784e4ffc3f@syzkaller.appspotmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 55d33500d55e..5e85f3cca867 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -99,9 +99,7 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, u8 mode)
 int synaptics_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	u8 param[4];
-
-	param[0] = 0;
+	u8 param[4] = { 0 };
 
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
-- 
2.19.1.331.ge82ca0e54c-goog


-- 
Dmitry
