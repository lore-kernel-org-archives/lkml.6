Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F70C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uv6f8cOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E29320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbeHAJoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:44:07 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:39700 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbeHAJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:44:07 -0400
Received: by mail-pl0-f42.google.com with SMTP id m1-v6so8398240plt.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIzV6aso3cBbRwIPS8DL9LqPtHHeWZam6wO8uhZIhTo=;
        b=Uv6f8cOuilyrUsJMwLSlGkRsQmaIQ1ADH2CRLyaqS1MpDoCDg9EIg/Yyi8CKwZN531
         Pg27JoHeDbf/rAIG+ng9/UAhO78LOa0MbUIO9GrNUNlODrSUcS5Q48gdezcN/n5aBrfv
         +/r0CXt9deoc5LYcWq5DhwNbdofl3xb/8IY+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIzV6aso3cBbRwIPS8DL9LqPtHHeWZam6wO8uhZIhTo=;
        b=bDeYDD3TJZR098e7yKlaJyJYP2Z9zhjeeoyj9Ei32nDyyzhChuJdyL5DkQcvn0Q40L
         XKfdg0Pgud2+hOyv/U+fEMSTDwXfHJy37p5+uYfvYHJGS+6uk86qY2/3zTiXk/yw5Jjd
         2DDcqkN6D0/KGn4dSvI3xu3bDKhtS4/qpAUgK268fTVtn03orp6IWsQVBE4pnzeWtj50
         oLCgeP5BtIzydAg1oCNtJg9VsG4GaJDkyBwTfDBFVh03CqW9JQU18waXKH8IZydYbBqK
         JxZsfkdk+j3yJrmLgvLrIAizjCj5U4Khns5mQwQEBhvOIGwOxnM1Nnnl1x5xtOOhsWd3
         fK2A==
X-Gm-Message-State: AOUpUlGL/TEeVn//g0PXjJWFYx6HFXIfTYqrrGv3eoC2GuYDGow5Cn2M
        MWQOFnftR/8TBgV1fRBJe2Ng9g==
X-Google-Smtp-Source: AAOMgpdCoqC3WH5zP0l3/qAhWJAeT4udXTWZ1D4XtyoLYSRRcAjuK0Li0jr7sPr18Th8I29AYe3RUg==
X-Received: by 2002:a17:902:5617:: with SMTP id h23-v6mr23475174pli.324.1533110381241;
        Wed, 01 Aug 2018 00:59:41 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r11-v6sm23617948pgn.62.2018.08.01.00.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 00:59:40 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v13 02/16] kexec_file: make kexec_image_post_load_cleanup_default() global
Date:   Wed,  1 Aug 2018 16:58:06 +0900
Message-Id: <20180801075820.3753-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change this function from static to global so that arm64 can implement
its own arch_kimage_file_post_load_cleanup() later using
kexec_image_post_load_cleanup_default().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e4e638fb505..49ab758f4d91 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -143,6 +143,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c6a3b6851372..63c7ce1c0c3e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -78,7 +78,7 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image)
 	return kexec_image_load_default(image);
 }
 
-static int kexec_image_post_load_cleanup_default(struct kimage *image)
+int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
 		return 0;
-- 
2.18.0

