Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeCLLeU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:34:20 -0400
Received: from mout.web.de ([212.227.15.4]:48837 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeCLLeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:34:18 -0400
Subject: [PATCH 4/5] Bluetooth: btmrvl: Delete an unnecessary variable
 initialisation in btmrvl_sdio_card_to_host()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <2c2f8733-c5c0-cb2f-62eb-4fa360ee271e@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:34:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:DbgheOCKzTryfcP/0YDuInZWBzBEnSQR5RTW/0CRmVb8fpHe1Ld
 MH4S/qC1cJVkX27OaHIVXdFMlUzWTkn+hkEt0LNATThzLUvZZGJWRVho4PrzRR+Tzwet3cl
 GEubWyT+jiVWFsy7j7IdUkN8q2pFy3NeZRAK70bM9Tswi3S8+9KcnqSUp0HLGPGMQ1FdTeB
 +r3+esfrONsZd2nCZ3lsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XKnRrommSi4=:fUQftbQzPiEh2Az9EWJsPC
 bCReZjHYRuXikm3lJHjunnij1OtLVkyrbOhGk6XMrHCRsW9TEq2mk8AUKYqrqS3cEELAEBU6e
 D5yu03lowR66RgNwtSvBsEXmZeAIZQ2QFhTiQNY7PuFYzybXv3nVKJmWJH5ro8LCFzE7xl1xW
 BC2wh7IyColplEmF1TPjLi7cChO0SqV+2wMfRAUGjaTbcAOj/5bJQyr3WrQjEE32Q6vGa25s5
 JKV66Edvl3VKX0/hqhLeNX0lUI68M8WBOu8wao7RAmjG/i8bk/QRsSikuwVllTuLFa0wU1S8C
 jUlM+bh0s/ni6SVD4iBHpPpap8sAs8UQYxQKwoqZyIXMuAJ0H7jZCBkoZxgO6bnfbglJuFgA0
 8Ghtf1BcRJlJwcnilSkFB/J98FF4ZJe7i5N6h97I0M8ICavqqY3JdFkcMzYGrMlvR3Mnfi2K4
 29z7LVq8uK/u5jCTyJrXrPkwGCCxZaTBma/KiDjrUHeEFDpJsothR9HGlcFbSJU27MIYvqP/X
 CbtoZl3y/agZ1wbImCADFZdMXocqv08jrXJadCIa5ANyD6LHncftbcIg8D9cHWk1jUq1/SAQL
 ccj98AtZhRu0uY4UbsfrSguBQ3WhEjtS8SsiBSkrvvd5G1OQmJn9KI6YQ5l5GE4YLTAnDAF3E
 l6lb6zhoMN0/tiqXkxe5gCCDvxj2XzA6xCFmgojUwKi4wXsTuC5j5sl/C7iBmB1vhwuyUyUVe
 1k0M8OfMd94iWh0uWTsNjSrpit1O939r3Z26AVnZA4grlS+r/1K1GhdBCQ5uQRpRVS/sfkbWN
 ApW/FnRPS02e69wgecKeZCty+xHcrQnJOGTX2mrQ1LcrI/Lmh8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 11:15:59 +0100

The variable "payload" will eventually be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 9854addc8e96..05c78fcc13ff 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -691,5 +691,5 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	u32 type;
-	u8 *payload = NULL;
+	u8 *payload;
 	struct hci_dev *hdev = priv->btmrvl_dev.hcidev;
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 
-- 
2.16.2
