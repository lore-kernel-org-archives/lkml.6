Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbeDFO3I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:29:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756340AbeDFO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:28:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hexagon: export csum_partial_copy_nocheck
Date: Fri,  6 Apr 2018 16:28:23 +0200
Message-Id: <20180406142832.2243021-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180406142832.2243021-1-arnd@arndb.de>
References: <20180406142832.2243021-1-arnd@arndb.de>
X-Provags-ID: V03:K1:WISlYNgLNTbARxP3FnIbNC9fsedO/DWzuQrOyd7sY7lj7Uh1VDd
 FEZAsqmNkzdgu075aZ2F6vJwTfSTnERYglp5jkSm5EzqOSAUhRJWQmbjiqnMv7hq3hHg04G
 SEcJpkInlSAl1aANLtPDmowTwWdly2AhZs00ngGVBSWa3Ty7heymtFXMEXE7ElTgsoiPXP2
 o0ZVmkYeA4e+wHuQV61AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SlOaB/M42Js=:elv2y2qjgDXP08Lslnn6GJ
 u437PrxQK++WvxbPwDXNsMd4LptI9zHkBLdzDhwmfI4+nVKRAU0XYna0nu/MboXT71c4UsmqV
 N19MLyq0RrezGRzIOFZ9is+QoOCRSVQmD441zLQPhyaqDJYRuw75OmjH4SJSK14KeRL+618x6
 ih3O0tEBG+t7/jWfPjSPykvU/22lxzBI7kqysjEVUprzVqOzB7Bqc0mosUSfKyul771vtZR+z
 C09FLBVvSSvRf3iQ7d2GnstiyBhO3Y7EVihqDi/088zG58MzOb5Bv2RH59w6LFN7lXi/EB+fS
 KBxkytnBtGLjD7vuhzhnt4+1VgNSxgvQF3QRvqmOdaFShMf0U0IiAXR9G90xe3N8mJvUjerxa
 ZmwIBnKuvKilmKWRe7n3sqxYTb0+ZqLEKSSp6WWlvbiPjb13OWxtawHbBGQdkl2emSi+1qjdl
 oWG/ALejIlNEz0swV1Ask9rF7lgBwsot1mxyLH0Wn79iHQswcerj9nJZBeafKgla/lLmdZkef
 cqb5HcG5vMH2Ta/ttLBQj58RekVIrkMpbZer84RA2fBcQtmIeP3an8cq93sVTJ/mr3BFXwBRU
 BGKE3Z7IUnc0BhBI0W/8ZcGI7dcDC3q6fWB0Mzr8Sm2eE/kC1cl7kTsDF5EUsvHpA7BKWZCEA
 PmZ7viTvyCnFef4P38dqgefpj/PEorr5PL8ovGqZoI7PlCzqOcb4eu/IviDMvKLkqAnQqotlt
 m+X4kwSlsyzRNOW6XzzWYCbaNt1M9qxZPxMc2A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to link ipv6 as a loadable module, which in turn happens
in allmodconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/hexagon/lib/checksum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
index 617506d1a559..7cd0a2259269 100644
--- a/arch/hexagon/lib/checksum.c
+++ b/arch/hexagon/lib/checksum.c
@@ -199,3 +199,4 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 	memcpy(dst, src, len);
 	return csum_partial(dst, len, sum);
 }
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
-- 
2.9.0
