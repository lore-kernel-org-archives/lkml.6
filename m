Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63016C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0329C2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByX4XZdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0329C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIEImK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:42:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43589 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeIEImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:42:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so2759176pfi.10;
        Tue, 04 Sep 2018 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GXIXt3ikpZ/xQYtNPxzYw4roewcXKc77FNT+mtyoPb0=;
        b=ByX4XZdScHZsYpwkQSi8fYO/wwxw7GkSxW+ig0luGBjdixOO4HUCHTssz8W9RqL0gT
         Cni91UAR5CinFvcSURxEu6NJblmgLVXIZDX7Zw3y8y3vFsZ3xYmdZEsuDloVUZBLa5Gl
         cpPF6Peq9dttSas+dx/huTviZKcVn3Tvz55HDVJh8piLbzkPITBFtU4K3ACR/rmMPMMF
         jjCwQJ7wrne094JNd2fd4MSgFLXDAS2gQKrlmO3QjbyKZZnav1hsEeEjospJ586OBFMN
         dzOzaY8PRiKjR95+qxxf0g6T23mtQ6smSdTn65Q2hEMgKT/nhIEUWGyY3l5cDirn0t6k
         wl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GXIXt3ikpZ/xQYtNPxzYw4roewcXKc77FNT+mtyoPb0=;
        b=dhFJFB2u+r1iTdReDWMz0hRWY8vKeK/Mi4ZCX1Lt+Dcq6eIXkHd9UldA8u8guvekUk
         c5kkuJvb8CHFySoudyFD4Qy8qj5spI+4HPr9e3ysr/muz1QbBHDQZXN/NOah1ciNSgnw
         Vu25fIrj552Qm9bbjrTVGzJ/YosU3JMYUxHTo3Ds6U6V/2cvc/laSZPpbwEMCbeGDpEW
         JtMyuTX5uMv4LltE6jUEPaYryl4jf5pXqkeGq8PMRVyZ+61PPElmPcYFXgRjDpP0W3cp
         0FFsLVzWQD8sK2fTp4CWMSBDMdjuLSgbVp4rekA0V/lBl0/Vy2F5Bz+uEE/mc1gN/Oi8
         BzRg==
X-Gm-Message-State: APzg51D9fZZ25Ghfc3EkpemDS83qtjuVyX4hAIX5P+HXd6TLffCaBw5u
        8hSIPMQJFtmX+XEKFQVdebwSlueuLEI=
X-Google-Smtp-Source: ANB0VdZUmSjUcNdFLJ/qk6xksZXM2I6F1ri+RBOIhDCWaXl2H27Z/HzQLNxJco083H0McFzqP9vqZg==
X-Received: by 2002:a63:1b4e:: with SMTP id b14-v6mr34130840pgm.303.1536120834777;
        Tue, 04 Sep 2018 21:13:54 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id 74-v6sm762641pfv.33.2018.09.04.21.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 21:13:54 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Song Qiang <songqiang.1304521@gmail.com>
Subject: [PATCH] input: keyboard: gpio-keys: Fixed a documentation index issue.
Date:   Wed,  5 Sep 2018 12:13:47 +0800
Message-Id: <20180905041347.19986-1-songqiang.1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_keys.c now exists in the drivers/input/keyboard/ rather than
drivers/input/.

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
 Documentation/devicetree/bindings/input/gpio-keys.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index 996ce84352cb..7cccc49b6bea 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -1,4 +1,4 @@
-Device-Tree bindings for input/gpio_keys.c keyboard driver
+Device-Tree bindings for input/keyboard/gpio_keys.c keyboard driver
 
 Required properties:
 	- compatible = "gpio-keys";
-- 
2.17.1

