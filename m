Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D767C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F8020855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F8020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeLJV7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:59:52 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:38549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:59:51 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MrPyJ-1hHLfj1trD-00oZyJ; Mon, 10 Dec 2018 22:59:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Greg Ungerer <gerg@uclinux.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Wolfram Sang <wsa@the-dreams.de>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: ks8695: fix section mismatch warning
Date:   Mon, 10 Dec 2018 22:58:38 +0100
Message-Id: <20181210215856.2238253-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C08GXU7G/QybJVSD6XwmX6YnmR+EjGBU/Jra0yrgutJo0sYTaDd
 9syqErBwHA8qnXfo+0SrIcGwI21H3g6LYFSFK5+v1umL5eLNfNQWQuHZc37wnZo+pzPK+IX
 Xb5c/GiDmdU2E0GGLDzBsGoQtBx6DoMb2AhcOkNB2YtSX/09ie0tZgTFkNJ+9EUFBnuNvH6
 QATu7Ik6SBwZquhJ9xzOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ntbpk4aPYZQ=:d0XjQYNwtnuQM85Pi6ajdM
 FMW7i573FTC4U0FhsPfu/5R+aOhR+MxOelpOODeEdbEe3jou7KEoB08yIBfSUw/+gOpGiwSOL
 TqXOwWf2JKz3vO6BOPCjUy+sGPP+1k3BHOcCOstohqCyMKmGAQbGGYCabvtJ6xy1x57QLYWRP
 E5SEP6FiaSOmSwXC8uyNA4JmVUHWVEA7lg+6cPWD9jkj98fbMiSrcx3VeOi8m82MP+mZyBMFu
 KY2aeMY1Zo8slt5M/JcRD9j4p3sV00pg/jDZoEVkCLWEVIAqOQ64ixnEJWeGuxyHLXqSsRtp/
 LUKT/afsONPkF20rFpIl/EOj3wyjoxo/+IRp0dOafdyKHtmeBXDImlopQP76Q/fiWZw7ExzpZ
 7YEyrXXnIXM3hE31//H2eVbg8ipS0Q/o1GxhCFCjizxw8XIhX7Sk1HK9ARJpPm9ExhRTbM+IC
 sLTfgwELHXozN9Gy05E3MtuDf8v7EYJ1zaQcg0PEE36eHPKBtqOMxjdXg8d92k/GeKwzMCaFN
 znoWurQdgMorW40zUcJyvv2edI+ido1xIFhJD+zw4WnZO5MP54TJaITmUzTCuElYfddXew825
 kWMXTWtrah85heGqwd8lkQGKnACQ7FbZBorDPTwnkSdLLy6OwXL3QzMqOktOLbNvtSrfgBXWs
 D3cDA7Hzzh17X4nMFn7MOAcxuz1nTMvJy0xdfFawyzPyXXJ3lZM8H5114UpGcATjZ0AA7gaF2
 +wrVO83GKc3FpI7ii24KqlLeVoxCG8Zgk+XSqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text+0x13250): Section mismatch in reference from the function acs5k_i2c_init() to the (unknown reference) .init.data:(unknown)
The function acs5k_i2c_init() references
the (unknown reference) __initdata (unknown).
This is often because acs5k_i2c_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/board-acs5k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index ef835d82cdb9..5783062224c3 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -100,7 +100,7 @@ static struct i2c_board_info acs5k_i2c_devs[] __initdata = {
 	},
 };
 
-static void acs5k_i2c_init(void)
+static void __init acs5k_i2c_init(void)
 {
 	/* The gpio interface */
 	gpiod_add_lookup_table(&acs5k_i2c_gpiod_table);
-- 
2.20.0

