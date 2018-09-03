Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97512C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F2E20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F2E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeICV72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:59:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeICV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:59:27 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EEE94C75;
        Mon,  3 Sep 2018 17:38:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Buesch <m@bues.ch>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.18 071/123] b43/leds: Ensure NUL-termination of LED name string
Date:   Mon,  3 Sep 2018 18:56:55 +0200
Message-Id: <20180903165722.496301538@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Buesch <m@bues.ch>

commit 2aa650d1950fce94f696ebd7db30b8830c2c946f upstream.

strncpy might not NUL-terminate the string, if the name equals the buffer size.
Use strlcpy instead.

Signed-off-by: Michael Buesch <m@bues.ch>
Cc: stable@vger.kernel.org
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/b43/leds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/b43/leds.c
+++ b/drivers/net/wireless/broadcom/b43/leds.c
@@ -131,7 +131,7 @@ static int b43_register_led(struct b43_w
 	led->wl = dev->wl;
 	led->index = led_index;
 	led->activelow = activelow;
-	strncpy(led->name, name, sizeof(led->name));
+	strlcpy(led->name, name, sizeof(led->name));
 	atomic_set(&led->state, 0);
 
 	led->led_dev.name = led->name;


