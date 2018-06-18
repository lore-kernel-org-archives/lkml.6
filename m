Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D32C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684C420836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684C420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935610AbeFRRpd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:45:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:37407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935127AbeFRRpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:45:32 -0400
Received: from localhost.localdomain ([79.223.58.86]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lv8hi-1gCArt2mHK-010N3z; Mon, 18 Jun 2018 19:45:27 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 581DF80086; Mon, 18 Jun 2018 19:45:25 +0200 (CEST)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] stack-protector: Fix test with 32-bit userland and CONFIG_64BIT=y
Date:   Mon, 18 Jun 2018 19:45:25 +0200
Message-ID: <874li0vvii.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:IN6nUA+QVZukyq9YCHyDGeJDh4lM5NQgTAfrNCow300piJ6HFdn
 z794e82z7fS/KuZnLBMlPR2Cv20bTUdMIdwwspuxs+BX9v8ldMbhGRQva5uHXYfUJ/fX6Ua
 1SgknFaq8xRGSj3mlhXZSiKJqhP/JXOB0DoAqcIpi/crwQ0Tn9AN7fqFVRiL7QCqJQFPkjM
 gEoDAeweJnQybiFqHnozQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M2HWkV7eP2k=:peVJ+dj+YAEuaXhAPc3Yek
 1IDRK7IaGjQHxF0eQKvcV4yNkZT/MyFYVIMggxTfCAeF0E3u7n80jlT9EqueJYXNzdrjxOpXC
 8X4DLaYmUym0m4bGG0sAuHREVNCHwJoa2j8Ar3qHu8h348H0OFF1bE9gFuldDTgImhVrMI3UU
 EF5FGZnF2PiRbY0iF7e1O4Wm7kJm4W42jMXem+V6+enhl7ywuRkyy9H5rQ1y/zH70fAXcqJ1z
 +qhHgjwH5epbJk1qv4yCA1CrtrTOiwtKwg2oSQmmy8UQpgnzml/zviQcaIS5qgAwmx+DsyeQ/
 NMB50u9YC3LT5hwnnWaotwOAFe5XjUY+tJ9gtPmH5D3eLQ7wyRjFvuXrbaxXYCEVrDzf3YdTX
 UkobTsz7PiftuqBl4UQqUW710QVoD6LIObJCel6N4ieSL+VDYHtRS7Kq1E6vp+rjQV0YZZHkn
 2cHcgdgFFN9a+5vO+tZtiTtJWjef/8/njQ4C2QFd2ULyNn7TjKzT141zNJE0iJ23fpQf7HSrq
 TdYSG0Xf6UaZ+z7PeoofBHzuzs+dnipCru5nS/iaA/rZBpMIBx+A8OXffsiNGBNJjRfL2hy2n
 +KZF5S8k466r0A+dqq8oH3iy4QF/GOoSB8Z4NHq/+XBLKNwwSZVOgwJujh7j/ZKiV0LptbK68
 WFuNb+KfoRa7deumPZPfGJ0+aAXifv1vfg9kT5AKgXKibVyiKBqAlKrxbM3tFAI+PpQ7nTagj
 zGOWb/lfoQXnrzdPdwg84qCsK9/jedc9zCpa0CEGOnIkMZnGqN4KaJ3dStPeaJT72dXAofsQZ
 1E6Np7y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a 64-bit 4.18-rc1 kernel with a 32-bit userland, I
noticed that stack protection was silently disabled.  Adding -m64 in
gcc-x86_64-has-stack-protector.sh fixed that, similar to what has been
noticed in commit 2a61f4747eea ("stack-protector: test compiler
capability in Kconfig and drop AUTO mode") for
gcc-x86_32-has-stack-protector.sh.

Signed-off-by: Sven Joachim <svenjoac@gmx.de>
---
 scripts/gcc-x86_64-has-stack-protector.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
index 3755af0cd9f7..75e4e22b986a 100755
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ b/scripts/gcc-x86_64-has-stack-protector.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.17.1

