Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34FCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E7C20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="KA55Vluh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E7C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeLEXTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:19:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43655 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbeLEXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:19:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so10759047pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASoKZVzfCMHpLOqEwAj7ivsik+7qFwrfw8+fJ3kEFjQ=;
        b=KA55VluhvNiUrHpBHiGYVoqdJ6wU4hTXXm6KHzwyFWi5P31OM7mXpaj5qfw1xFXTjq
         9hSa/LwqJ2WCG1VSempWAhFeQvXhG9r+R9Jj+Ic4z30OBptpx1CwPNb535TVKF5UwvG7
         82GVRPcRhkNgfibj2vP6Te41ZHgfmELZKQR910Vh99Bn61e6D9cnv0Ru9um3Nbr01RZC
         SSg5mxMoA7a2GUhvBNrMMwiwmWGqMaGSxmBBjGfMq5Ym9Vka90ztHlXJYBOJfpjFLFXh
         kR96gZcNPokuWlwvSAA4D5M6asguAtjqwTMb+862+A1QnLdyUhayUmBMxh57+4FZWGEt
         /K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASoKZVzfCMHpLOqEwAj7ivsik+7qFwrfw8+fJ3kEFjQ=;
        b=LGlr15kW8l53q2QdxUz3cR4PdAx2Qozsosut33dxY5NUFbI6flAlTMfyl+3DqpaPMb
         9c03Dg0ib30kok0Oq0jdaJgsjsQj8hG45ZNUZWuaxu23Vcmg36b8UHebOo4vFkXdyu1w
         3eIuYC5/yif+xdVHk4SrAelzY2v+Fv7zXzav3nQFX7IKuUhomsnyzxmjULqiYmCJImVP
         t+er00j0nKSlZo4EYRpL4aJomrDckZaPuGkxCHAeyxetsHFrdhPmvie9lf/VqvnDzPCj
         anIPWxLofPWcWjpJH/QIYqlRJ0gcQB8NFevxp4C8SyOxDWV9ymaR5/qE3XRbx2wKYzuH
         zz/w==
X-Gm-Message-State: AA+aEWbqQm3lMjco3Hut9OrAMJPhc6AjcCWBSzUIiZaTRXx9FoDDr/Ju
        GXrMkfXyqFrTjK/NZbbX1uvMBQ==
X-Google-Smtp-Source: AFSGD/XJiyxV8qwWpfn4omUVt1BQDxGndi6/rEziusn4D6HsUeaF9N2G0vqNdbUOidydrRWgr6DCMA==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr22063494pgo.221.1544051980820;
        Wed, 05 Dec 2018 15:19:40 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id p7sm51442338pfj.72.2018.12.05.15.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:19:40 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com
Subject: [PATCH 2/3] binder: fix kerneldoc header for struct binder_buffer
Date:   Wed,  5 Dec 2018 15:19:25 -0800
Message-Id: <20181205231926.45928-2-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181205231926.45928-1-tkjos@google.com>
References: <20181205231926.45928-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the incomplete kerneldoc header for struct binder_buffer.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: no code change. Removed needless "Change-Id:"
There is no dependancy on patch 1/3

 drivers/android/binder_alloc.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index fb3238c74c8a8..c0aadbbf7f193 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -30,16 +30,16 @@ struct binder_transaction;
  * struct binder_buffer - buffer used for binder transactions
  * @entry:              entry alloc->buffers
  * @rb_node:            node for allocated_buffers/free_buffers rb trees
- * @free:               true if buffer is free
- * @allow_user_free:    describe the second member of struct blah,
- * @async_transaction:  describe the second member of struct blah,
- * @debug_id:           describe the second member of struct blah,
- * @transaction:        describe the second member of struct blah,
- * @target_node:        describe the second member of struct blah,
- * @data_size:          describe the second member of struct blah,
- * @offsets_size:       describe the second member of struct blah,
- * @extra_buffers_size: describe the second member of struct blah,
- * @data:i              describe the second member of struct blah,
+ * @free:               %true if buffer is free
+ * @allow_user_free:    %true if user is allowed to free buffer
+ * @async_transaction:  %true if buffer is in use for an async txn
+ * @debug_id:           unique ID for debugging
+ * @transaction:        pointer to associated struct binder_transaction
+ * @target_node:        struct binder_node associated with this buffer
+ * @data_size:          size of @transaction data
+ * @offsets_size:       size of array of offsets
+ * @extra_buffers_size: size of space for other objects (like sg lists)
+ * @data:               pointer to base of buffer space
  *
  * Bookkeeping structure for binder transaction buffers
  */
-- 
2.20.0.rc1.387.gf8505762e3-goog

