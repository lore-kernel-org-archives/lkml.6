Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC29217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277190;
	bh=Pm1sKktgHVCjBriTON3BxW9NXYb/DkTSNLyaYLXhj5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lE4S2ybTI2+qB1/YsQOqwkurciesX16uKT3xauDSpRHO7BcmjZZA2IF5CmWg7PQFj
	 pzw6nl4oHfrtDAMEygLZumo9eBQN4mlG9V5fBytfobV9/DuZtjpUVTIOgYcLCrPpSl
	 mkCIYnMveKrHVxpLGAYwu7HpoxUrG7KLUH4tJImg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfBDKq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfBDKqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:46:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40992087C;
        Mon,  4 Feb 2019 10:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277179;
        bh=Pm1sKktgHVCjBriTON3BxW9NXYb/DkTSNLyaYLXhj5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3MedeIEWEqzLNOJp6CNlpipStnxZsjpUpI9xJ1Np7c5VtPCD10vxTm1rxb7Edyb/
         5Tiz+i0aP4gXevzgiA9UFtKZ++UCoEAf8ByTairvQq1kBDTk2tzYl4QEUsxrv8h2We
         MiZvnZbxAZ2shZ+foR8C7DF2XvnmjcdABr4rxV54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.14 29/46] gpio: altera-a10sr: Set proper output level for direction_output
Date:   Mon,  4 Feb 2019 11:37:00 +0100
Message-Id: <20190204103613.748978630@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Axel Lin <axel.lin@ingics.com>

commit 2095a45e345e669ea77a9b34bdd7de5ceb422f93 upstream.

The altr_a10sr_gpio_direction_output should set proper output level
based on the value argument.

Fixes: 26a48c4cc2f1 ("gpio: altera-a10sr: Add A10 System Resource Chip GPIO support.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Tested by: Thor Thayer <thor.thayer@linux.intel.com>
Reviewed by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-altera-a10sr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-altera-a10sr.c
+++ b/drivers/gpio/gpio-altera-a10sr.c
@@ -66,8 +66,10 @@ static int altr_a10sr_gpio_direction_inp
 static int altr_a10sr_gpio_direction_output(struct gpio_chip *gc,
 					    unsigned int nr, int value)
 {
-	if (nr <= (ALTR_A10SR_OUT_VALID_RANGE_HI - ALTR_A10SR_LED_VALID_SHIFT))
+	if (nr <= (ALTR_A10SR_OUT_VALID_RANGE_HI - ALTR_A10SR_LED_VALID_SHIFT)) {
+		altr_a10sr_gpio_set(gc, nr, value);
 		return 0;
+	}
 	return -EINVAL;
 }
 


