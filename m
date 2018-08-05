Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B260C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C4F218FC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kripp.ch header.i=@kripp.ch header.b="UD520oGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C4F218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kripp.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeHEVrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:47:08 -0400
Received: from sw.superlogical.ch ([37.221.197.145]:47154 "EHLO
        sw.superlogical.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeHEVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:47:08 -0400
Received: from localhost (unknown [194.230.159.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mail@kripp.ch)
        by sw.superlogical.ch (Postfix) with ESMTPSA id 37698C4192;
        Sun,  5 Aug 2018 21:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kripp.ch; s=default;
        t=1533498087; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=yMaruzkf5p2W2UgBE88iCeJQUdwyVOERZhq1LBEd0Hc=;
        b=UD520oGvX3fI7qVkodZsk+uWcaSUZPv6csNMBTA6novz1FBfOAtv+XXiVKHqzUe1YkiMW5
        GelJoy+1etwOyMBvnzlFdkIn3Gv1J2DpaODfTLBiUkNmDQ3PU47vWl1r57rLscDCZRfIJv
        YAL+jmcBzt/cx7vaxL0Ce4dzliU7Uvm1VsIAqPTSXp4CN4750WcrENmwpMyiHVvjYPtjp+
        IHLH5v5VYQBF90VnopeBVu3ZasNfd+f4bW8x+cCfuAvztUfuoICPzm53HL/yL+Bq2oSKQq
        ckKUuqYweEmKdscrve1C6o7TI0CwmAkyCZLkhUbW8GO6VLuqEeVcbDwkO0aIhw==
From:   Frank Werner-Krippendorf <mail@kripp.ch>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, Frank Werner-Krippendorf <mail@kripp.ch>
Subject: [PATCH] Staging:rtl8712: Style - Removed inline block comment to fix "Statements should start on a tapstop"
Date:   Sun,  5 Aug 2018 21:41:06 +0200
Message-Id: <1533498066-31466-1-git-send-email-mail@kripp.ch>
X-Mailer: git-send-email 2.7.4
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=kripp.ch;
        s=default; t=1533498087;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=yMaruzkf5p2W2UgBE88iCeJQUdwyVOERZhq1LBEd0Hc=;
        b=Xos4aO6rxQkbv7CF7VgaxVHesJAR3vemp1W0RLjyjZ7ZGfodaNvJS2PplxoMKReeatTnCz
        LXdGmM3HkfQl+P/8eVHFm5xntOwCo0o7MN5sK2AF/3tDpw1BSKg4MTifZqF8kqTDcBiS5O
        /sk3gL7KC1dnIkQ6SHPzU9w2Cy61ZyFGunidndKay0xosaHPYW3A1XgolGqcbyopRlSOtl
        1s+9i0SB/0AmMcCBm2JDDbZdqq5dAMXY44SvBLL+HSRPqNbUCdEj9xVu6sai+BpR3P7wCw
        2Ih+k5rdAWfaU7QpTFeqeXXCOvKNsy6iMzaP2gSpe+63WHM70YsqKlmIwuPh0w==
ARC-Seal: i=1; s=default; d=kripp.ch; t=1533498087; a=rsa-sha256; cv=none;
        b=MT+hVcaFWRpyAPseFF3NW4B5YekM3qgXPzyn0RUcR2AIzC926CGtSiFhR+l2Sr48SJ47OiOYiLCkdCETkQCCqka+gqnRJ9RUCpqDtLMtAYfNDc3N6iwGMi62x4XcF8xKio6xNLGHDHl/6UabBwpXQ2H7LR9VG3ejkNHUSFfka5AK2cgwBV4BUwdhJl7o3gH1j2ROXZQt1cZtglqWmrdI0vwC8r9J2aoyeTEfVErY3QLFyLJMRkGcKPfXnhIsaCgdcuMPopPIW6Z+rGtEusbvhB5D89S+Ft4q1/LMURuE7cmTk2OI9qB/aZ1owngcZ2tIdouHN8UMSY1/ElU37pblpA==
ARC-Authentication-Results: i=1; sw.superlogical.ch;
        auth=pass smtp.auth=mail@kripp.ch smtp.mailfrom=mail@kripp.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed 5 inline comments "/*volatile*/" rtl87x_event.h, to fix
a coding style issue "Statements should start on a tabstop"
detected by checkpatch.pl script.

Signed-off-by: Frank Werner-Krippendorf <mail@kripp.ch>
---
 drivers/staging/rtl8712/rtl871x_event.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index 5171379..2e59e8e 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -90,13 +90,13 @@ struct event_node {
 	unsigned char *node;
 	unsigned char evt_code;
 	unsigned short evt_sz;
-	/*volatile*/ int *caller_ff_tail;
+	int *caller_ff_tail;
 	int	caller_ff_sz;
 };
 
 struct c2hevent_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
+	int	head;
+	int	tail;
 	struct	event_node	nodes[C2HEVENT_SZ];
 	unsigned char	seq;
 };
@@ -104,8 +104,8 @@ struct c2hevent_queue {
 #define NETWORK_QUEUE_SZ	4
 
 struct network_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
+	int	head;
+	int	tail;
 	struct wlan_bssid_ex networks[NETWORK_QUEUE_SZ];
 };
 
-- 
2.7.4

