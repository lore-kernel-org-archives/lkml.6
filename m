Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeCIQHU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:07:20 -0500
Received: from mout.web.de ([212.227.17.11]:40995 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCIQHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:07:19 -0500
Subject: [PATCH v2 04/17] mfd: si476x-i2c: Delete an error message for a
 failed memory allocation in si476x_core_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <77d99255-820d-1152-0c5c-88d8cd2f26ab@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:TYOSkOCO/llWqXDe3egrlmpD3glNEJPxi8/gutK5KwwOrvyi5Hx
 I5Dyua2xLGtBBtUlv2WUXFaVs0rcFAGg7mS6O/pxvqzr+HuQi2e1N6M4LqKYGg5Zk8mGJ7u
 g1M67PSNvxcWHFvg0yA7OYxNKocq3jUMW51uh98FkMBs7EHNNQyv3F9JWSqx1gEbANW1g7s
 +dr7TZ1ibnrE4SneGdi7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QRrbVsnD65A=:ady36uV+lfwE6Xps7Lk1MZ
 C5IJBogMJ7FQ0N3+sj2fu28MEpVUJhKZbPkV0dBpvR9LivOHRYT5doR+Oh6WmYQWXs//8JuXd
 CB2B2HQOWQ6txzGsfLdTlrJddBSe+2TO6IAr0dUFs9e21nWupOx6141050o2szrOpFZgfd7bB
 laUE1BMCnWPqht1Lt4dbw9JbMzXuj6NkivgZtNPUZrpY+crLEeJi2L59WQ+ocEERQVUa70WF8
 rUI4EYGYC2wqw1PGHZqhjeobowz8W23SP8OyXXy4CkPggyQfteJ2IfaZQq0GQPkhMbq+9/KWB
 LneuDgWWn1ivxWLOWYyIcJ9qYv9EpjZxGwQlZLF0D1Pv3hz2BIHB5plNTwk+qOHkgXTebbTlR
 zDbv4q4dF6IMY7sPCE+RWDAkRjUlToPZmZ222jfnVrYqdx+zksRbgf02l+nNs/7exFG0hVgCL
 MBMw278DR80X//mH0SS2f4AtpcBpmh91gPF5fXSS/RcEe+jAlQjR19V+y2b+7/2osQHQeBDku
 GPvJcL/j7f1jkFv21pDvMYvZ+iXJKRp2y9LAWkDT3KJnjhv76cbn5iDko87bTfLKyjf05cCJE
 R3ZMHb/7h0bd9V6WJzBO0R0oq6x5IqvGOe52ufqmVxArzs8lE0fcrCTPqkKJ7WDf5v/eHREA3
 ydtr4IABfsbxm3jt8ydvPyneNtI1qS+qI3s/1kePM0oFGaXTcqJMP66ZyMm90x+5yjZuA14pd
 ioNS5xgTNut8gl01izMMjelskqrO9m2J2nUZl1V71+wCZx7gd6xtzNC7fPa1WKAUfMALiMEu0
 bNzH9xH8p6r4APp/6TREh7wXCRDZ6taAPKI9jfeVXcSdZhbtl0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 13:45:31 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/si476x-i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
index e6a3d999a376..2c5ec93333c3 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -697,11 +697,9 @@ static int si476x_core_probe(struct i2c_client *client,
 	int              cell_num;
 
 	core = devm_kzalloc(&client->dev, sizeof(*core), GFP_KERNEL);
-	if (!core) {
-		dev_err(&client->dev,
-			"failed to allocate 'struct si476x_core'\n");
+	if (!core)
 		return -ENOMEM;
-	}
+
 	core->client = client;
 
 	core->regmap = devm_regmap_init_si476x(core);
-- 
2.16.2
