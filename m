Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72280C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD7821019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfAVMAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:00:47 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:44055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfAVMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:00:47 -0500
Received: from orion.localdomain ([95.115.125.104]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXH7g-1giBso3Isw-00YiCL; Tue, 22 Jan 2019 13:00:44 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     juhosg@openwrt.org, nunojpg@gmail.com, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date:   Tue, 22 Jan 2019 13:00:43 +0100
Message-Id: <1548158443-21614-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:Rc0eQt0uQHdhplfsnw9sOctFgJncbAVuUeco7cSNaI5uC5BQae1
 vdFJfmuKvRvxurTKr5ck0Jlh/tjdIeFhEMyrWZozjdVztofIPRXXXT+/evD0P3Mf58dkPtH
 muH5YobbTYbFKG8ZVj+PIrC3bNXuzsR/WXFmsRAVW7FdGGGcNdB3FjDYTRTlp8okTg23ibu
 hC18hbxUkTKvo3k5vDZTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4p1t4xFR1Gk=:oCdU4JK9BEdBUpKW/NTtEv
 h6QOZDwsIs691pQTvjiSkalZ6sDWvROHj71B61jcDUMfs0GEuIUTtAwHh6lF6ZxjO/mdRvsN2
 xWmRvBRrGzTE52A15CBlDWTEUndEoSEIs51AGbVhafI/QPJ5Wkkgd7V5J7e9f6gJMynXwlYba
 YFb6kII2vPRTAJ5y8OycEU/DPV6hpQyFS5QjMvF9D9srTvBW0sDo6oqVUge9NL3iYPTGTdYDG
 5cYx+8OW+e1ZNxNggHtDXv0LZVnsRu8lDv+v/bqqiQyFStY314/yYsTyrNCrjyKMjxdnZrvAq
 lJ8sroSE2kefq/enR5TZTXE/sw5av8mo0ORro27E1EC+f4AbXBP5IDpDyttok3/v4EcERNv9N
 jWgecwXhMy+SXwy4TsU9wupwaq4ZP4DyDDFIeRm/zRyE+80ZmowBGQQxrojZ9AW8DTOae0cKQ
 GbzJh0PPvKKJ89kw4TcqrQEUKTF36vZ4vu5hhUcUwwlxPeBGx0pwvBDWu3ei565qPoPlJgnze
 sFfEzdYo4isfWvtUsMzHGo14g43oBMg/maWI1JY+/omMDcLrbQljETgFgrQzA2ZnPZ+XMpWSk
 xUgaxByDEAM1D6Y9Jl7CHY7Qllm4McbkCasg2QUwDWmgsTnJ3Nq6fZHvnMFvDqF//Y3hbKfIU
 UyN58wKoeyk2OujSCoq5kBEbzYFu4rpyDG3h+RsX4a5VJqs0B5nbhbDW3iLpss8Q65y/+FbB5
 0oaclSbDkNiDSIseAJAzgRfK/Y2HFzPaCI7skQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding the input name to the driver name ('gpio-keys-polled'),
allow the passing a name via platform data ('name' field was already present),
but default to old behaviour in case of NULL.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262..3312186 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input = poll_dev->input;
 
-	input->name = pdev->name;
+	input->name = (pdata->name ? pdata->name : pdev->name);
 	input->phys = DRV_NAME"/input0";
 
 	input->id.bustype = BUS_HOST;
-- 
1.9.1

