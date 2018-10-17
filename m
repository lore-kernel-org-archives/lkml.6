Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E27FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D1F2147E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1OqtJYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D1F2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeJQICo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:02:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43659 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:02:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id 12-v6so15368083qkj.10;
        Tue, 16 Oct 2018 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Rk/ypljEkW1Kxbdg+0tIBavPRfEkfxYVRHQuJ41aF3s=;
        b=t1OqtJYcXFA6LqjDddeMT4zKkFkpfwzkkvbwyQ6J1ypLUqyOHK51xPjP3Lkv7hxnEP
         Oay3FStrJdAO4vFp+0OvHjcN7J43YW7EUiOM48tFLhXCSzEW8VoaQSoD4WKuBbZ/cX6+
         Ti3nN/C/VR21IgEV4pfpf2qrfuC4BBSprmzWLMCeWYwcQ3YQ/IQJAqFfbefB2sK3UmzP
         A9jBrcIYRgJGBeKCzRTCDG1NvStrUmlcyvc30TOwjh51C2Jyi0UWN2qlMMdxyqbfDjit
         0y7yYUfKHWX0wzbV7VVQwyMbRCdYweGADjzw0v4yxSyv7mHqzSpC3DmCrRO3Tb0m+ZFX
         C78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Rk/ypljEkW1Kxbdg+0tIBavPRfEkfxYVRHQuJ41aF3s=;
        b=EtvKDDueDexHPaRyasnSIeOh9iVUwu3OjagyOd77d2XoIGLSxXxF9y5HxAHQ06MMMh
         iy1qBfkn7YUWRkJJOhEc/9dRl2ntBEjOyuSxgDJ2n/yRCu75ZMpvwNPPwnkIPnmohMPk
         zph8lD0IU658s2Z2QddVePBrSqBjjW8CqRgBLyTBaLLP16PUnHMs1boCD77j7JLw0/fc
         X7Hi/EJ0o+cY8qkaHnqzypGTaYvqr5emXfpV1j41Z5C66ZqVEPlH56q5HUsje5Nian6D
         sABltB8OeuvkV2kPOe5F17X8KMxnvodohoxvB36tiXqDDIM0St6PHjZLbSFx9xdJnCwP
         NfGQ==
X-Gm-Message-State: ABuFfog+JOr5eRmsvty8kBZRiLu4mhP/S0UbjEvg8WMKZSozAbJJ2K4w
        XDCMSlri/KbMrtma9fHbnCk=
X-Google-Smtp-Source: ACcGV63cEACIKB7l583zFxXY5FKQwHFhD0T+RmE9SLRSmNIrF1ZFDk6LTjn2se0MlkoQc+X7I3vq8A==
X-Received: by 2002:a37:b042:: with SMTP id z63-v6mr22028105qke.94.1539734989116;
        Tue, 16 Oct 2018 17:09:49 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id j41-v6sm11694149qta.43.2018.10.16.17.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:09:48 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:09:43 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 4/4] Changes macro usage to avoid shadowing a variable.
Message-ID: <20181017000943.GA21382@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the usage of DEF_FIELD_ADDR in this function to create a
reference and operate over it using an aux variable.
It also changes the loop logic used to find duplicates, to avoid
creating another variable.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 scripts/mod/file2alias.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7be43697ff84..9ea1db2aefdb 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -641,25 +641,27 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 	unsigned int i;
 
 	device_id_check(mod->name, "pnp", size, id_size, symval);
+	DEF_FIELD_ADDR(symval, pnp_card_device_id, devs);
+	typeof(devs) devs_last;
 
 	for (i = 0; i < count; i++) {
 		unsigned int j;
-		DEF_FIELD_ADDR(symval + i*id_size, pnp_card_device_id, devs);
+		devs_last = devs + i * id_size;
 
 		for (j = 0; j < PNP_MAX_DEVICES; j++) {
-			const char *id = (char *)(*devs)[j].id;
-			int i2, j2;
+			const char *id = (char *)(*devs_last)[j].id;
+			int j2;
 			int dup = 0;
 
 			if (!id[0])
 				break;
 
 			/* find duplicate, already added value */
-			for (i2 = 0; i2 < i && !dup; i2++) {
-				DEF_FIELD_ADDR(symval + i2*id_size, pnp_card_device_id, devs);
+			while ((devs_last -= id_size) >= devs) {
 
 				for (j2 = 0; j2 < PNP_MAX_DEVICES; j2++) {
-					const char *id2 = (char *)(*devs)[j2].id;
+					const char *id2 =
+						(char *)(*devs_last)[j2].id;
 
 					if (!id2[0])
 						break;
-- 
2.19.1

