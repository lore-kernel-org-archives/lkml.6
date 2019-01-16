Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9301C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AF92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B5sY8+vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbfAPKEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:04:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46635 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfAPKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:04:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so4890810edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 02:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZKkLEF/VMok2kRTXs+eYfoWbJrCcya+Ar38+YsM9Xs=;
        b=B5sY8+vRjIOsZpolFkHUwE2OFZFnHm/zzEn+kjAoLNE5YN+9WAYHEGYvoutYEsHI9v
         MY28K8sYc0R98YxX0mtWdzjTSR+ZhXDJhrshEaeERX416HaGDCRaMWUp2yiMcgtEdbYI
         0VATbgsXkyw65g+yPCahyd6KzyUdkZcei/R2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZKkLEF/VMok2kRTXs+eYfoWbJrCcya+Ar38+YsM9Xs=;
        b=EOqsG736riayM/8FBFq5O+WFsk6161cVi387ZpSkSr1zGEsIOOmikEOz9zGiM+5zjc
         w7y8iu1bz7VwK6G8syXOFIZ8Ir/lvhgoouMnXrwe/OswxRS4WF+g0ciY87cMvJZU61j5
         IuMKfdIm3pAwT1gqH6Rm+7BJ3279IgRUkdE2SxhZtFp5Ft+wi7AYhlUTVmLJyfHZEghj
         bw364ukfiZwdnKBfzSaP6VenIW0stuUlC2DqBwKTHvQzskRc7jVdWW1Rl+0yje+4CZD9
         hNnpnsWAeBWvuQ4YYF+B6TJQZATjDUyvveBqFh5bEOtsPmIlBPGAjcOyAQyShqH28Pxe
         d8jg==
X-Gm-Message-State: AJcUukeVG3TMGh+uyGv/UeXcKvW6B7c/1theryDaxcR/cazu5DTxhAtI
        oeYxmVMkhgRfyBTeV0CaLXOYcuzXdgU=
X-Google-Smtp-Source: ALg8bN767iggfpfrIbwn22glT3TgY2zOnYlFu5Zc/9CPfXRHM2ZG+d2HVldHcYuZ76HgS9PCAlyrzw==
X-Received: by 2002:a50:ce0f:: with SMTP id y15mr6559101edi.207.1547633089556;
        Wed, 16 Jan 2019 02:04:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v11sm5351463edy.49.2019.01.16.02.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:04:48 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Arnaud Patard <arnaud.patard@rtp-net.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging/xgifb: Needs to be converted to a drm driver
Date:   Wed, 16 Jan 2019 11:04:40 +0100
Message-Id: <20190116100440.10071-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev subsystem is closed for new drivers, those need to become
drm ones (which generally results in smaller drivers nowadays, with
the massive amounts of shared infrastructure and helper libraries drm
has).

Although given the lack of progress since 2010, maybe time to ditch it
from staging outright?

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/xgifb/TODO | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/xgifb/TODO b/drivers/staging/xgifb/TODO
index 7eb99140a399..a1e25957bf1b 100644
--- a/drivers/staging/xgifb/TODO
+++ b/drivers/staging/xgifb/TODO
@@ -9,5 +9,8 @@ TODO:
 - remove useless/wrong/unused code...
 - get rid of non-linux related stuff
 
+This needs to become a drm driver, the fbdev subsystem doesn't take new drivers
+anymore.
+
 Please send patches to:
 Arnaud Patard <arnaud.patard@rtp-net.org>
-- 
2.20.1

