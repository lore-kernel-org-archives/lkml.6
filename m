Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AF620878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lxAHv31x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AF620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJBQ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:26:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40842 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeJBQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:26:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so664867wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXs1lClEWsn92wLmUxVM+cd4Mz2GfrXa5objbOmjlQo=;
        b=lxAHv31xmGTTjVY6FrHZRKPP/sDlR97vQxFu1y2Qz6u6dNtqzpiiiDr2WJlOaUqexD
         wESE7DKPnvHRuDRvdeWuZSoT3RNAFTy8p8T4CUjaXg8YHlWFo7/Ob7DVJF3yYGywJbcR
         0M0nMlh45eStYIg+cdAUhCGM53NPrylKqkruAtcTVTDljcX3vMoE+FHKwIXb5SwyYRFE
         K4oyFHd3xuBGS28tfFn9DYhEkXTX+d8zMPO7c3VpU3bv9Cu1qImJz2VCeHDGBgpAts2+
         2N3TOFLjmI9VpidbNF9AOr7SThR81Gj1WgmUoVWplAlkP6bgHjYsoeJFjREIfSzcKGer
         oXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXs1lClEWsn92wLmUxVM+cd4Mz2GfrXa5objbOmjlQo=;
        b=eb/hQlc7/9dAcV+WfY4VqaonI0zheCiZqF1l+vmfqabCwgfp1d51SiRKyakDonXBtC
         M0TtgqIeUnf0jxxZkebM+tAULaFMRSsePPZynUPQutbtPjE9J0QvmUgtL0YW9dtCB9+X
         YG4VEekN70RUbqmk9sGvC9OmDGMIM0+FvJtIMfuyp25y6aFlrf1+U+R/LADqlagNrTDl
         xylV15AgoZZwd2duw9ebZPug6kqApeeTW32WyxHo7V8po/Goz2QvHN8dpF6bXjYffow6
         cjVk4Xld6s6WQf5BjRuqDBD2JWGb8OWOxSQ8cSq4caM6osBxRWQg0m8UB7Z09eQnAJXR
         Nrrg==
X-Gm-Message-State: ABuFfoje9do1GPByh1mEOJ1bbc2W4HRsnMhH1PPi9aJqO08Tr/fejbFI
        nno+8vVguWF1Gc7VvjCUNi3taA==
X-Google-Smtp-Source: ACcGV60qbeO24HWoB67EJEmJ4fmH7anTnVPh7li25L6qHDkMMq/HrcN7xEfsAXdsGL9cx2A7jtKQIg==
X-Received: by 2002:a1c:c145:: with SMTP id r66-v6mr1254363wmf.131.1538473434443;
        Tue, 02 Oct 2018 02:43:54 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:217b:7d7b:52aa:bc53])
        by smtp.gmail.com with ESMTPSA id r13-v6sm10863996wmf.35.2018.10.02.02.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 02:43:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2] nvmem: fix nvmem_cell_get_from_lookup()
Date:   Tue,  2 Oct 2018 11:43:50 +0200
Message-Id: <20181002094350.17649-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We check if the pointer returned by __nvmem_device_get() is not NULL
while we should actually check if it is not IS_ERR(nvmem). Fix it.

While we're at it: fix the next error path where we should assign an
error value to cell before returning.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- use ERR_CAST() instead of a direct pointer cast

 drivers/nvmem/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad1227df1984..f49474e1ad49 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -952,9 +952,9 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 		    (strcmp(lookup->con_id, con_id) == 0)) {
 			/* This is the right entry. */
 			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
-			if (!nvmem) {
+			if (IS_ERR(nvmem)) {
 				/* Provider may not be registered yet. */
-				cell = ERR_PTR(-EPROBE_DEFER);
+				cell = ERR_CAST(nvmem);
 				goto out;
 			}
 
@@ -962,6 +962,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 						       lookup->cell_name);
 			if (!cell) {
 				__nvmem_device_put(nvmem);
+				cell = ERR_PTR(-ENOENT);
 				goto out;
 			}
 		}
-- 
2.19.0

