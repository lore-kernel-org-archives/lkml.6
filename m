Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZzpQB/+RHluaEgAAmS7hNA
	; Mon, 11 Jun 2018 15:15:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 23EA4607BB; Mon, 11 Jun 2018 15:15:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ffKgK2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B0C2E607A4;
	Mon, 11 Jun 2018 15:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0C2E607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeFKPPV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:15:21 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:41149 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754000AbeFKPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:15:19 -0400
Received: by mail-pf0-f172.google.com with SMTP id a11-v6so10392085pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language;
        bh=Ur6nBqumN89x4L0DGuqnQRa31dvRcfA+0pSXwszc59A=;
        b=S5ffKgK2vGSJK+DTH7LMtHtrH1Vm0tZbplFkKUouxCXTu2OXU5HRTjTsPrN5ksh2ch
         AtZgXNt2DQ92zyLiY6I629+LMN2sCYCa87Q1H5/fXlE4DY+N2r+DfbHgXfT42ybZ1Ejj
         1ZEa7ijTIqPinTIPdTQPvBiG0f85HD9i03hAb5oehBNBTTZ1ETi4KZwgt8X8vIU+K5EM
         bTaIMYHK8E5d4TZwuMRjGWM4vO3zI9WnJqMozCFHxbN5ssU/TUmd+8ifZEXTHy0c/V3g
         4bR/GKX0Xqetb+Hj4Cw9mqXZFV6MWoDNcoPvx8Q2dXV974FBaEt/d3I3xfHJxNxuiiUd
         nKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Ur6nBqumN89x4L0DGuqnQRa31dvRcfA+0pSXwszc59A=;
        b=q9OonxT7tDsc1glNNyCLaxaMW/khBdjv3QNSL4adHKI63Q14ZMioZ8goLwky1R3R37
         xVBZ+gV9fMuj/saX13h5BAmgcaOnvVTAOG7VAK/L6+i9ojLIori9eq6aGfqR3NX48eZx
         AiiDPyEjvchDOzr0JJdlCw0y0SvT338DvlYALMZYPikPD03zOD9GMqq+4QDTNsXYhax6
         Msac975dlykJ/zGY7SGog2sbfhG56izYYzk9PJzMptSaZH73ocLDKVZmArwsxZa9conw
         xZMFlf44blXbmXMm+BD7GMdXWt/nByGSMQJNrFBTyD68iw48xeVCeU1mPT+dtoG2MFF7
         laqg==
X-Gm-Message-State: APt69E0ybCabqoxcNrDqFRYnA0LDX5PpYnSHncMSwt2sideyL2D1s3P7
        bJzY9jFkbWkXrF7EtjXDJ8VQoE8q
X-Google-Smtp-Source: ADUXVKLWwr2WEHQtpxVMGl7hzeaEU+0hVS2oA5Hx7CvCISqOIqkZmJCNpmknqM3V5bk9dkl5hWtb8Q==
X-Received: by 2002:a62:a21b:: with SMTP id m27-v6mr17922172pff.248.1528730118979;
        Mon, 11 Jun 2018 08:15:18 -0700 (PDT)
Received: from [192.168.28.145] ([103.224.155.13])
        by smtp.gmail.com with ESMTPSA id q69-v6sm102944373pfl.16.2018.06.11.08.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:15:17 -0700 (PDT)
Subject: PATCH fixed coding style error in drivers/bluetooth/hci_serdev.c
References: <2a6059f5-e3f8-9a15-1319-f1189fdd4d83@gmail.com>
To: linux-kernel@vger.kernel.org
From: jagadish tirumala <t.jag587@gmail.com>
X-Forwarded-Message-Id: <2a6059f5-e3f8-9a15-1319-f1189fdd4d83@gmail.com>
Message-ID: <07c1607e-e75a-967e-c007-329832306936@gmail.com>
Date: Mon, 11 Jun 2018 08:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2a6059f5-e3f8-9a15-1319-f1189fdd4d83@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------4B56553444366FF2841AD706"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4B56553444366FF2841AD706
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


HI , This is Jagdish , I have fixed a coding style ERROR: space required
before the open parenthesis in drivers/bluetooth/hci_serdev.c , please
have a look

Jagdish




--------------4B56553444366FF2841AD706
Content-Type: text/x-patch;
 name="0001-fixed-coding-style-error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fixed-coding-style-error.patch"

>From 3c3e844d0f0ba49a6d40a7265548f81316f756e4 Mon Sep 17 00:00:00 2001
From: Jagdish587 <t.jag587@gmail.com>
Date: Sun, 10 Jun 2018 04:15:53 -0700
Subject: [PATCH 1/1] fixed coding style error

Signed-off-by: Jagdish587 <t.jag587@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b..d41c520 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -94,7 +94,7 @@ static void hci_uart_write_work(struct work_struct *work)
 			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 			kfree_skb(skb);
 		}
-	} while(test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
+	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 }
-- 
2.7.4




--------------4B56553444366FF2841AD706--
