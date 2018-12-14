Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B47F2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbeLNWLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:11:38 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:49217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbeLNWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:11:37 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M9nhF-1gSj920Den-005rZg; Fri, 14 Dec 2018 23:11:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] scsi: raid_attrs: fix unused variable warning
Date:   Fri, 14 Dec 2018 23:10:07 +0100
Message-Id: <20181214221023.3878670-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WD/yj5Ry9KafPGHVw9edfVP0752pVKVw0uXAKK5BxXcrQDej+Uc
 mH3rUo7bMb2CKYrIxPnuIHlgiZMl9KSp1h5y8SeUhaECGrDYSyItPRvRbRlsh4p4MruhZZj
 RDkdtFpQzz3tXSdWUvm0pM9mYlKoSrUrIW+NEtKiw5u5xOzBmojQ5dYMbKk6iZ1Ci4/DUvy
 cqaK8Un+A1sjX6MYdTisw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X780U6YvOBM=:iIMrWABabKU5tg+LtoWDjT
 vKjL6EWAOgNwgMWj7M7CUndT4xirt8nkXay/8LiR+CN5aTgLt7SmuAuojmDmWPIi1FOjDM+FS
 KULiLFZqnZLCufJkoQKVp40r3H+vyRccpPnj9NZrxSVpaH25kfSzTZZCvHQ4YshuanvMmklhL
 SwppLpdJcCS2k+KkJ4Om4jUNqjYIy2ZBFEwU6RPm2FC6oap8Z3uzW529Pvfaw4f2oXbnXwCLD
 eVKINt8jqd/RqwK9U+80V8IUvZwoY1wsgRs0gGBU8pw/j39Ld/tsYJTRSx+dNEtcrl+XIZQx3
 kvuPLElxJJSNXseBvSu9lK+kFRFr7PXtmpiFCGYku+FBruifhKuuRkBqVaYrcLVDdK8yFRBeB
 Ypw9bxdG6uv8l3l7o2YAheVypSlDC8z1NM6Mt/XUxc3m57hQby9a2tjG3KElP8KdxM1TY1vwG
 7zW21DUysg8cF/n4Py8k6A5hjGm2V9EfKWBGv0ok+Kwisq9kO/WKBy4MixwIZSkaIAUifox6Z
 vSv9JmMZdfz6JeGT96R/JrSfUmVZsbNnNttVTfoU/WUKXWswkJAd3pkssPy5mvSg+g5beACt0
 E4get/uJCtLpWrWW8tRFl9IcQV8fs1jAq2IAPazdt3beTPsZJX7a5T1shgqT47EjtuVLEVuUX
 OV2pOCZMFrnyAQtpLWCA9eswg9MUP5WnUCJ6h5CgZO1UXOS4y3VWapdkDcjPg8MZbS30REC6X
 3tELOeU7TiVIWNf+/pUTSoxQsrF11tr6fwMTeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0eeec01488da9b1403c8c29e73eacac8af9e4bf2 upstream.

I ran into a new warning on randconfig kernels:

drivers/scsi/raid_class.c: In function 'raid_match':
drivers/scsi/raid_class.c:64:24: error: unused variable 'i' [-Werror=unused-variable]

This looks like a very old problem that for some reason was very hard to
run into, but it is very easy to fix, by replacing the incorrect #ifdef
with a simpler IS_ENABLED() check.

Fixes: fac829fdcaf4 ("[SCSI] raid_attrs: fix dependency problems")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/scsi/raid_class.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index ea88906d2cc5..5c3d6e1e0145 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -63,8 +63,7 @@ static int raid_match(struct attribute_container *cont, struct device *dev)
 	 * emulated RAID devices, so start with SCSI */
 	struct raid_internal *i = ac_to_raid_internal(cont);
 
-#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
-	if (scsi_is_sdev_device(dev)) {
+	if (IS_ENABLED(CONFIG_SCSI) && scsi_is_sdev_device(dev)) {
 		struct scsi_device *sdev = to_scsi_device(dev);
 
 		if (i->f->cookie != sdev->host->hostt)
@@ -72,7 +71,6 @@ static int raid_match(struct attribute_container *cont, struct device *dev)
 
 		return i->f->is_raid(dev);
 	}
-#endif
 	/* FIXME: look at other subsystems too */
 	return 0;
 }
-- 
2.20.0

