Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB56FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6D021929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406075AbfBOM2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:28:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:42431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405454AbfBOM2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:28:15 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Ld0E0-1hKqgF41BI-00iDAT; Fri, 15 Feb 2019 13:28:13 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 1/4] chardev: add additional check for minor range overlap
Date:   Fri, 15 Feb 2019 20:27:11 +0800
Message-Id: <20190215122714.28842-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PuxX26Iwc4DsD6HQypaGn4HHmfiFlbvc+zDkpxeqQf07xuqc4qf
 uTMrJ+1tvt9PxrKXunk85gRqfSqRCnXmZAWhCU/ydtJRBviCy9ejH4bGAB5yzS3WKwR0Ffa
 N4aXZW5bodlbxI+DPXc3UHWBJqS3bUAwrBrZdf8a2CJZ3EF8DKzx7cFbVD8P4T5NSdleHEj
 4Ba6wZ+bPRTu+NmBTa4mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AI/DMhKy2a0=:E7+ZJX6F6prUEy3oG6tclE
 I1xgW+rbUeOiMIIUDz9Q59dlDmRPgYQc/oLJ6YeJaCAPe4czTodEmuQRmQWvg95WUYit0x7Ys
 Y8+yNebFo1vdvKxZyNHFhiQz1KtDSZzUQowOEj/xsIFVdJS537O/RrfoEIqQ/DEEC7d9H/Fh0
 Za+QMpI1UpL5lmkHvud03hS93H1DIl3CljTNpxP/ewkxonHepIEsSggA1kbEi5vJXl+H12/X6
 1s5idcRK9P2fG3bNwVTdyfkS0OX677dHiTtI1zDxbor+BJ1NjDYuz6w8MGlmugTWveJAGZuDj
 /Ig6gbk5wcK1YucSwW9t/OJztdi+Ylz6i/BeO46QencGE4QU8u3jv1a1AWf2f1hm4rayUpxU6
 L9/TH8B+5gD8i8eGDpW74c6D9m/86UMkhOXfOEkUsCFG/yM5HYbqrfNk1vZ/phrlJRmW5ONN0
 ZA4o5RGYYYhlUaanMIY9fCGRDc9qAL8kBEHIf8ooOvS+R8BqbPVcOu6Ofov/X80+mORsPBjjF
 FhyW2AFx+Wc4hSwCHgJrcHwCaKv5RQ0QST1gb8ZsUSXYRr2eeg+1AiJPMimrsFRqqhAHx5eg0
 fq9YfMTToH1Uc9wrMIhq5nLxDYGQ1tue8h2RMEXahYO/gOPdigH3T/+OueVUligDBm4F3WfNw
 KeL/ewcNQ0JIexW16FufVZcAVmh1psE0t4BpJHYQk8jXUK+PUpsaF3xQ6oiyDxl7D/zWKixN3
 +iLAkPPFf3fpd9Va9+f61GYg4puGmzpThBUji0zhBKHNF/JrDotSU3IO+elmfue+C1liDCPPP
 BubiKh1KhuEsDoYuVPwklWqp9Q8UyNWyARR/uWmhoOC4BqKPkBzpqcq8x9MbOXrIx2fAzVCeA
 7BT/mFeF7z6ybs2GZASIBjY01tKonYjZtzizayk8nWVSfLJL+ssJaT1liCKV6j
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current overlap checking cannot correctly handle
a case which is baseminor < existing baseminor &&
baseminor + minorct > existing baseminor + minorct.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

 fs/char_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index a279c58fe360..8a63cfa29005 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -159,6 +159,12 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 			ret = -EBUSY;
 			goto out;
 		}
+
+		if (new_min < old_min && new_max > old_max) {
+			ret = -EBUSY;
+			goto out;
+		}
+
 	}
 
 	cd->next = *cp;
-- 
2.20.1

