Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD04217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277374;
	bh=Ih+yhMDla8oJ4fAxwXuf1v7ZbNVu0T4u1lPdIdv290s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RwI/g3+zsgLwrJGhKcOMPfdzMJrpdnWtU1mUz48n4EqT6LOGfU7fbGQaZ7DYZtOze
	 Di2WoZWY0fkce4v/So4J8Cwrnrix95jwdlmnwJQe60OT8Fc77Q9wfVblvb4nSWTO1T
	 wE+pLP+CKtcfcZDvlgdwYoFO3sWXAxFdesxugDEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfBDKtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732027AbfBDKt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05BE1217D6;
        Mon,  4 Feb 2019 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277365;
        bh=Ih+yhMDla8oJ4fAxwXuf1v7ZbNVu0T4u1lPdIdv290s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0oOS76fNB7/Tr7gED/gqDoFO4v4wBN4YAAndMnkeVyAzetViuZflnA2d0OF/kyf5P
         DtD/QTeoSDp5gDfJjuAimOIPmiyyeFTDuaar4QdnyNVycYj8CGsnNw6lI3CGxOUhVY
         LXnDpju2w7NS7UybPqdrn2/mrFlKl+yHpU7S0LRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 45/74] gpio: altera-a10sr: Set proper output level for direction_output
Date:   Mon,  4 Feb 2019 11:36:58 +0100
Message-Id: <20190204103625.389517834@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 


