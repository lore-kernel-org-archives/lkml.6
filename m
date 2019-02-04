Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBEE2075D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KZ9VDBjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfBDKbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:31:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38872 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBDKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:31:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so10777134ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 02:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywJc4XpkpfOi9C4qsEM+/m2BQ4RqctN1MsjTz+rv818=;
        b=KZ9VDBjIjOpluohU1csjotaUtLOcRwngU8jjcEnZpgNzs8LlBc+U1B+BZj91vTpdna
         +yrbxlHOJohM7mz23QzdZLeZihP0+GP7hV1tgxmuiyv+rvTxrnNLrgCvubAIWW3dUi5j
         mzUDIqMhChUYHP0V0DX1fOhxuTl1K5U7NgPOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywJc4XpkpfOi9C4qsEM+/m2BQ4RqctN1MsjTz+rv818=;
        b=FgCZVlZgGz/gbJGSPphPECn0wOtOnnZemp0HNPLh9CK1bSV1O5e+m1zjshHtxaWDMe
         aZ227aai4NRBdDu+DX5RItRUjJ+6880te0CgBcN1Dg4EpxWYq8dH9wwuWSLT3+8tU5hs
         XfgJk9Ds1JUZx0hw9N/v4WFwIyscfpyVrbploUiyhO6zKGkQ3B5x8PzSwORXFkFxP2sb
         R3y8Cy2/t496CACAhJ/hRzi2ThpvmP4Rtti5YbcPngl8Kct2scffMKfZFRFiH9qnm72d
         wl2D7NlI0BZEzpRpR5Su1RwhtnFmCpfHrU00aE+TicE47DK5pD3aE3FmQ0sfYCb9Y+zz
         aniw==
X-Gm-Message-State: AHQUAuYzUHHeBxn/8bSlYu9cPUg5Hb4cSP7zUSb/rR1hW/8gXPP6DGMx
        8nQ++C6O46jInvlr/4nOT4eDdQ==
X-Google-Smtp-Source: AHgI3IZSCsEYPMODbFbAQqAy+s8DfEmtZJeFCwf8UUfTXfCzGoI2DmuJkO/VaGO3Zq519+nuIGviLA==
X-Received: by 2002:a50:ccdd:: with SMTP id b29mr2724864edj.102.1549276281573;
        Mon, 04 Feb 2019 02:31:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s46sm4253691edd.9.2019.02.04.02.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 02:31:20 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Rafael da Rosa <fdr@pid42.net>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] staging/vboxvideo: Add TODO
Date:   Mon,  4 Feb 2019 11:31:14 +0100
Message-Id: <20190204103114.30772-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed why wonder what vboxvideo is using the ->master_set/drop hooks
for.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Rafael da Rosa <fdr@pid42.net>
Cc: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/vboxvideo/TODO | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/vboxvideo/TODO b/drivers/staging/vboxvideo/TODO
index 2e0f99c3f10c..2953e7f794fb 100644
--- a/drivers/staging/vboxvideo/TODO
+++ b/drivers/staging/vboxvideo/TODO
@@ -1,5 +1,7 @@
 TODO:
 -Get a full review from the drm-maintainers on dri-devel done on this driver
+-Drop all the logic around initial_mode_queried/master_set&_drop and everything
+related to this. kms clients can handle hotplugs.
 -Extend this TODO with the results of that review
 
 Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
-- 
2.20.1

