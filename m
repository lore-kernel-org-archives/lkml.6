Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C48820836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNX2g0Cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfBUT61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:58:27 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:32848 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:58:27 -0500
Received: by mail-qt1-f202.google.com with SMTP id k5so27699372qte.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 11:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=N4x8bK1gHEnm96DktQSQVLadV2FNKbQewRMx2PPKc8k=;
        b=qNX2g0CgxYDjeaiByVmK4olPqY+/JLb4yR/xlgyLkBTnRnpXTjY/Sw6HmHv0ClYTL5
         c2W2wQZ2Thh++ZA3v1WK4LIjM3WlH1ICT8LZwR6MA9vHjT3vuWdW70LryWfsfN9nqBqV
         vaZSMfUEAc84RlDBvhy2jBZTQbqAQNGAThoo1RdLxsUY/KaRN5aOAEi/CHQiaCozj++d
         9tO5MKaIREa55ynwkMtqEA0htaihyv/cafyoABEyEr5nniwJOAqaZuaKhSAAmpKWUVA6
         m/zTJGo4+E5pBM4Qqy5n1FEDlY4SNj1zi20ecVUVctB2MEqS1LVr12m5bUfrDI+c9IG6
         M0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=N4x8bK1gHEnm96DktQSQVLadV2FNKbQewRMx2PPKc8k=;
        b=FVvDNlMP0f1anl6Tkt8zLdCj+toWfzYEDtaZ/aolkAR5HKmqVl4hp+76LubPBjIKBj
         sgcTxsXxn4Hh23/Y8z4/FRyeUmQ8atU+eFehcBIO0kcLZxeJvEdfiQZJzHrPyHAIWgKk
         8f31GaEWNnZ0RwPW2s65Jl7iFdnue9BImNSXnNf4QTP+LKHo6bXeUgNHTw57jt6vghrN
         ieP1j3A+ZGRTspAtkAFZMeDxPZ/4a/QiYDtfCP2b/E0nCDqI6oFQ844hiTAnWOye1TwX
         6Mvxi48RjlBIWrDerKBbTbGf2Il0t9HhWfai1frXRYSYmFsuZIaxZ/3rfQ5G+FVrwOf5
         m6kQ==
X-Gm-Message-State: AHQUAuaXdnGj1P1EH+B65+lLoSRx02EMa9v1YCvOfeslbmNTbYEAuI1P
        HKFFQtN7Yleevvbdj01bsrUdNG+5EA==
X-Google-Smtp-Source: AHgI3IbZWt0GXspXGhAVnO/MyjsPI4EiI+BaIkBl7kXEuBLAp30wN6wW5yYwFYvdhJFQ/uYJajXk5PrdaQ==
X-Received: by 2002:a37:480b:: with SMTP id v11mr176482qka.12.1550779106038;
 Thu, 21 Feb 2019 11:58:26 -0800 (PST)
Date:   Thu, 21 Feb 2019 20:58:16 +0100
Message-Id: <20190221195816.136157-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH net] MAINTAINERS: mark CAIF as orphan
From:   Jann Horn <jannh@google.com>
To:     "David S. Miller" <davem@davemloft.net>, jannh@google.com
Cc:     netdev@vger.kernel.org,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        abi.dmitryt@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The listed address for the CAIF maintainer bounces with
"553 5.3.0 <dmitry.tarnyagin@lockless.no>... No such user here", and the
only existing email address of the maintainer in git history hasn't
responded in a week.
Therefore, remove the listed maintainer and mark CAIF as orphan.

Signed-off-by: Jann Horn <jannh@google.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4ad838..98457a87b238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3390,9 +3390,8 @@ F:	Documentation/media/v4l-drivers/cafe_ccic*
 F:	drivers/media/platform/marvell-ccic/
 
 CAIF NETWORK LAYER
-M:	Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	Documentation/networking/caif/
 F:	drivers/net/caif/
 F:	include/uapi/linux/caif/
-- 
2.21.0.rc0.258.g878e2cd30e-goog

