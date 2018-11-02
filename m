Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7A3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C9D20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C9D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeKBUSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:18:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:18:50 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7JnA-1gApjS1SVo-007maI; Fri, 02 Nov 2018 12:11:30 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7JnA-1gApjS1SVo-007maI; Fri, 02 Nov 2018 12:11:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: auth: add CONFIG_KEYS dependency
Date:   Fri,  2 Nov 2018 12:11:22 +0100
Message-Id: <20181102111129.276496-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:CEEAGe1CdgavwNnrg0ejytqy3AyGSfj9TyB8ISxljeckjjICYTz
 vhxk7GABJZ0YXzIvpP2JROBy+23obH648Mwa9oApo3OCTjEJRVRN3ncPsm+ojI53orEhRaV
 33nQ+BB3Hz26RGi02VSLKWe0/Hfl2HZLrGfNHYEGTgpiEmYAL6RcE8lckmNlKHYVI6BfoGo
 gwp9nEWsQZ9NwWq9GmAWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wxpjIpwPxUY=:FUCBYv2K0rgYr2De3DbKMG
 EWYWIbTE4XBUuUBkKCa2oaFnhIc/GJ3V9tKp6JNG6SM/oXv9UXhg4okNfmW/pVqn3/1bk6tTl
 vFeSbsmDb4SHoGXnc3EdGQk4wgCsbSCx2TAXV9cE56+F7NBBVS8dTrBoLRwLiP2qLrxQqBPFM
 xV7LiCKBNdVNbc0kwgZWAOUBJJQmW+QTFv57bsI84elE463R96vuhD0UVBf0V8avh4V6R9nMy
 HKFiFOyooo9L3iN5aw46zZrt8gX3N7yeBUZGfhMiIrd5f1wmEeeXBqVJ4at68Q0FuWBGOdlNU
 RviOD15PNMLuckIx5ar1J9GYOpygRP6U7QsDZxbzYnqeFOwMpXr2PjVyrGiHtpArUJNqFGcMS
 dKXSOqE/v3tSZyRC+lGTPOSdp40CWitRpgQvFkEiEZCOCHjFRrI0UC3ga0ANKh1urtDon2JM3
 ILht4/bdtTuICilh2zMnyUXh3T/WP5AYksfmOyAkT2tvWP4US9xv0sLtKAq//S5KGt+Ff8n73
 R7r/RHJTa94ib/vWnqNdCRX4CYK/AHQAJvUAT0+pUHXUjk0CZK4j1u3/wJPyZrrMgnuk4mGd1
 z4HB9p8tfc41GM/z8jf70wfgooLgZxD7shRg+4tfHtYsFwj95flQJKFu0xDa4oy1iOQCJTkqg
 y6tblQ8VInYoiINC00/WMVuqmHz4rT4cmRSy04zJyWDkxOe8NkMq9yW601NUhZOMqQ4c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new authentication support causes a build failure
when CONFIG_KEYS is disabled, so add a dependency.

fs/ubifs/auth.c: In function 'ubifs_init_authentication':
fs/ubifs/auth.c:249:16: error: implicit declaration of function 'request_key'; did you mean 'request_irq'? [-Werror=implicit-function-declaration]
  keyring_key = request_key(&key_type_logon, c->auth_key_name, NULL);

Fixes: d8a22773a12c ("ubifs: Enable authentication support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 529856fbccd0..406c88dc039e 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -89,6 +89,7 @@ config UBIFS_FS_SECURITY
 
 config UBIFS_FS_AUTHENTICATION
 	bool "UBIFS authentication support"
+	depends on KEYS
 	select CRYPTO_HMAC
 	help
 	  Enable authentication support for UBIFS. This feature offers protection
-- 
2.18.0

