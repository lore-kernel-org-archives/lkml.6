Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B4C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2C12184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="m13uDjHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLXTAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 14:00:46 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:50130 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeLXTAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 14:00:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 3077DBB7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 19:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n16YtQDeZ_s4 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 13:00:44 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 02D469C3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 13:00:44 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id q207so11833870iod.18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 11:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HRlJkk/B03cDNB5P9fcyd7Sz9trQYzpYEkvCb+TAWDQ=;
        b=m13uDjHT9soBdyLr9yidUsoEgfcorq0PtBUYa3Nm4bGYmgMR1yJ2lazH57M9359WfL
         UxYCA8CLe7PeFRs2PFU3hWtzUZiLTRfnu4KlzF5hCfYSD7RuAca97HbcEXZHLG4Ulw+g
         1oPyieIGmiRvz6BlOoP+MLTNyF5XAXwlwvKi3F7KjGwbqR8+h6D+RNtbJbrbgouQYaj6
         /XaKnIjWn+74DwoTTeBJlquDTaSgLiYjgdZlBAL0w20TYljLa548104bYmpdlnqmkgNE
         Lqxutu0mlDKWpnraTmMoh5HbwePIgQb4zEcLhC5ZcISbC1BpYqEdQvil6g5FW5i/Lorw
         9rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HRlJkk/B03cDNB5P9fcyd7Sz9trQYzpYEkvCb+TAWDQ=;
        b=V4EKoVjz3vRxolSo2qVPPkVG0vZ3Yh0oT9mvKI1/lEt1MaB5U+JqrLLhfMtpuLNp2U
         h0qnIhH9x5T7I4LFljV41D+dvYBky9FLOvQAlRlVyQ4dK8TpqP824BAwia+R1IO5WLQX
         vSZIrnigfx5ZNUzkZltqnVSVQKEx6LH393b2FqXoxKTArfU5SCKXgusjXPqNC/vAjq1I
         kzB7PLYn8+KHvShUfY3fozNMLREVMcyI7StuXVQAYNXtQFm2GrumNjq6B7NAI38O+MCe
         Y5WLyr7wD+MlNAqqA2fAZ/ijvqFzvhx4238+JtvRqAk9Of4+elRxYnDzg+pywEMFGzwJ
         3hgQ==
X-Gm-Message-State: AJcUukf4OZBFNV7hF2QLWQ7IcuP+Ftz6KDbKzQ316YCTqm83NbQxa7v+
        n0aSBKHLXMUpXXtmZTYfpNgQQPCJAbwDM8BV3wa9a01UFa/xf2SdOxBZbNrb2fC4ZW42wlNDhql
        I/EjvOxMPaHmAHiWqf4kxMxJujYVq
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr10167028ioa.266.1545678043617;
        Mon, 24 Dec 2018 11:00:43 -0800 (PST)
X-Google-Smtp-Source: ALg8bN66j9dLJeQu9EplGRbsnB95dn7ke5Vj66+x/TkGFOiUWJ49uE2MEAptrO07rcKAnhweAY/C6w==
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr10167017ioa.266.1545678043399;
        Mon, 24 Dec 2018 11:00:43 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id q14sm10000997itb.36.2018.12.24.11.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 11:00:42 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Fix a missing check on regmap_bulk_read
Date:   Mon, 24 Dec 2018 13:00:32 -0600
Message-Id: <20181224190032.23167-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vc5_pll_recalc_rate() may produce incorrect output when
regmap_bulk_read() fails. The fix checks the return value of the
latter function and returns 0 in case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/clk/clk-versaclock5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index decffb3826ec..cd76a893c594 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -413,7 +413,8 @@ static unsigned long vc5_pll_recalc_rate(struct clk_hw *hw,
 	u32 div_int, div_frc;
 	u8 fb[5];
 
-	regmap_bulk_read(vc5->regmap, VC5_FEEDBACK_INT_DIV, fb, 5);
+	if (regmap_bulk_read(vc5->regmap, VC5_FEEDBACK_INT_DIV, fb, 5))
+		return 0;
 
 	div_int = (fb[0] << 4) | (fb[1] >> 4);
 	div_frc = (fb[2] << 16) | (fb[3] << 8) | fb[4];
-- 
2.17.1

