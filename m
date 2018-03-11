Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeCKPWx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:22:53 -0400
Received: from mout.web.de ([212.227.17.11]:58855 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeCKPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:22:50 -0400
Subject: [PATCH 7/9] um/drivers/vector_user: Adjust an error message in
 user_init_tap_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <04d337d2-a2db-a5c8-e056-4eb51a3882b3@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:dNI4VHlg5hPBMbbZIiIiD+r0mHSvBylT2SrSFWChGqZMuOYAQre
 KfcqEQ/kH8A45JWB8E2iiyUSieYBZDxCBiqyuaYvUVk64rvM2Qf4WXmziqAleq24EqgBfv6
 eqdaVHGgmiHVBZSIAz7p9ShwELZUrExaCnP4lzw9K6La7tbMV4Z76Ft9aiA/UOlO1tOzQ1f
 K9UHsquJZqTbLyoIcqz2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nzd4sV8/mPY=:+Xj6RjEYktBM6sohBeMqUG
 wOn6/mO6bx+Ky8ShDrqR0MJx1SMImKoQEn8SmrGHUHXkwSWdhDRIR7HZ+LXZe1tiVvzPv3HjV
 KkrvLbFf5ihGSiidDv+s4YOyWCrdzN5ihRT7EAHA0Qv6Bs/kr9wHJ1/SSCcBKFKxoqXrCT1Os
 mvWJ/uhPSwuT/xkWluVPRYVd3C7kFsyrTcfuMaK8xEkg015h64CkihBLAlRz1vpyuJUhdTfWv
 VFLvVQBUdPhPBo72YLt/F1oWaSC7j8hK5MbfsZmI19njk0/xWLigs9JLxNQR7zt7lYj4vL16u
 L1P2IBKH0KSydNgZBJ2n74UdmFOmvUpfJH5wSBu70SKolHbBovSbudLukCeoEhPwRADs807GA
 T8y05gB2ejXmxzewyDzp8GGhf8T0zoe7MPr7Titg51xELi7i82CkktA5kWbKeP6/KLmyS5Kq9
 /KVICJburAKIbFOSjwn0O+Zp1PZwO/XYh10PDr8SR2VmDG4kk9VAMLKlGuKgTo/KseHcYrMqD
 6oQFyChM9zXhgTWCk/yMnej+s/qegpblMES/ch5CN+8ayaqhjgmdF8rVWgUFZIStVb3D1UDgP
 5zWQCDxcaLxzqVAf921c6e94Ubak61m5XfQCUp5g+Q5U2gBw32CIdEN6xigL8udM5ve4mktY8
 OCGhnxX3qhQoXY2kPKHKA4PxVHH/1RCTNF2RYleYJlcX5WmR6e6NWzI1OE3v2jLm/yOVIzHMd
 Bfd+ZyZMjq1nLGYgCaK1DFeoResezvI9ro6zxXUWa1uWwUdGJarckKQPHmHA9wyOuyagROyZl
 QavUKFIphmYzFbNVrbeQ6e8Gx8kLRQrNytUeBzEGFMQQVjTYIo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 15:10:05 +0100

Adjust an error message at the end of this function so that its name
will be automatically determined as a parameter.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 4c265262a369..5e78723c34d4 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -192,7 +192,6 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	}
 	return result;
 tap_cleanup:
-	printk(UM_KERN_ERR "user_init_tap: init failed, error %d", err);
 	if (result != NULL) {
 		if (result->rx_fd >= 0)
 			os_close_file(result->rx_fd);
@@ -200,6 +199,8 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 			os_close_file(result->tx_fd);
 		kfree(result);
 	}
+
+	printk(UM_KERN_ERR "%s: init failed: %d", __func__, err);
 	return NULL;
 }
 
-- 
2.16.2
