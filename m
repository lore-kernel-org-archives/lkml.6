Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324ADC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF4220864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk2XA7fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756731AbeFOXAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:00:52 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34012 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbeFOXAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:00:50 -0400
Received: by mail-pf0-f169.google.com with SMTP id a63-v6so5518730pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHSvdkQ+pBrjMUbzMKgy6ofdZ36HXkxOpzdNnz5cjtk=;
        b=Wk2XA7fc3KLEVG+81jiGDe7ZdTL4j6bdlUHgB37z95GZS/6DiVAk/UwYcA8ktGtXRE
         LryGMYy3sQOzh7OV5iAnJkBd7TkgWzxDxV/9QCFaj4G0NAL4kcBIuSlcv40kOht1Kylz
         9QimkQdfTlxNJoS0458HxfcUQPfSXahTdpSe58rr12GcNb3YVTWwe9Wtt6IHMGa75i2I
         kBdSQKpyROnKwXg4krGAGd9Drfg9bfmHwVYDd7xJSuGLR7l/jvvIMznLIX5ayH7PH3PA
         w0jfOFeqVU5OulWoQt7PQ3vXDPrQHQUPqIGjTre71SjXfeqesDLauXPDsgae4szGzWSI
         Q8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MHSvdkQ+pBrjMUbzMKgy6ofdZ36HXkxOpzdNnz5cjtk=;
        b=E4vIuNH2eR6oTW7lS1VBGd7UUw1wZrYsq0AXqy6voesZT/hBsoYO7ZaJbjR29J1t5N
         Q1VEbKbeCiS3y04NWBjOyzAF+vjxL/DLaymh2J8GI++qVOtsXQ7iGPXGFvpDwMGt9kfl
         +tUq05cZJsLiSczDfIMb6x6pF/1roMGwifF/oVw6tDajBIde1OHJUU8cNxUvpL/PS6O7
         Ve9hCGKWCQMD3nEBCmmDtParNdfBr+zfDeQ+1SbjPSB7NkcHUzWqahbiGN7/SUcDMvwX
         +hTyED/4bPNsZUf9EcFzUb9G/z2le4VcoJXRtI9ft6fc6i00zJQQaulvFohLi0EGDNyZ
         cTBQ==
X-Gm-Message-State: APt69E2Agq3R3dcJNKuMbCRhX2wwsFGnJoewpMWKqtJpDj6CzRUeCw7P
        YP3UsYGpnjTUBTpoCV5WnT5PWQ==
X-Google-Smtp-Source: ADUXVKI/fmYNWnWe29CzGCyG7H0VzsTOuB9AEbOqvWXqCJzOvmDSWZeTVh2H0L1B8f4z12jt/cJE/w==
X-Received: by 2002:a62:2414:: with SMTP id r20-v6mr3961514pfj.108.1529103649758;
        Fri, 15 Jun 2018 16:00:49 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id t21-v6sm22570148pfi.22.2018.06.15.16.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 16:00:49 -0700 (PDT)
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bskeggs@redhat.com, airlied@linux.ie
Cc:     mka@chromium.org, jeyu@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/nouveau/nvif: remove const attribute from nvif_mclass
Date:   Fri, 15 Jun 2018 16:00:42 -0700
Message-Id: <20180615230044.189899-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <CAKwvOd=ntzV5x+rDSH6VEoS2ONZacnqeemewNgv3Aotm3Hd-hA@mail.gmail.com>
References: <CAKwvOd=ntzV5x+rDSH6VEoS2ONZacnqeemewNgv3Aotm3Hd-hA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 0bf8bf50eddc ("module: Remove
const attribute from alias for MODULE_DEVICE_TABLE")

Fixes many -Wduplicate-decl-specifier warnings due to the combination of
const typeof() of already const variables.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes since v1: added additional space after statements.

 drivers/gpu/drm/nouveau/include/nvif/object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/object.h b/drivers/gpu/drm/nouveau/include/nvif/object.h
index a2d5244ff2b7..3d7e485a9043 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/object.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/object.h
@@ -78,7 +78,7 @@ struct nvif_mclass {
 #define nvif_mclass(o,m) ({                                                    \
 	struct nvif_object *object = (o);                                      \
 	struct nvif_sclass *sclass;                                            \
-	const typeof(m[0]) *mclass = (m);                                      \
+	typeof(m[0]) *mclass = (m);                                            \
 	int ret = -ENODEV;                                                     \
 	int cnt, i, j;                                                         \
                                                                                \
-- 
2.18.0.rc1.244.gcf134e6275-goog

