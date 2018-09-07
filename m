Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE28C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D4C2087A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G8hacTty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D4C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeIGOsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42418 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbeIGOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so14348207wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1VBG0PAwehY35jashnN3ubpOSw/AOLijfoN6Rb7R00=;
        b=G8hacTtyH0EPG+ekgqJrNF0glLu6/vPrPUoWVfQIZ+3QElZlOQhUVPijOPeOJjRSlj
         mryexc7U/A402JGKKl0OaMjEp8yYsksr9a5VrO1Bv6EUHEHF3agQgUm7SRJgDsDn3b/U
         S55kNmT0krv+0WK/kZpfq+lV59qz39puQPISozz/gTV4QJRitZvow5wHXqXtXhq/yKUx
         C5bsOLBFe2gtAk1YzaNfYn//nAhTwa4yH5dnOc6i/uW/HbR9xUbSxGYuiCoEhbflTO18
         MM8KKoF0hP3TQUvlyrFIcvet9jtTcB+iUYdTxR7NboZ3Hdqw1qMf1NREnLkHp6Rzt6gt
         6CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1VBG0PAwehY35jashnN3ubpOSw/AOLijfoN6Rb7R00=;
        b=RuCpcZEOVpmLuzF5i+JD4+bXvfQPJSUYWshIvQ3GKRySRFlV/Ke90PqVjIJNYw5QS9
         BzgtK43R+EEF4hi+Eg+ajwDLpYt+qf5c2iKcbzUJwNt7V+Yozac4/RicJeIIfGpiwmPJ
         GtSBPqGWJWaEcasr4sN/2pZKoA6fttFCcNWp8Pno/xYUfRmS8/TrugkFeDTAaJ6KaTm0
         UsvJ0crRcdvPDS2UXK8FABGdHwSQFZsjIe4td/gdH6vq/XKmRsReMdMbMsfdVVdolV8l
         lbsFnqU/RHiQnk+K6dNP3+0KMfXUt8R24mXxbH9Nf4Nz9tcccZc66Ov2jccyfSBKRAoo
         ijkQ==
X-Gm-Message-State: APzg51D/fMF4SF7EWdlHhlVJ9sJmrdyiFUBw3fbtYFspp9g5Uno7ehJW
        TXmaD2IrveudEp+4X+kqPndD5Q==
X-Google-Smtp-Source: ANB0VdbtKtyY6wAzPCg/dUJiyphNjLbW4pTCoYbvr+dBKK484w8Mvp7op/8MXmYLj17eU5BIEppcaA==
X-Received: by 2002:adf:f648:: with SMTP id x8-v6mr5742256wrp.144.1536314910161;
        Fri, 07 Sep 2018 03:08:30 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:29 -0700 (PDT)
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
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 09/16] nvmem: remove the name field from struct nvmem_device
Date:   Fri,  7 Sep 2018 12:07:43 +0200
Message-Id: <20180907100750.14564-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is never set and is only used in a single error message.
Remove the field and use nvmem_dev_name() instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 364ee16e7d6a..e456aaa6184a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 
 struct nvmem_device {
-	const char		*name;
 	struct module		*owner;
 	struct device		dev;
 	int			stride;
@@ -537,7 +536,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np)
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
 			"could not increase module refcount for cell %s\n",
-			nvmem->name);
+			nvmem_dev_name(nvmem));
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.18.0

