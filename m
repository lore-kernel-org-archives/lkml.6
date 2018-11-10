Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D27C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5020840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av8JrgZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE5020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeKKDkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:40:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39833 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeKKDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:40:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so4604948wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 09:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K26d16y4h41njjgY2i2jONZ6r0g0i04wrzMp+kXsn1U=;
        b=Av8JrgZ/vhULkx8aR7fK51yHXRqqyB1LTwG5xAmmcQ7fT2IyJwvOBPK+JDfSzJBqKO
         47UIqUnofyxUqcwEb/q4/odBeCnMMlGfo4BmxJtCiqCHEuVICpGJxVUipSL+7HhrbV7L
         PB9Hd/b+s+QDwa2vgALxTKu1Uz/KMU2zNkzlelz3/xKn8TiwjNj1tM1+gSgW2DcUIN4B
         yGp6iERnF4MtjRdDh2M3jIKMipAO+J9q1FLjkFAeCvq1RIvX7DM+jQfiogqE8aCyvk1O
         JF3Rj+e8rQKx/aB7oOLFPq3Mv5dbDvmv8jnObf2gSiKLDkRtI6gxc0LNtH2f5/eYqgWI
         8E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K26d16y4h41njjgY2i2jONZ6r0g0i04wrzMp+kXsn1U=;
        b=I7SzzJKH9NtTH+iEgPe4li6589yPV3u5YwHHtcXt3pVlD5lCr4a5v+m/lufFlW05oW
         QNLpM4GgnSjkazrbSyBAh5UtK1sqi1nlYYsBxOj6kVj/bU90LqPSdtwn+WiC3h1+NN5Z
         Xklz29cFh/uHTJLoCt62bAuCt/IBi53Gl5JR6fBSb+8XUcRnBqE8a4BjMruHQEQHB0Fs
         XCiGH5j/CGh8/WHbKFD52wgUjofnDTH4PRV3j2OYnItBlS6Zb4ckW4Eqz46uYt54GXf4
         VVkF5ZMSzFlCczI9DHxKVxBjA+umvlO4hyCMmurjk6/WvGD7NpMkm8fd8syq5eTtrs0c
         jbkA==
X-Gm-Message-State: AGRZ1gIQYAAGOF8FbaRtoTxDqc8E0YIMHaXzj+YVZlrLYwyjbtqJpXLU
        J39Qgqexxom4wgEi0M6xo/A=
X-Google-Smtp-Source: AJdET5fky/gfGTnT+KX/jqazJgNpuHAN2cO5XaDQ+4iMTx88Luz2ab6yQBrpg5NVasPn3FMoKFdSGQ==
X-Received: by 2002:a1c:d948:: with SMTP id q69-v6mr2932655wmg.134.1541872499074;
        Sat, 10 Nov 2018 09:54:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id y81-v6sm1446407wmd.11.2018.11.10.09.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 09:54:58 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: add spaces around '*' in recv_linux.c
Date:   Sat, 10 Nov 2018 18:54:45 +0100
Message-Id: <20181110175446.16224-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110175446.16224-1-straube.linux@gmail.com>
References: <20181110175446.16224-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '*' to conform with kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index 764d33c4e839..0d253a84904d 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -38,7 +38,7 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 	} else {
 		cur_time = jiffies;
 
-		if (cur_time - psecuritypriv->last_mic_err_time < 60*HZ) {
+		if (cur_time - psecuritypriv->last_mic_err_time < 60 * HZ) {
 			psecuritypriv->btkip_countermeasure = true;
 			psecuritypriv->last_mic_err_time = 0;
 			psecuritypriv->btkip_countermeasure_time = cur_time;
-- 
2.19.1

