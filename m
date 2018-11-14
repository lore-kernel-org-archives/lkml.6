Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC542C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8365A2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+0Oqo0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8365A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbeKNXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:20:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35398 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeKNXUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:20:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so351419wrb.2;
        Wed, 14 Nov 2018 05:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=luGH8fFlOje6y8ZeQbgrxuGMpHoEwVHKefdy8/mTLqA=;
        b=H+0Oqo0gv1dTrwzsm/iT4WN7jLKctDCxerE0TUZ83L0XDKCKTMme7hw8yRuB8lB0t0
         Z37izRJBoUcgQ8Lfk+eRoUhRoADZ8NdxlyZpcd3J3DSqUnV+C93n1zvuSWB3g4gxTWdV
         IB7/fI/n4mAAI0lunCdIWo48f3HsyY8e9XuBDemitKsCwhKslbCqHr5D6K7+zJJ3o0HZ
         NIAXDCgcXiYbh1FAURuD22jKJTnCtYgQ2CW+EpdOt3f2+NK4AJR6U7A94E0c9ddZg/wS
         FJmfK/9HRPgDPmn15uAoA5fVHqi5cCr0ZnFW2k56UmzjinY0QqEz6IbDAXbZ75uV5nl8
         A3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=luGH8fFlOje6y8ZeQbgrxuGMpHoEwVHKefdy8/mTLqA=;
        b=ZeeNt9uhuYYQCK5sc73Mg6JsoES0BJXxDraJ1waEp59CBA5Zn+NY5LWAm1pY3mb+7j
         L+DbGo3kYpsCBkxVubY1MbW917nRP109YJM5W2MgMMuXecUcAtJwGy9kptV39jXkgrrv
         zqj3BUN6klBvCVX+rjDZIhGeFqSTsrR5CxtYyZvJ1ZTLEIAhfnzEvnWXCQSho3sKRp1i
         lXATDNI+K5dmdMz+VSFd3SR+27l/JdI6mft/4DBpW4y6Q1v5YKStexrLQppvbZdTtzdj
         juJLz6Ehv0jXzzH6A1FwzgdRNyze/2wipI/1NTeD+qFiFI2zmHDsFcobIDyUKXqZB2ZX
         e7bg==
X-Gm-Message-State: AGRZ1gJJmOOPOjgMIyyOM5BA4OV2QhOoeO48XcSdsvKu1EjAaXLH9fSB
        A2d/pQznsphsDRtcQk3F3zF72C/v
X-Google-Smtp-Source: AJdET5fEn8ZI/kdPlYl47ID3NCX98kZbPcCGKWXo2ko0O4WG5GQ4VzndajVoUo4ebI+KqCuHTLg0GA==
X-Received: by 2002:adf:ba8b:: with SMTP id p11-v6mr1777935wrg.203.1542201408666;
        Wed, 14 Nov 2018 05:16:48 -0800 (PST)
Received: from david-x1.fritz.box (p200300C2A7086500829F3F8E4928CB10.dip0.t-ipconnect.de. [2003:c2:a708:6500:829f:3f8e:4928:cb10])
        by smtp.gmail.com with ESMTPSA id s1sm8818931wro.9.2018.11.14.05.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 05:16:47 -0800 (PST)
From:   David Herrmann <dh.herrmann@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com,
        David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date:   Wed, 14 Nov 2018 14:16:42 +0100
Message-Id: <20181114131642.21425-1-dh.herrmann@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 336fd4f5f25157e9e8bd50e898a1bbcd99eaea46.

Please note that `strlcpy()` does *NOT* do what you think it does.
strlcpy() *ALWAYS* reads the full input string, regardless of the
'length' parameter. That is, if the input is not zero-terminated,
strlcpy() will *READ* beyond input boundaries. It does this, because it
always returns the size it *would* copy if the target was big enough,
not the truncated size it actually copied.

The original code was perfectly fine. The hid device is
zero-initialized and the strncpy() functions copied up to n-1
characters. The result is always zero-terminated this way.

This is the third time someone tried to replace strncpy with strlcpy in
this function, and gets it wrong. I now added a comment that should at
least make people reconsider.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index fefedc0b4dc6..0dfdd0ac7120 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -496,12 +496,13 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		goto err_free;
 	}
 
-	len = min(sizeof(hid->name), sizeof(ev->u.create2.name));
-	strlcpy(hid->name, ev->u.create2.name, len);
-	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys));
-	strlcpy(hid->phys, ev->u.create2.phys, len);
-	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq));
-	strlcpy(hid->uniq, ev->u.create2.uniq, len);
+	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
+	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
+	strncpy(hid->name, ev->u.create2.name, len);
+	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
+	strncpy(hid->phys, ev->u.create2.phys, len);
+	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
+	strncpy(hid->uniq, ev->u.create2.uniq, len);
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;
-- 
2.19.1

