Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeBBOyy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:54:54 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:52665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeBBOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:54:49 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: x86@kernel.org
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] x86 bugfixes for LTO
Date: Fri,  2 Feb 2018 15:54:28 +0100
Message-Id: <20180202145434.100626-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:UPk4t5/qqaWPi69+X5ps5Mp7Rv0momQ3gBiVGTGa9CUyRk6/ETJ
 qYlslsYHCbj3xAIw6VF+mEfg7x8PbbALS9KpbiSz0/Km4r68ug+9pNfOiM+5vtSMUVqr5y5
 51EaQifz5gOD5O1690WlWmCa09caUx/XPkh66UL+IG0C0r9xtAF1jCjgEY/bhbjDLgjqvgi
 7gdk/cZC+Dwd5LlsuYrfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9KCHHH7zPf4=:wzsHu2s8prtKdAmxdmSgko
 zKeQ/7dmVjFmRcTUsHS0E65+eaFgfPlFRJ/kLbAhyg/coErS5xgtN6VS98kIvhH+sCuAzfVR3
 0fWNcrg1iTEr4T3WsxkA4imTD77YbmtiDqdvgTQ1ItKaicjvJ+bt+q17kowPdlLkVw0Ld3A0o
 w27ZXzlSCi/W2+JZb4jqGqj88MaGoadCeBfDO+tjrycip4IjG5mRc/xskdw4RlyDwSYoAtbKO
 jcHdyo5j8mAppMT91GgoxE1amcfiAf6IIM19/TXYOL0elcs2dS8JI9QC5B9wQdFFxwLxR9jK+
 9xdKl9FChsSGsjpdTq6wOUOWHwBgxyAdYgBN0QuNT7tnuFKaINm4dvagktbLhAVw3Q2pfhL2n
 E43es8xg79/4L2janB1HtnbDKQoqFkZkddg1+72bMw5iYd4BMSiTe2PBaQ4ZVdFDpiQHChrT5
 SH9IEJGTpPR327KdTu/oW2Bh93swxTKBQZ7j97ZfDzFMtHQNqyc3WS2xFBUvIpuVkl+S8KOgm
 2JpO2CGgVqHLLTrx7ezpBtErkOFVbNV8AFExwcAd8j44PW6OKZYNoMZMnSOnMuBYRKKaQ7TZM
 N4AvoD4DMkLnrylR1OSgWb14C5V5ylm67UgDWIaSD4xkO327dtKqoic85MIgmRhXTkiR1FX1r
 QWNNc7ARzufLlKXoF4cZqW0PQagc41rJmJDbQA53JDhKfOVf9cQrgQbVzQ64l9Z/HouRg4zZJ
 biFgot6A6Bf8fiSunnT7sfVCgMK8sSwPP3sTIg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are three bugfixes for x86 that I needed to get LTO-enabled
kernels to build reliably. I'm not sure abouto that first one
though.

None of these are urgent, as they don't show up in mainline
kernels and they don't indicate serious problems.

Arnd Bergmann (3):
  x86: dumpstack: avoid uninitialized variable
  x86: fix swsusp_arch_resume prototype
  x86: error_inject: make  just_return_func globally visible

 arch/x86/kernel/dumpstack.c   | 2 +-
 arch/x86/lib/error-inject.c   | 1 +
 arch/x86/power/hibernate_32.c | 2 +-
 arch/x86/power/hibernate_64.c | 2 +-
 include/linux/suspend.h       | 2 ++
 kernel/power/power.h          | 3 ---
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.9.0
