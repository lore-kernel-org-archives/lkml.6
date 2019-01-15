Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C22C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D7D20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QlsNIcFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfAOK2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:28:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41533 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfAOK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:28:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so2102563edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9/TahN1Y+/fxN+tfmX18vYdcQT1mEK6CwM2d9WZuR4=;
        b=QlsNIcFnyRt5MvgqaA+1M13a7shgnxtUbB6yOF+Ouk087NcFJwcU0dE26pMfIJn0lF
         8G7KJkObUjEhRTiysnCzLll8AEPLaYSXhZLy3/gF8SgaLD+bbf6+FV+fKFnS19OlXiWL
         M1r4oDSN7Lcsm/N0VU4YUq4NL9vUkrO0RxDF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9/TahN1Y+/fxN+tfmX18vYdcQT1mEK6CwM2d9WZuR4=;
        b=Q2WkeWJub5UJMchh172vPvsurQCH4CtYrtzjjP5k27yPEAsJ2tKa4vigrZTTxH8Nnc
         JrHqQub/O1IMeZvvkKtc5SrvyArsMWRUrpvZ+38RcFnxb6aWqndtSGpKiCYmz+3A98ib
         rX+/qo8dc1QvNDvPt9id3qu+HNLT7S7q52zVzJokDNeXEEr1nVHCDPz+OvWqZzrgP/At
         5PeW5ClKLN+tXDTqYFWQ8LCHOfCHF1AaP4sovjJpUrvLXwc4dJr2xdy7G2VYN5ZxSNc9
         hf/PaGgjjlTn1aSkNkH+fZRjlCZ3NG744WfRenvhjvUhLZAGDqoPeeJAspNucmxTnLvF
         3jkQ==
X-Gm-Message-State: AJcUukcfojJBwVIfnYR9eQ9NApdRJrVifRzW77dfQeLeiCfm/E7t50it
        LJETJrgE7htREm/dGWudNwoLjt/ecog=
X-Google-Smtp-Source: ALg8bN6b6ByReiXuVM8zNy+GvFOoCJNCkSkY29fVBp+lUWqpLq6pkZ+m8ldISUu1Zm4J6Tjl+CqmeQ==
X-Received: by 2002:a17:906:cb2:: with SMTP id k18-v6mr2568136ejh.129.1547548098404;
        Tue, 15 Jan 2019 02:28:18 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z9sm4597518edr.61.2019.01.15.02.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 02:28:17 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Arnaud Patard <arnaud.patard@rtp-net.org>
Subject: [PATCH 2/2] staging/xgifb: Needs to be converted to a drm driver
Date:   Tue, 15 Jan 2019 11:27:55 +0100
Message-Id: <20190115102755.16183-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
References: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although given the lack of progress since 2010, maybe time to ditch it
from staging outright?

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
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

