Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B77C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9085A20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz90RgSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9085A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937792AbeFSMXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:23:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39671 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937502AbeFSMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:23:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id f1-v6so10874295plt.6;
        Tue, 19 Jun 2018 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f4m7qOyaTR8jMyJ06iiLVjF3E3BsAYkyrEs4pmCan1U=;
        b=Uz90RgSEuCvIu7onkABg4cbjoKHW89FzyNUViycSs7ViHUX6KxWwamB2jKe67atXys
         dT/LIolM4J7z6Swe7x5XwzW6w7b/VfJI3mwBEVV14/ChKy81UcqaVoUIrHmgGd555b+d
         8S63XwbJorouHVikmiGt9G221QI3j6w9u9bkzk4X3fUw+JmqAcl6+v38Wcvrv/HHEtIA
         bUA1YVL00UZ0jwlmsSmx4HCcOszsgakoDR/O4Np4ONbNcesgWD21azrbaj8QZqPi1Euw
         SK/VfKgUNvwjhV9+7WudRPNNyzp6D4eeA3QTwROG8w/TUNOXy8uPr7SK8jG1mzoc7q72
         4Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f4m7qOyaTR8jMyJ06iiLVjF3E3BsAYkyrEs4pmCan1U=;
        b=KClnv35245W8e7OxB5J8CT/++ajwXiy7v1dPIoD6oVc6JztQq+dUBDF9KLSIyqGL7U
         aTj0K3Jc3DB0TJmDaIhGFo164Mvljo+lpsUtn/Z9FJatg6qwKBBcOwGG30GHDrt/M0aJ
         BC3+1sBO4YhLC0Q7psaEroDz7vJuQhA+rwM9zrANw4G2CbI2zVdBbFIkX6ADGaJm8fbe
         X8tzLN55DLlfNf7kd8D66CGAObsDJEAyBe3g6abSbvoG6VKHXkNkEk3trGDmiNYYTgZk
         nmZbeF6nFVtzGtaNjHoZzWdL7VJsxaXM+fgwzNNSsd+mt4c9lTylE57Bk1/ihg7pcUVj
         DbkA==
X-Gm-Message-State: APt69E1tEH/kIS/0tL2DEUXcfvii4sny2WWBj+RJwK8rKx+wFTB4ijNz
        j76L6xroEG8v2KJaHLfssm90hd5/dQg=
X-Google-Smtp-Source: ADUXVKIlA67FAAgPep91zYllpV87DdXTRbwu3LzaCK3bDAOogAvicwOfl7RXVjYSUogqH0pmK3Q3fg==
X-Received: by 2002:a17:902:b28:: with SMTP id 37-v6mr18282379plq.201.1529410997526;
        Tue, 19 Jun 2018 05:23:17 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id n85-v6sm30320231pfa.146.2018.06.19.05.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 05:23:16 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        David Lechner <david@lechnology.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: add error handling for skb_realloc_headroom
Date:   Tue, 19 Jun 2018 20:23:03 +0800
Message-Id: <1529410988-70261-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528778503-41615-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528778503-41615-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When skb_realloc_headroom fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling skb_realloc_headroom.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/usb/gadget/function/f_rndis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index d48df36..17c164b 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -374,6 +374,9 @@ static struct sk_buff *rndis_add_header(struct gether *port,
 		return NULL;
 
 	skb2 = skb_realloc_headroom(skb, sizeof(struct rndis_packet_msg_type));
+	if (!skb2)
+		return NULL;
+
 	rndis_add_hdr(skb2);
 
 	dev_kfree_skb(skb);
-- 
2.7.4

