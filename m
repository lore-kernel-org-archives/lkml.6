Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeCNOwd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:52:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeCNOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:52:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kamil Rytarowski <n54@gmx.com>
Subject: [PATCH 15/16] recordmcount.pl: drop blackin and tile support
Date: Wed, 14 Mar 2018 15:52:00 +0100
Message-Id: <20180314145219.2055160-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Yi9GTWXfbn31y2aFk3ZPJU4MFTh3lD6eLsz1DkhJd3O7siUxD03
 pUp0qv66pMc0ujCBNjVtwtfYIZ0HY8RsRjHu+1J8MJ4kJ+X6kanalBEDcafddZVm4yOpeTT
 Fyrgwy7DBZ2KgHaUwewPIlSvEXJQd1INrFceBzG0wdE2KVp50wsu9CqXuQ8QSJX4tej1R5D
 4wIwk6IpF17CAkLUfNkiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xT3h0ieMgNw=:EDt6Ug32852TxXHNmhdJB2
 c06nImIuJUO+TbWrvz9F7ZYPUA1QcHmkkN7DclxIw1YrrXsS1sE/fc82pJFe+4zLrTrceQb2J
 1yVSO5iaIAeHtr6xRyEvjjfuTM6I2l8kTYUN7bH2ivyQZadrcFfubw8s6D8F6V18jDbqooe9l
 li5vdjvdMR0Lbx6f9f2pXfYhqZjxZ+IXr1bw1HO13qvrRrZa/Kzo6FzQCZ1ftrDYCbPi7jX5/
 jFdxzSZ8SuZgJZ+uoOpGNxszwBBB2Z1sCR7wGTb6gS4fiWzr6/rgVQKUuzewaxJMyaDbCj3T8
 zUeT25ESQTXQz14apXS0WuBk0/Q676SgSsl/qPBJYVSV9Rvw6Q98vZNrElPAFkJag+w48mPiR
 Hnkx/AL4QVTYuUALOoO+kiK8yBU+ndMh+oNTW0DRhpptTYS3NddiiMKE4YpfSGujPnqmMuvQ1
 k4Ls2cp4PBCNx7FfbrnYCYowFUbylwmPgLDVeaD6cUiLF2vmb9gx1GGspWqDU90D527BB865g
 vduci6KwAsdW1HzqDy0RX21Bjo7PMCncFPxt+1OkTX0mAdiC/6rzFH5zSPEKeA3fdM4tgg06W
 UX3/biqqI8ODQpYWvqPPhclC07rNmCgRgusjHukj9biZbfWcz0VZQ/UOzlJw2cVuEHAF2brqA
 J8z3n85JWYYgrVMn3OuFGEdb5nWz9h7jfYLYLd5J5I4wkx4JwqDuMuAlCbW3LBadcIhopEQ+Q
 ADrmmrUGvVKIAW6a4bK7vfr1yBUHTu4BHo5CxQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two architectures are getting removed, so we no longer
need the special cases.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/recordmcount.pl | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 2033af758173..c74ecc6504e8 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -368,14 +368,6 @@ if ($arch eq "x86_64") {
 } elsif ($arch eq "microblaze") {
     # Microblaze calls '_mcount' instead of plain 'mcount'.
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
-} elsif ($arch eq "blackfin") {
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s__mcount\$";
-    $mcount_adjust = -4;
-} elsif ($arch eq "tilegx" || $arch eq "tile") {
-    # Default to the newer TILE-Gx architecture if only "tile" is given.
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s__mcount\$";
-    $type = ".quad";
-    $alignment = 8;
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
2.9.0
