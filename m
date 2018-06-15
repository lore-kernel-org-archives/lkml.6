Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846D208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBlQo8Sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3846D208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756575AbeFOW4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:56:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35389 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeFOW4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:56:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so6066248plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ppihD1OoxteFoxOjO7adVgv0F5mAbgN4RNDTHViUapY=;
        b=oBlQo8SwUUyeMO0OJWB8tmZ3jXgOwxwo+UU6ECSi+fdZjIDR2w/+BgZDFstPU4qAbk
         zF8X2hgQGFTtCqWmWtbWQ7LUtd4AaXcRrS1wPKrnhdHm/98BSmSVcSKg0/DXRO6UgkYo
         uhWdz+2wHwh2bhkQMMADHwWx4Bg57KwU/5PZoCLx/YC+m+3dW5oD7kXx+zI6xr9xFADJ
         CLaeJPyijU+p13EUmYOrJJsJLScaJ2afZysBNbkhJV5DtC5B3dje78CMtu+cejTF15aS
         GoOfMv+JjImIk68icgoGo3ZpJDi7vjyDEBRAgDANp8Zrqz/5KrayxKRVkWwgiSMSA4Zt
         DEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ppihD1OoxteFoxOjO7adVgv0F5mAbgN4RNDTHViUapY=;
        b=nd4Vk5AB/D0LGyXoq1fvaf6ELV/VJI8KfV/vmXnFRxtc4e2yhoL25LwhQ92K35biQc
         I7XWq/PZ1qu86exPpVUAkBUNgvbz0IK42UBKMGYuwMdUCPqx/P+/tsZxuJybN3660zlS
         U352ClyVWHKzeMmFPb9DbIlr5jOQRzVsTGsrmDZ3IGSHyCT9xhRsuQVscWWVCI6FGbPZ
         aFTcfTC8JPPxxEduFtZYYkWkFi9uowAPjwsND9rZJNrAIe8xZQl1WpdBqfNSMvdkWOad
         miAQSGvLTkgVvgXY/U3FH5Q48y447FsrutuIs8sttpZMBantQbaJ6s9scDXFR41Kc3SS
         FG3g==
X-Gm-Message-State: APt69E0JaxpDFjU4yXZd43VEP7Wlkuv4AvvpVqDGHg0INtOe5UOSegBX
        WEKlvg4EF4HnmpuI7YIeOvRgJw==
X-Google-Smtp-Source: ADUXVKK01mnMutcJC1EiJnQDrbBqH5r0Igc5oKDTN9ol5rRXhKTqaS4I0576b+BQk+NEDBHZ03qoig==
X-Received: by 2002:a17:902:7c83:: with SMTP id y3-v6mr4050046pll.51.1529103377914;
        Fri, 15 Jun 2018 15:56:17 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id v78-v6sm8075306pfd.64.2018.06.15.15.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 15:56:17 -0700 (PDT)
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bskeggs@redhat.com, airlied@linux.ie
Cc:     mka@chromium.org, jeyu@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/nvif: remove const attribute from nvif_mclass
Date:   Fri, 15 Jun 2018 15:56:04 -0700
Message-Id: <20180615225606.185324-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
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
 drivers/gpu/drm/nouveau/include/nvif/object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/object.h b/drivers/gpu/drm/nouveau/include/nvif/object.h
index a2d5244ff2b7..7f188f66931e 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/object.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/object.h
@@ -78,7 +78,7 @@ struct nvif_mclass {
 #define nvif_mclass(o,m) ({                                                    \
 	struct nvif_object *object = (o);                                      \
 	struct nvif_sclass *sclass;                                            \
-	const typeof(m[0]) *mclass = (m);                                      \
+	typeof(m[0]) *mclass = (m);                                      \
 	int ret = -ENODEV;                                                     \
 	int cnt, i, j;                                                         \
                                                                                \
-- 
2.18.0.rc1.244.gcf134e6275-goog

