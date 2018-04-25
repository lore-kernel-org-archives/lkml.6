Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeDYBMs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 21:12:48 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:42872 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDYBMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 21:12:45 -0400
From: Adam Borowski <kilobyte@angband.pl>
To: Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Date: Wed, 25 Apr 2018 03:12:31 +0200
Message-Id: <20180425011231.24143-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <bb5bf465-bf71-4ddb-2a7e-866bb0f76606@molgen.mpg.de>
References: <bb5bf465-bf71-4ddb-2a7e-866bb0f76606@molgen.mpg.de>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: On Tue, Apr 24, 2018 at 11:08:34AM +0200, Paul Menzel wrote:
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ere you go.  KERNEL_ZSTD is not in mainline yet but knowing its magic
can't hurt -- especially that scripts may be out of sync with an installed
kernel.  LZ4 is in since 3.11.

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
>From 30886e965e7aeae8d3729c4bacf614a19e103cea Mon Sep 17 00:00:00 2001
From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 25 Apr 2018 02:29:18 +0200
Subject: [PATCH] scripts: teach extract-vmlinux about LZ4 and ZSTD

Note that the LZ4 signature is different than that of modern LZ4 as we
use the "legacy" format which suffers from some downsides like inability
to disable compression.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 scripts/extract-vmlinux | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
index 5061abcc2540..e6239f39abad 100755
--- a/scripts/extract-vmlinux
+++ b/scripts/extract-vmlinux
@@ -57,6 +57,8 @@ try_decompress '\3757zXZ\000' abcde unxz
 try_decompress 'BZh'          xy    bunzip2
 try_decompress '\135\0\0\0'   xxx   unlzma
 try_decompress '\211\114\132' xy    'lzop -d'
+try_decompress '\002!L\030'   xxx   'lz4 -d'
+try_decompress '(\265/\375'   xxx   unzstd
 
 # Bail out:
 echo "$me: Cannot find vmlinux." >&2
-- 
2.17.0
