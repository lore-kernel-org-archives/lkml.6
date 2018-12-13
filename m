Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD60D20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usMNei7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD60D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeLMSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:01:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35416 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeLMSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:01:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so1483881pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfztylOV0k5Rj79YOKzZ8VdvRVm49wDfHbQ5r2xL8Yc=;
        b=usMNei7JhqGbhh03xwsc5PT/UoqpiO6i+Lu2TyOK+kIhwETvDLM/XADhJusl9NwKNz
         1RfcUYqfMGYdvqVDp1g/XqBwbeU//+m6wpFNE8iqdd91jKZ6+Pml8HwC7f2j1MZfghVh
         mh3MTkfI/C9YMMdGURwS+06V/SqsBiTN3U4McuunQFPJifY0c01FDSRoNEq6QVSjSyOk
         I1z5L//KziwqdK5m/aT6CxYE+beQLAHejAXsBBrT4zTmAs14chQ2jFSFVKYDt/Ek4iNU
         k2wjmILC2haEX1vIfPUpjyE2VuZ/gCcg6uHR5kDGo+ATzvCCE7O3dzZq7Z+7OklSGgMS
         e0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfztylOV0k5Rj79YOKzZ8VdvRVm49wDfHbQ5r2xL8Yc=;
        b=j9iFQkRNvAYZph+nDEZk4SKxU5fBevpEayOCQwY3E2S+clkOWV86Fpx7+x4CnoXeo+
         J5m/m/pOHssZSj33OpooKewnhVqck0vFQLzBFhKjdyN5lPIqG06+1b1+lQ4CG84yjqip
         PL1FotvoASAOtr6zggIckf+8P0bEtSoQ+iY2YUijtpNH5ehjMHP/EeuTSuG6M6RSW5oL
         gYSj2lW1moEQ3CKEpjX7mVw6kk+8vKV6vU7z+A5Ni+NKjpX8udS12X6LR1sP635v/boS
         mH4+t4APnUAZISoDknVD1qybHhNcLxKEjypBmyqL2FpHvAsQXq02Aknck7u3Q01POUCP
         +AsQ==
X-Gm-Message-State: AA+aEWZJguP3ULF8SdvmwIMwqThxPHDOjLuAmQSUj3J8Lrj/8eOPe7fK
        mIewPAyCNwv0l3o5cl/R4IdLODHqRBU=
X-Google-Smtp-Source: AFSGD/XDhw7ueLFs7oZiOGFiMlDFIDdcWC7mTLFDpIm3VaczHxqYiOP7y1mbVvftZ2jLuO6XdER8OA==
X-Received: by 2002:a62:5486:: with SMTP id i128mr24366388pfb.215.1544724103105;
        Thu, 13 Dec 2018 10:01:43 -0800 (PST)
Received: from localhost.localdomain ([2601:646:877f:9499::6872])
        by smtp.gmail.com with ESMTPSA id 196sm10929734pfc.77.2018.12.13.10.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 10:01:42 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] include linux/stddef.h in swab.h uapi header
Date:   Thu, 13 Dec 2018 10:01:29 -0800
Message-Id: <20181213180129.1373-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swab.h uses __always_inline without including the header where it is
defined, this is exposed by musl based distributions where this macro is
not defined by system C library headers unlike glibc where it is defined
in sys/cdefs.h and that header gets pulled in indirectly via

features.h -> sys/cdefs.h

and features.h gets pulled in a lot of headers. Therefore it may work in
cases where features.h is includes but not otherwise.

Adding linux/stddef.h here ensures that __always_inline is always
defined independent of which C library is used in userspace

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/uapi/linux/swab.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 23cd84868cc3..acddbe50a20d 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_SWAB_H
 
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <linux/compiler.h>
 #include <asm/swab.h>
 
-- 
2.20.0

