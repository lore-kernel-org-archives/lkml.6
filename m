Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C06C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B29E213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B29E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJHX1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:27:21 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJHX1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:27:21 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3bb3-1fiI9G3tPH-010ZL9; Mon, 08 Oct 2018 18:14:46 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3bb3-1fiI9G3tPH-010ZL9; Mon, 08 Oct 2018 18:14:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Axel Lin <axel.lin@ingics.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: include linux/of.h
Date:   Mon,  8 Oct 2018 18:14:32 +0200
Message-Id: <20181008161444.3871508-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:UCMr4PVpGdFqxDS9uyOmAXl7kbM/hCUIDY+g7sIMGkcvX/QtHjX
 S8GdPHwWzRIB2jh5oRIPZf8F851HNAulrXnNbtMYOugDj8Og2qqWJMRq6WD+7c//L98Ne5M
 aFMa1dCKN1UDTQxLhQ8NQOKmiVHLW/eqHNkpt4hGdVcqHF2iH43QrB5LdOTxswuWM2Pulv8
 oMImayiOk2n9YPbS0HGXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u2tMWiCZjC0=:W+vObD8TWeBTdFYWzEj//W
 EzePj95q8Dh/092v5lo1c2eRD/YUfPWfZb5voFDLOvcdsgHgQ10H7XlMRkN1qoJyjhA9nY9y+
 /pgBHqbu2YiPZ6Rt7scApNQHqwp1DMqXux2gLikHKbFM5hDZQmh85u34foo3WqLgsTVtoZAhO
 3nsasw7NA3kmRVy8ezRZVRFXMD57szCZP3pP4E+aShTUqLG8DtZmXcaKstRrswOm1e3l7SZ7X
 GqVndedvyS4+1/LXIfxRz71OG1h7kUKc0r6w9RyWAiiS2YmqpEeX/ET4rx6T2aVG0JzD0fRv6
 ML1CZ5dwkqZAJk80m861Q2HMI0nxz+M9yc5bSehptw3RlO72P3QNBmAOw5BbX6HPBJ0w90gMo
 7lB0kJ+cP+anlK2HGOqywZ+LlqbtR/uSpIQAR1c9rEBsEeQiSaEKUrW8W31es6wM5rTuJHBnb
 bsZdxYVEibJFVZKd2IIwIGSmbjeKy72nztJG17bszhnLSqWY2N9nCiigAEy/I62SsoOdiLGge
 bG0H6pPvNzIr4QAekMMFb7bR+k18YBuouxu9+pAAhgHVlvgI+iHuPm76/bXR+Wtvk0APTLTg3
 xs11BdEyPjPHJoxCrdi1E+tKUP1egsfz6qo8FNvpeGK78WfJgS9fWAQKXReP4QdvDJfs3MpBH
 x8iSoS9IYJS5/1jQtJ9k8tB5OIznjncWuGakuP8SQyYECg5B1WjIVaMnuIV8BZlO9Sq0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this header, we get a lengthy build error:

drivers/regulator/bd718x7-regulator.c:364:16: error: implicit declaration of function 'of_match_ptr'; did you mean 'hash_ptr'? [-Werror=implicit-function-declaration]
    .of_match = of_match_ptr("BUCK1"),
                ^~~~~~~~~~~~
                hash_ptr
drivers/regulator/bd718x7-regulator.c:364:16: error: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
drivers/regulator/bd718x7-regulator.c:364:16: note: (near initialization for 'bd71847_regulators[0].desc.of_match')
drivers/regulator/bd718x7-regulator.c:364:16: error: initializer element is not constant
drivers/regulator/bd718x7-regulator.c:364:16: note: (near initialization for 'bd71847_regulators[0].desc.of_match')
drivers/regulator/bd718x7-regulator.c:365:23: error: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
...

Fixes: 2ece646c90c5 ("regulator: bd718xx: rename bd71837 to 718xx")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/regulator/bd718x7-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index d2522d4e1505..7bf25aafe077 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd718x7.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-- 
2.18.0

