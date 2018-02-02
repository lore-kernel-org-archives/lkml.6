Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBBQQQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:16:16 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53988 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBBQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:16:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/7] LTO: hacks to build LTO-enabled randconfig kernels
Date: Fri,  2 Feb 2018 17:15:38 +0100
Message-Id: <20180202161550.2106846-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:0FXVP2Q/aRK56Mc7+yKV41r+bDq1zjCCP9SGaZMiMtdMvhfA5r8
 IwVa/yAUXz8kUNuizjufsvSdD4ihqyGi5P8aDPhlzlkOtFUfZM+2rnT9J0d3GGOmDbO3G5r
 TfNY80mjcx+tqbHPKFjoMFPM8j44CTrU8Ge1rSd7/yr7d1JDpTrl9UtbKcbtE1JMSS1OZAu
 rtOfAQC1Qq1Hm8UPpIgkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mKk8t6h4Xes=:pg9vUhyslxGLNHGdKB4xPp
 HLz0oBz8ZpoksOs3D8lVE7L9Tzt4MOCxOTaLV9+R4VGaCf2BhiH7CyizSuNhSFQhSNSxwJBZw
 hZGUipUBieO3+ZMQu2G/KGucdTRqMexNk5dMh0wltjTrGv6bthUdm55o33/QWt7m2JluiXFdx
 VZSZcOtScKW7bd5lSByXOy2VbFauVEgOGQrZ7Djj8y22ccQniEj0GneOELFZwjCMm3KgLuX2B
 Ob3BChCxEFLiHV1IhXBL6Q5N8PHJRiuV/JsXWVTd8UYS/LgCsEsBQyfpjYzK/4FU19eTyxsbj
 SmSSp5gE8fWjTHO9ZpD35UeCo//+2DEjzEs+REyc/+6KhOQJ2BIzPbjSIQtfbMtHJG2OqfEC/
 4Jwq+qyfTcKsmyV9viGmclSU1lipF2uvCyOiW3TUqVUu1BLBeNyWMpDRG9N+l6JU93vOTw1p7
 shcNCnIlwZd1fC4CJpoSIJRDwthKSkaUyu+AS5UDSYRCGqOPYCph0yqQ8ZimsQHHC6Iu0eeji
 EesECWmD5SzJgqlKlfxQGGnBsATiJJHIlTXHDN2Pw97K2ItADscRO8yq+kcDC1jgzc4fgtkZB
 BLmRvQFdCE6TrExYCQe1OzlDtqemVr0EtL0Yr85NQXkHd4ZBcKLWlPVIzhaIGeWZOCzAYYZRR
 esQhJAlcgUCzvWBgilhj0/fJ29oEUxftJ6tZi6v3x9m7qmyBZ8EyfhX04Qr8yxlsOJX+gFvTT
 1ZkSXxc5KnKaXRzzZkfjuHlzF8+uhVKcLWOhSw==
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of patches that I used for build-testing, resulting
in a successful build without warnings when combining
https://github.com/andikleen/linux-misc#lto-415-2 with the
latest linux-next.

I sent out all bug fixes that I had a good feeling about, this
series is basically crap, but it does the job for me. I'm posting
it for documentation purposes mainly, so we know what some of
the remaining issues are, and so people can google for the
error messages when they run into the same issues.

Arnd Bergmann (7):
  [HACK] lto: make config.gz symbol visible
  [HACK] x86: lto: always link in library files
  [HACK] x86: crypto: fix link error with LTO
  [HACK] lto: shut up some warnings
  [HACK] avoid gcc-8 ICE on LTO
  Kbuild: lto: clean build artifacts
  Kbuild: lto: pass -m32/-m64 to to LDFINAL

 Makefile                   |  2 +-
 arch/x86/Makefile          |  2 ++
 arch/x86/crypto/aes_glue.c |  5 +++++
 arch/x86/lib/Makefile      | 39 ++++++++++++++++++++-------------------
 kernel/Makefile            |  2 +-
 net/sctp/sm_sideeffect.c   |  2 +-
 scripts/Makefile.lto       |  2 +-
 scripts/kallsyms.c         |  2 +-
 scripts/link-vmlinux.sh    |  4 +++-
 scripts/mod/modpost.c      |  4 ++++
 10 files changed, 39 insertions(+), 25 deletions(-)

-- 
2.9.0
