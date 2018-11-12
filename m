Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC31C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DAC224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpAYPtBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DAC224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeKMJOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:14:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37446 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeKMJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:14:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so9660013wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=UtKKgibYbN9+8xoPeGbKs+nomifQiQH74EyGSmoPWEA=;
        b=FpAYPtBgzdKv83nz0caDip3svy+rjI8JJw9FCB2yM4qWtpvFG2fncRHmIfC961s2Yw
         SMTbF88blroJfbuyXVXpudflFCbNfIrXTI9bnlXYiL7Hy/4+bEpMt3l5e4YeHxdPjejC
         0EpbyaHvmQ0LLD0SlyYutDnp3mY03m81eRcmBrrbLXKZ49tPqKxtVzyG7H8qa6/bhcjc
         gaepJDeJ5kAkoLzMFJtDKWuIO44UN0UEPOUQDRb9CdUd+CGlW3I7pOluIHgOU6BIlR0J
         j9mFlSi4P15fNhXLkzcvocK1yleqsizlBgPWsYEFpq1Vd0uJz+ywDwuKxcZU3L8i+fb2
         1qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UtKKgibYbN9+8xoPeGbKs+nomifQiQH74EyGSmoPWEA=;
        b=ptW2kgkGmY2mLtN2JybWbaBQLm6rf29TXwfSrPwqjZpEI71AfPjrmg7xjRMth60lpj
         1ph8W2QDkU8kY7RticoBxYhHzJnxeY9iHuFCoPMil/5IX4DVrQakbduUWtwoDXC4vIbq
         CK9TNDVOCwTWikcXXFA3/8HMVO0HTqRhTRQo0zFFAS+uyUlos3YDcgE3dYfEAMm7MziJ
         Wvmqzp1gXjiT5HB9EB717iFzSZZAFJe06mOwzpv3ZjyDcYJmLp7A8EotWXMfrzzbl8JK
         eZ7fn6tNqdqT68xhM6Y2U+iHP0I58o6Rn9qT5fUCNrej+Eu2+5BGPlGXqfi26biyrLON
         DUow==
X-Gm-Message-State: AGRZ1gLxPRn4Vn653hcgEH6CpBaIFvh4bdsouAe/Z7GXiz5YhG3gVMJm
        wDqCRMlF5943yR2V4w7efvg=
X-Google-Smtp-Source: AJdET5cJosHjHUstTR90BRPeLLzsUjcjk7FwNkYNuAB9kSYVliD193yQlQGJWzL9zUt9ClxfAh3ojQ==
X-Received: by 2002:a1c:1d12:: with SMTP id d18-v6mr1229856wmd.31.1542064741288;
        Mon, 12 Nov 2018 15:19:01 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id n131-v6sm18708843wmd.7.2018.11.12.15.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 15:19:00 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: rtlwifi: Add new line to stay in 80 characters
Date:   Tue, 13 Nov 2018 00:18:56 +0100
Message-Id: <1542064736-27655-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter is sent to next line to stay in 80
characters

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/rtlwifi/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
index ca37f75..a990281 100644
--- a/drivers/staging/rtlwifi/core.c
+++ b/drivers/staging/rtlwifi/core.c
@@ -1882,7 +1882,8 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 				return true;
 			default:
 				WARN_ONCE(true,
-					  "rtlwifi: %s(): Unknown CMD!!\n", __func__);
+					  "rtlwifi: %s(): Unknown CMD!!\n",
+					  __func__);
 				break;
 			}
 		}
-- 
2.7.4

