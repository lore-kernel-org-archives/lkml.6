Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32888C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F221A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2BoAnZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfANUfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:35:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44569 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:35:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so395844wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6aH85HXvGaBst6AsfmYEtc1Lgu3C/G7wpGvW82yl+3Y=;
        b=H2BoAnZt2R0LlPoCUmzpLYx3NE+Kh7mZC1qZTWmPXxzk42xeuNLJ4QfFQw4MD863o7
         fRGpEVoTTY5acp5C/JdYamFheEzHw7YH5zCxU1VrBDbJmilq3apx5gOywqXabXluo+aE
         5A9kTZn0fhYti2QgCKYdbXTGJ4NcFq1q/eIdHUggaXAexQfSV/WPAxrpPI5PKXquzVzG
         gVlPrEaJEZHElA8TWjqG69YEFIW3xUvbq9Jy5o+NuU7glBRYFL+2CjweMNwMaZZ65xyg
         2EORvdX1ATp+r+DXSvLXhTCEDeJCfFwZoYAdsZj1A8zn7N+81+0qs7j7E22UFKmASF6h
         YezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6aH85HXvGaBst6AsfmYEtc1Lgu3C/G7wpGvW82yl+3Y=;
        b=cKto8PaFJrl/ETxi//m9Qz1wmq/Z4ivOmgqiMAA07/h5RwIH35iwYQH7bibN86/rL0
         ZSv0ijBXQvNO8J4BM1TmYXDoN+gtMYt10eo4nWKBYcLHc9QlTpd4MSqwhx26vc8AQAY2
         kiIFYCpJ530tFOPNLidGu9sr4WjvW0npIz//65JNxoQgcTnUIr1HET4RMiCXer2snQNR
         ixea/gkWevXLKhE8JECcsS1+5KKyo1FBD5sTpxb5sUkH3/tX5N1R6EUS6SpKOB4SX/Ty
         ZHbiJTfom5Hhe7iAYksmpdyKyDP1w9h7hTwpA/N48LhkIeGXm4QKGR32oAbFbrn4h6fH
         zysQ==
X-Gm-Message-State: AJcUukcsDl5tEXJshgyGJnkXx7o0ETBdJ0a73LKPFyGlw37SPAkzOqTT
        dX82hQTOZGkUhhEpmJfAb3w=
X-Google-Smtp-Source: ALg8bN5+su0WA6sjhe0bxHHDZDtljUE8nZTMN7tcm9hxGuqbKQSIavGZGBDKsLZfctsZiQrXeoF21Q==
X-Received: by 2002:adf:fc89:: with SMTP id g9mr219882wrr.96.1547498114804;
        Mon, 14 Jan 2019 12:35:14 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id c10sm66016268wrw.49.2019.01.14.12.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:35:14 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 185B111422AD; Mon, 14 Jan 2019 21:35:13 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] signal: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:35:04 +0100
Message-Id: <20190114203505.17875-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  kernel/signal.c:795:13: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..aa7a507757d7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -794,6 +794,7 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
 			 */
 			if (!sid || sid == task_session(current))
 				break;
+			/* fall through */
 		default:
 			return -EPERM;
 		}
-- 
2.19.2

