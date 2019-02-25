Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C8620663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfBYOEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:04:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:35211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfBYOEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:04:34 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7pDs-1hBFJI39No-00vPax; Mon, 25
 Feb 2019 15:04:32 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH] div64.h: Fix description of do_div parameter
Date:   Mon, 25 Feb 2019 15:03:54 +0100
Message-Id: <20190225140355.4335-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c+nzDT4oituyxymO8kIlCsmFdV2JOwBXZ95jPy4wkUMO0ONy4xt
 4pMPXa7HtaQ8A0mNDOGD+nlJDAvVBmSdqwSxYhmYoZ1VcpGNQ27zrggZ/0uRCJ0Ysxp8/rU
 X5x3RDk/ozRvjYrbRDwq7BW4r6DtcB/Zhnv4ZnNLi0cMXEKX2nxfvnNUza1V2qCSKqM4+v6
 kuhIu5SyOh6COQlWZMTNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h+3NdTKhxwQ=:B0FK3Jqbi/BF7rPGk8IBgs
 e6HUgNrtQbQJdLqolpldIlCQMDuOOi7JH3G38OPXHqmLkqGynGQzCOi72Hq6VPKU2cHmj3Kzx
 EUElMmv+fpD7e9aCQ/w8R0R1Yity5LfcS1SyQiRZOKV24sjUI1uBRClHLnSYLthl/ycy0UDuv
 tAM4cAVlMQw1AbAg1ASR/LluzAIhlEc4+CxQ9Gtie7jl861LMV8PJEqwt9n6tl/Ra7gnu1AfE
 OXeiA/PHoNyrlTqxVeas03POfri+Un4SLTuCUFK9uHjAsgT5v5TSnEbjB34wImyPykZG+KRE8
 mEyvMJl39E8MLcwH1dXZZ8IRSyTnuYixSjcZ2KJxXk49QBCH8JMV8iE2DcUGlQFN349BiB+en
 gGLm4ybcLI/m/OB/SNgpbHR3fd120HAOIWA3Gtm2mnteGzyaTgbxYGmhXeYjY0SUNzPFbY89f
 tHhZeHGhrhrs0tiG1Eny1O2H43rEWMG6yZt7ozN7Ct+NCk8fvB9+PkZeCAkDUPWQA01ZSNqww
 JSH10NRRaM3di+DRFuewRt4RKDfHIW+vOmVTpAtpTUU2ANnVochqGI9dJL0gIF/6Zu5De534R
 h2o2c0QcyX6LJHA6nNSoStuE3b4DjNYPAO6jF6Uj6JApkZ4q5kyEnI37hx2P54IhNODSlIMZF
 cztgR+2pZziyJLajm4rkYj5HzbiDWqDGPdoxmXURGxe24YwgafOGjJBBs6RyBypuAHAT0G33z
 JF/x6SCswZaKCrnl9xSym03s2fjZJDRpq4TEnnv7Jdjl+pSzuEVEEn6zRBaGEIrql0hAzVgy2
 zt0GXVXrw2ZoRdyujVzDtey16psyuCm4R//MlMrqhOKWw7xiqAGpmima2JliXbwfrC84H5rnD
 IwcF1l7WeBA3M9BwpcnLqGfopAaIco5SFSeGDK0oND99KOsoOk6ye46YOwcblMTqJh4dds/qj
 KKN02+gJk0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the description, the first parameter (n) should not be
passed as a pointer, but directly as an lvalue. This is possible because
do_div is a macro.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 include/asm-generic/div64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index dc9726fdac8f..b2a9c74efa55 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -28,12 +28,12 @@
 
 /**
  * do_div - returns 2 values: calculate remainder and update new dividend
- * @n: pointer to uint64_t dividend (will be updated)
+ * @n: uint64_t dividend (will be updated)
  * @base: uint32_t divisor
  *
  * Summary:
- * ``uint32_t remainder = *n % base;``
- * ``*n = *n / base;``
+ * ``uint32_t remainder = n % base;``
+ * ``n = n / base;``
  *
  * Return: (uint32_t)remainder
  *
-- 
2.20.1

