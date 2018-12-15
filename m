Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33733C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34E92084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeLOVSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:18:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:57819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeLOVSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:18:23 -0500
Received: from LT02.fritz.box ([84.118.159.3]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M4B71-1hPPoN3ofb-00rpJl; Sat, 15
 Dec 2018 22:18:21 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi: efi_guid_t must be 64-bit aligned
Date:   Sat, 15 Dec 2018 22:18:08 +0100
Message-Id: <20181215211808.16837-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jcNklnLonaYaEYZJSqPaLXCw/XnjJ56O4GhAnPHfzNSoM5qKLL4
 MafyfbU0pvi1N0M2ACnc6VUdEiKAtEDhpNRmqydsjRSkpYsLLz0r4PaPqOB49JFgvI6iTRv
 cxm3ZTbSXZL+D7dbK/LdXZXAHH9ebsZbXciMdheJKKhzRV4CnducLOyRBjSGHkf+Fspif2M
 oHLoou8EUy2aVGtQmhqew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CixJWK5ZI4o=:lIvrxahpWB78lRBHhevNdL
 tuCAvqBE7yfzPWdRuLhSFvzSbDTMCduCqAPLT/QF93HCIRfLWZUPcAppxAmruXUrivvCk1PQi
 yXQVVJ5YIU90Z9DcIYBoSYs60Ilo214pU0Lj+gSVlKcYde8LtX/JTfB68b2oAJkCNdNYR73Zh
 PKT12J8bxbUYzXijFNhOpiooIcLrkv7kCX5XRYdZ7glZy606mHmsPIKx7TAIp153FUMS07s4j
 LydPoDv3m7xYSkmZODNCq6p3JnyQ2Q9rzeZwYzHhJO49Qe60CvCiR3FqXbeuSzGjOTvKvU1Xo
 We819SWNExcAItHQRE9PIeHqMFSWp2+zv/yRjyXVPLwFlidnh5Uc0JuWp8Z6LHLovpPqhOQ1o
 Y1FR7rez04aeLjrNLF9dmeoKWtUvUa8ktxNKFItVaVxR62LhtFsmEvB5yPDTBiISPfuuxyI8P
 86McsLHeQPU0HCn49wgd0O4Xo7TrpI8URnnn9jefrNT/LkoMYmJe0Xh3Nrs1VGFBrAYyy4veE
 PTQkNjQY55pKIBoSOGHHk4G2dG2GSWeONlXrOvRR/pmdKAUhJjiZgkDPJAQRGl7DaXfTvTUaa
 2clqChv03nR/6CEfCGDxfG+SvIFNAJeFbHOzVYfhGsUXW5KAmla+3chXgBjxqTnyaSYFcC3mf
 MXJzODznbizhOM9JD0TsoToTSbs4OxvX+bd/J5sC4Oz3ieur8yVJWzBYn9n/+FYt25iAbv4q/
 AJ3Ha7LHPMiHUppcJorpLRvy4+rqT8Qvu1TO/tErDDYDFgT5XZXfx6dri4fSMXODUQAIEUHbx
 ixJFUPndMNGJSG8eP9QeYnwiFIEVgmWZde/Ljsj3t79YzOVU+4wQICgjwrLTxlxnp3mXS0rCO
 lmmYKnzTi2iGxnHHXP2HSdYRfZE+Xfrmf4AYKsj+CG4mcqvS1xdCANcaW9AD3G
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UEFI Specification Version 2.7 Errata A defines:

"EFI_GUID
128-bit buffer containing a unique identifier value.
Unless otherwise specified, aligned on a 64-bit boundary."

Before this patch efi_guid_t was 8-bit aligned.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 include/linux/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 845174e113ce..c1a1931238c5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,7 +48,7 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
-typedef guid_t efi_guid_t;
+typedef guid_t efi_guid_t __aligned(8);
 
 #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
 	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
-- 
2.19.2

