Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9EDECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0CD213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZEJ7n4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0CD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJRGtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:49:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43270 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeJRGtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:49:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id 12-v6so17612680qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NJP8RhddxlkHggwBq8RsEee/mt9L5b6ytDUn2e0NUFw=;
        b=HZEJ7n4kYtfYXZg/pgn3Bvl7rx3wLTLDioBINug9pfCv6ukMtqg61erXXy8OWjfUgf
         NF773YeJf7SRXwffR73smlndktdv1qWUqFwXw4AZx43Z/IFhNohGuVsnqVxq5xu/wJFp
         6G0c/PptlH0uUa2c10fyMLuzS2LMKEcE4r94X4jzrMfDHYODclMzi/yGyxpq7lgM3fmW
         aLcSV0Mwdt1UBfCC2GOP3RP3rP1nMUmIcxCgD7YErebrRg9lLmmdSRkrj4Gshvz/Epls
         ZyQOF/HH2HYqDJH3D9FDhOTa0HixNsw9+77XptKhcaw6qXYMBmLniqQvSBREFRvxfPNb
         gtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NJP8RhddxlkHggwBq8RsEee/mt9L5b6ytDUn2e0NUFw=;
        b=cHLbKZQClkUaMuObSollJejD4US0Mmu36AmleKOuynjQ7w4TSjOFO+xzPkMQaiICYH
         SRyCzZP3CclgSrQ+fdTMRMsx/Py8d+pxyYF8KJrIgk+J8OPyGGjUHDSiSfVGNN2trJib
         CRRH28YKSln2/sgK/asDYVD7G/MmQmWsW9/iIxehuY34MjKddyQgQv26ncPcoeWn4+o8
         njmwzbr20Sgw3naLz9QZYOk8UA2xv+4EiD+sE85VW3/Oz9gRjjr5KN1KBr+N7fIskAQi
         OJR+Pe61qYpwCjK13tZuAaHcthrtHDHdLV9W6m2t9ThWBW+j7GfJTH9BecVnnuj+32qg
         I28g==
X-Gm-Message-State: ABuFfojKxUL7b3Z95on00r1BYdZ2zAxM/QulguaySilFp6hF/dB83pAd
        nlDgah2FSf3Qj2MD7zG7l2g=
X-Google-Smtp-Source: ACcGV62rRpsmsnHWd41LYQioXuaVwt6h/I9HEkgB4s592yFTVJigTWFu3SxSX7YcCoGKd656KwazDA==
X-Received: by 2002:a37:7907:: with SMTP id u7-v6mr25780036qkc.283.1539816691417;
        Wed, 17 Oct 2018 15:51:31 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g39-v6sm13398150qtc.89.2018.10.17.15.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 15:51:30 -0700 (PDT)
Date:   Wed, 17 Oct 2018 19:51:26 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add entry for VKMS
Message-ID: <20181017225126.o7le4sczgfol62mq@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers and reviewers for VKMS driver

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39c3f6682ace..78c3c0bf89fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4592,6 +4592,16 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Supported
 F:	drivers/gpu/drm/pl111/
 
+DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
+M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
+R:	Haneen Mohammed <hamohammed.sa@gmail.com>
+R:	Daniel Vetter <daniel@ffwll.ch>
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+S:	Maintained
+L:	dri-devel@lists.freedesktop.org
+F:	drivers/gpu/drm/vkms/
+F:	Documentation/gpu/vkms.rst
+
 DRM DRIVER FOR ARM VERSATILE TFT PANELS
 M:	Linus Walleij <linus.walleij@linaro.org>
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-- 
2.19.1

