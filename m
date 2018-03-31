Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/cRlnI7/GF6ITK7ryqNQvkkFI5yYra/bQ8bUx1zmw/z2geMsMQCuj2iA4g9OgQvhZcXL4V
ARC-Seal: i=1; a=rsa-sha256; t=1522476564; cv=none;
        d=google.com; s=arc-20160816;
        b=sxoxdPNZgTImHjCQZoL+puadI06XhtuzTuGxKicI9/OFK+Xb55ePpHm1N2YrKcr0Db
         vU5tG98Js+w8nOochElziQE1kXDLTfvhcN7OBX95u6FHLjYaBO7kDbURm0vgdKZI5rBm
         C66Fx4nPIIefsYPTHyeMZ4t2bm36bHy6WBD6tAwaa12FSF6LmkbXjngSO1S6nBptYbdy
         A0FXMDlOPyQPFzHVdHUatE3k9imMsSeXQ7aU7RmR/WecMHWIQ+kicTVwvWOGTJqrXNR0
         SaJW50aCo1H+be7orcvup48yKdaWmo2Zy/jqXZHRF59g8vr3tw7dTwrF1SPPjZvdzsb8
         nlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5oeInkYri/3la5sos25F+gZ8QbRpt0ycrR59nE18H48=;
        b=U3qjdwsTnWhXt6YvlQyaGBPRrEUl07Eu3OFBomj6O/+hto6MSdiv5KaID1UsyEx9f3
         q0JhyQhXFwoHxO7xiQjMF19bT+Z5IpRHcuvbgMcGDqcAPIgAYkOtY70F3cpxBQ/iwnW1
         sSHQQg+xX+Zgz5P1AwKfO9F+seHJDuxqI35oG3cCyHK9uad3HKdhsYRr0AhVzqQtfOXp
         AELwPD6LqRzpthMqvPnukAj7h2D75MAhriiC4gXp84w0db1MIO2lokqQ3dgiPIEgG74O
         NAxuCW8g/xpGHK1uCAJWdqL7JVMlWoSNKFvP7shR3NXY8tfheNegnZPEdmAMIoMNNsf+
         ogzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 01/75] staging: ks7010: Use the ARRAY_SIZE() macro to calculate array sizes.
Date: Fri, 30 Mar 2018 23:07:41 -0700
Message-Id: <20180331060855.9452-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
X-Provags-ID: V03:K0:l55gRZNvoDnd1OhFnfnpEpzzhCklwV/O+2XBBHGM514DABccPGC
 tkxkps8yFPW/yxqJAytGIf9+QXnznxgvlFK4bOfA6yZs2+ehfVZE1o7lXCXEayJQanEZRFW
 8qHPh1B8Q/kRxaKo8tpLbZ46htqknok9IxZL9gFtyxDpGWtu6zsJFFBztL61AY//y1fJpC4
 wZ+qmc02s7BH4OlDw4TOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WMYSexOVGwk=:XE8gM1vAPJFX1br0Jd164A
 wdxfZ3fnOBOdomiUepn6JY/mkKokskpEeA9YGPaiVNIz9nfKQHhPvEwP7iqLwRjl7RzFEj/QL
 msRu4Mg0jntIrwI0Kp44o/VuD8CkUWNZv55CRY1xWbKbmTBIODjY9yc5hfCvWj3PXTw3KTdae
 TKQLryP6m82HXlDRnSoNwLCgJPlI9h4OgX/pFxbAnv7QCuI/HXsmkMLQlzT1TDWLUCnHE95w4
 ylYSTl9d041+T6gB4naVkC+I6UUeq+em/Qo04AuS/3XGhBXZtgPKViJ66Ua+I8TTLTPLvjnZ2
 5MfMO6sQSW3Jpd3HWP75tkIVwvhMMFf6A9rkzG38PCf6JzD3iIa6IBnw7QH7xYoTBtXLyAFcC
 wY1f8noLN5n2cF0Md/f3pK7CKSIjbaRPMZZHTI14XmV54F+fReSSdMojvuh8VRyPKq8O7OMrW
 Sm0CS3RdYPR3a4L1kYhEB6BXtczcwsBEb5c3Gr3Q0iGN2POENhJoBe5KerucWmmx02VME1CbE
 U4Ks4yFBlkgrt1tq7fK4utmgLdqwCf3rPTcH5RMkNfmMlxgkuHpsXs00RAGiqBpU6N1m2QnsP
 kY014muMQlMQi/ozmwdHJiRrOzP50OMpOlRdr/IVNm4EyKw1/K4VQ2cWVagRvZAvjM62Cz5FH
 x1qmzV0KcuCtlLgz2shu/pdXA4TVlAYc83EfeLbahNEB/1rTqHgD2er0GBYV1WGtlyUd9HVM9
 2JB4rDfT/am1UPSR8H+Ntr/o3rUHoDrj/DTUJg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432385681826765?=
X-GMAIL-MSGID: =?utf-8?q?1596432385681826765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This macro, provided in 'linux/kernel.h', will calculate the size
more succinctly than a division operation.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 9078e13b0d4a..533feef604a9 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2702,10 +2702,9 @@ static const iw_handler ks_wlan_private_handler[] = {
 };
 
 static const struct iw_handler_def ks_wlan_handler_def = {
-	.num_standard = sizeof(ks_wlan_handler) / sizeof(iw_handler),
-	.num_private = sizeof(ks_wlan_private_handler) / sizeof(iw_handler),
-	.num_private_args =
-	    sizeof(ks_wlan_private_args) / sizeof(struct iw_priv_args),
+	.num_standard = ARRAY_SIZE(ks_wlan_handler),
+	.num_private = ARRAY_SIZE(ks_wlan_private_handler),
+	.num_private_args = ARRAY_SIZE(ks_wlan_private_args),
 	.standard = (iw_handler *)ks_wlan_handler,
 	.private = (iw_handler *)ks_wlan_private_handler,
 	.private_args = (struct iw_priv_args *)ks_wlan_private_args,
-- 
2.16.3
