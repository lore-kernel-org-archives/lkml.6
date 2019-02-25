Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C37C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CFF2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msu5Jz53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfBYSSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:18:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39717 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfBYSSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:18:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id m11so7609922lfc.6;
        Mon, 25 Feb 2019 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuLtRds5HE+bHbqnX7XDugI3ERBiXhhEf8bbIMwPhxw=;
        b=msu5Jz53axWS5i5KQjekswN46GbUFtc8LWUqXq3tL3MLLT3XSTJeUX0SlaqimYF1OJ
         5jTPAz2nGntw7ejU5YYBfdSCri2PFrVwre3AYZD3R4hbuTlGiYVku/bi6h0hTKhUHfyL
         8y0JHT2iM5uA8x+N+izBR/u26dOWastzFIkC97ufst3kYqqXwiI2dAwxLXv5sg9Zpcz8
         IRoajZ1lov3IybXFjDosNrHtik1sYJfzAbg2gDutbnBbFp6CljfAVYOTDdPysIF6/6GV
         fcj9C+t4Gs/9CgJ+9sQ2uxwHAl4ys8t6VKPGSLzYJp4XkdfQZYsbPpklcxOp3gLsOdmL
         QaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuLtRds5HE+bHbqnX7XDugI3ERBiXhhEf8bbIMwPhxw=;
        b=sRm7SkpC+rBPPd0943ELfFjJXZ1veRFDQi8U0kAGMKquPbjE5I87eW1n/ysPVSy2H3
         WpQ2zBZgZ1LGe0q4+i/QpzrNnLQ8oco5ZZqJnPj6/mp3AAioNfqFusUTwvi3Hxbp/y8E
         182tBZ3T+/YblSEyAQ4rI4MQdcR0j2i7YRFWqQxSOijRZJV8q1xv9AY9v8JQOgNug8J+
         Qex1fPKqI7sBf3szBWV/dk49umcq2wwSXKg89PkVaPjXQ0ZX8iz2bHJCzvYAlThraRpr
         fPoUycAuKrhQ8pDGTucmhJSNQeF7G+qWPPXpDuxW/lLjG7Fw1cq01fEX2VM7qsW6guld
         vFBQ==
X-Gm-Message-State: AHQUAuZpLpEve39nvwIS9dApIZUAJ6Rnvs3RysSqS0Cv8OgtAhmpmdj9
        8xc7vstJIBmBBR0+50QsRChZuGCI
X-Google-Smtp-Source: AHgI3Ibk1fq1DB/sMlDWKPlK9gBSQfji9HiDDC6yQozML5dyZ6uh4pWM2ldyJUFMYmCyyAIZEv79ug==
X-Received: by 2002:a19:f704:: with SMTP id z4mr11146415lfe.10.1551118686422;
        Mon, 25 Feb 2019 10:18:06 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id b14sm2401053lji.25.2019.02.25.10.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 10:18:05 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2] iio: chemical: sps30: fix attribute kernel version
Date:   Mon, 25 Feb 2019 19:17:40 +0100
Message-Id: <20190225181740.13033-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.22 have never existed and this change was actually added to 5.0
hence fix the numbering.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
v2:
 * this is targeting 5.0 hence fix the version

 Documentation/ABI/testing/sysfs-bus-iio-sps30 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
index 143df8e89d08..bef52f3e47bc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-sps30
+++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
@@ -1,6 +1,6 @@
 What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
 Date:		December 2018
-KernelVersion:	4.22
+KernelVersion:	5.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Writing 1 starts sensor self cleaning. Internal fan accelerates
--
2.20.1

