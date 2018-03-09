Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeCIQ3B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:29:01 -0500
Received: from mout.web.de ([212.227.17.11]:45713 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeCIQ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:29:00 -0500
Subject: [PATCH v2 11/17] mfd: tps65910: Delete an error message for a failed
 memory allocation in tps65910_parse_dt()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Message-ID: <88eea608-0242-ebcc-5542-8ab9375242d2@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:AB8UyE0J0Km8pGEjFsdoZNL1bJPihWLmPZxjv/l39LqMq9248Kb
 ERZ0sbniFcp3V0hfw71CtY77vLK/LL0PXxnI7OIdMKlf9xtQFkfbMK6VM5R5Gd4AGjduF/1
 F/9m+v/DMSauUjQX4GK9luwQPk3LEZFDFuaXlGJ6zRigcaXIUnwFZTsIUtWQEJm3D6vpNQE
 93ODptD1eEP0Z12F8TYfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z7XxsgucMaU=:nRYHkqkljlY8XCkMqhfvT2
 ta2jjIloaakCaLgCMzmipeP2haSS8y9vD4847QlQePIs7bXa3WImwAq1eDLtFjZlQ99fl7mBK
 V8e0fe0XrTzd3AIiER/wcweGPS2JxxdCRGloBDR4BNZZnJUrOMKPC8L/jvoQNjeNy1kjDAziz
 DEYhc2GnWxENI9FLpORBnL6udWDWqelkqIXSdrY2I3FW3xwoFNVrucsyFNS7g2XO3R6vZS6Xt
 pyzTyY6nJ5RcuGZJI/zLPKfyWknxTOY5pZla43U2G6vb2zBVh7pqZDEGOpkPAEXZAxyp1YTJj
 SW9XmPcHAOe1Z8zTPZaRza9gXEZeo1lNZrtOy6I3to9bgcjsH5Anvh5gwutQ61vzzjpIbpBQ5
 ELtT1Oq85ORdLdQY4VADF4MUpgcT7I5kpYXFmk/czxLIjBrdEFE40KUGCcyX/DzgeUhOroxcC
 CrwxmuncC+ZvHa2e8KLECW1Ht+3KUnjtsGNVmcXypgCOjzSQbLKRy+um9Kk5qRryUrFMfcoy4
 nNbvLWsyE9onaeobSnEWErbL3xeBmhYwMpJL/fgzEBV1RYuA+vXltXPJQcrQtW5cIVHTb8uy/
 ywijcAKHCbhyA0gcHrBPeOOULjAAwQZDBoBXLAbJEegcuHRGpUltC0WBFbTEWTu5SS0jQg16U
 VfZcyICTqk2fcTVdwzbQl/SmCe86KPjcMcRk9CI9pcf4eZA76PcykipxAYpY50YmA0S8b85qF
 +lQ/GLnyH0JdKTpAwLF7uazP0DiTagJhVtjvcCg73WVSCN5Teg89RTiyNp1jClIkp39PPo+ye
 YByka9HHJcE8lTyIP0cM7pYqwpAEISmBSVguSlkfHl4UMKd2Yc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:00:59 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps65910.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 8263605f6d2f..555bd394efc3 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -395,10 +395,8 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 
 	board_info = devm_kzalloc(&client->dev, sizeof(*board_info),
 			GFP_KERNEL);
-	if (!board_info) {
-		dev_err(&client->dev, "Failed to allocate pdata\n");
+	if (!board_info)
 		return NULL;
-	}
 
 	ret = of_property_read_u32(np, "ti,vmbch-threshold", &prop);
 	if (!ret)
-- 
2.16.2
