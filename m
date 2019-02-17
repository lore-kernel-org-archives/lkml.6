Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A111C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F7021773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SG0l6A6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfBQWTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:19:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35540 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfBQWTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:19:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so7733932plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 14:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ehJ5l7zl5GcH3pulBWL6yMGSbcSlnXfgoJd7ExWqT38=;
        b=SG0l6A6P/hPKBrUCZmQ1cNdv/oQgJqyPC46MdB+dLeXVy0s60tcGq/qq58OX288Wpc
         zNmUYEoslb6O6Sb3aWmN2o6CX0WUdri2hF/xwSeT+Kug0bcMASTEps46yQ4ivHbyDEke
         61qJrupamV64Y4n0Lk345Nyf5U7y44j+civJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ehJ5l7zl5GcH3pulBWL6yMGSbcSlnXfgoJd7ExWqT38=;
        b=sumhPJm+32/oy/VmkKIQfXGJQCg50XuUkwGhRxlS0i4+vyh5UZB8iYWVgtQSXdUMpD
         +YQCvfGSB9zg4dEwgflycc8L5F40CL3K+yB2tjLFymuWJyImUmZXVD4jyVHx1shZuvA9
         lhSpyxvKk9OPxVaLm5uZ8w5Q2+vU0qdIV83dZOLdm/VKQPTQMpQw8on6E4y4C+J1z+bN
         QaY9TpBkbKE3TV8HnL3vwpCiWgBneU4TbAtXYnxOmfCYXIdchiDd/9ravGqA00A+gAEe
         myNqsFdW6Q3mVwUfOLzBJnKzUECRUcQ2jXT0a3B89o2pjaaA+K+Panm+hfjWcXsLt/4I
         ftQA==
X-Gm-Message-State: AHQUAubzinWi4HbaWtXEc7RKUGeTvOVqZqKC8z/aeTXxcJ1mn09OefRX
        3Vo8XSUrQUB0TzcEfhGz5UIqQQ==
X-Google-Smtp-Source: AHgI3IZHgxNUIg/i9IZSRczYFFgfpXkJy1F7TJw0LzZ6blHPsBl8PYxJW4ZPTBdZf1yNq6jlczN/yg==
X-Received: by 2002:a17:902:8f98:: with SMTP id z24mr21577540plo.40.1550441943714;
        Sun, 17 Feb 2019 14:19:03 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 64sm18521293pfe.143.2019.02.17.14.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 14:19:02 -0800 (PST)
Date:   Sun, 17 Feb 2019 14:19:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     efremov <efremov@ispras.ru>, James Morris <jmorris@namei.org>,
        linux-doc@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] doc: security: Add kern-doc for lsm_hooks.h
Message-ID: <20190217221901.GA41920@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of kern-doc for the LSM internals, but it wasn't visible
in the HTML output. This exposes some formatting flaws in lsm_hooks.h
that will be fixed in a later series of patches.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/security/LSM.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/LSM.rst b/Documentation/security/LSM.rst
index 8b9ee597e9d0..31d92bc5fdd2 100644
--- a/Documentation/security/LSM.rst
+++ b/Documentation/security/LSM.rst
@@ -11,4 +11,7 @@ that end users and distros can make a more informed decision about which
 LSMs suit their requirements.
 
 For extensive documentation on the available LSM hook interfaces, please
-see ``include/linux/lsm_hooks.h``.
+see ``include/linux/lsm_hooks.h`` and associated structures:
+
+.. kernel-doc:: include/linux/lsm_hooks.h
+   :internal:
-- 
2.17.1


-- 
Kees Cook
