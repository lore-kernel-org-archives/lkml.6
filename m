Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeBAQYe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:24:34 -0500
Received: from mout.web.de ([212.227.15.4]:58943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeBAQY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:24:27 -0500
To: linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>, York Sun <yorksun@freescale.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] i2c-mux-reg: Delete an error message for a failed memory
 allocation in i2c_mux_reg_probe_dt()
Message-ID: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:24:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:J9lesRdQ824wBFz8+ancgBSaB/mx636s+mliJpC5y9ALFaAwXks
 a6mctGOWbDxV8CTjQH1I4p0RBIOtWk3EcY6bNTukjbKY6zyC4K/jwpkB9HlP+rKmg1YRxKq
 NFQdHSdcRMLCXzVDQkMj5SfZZ3+CsLwLXpNSlS+05mKRVj5U+MPt8UegT1MJ2vqzxrb6HwB
 CLtIGIVmGz8VH1CpTpntg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3HWSpoYenGA=:vy7OszB/CWGGEGWUjqVzAK
 2t6dmiodHvTwc2cJCUrtmvvkxAlhz2hWoL5PpCw994SUh2xJ0DdgZGCKGbqvOY3OU8O4s+WN2
 lyVMw1XyXSlCeOWlGvym3jrMfOTZ0WeBwsRGCBWyiHZ9X/4JzjoJUVedZpfwte149KN+u8gCv
 KH5RumKENQnW3Q9Vw1DwvVZyfXF4oyTIPZsrSn1BBHMKFB3ksMUxFIBrYx/gvoFmaO0GjoqAG
 XXc7EIN968ibvsd5GHk/trcIyuSekrRjBWtT99iHHA84Dh8sFkbip+NFgfjh1lC6ZHUdOIS52
 xzSy8RUB4APCscEX6MRKZ24srwLO4T3uqR4zDK0p9dQ6ue6oD1QWk1lVWzpbyXk/TF+KlH1bt
 9af33SVwbTYySlQNbuY7cR2SsSIp5963ojCbwYV2umXO6NfJCWYzSxu4ZRmesISO8695oyihv
 sZsEj8LwVFFRoIC0Wk6fTEdaQVjKaMtSASiHcdtcPjvqAoLQ06qNZXBbLCIR/A/T1BYTqtxA7
 hERBe/bjI+acck2L97Mm3jmGwGlFCv8VeHKlH8m4U6ZV+Rd8jhv7noBQYZ028RG174hjXmr9g
 FEwD+TxeKmA3qTD4oMxBhEr/G0k3rmis/MPT4+kNgyXtIe06ZhgsYiRYJXBxNFrrDupY/he4G
 IcCXPAwlucxcP/jyygpJ+RZY3HqwpwLtzqtEZKQVeTOrhdsEbqelvKDy8IAChvG+zoPNIl+5M
 sGZwnZA3+yE8+BQ7be4czaqGuO1t9FJgOD7CGqGurpJbb0N6j5VkB49aM0EZpF6JruMdmEbrH
 CGDg2q0yTcYPXVCuhb9uXbzv7p9I23gx+gNw31FIRxKKtfAKnM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:17:19 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index c948e5a4cb04..f624ed64a47b 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -127,10 +127,8 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 	values = devm_kzalloc(&pdev->dev,
 			      sizeof(*mux->data.values) * mux->data.n_values,
 			      GFP_KERNEL);
-	if (!values) {
-		dev_err(&pdev->dev, "Cannot allocate values array");
+	if (!values)
 		return -ENOMEM;
-	}
 
 	for_each_child_of_node(np, child) {
 		of_property_read_u32(child, "reg", values + i);
-- 
2.16.1
