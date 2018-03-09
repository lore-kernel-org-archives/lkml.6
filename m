Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbeCIQkB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:40:01 -0500
Received: from mout.web.de ([212.227.17.11]:37573 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeCIQj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:39:59 -0500
Subject: [PATCH v2 13/17 3/4] mfd: tps65910: Delete an unnecessary variable
 initialisation in tps65910_sleepinit()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Message-ID: <4b909856-0197-43ca-50c4-2e592bf7514c@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5ORJKkUUxTu5sk7TTeLguEab5e8e73rRQlZZLB4OrDA8cvEwBqX
 FzTzDToW1Zq1wzHgB7dOfYA0uwpUApB4YYaSnshw07o8QMmo2ooVnAbK9lddBeJpG/lB1Z4
 HtDs5dTbvgC/E/RN0kX5fs4fzygLP5YpDnDv/rG4gSDPXdKtgQx8URehxHg1ce478B76jwY
 2sBoOASg1rQyBopfXdyYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wjGiHo51ZQI=:TubzmW4Ts2l3Xa743lzkAj
 aiMAgfLBHq82huknXVuotF5UU5hvWP/tW+gFi2PvOWTvCLUuRP2peCU7jkGnyFTmzuxMiPzdf
 NNHc9Www4+kaVkzKkdFRaUW0RRuHKCoYcbRgROqb4zEl52rgvi9I41T1ryfu5JQNkL4X0R7mb
 ZBF5QkZYt4bCjeCd2SObv/3r3r+BpjlHFwSpwKaWo0FIfRHaisvES5ACprtih8M2z3Lk2w0Wu
 a0bRHznkog+CE1q+QRT7UCqWt+A8HYPvZe4nzp1EJyD3V65aenuA1PWxrV0RVIwIjeDRVSLne
 /xrfrW5uJjNfKuYJ1la5w5lEVw7vegfEPGsUfJxaK462+cCY6cDzTQ+XfaHU7HLwsIKBpdGWg
 oGy+i2iJw8J0/Nf8EpVauJcp+G6GTuW6IFtxsF96phA/m22R45El0cjZ+8+Zr/MLnCZN82Ve8
 MfFy0UtM+2AGXTitSsMcnwVaksh5dZfcaH9df0iJy8ZI7NZwQGjigGgElB76bmwoUE0T0JwRI
 K95lYkyJUyhck1N4aBrcuVm5/FJRhMWfTM+swK4jHxXLlMS2CG1wasRwYXKYO5BuvptjZBKRw
 3MvXMgMGr4wXOozX4JDe6jPCyzGBoMtXDEjymuWqDz/AQH+Zykoupqr+U3bFMa0of5QbHsGxW
 +aQnzwDgBwclWBlVKgLGZnMEvd6F+RSvmyejwTkwg1DWNcbMZVWa72hOPXLMkZNet5AFLWQ42
 nppykpKFOYw+N3JPMaBpjXcb/zP1o3patHUVVZJm1EjeNAv7RQF+RsAN335LanwKFjtabj/AJ
 Z2EFfqc6wvwosCO86ku03svkcNgRTapHKc/maRyVzpFbqj80gE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:10:09 +0100

The local variable "dev" will be reassigned by a following statement.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps65910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 80ea1474c654..7e7d3d1642c6 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -312,7 +312,7 @@ static int tps65910_ck32k_init(struct tps65910 *tps65910,
 static int tps65910_sleepinit(struct tps65910 *tps65910,
 		struct tps65910_board *pmic_pdata)
 {
-	struct device *dev = NULL;
+	struct device *dev;
 	int ret;
 
 	dev = tps65910->dev;
-- 
2.16.2
