Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeBBPsd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:48:33 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51811 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:48:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: don't mark __ubsan_handle_builtin_unreachable as noreturn
Date: Fri,  2 Feb 2018 16:47:39 +0100
Message-Id: <20180202154813.1625742-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:07p2UKWmTtY/CbrjB0hjtM7SfjdNFCUcCDoKnka08ow3SSmiKZe
 dlEduRd1/xX9QRqVz2tdKMlZAA41DSiOz1ED37roXtPyjBHkIf1yHy2C0211nmSLbO+U+YY
 gJVfHHnDB0fILlPXVzUqeZY7PqIjIMUHZBvOqxub2DzPBNKrSLtF/ROubCsM2QiVbCG2ATl
 ntf0tWNv8J6JJI9ikwn0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m18opPtAeoE=:pMXRBQJ5cpygikhb6ZI2hu
 Vu67mSGdzzm9ffGg+Zsym7YVSKjbd8zu8VexlSo7wm41XX2+Y6C46T8vwXPxDIxEm4nl6n8Ns
 Rk7ncpu4/p6xoZaIQm7Bzfpn49aqKOz4C6+BGGU9Wt44NfeqUsSw74cfYZO1ZdWbpU/+2pDWq
 XZDwykeBgnCR4zJ/W/a52hTSO7mzN1jqUXHdbG0FQBJHFxBV18wKTeqxLNImgjK5FpRieuy14
 5WeBIAwKAgFCiSA+2hoQKKfz+fGobIlm38Oe7KQf4tPP3OiKZoJHjlu/K98zdcjHM6/w952CX
 TMrndQDkPWQV0tBT5Q514qC7jR5VXjyVmTaVTjEmYAfAYPYCOdeIrc6DNP975iQQljcbVZV9u
 vHlJiCJXIP68z6MzN3Rz4cJK/jxpbR4CCFi0i2QYQLznhqtAbSwcg8hxGrscgNifujQYRsftM
 8ClOVB+T3dUsipVCti2PKyvyA2o/Iuc1CuGpzq/8hcD81cjN0dbY4qNnHyUysFxYTHKmdbCuJ
 mBj3mRerN5P2TR0R1+5DTgFg53MvSwLakkcGYqjOFEp9f3rT87k13U6Pr/Q6Hu7ETkG8RBLEX
 M91tf9tSsFg3NNgPn7h60y0OwkJIw8OBvkjvDC+fE1+Am65jZ0H1VUBxCstApZuGmQcAx01Th
 RV7k5oT1/rSB8aoBPympF1HzSNbRRIWCl+DgU7ZKAz8LEX8rAMeRi3xhXkw+Ajxb2tHZnatNI
 6mFTp4/fYBxWofoaF5cPkNlgH3qxdXH/runysw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 complains about the prototype for this function:

lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]

This removes the noreturn attribute.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/ubsan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 59fee96c29a0..aa817d79c47c 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -427,7 +427,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
 
-void __noreturn
+void
 __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
 {
 	unsigned long flags;
-- 
2.9.0
