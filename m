Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162408AbeE1Khu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161566AbeE1Khm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:37:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 224/329] builddeb: Fix header package regarding dtc source links
Date: Mon, 28 May 2018 12:02:33 +0200
Message-Id: <20180528100300.764943135@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kiszka <jan.kiszka@siemens.com>

[ Upstream commit f8437520704cfd9cc442a99d73ed708a3cdadaf9 ]

Since d5d332d3f7e8, a couple of links in scripts/dtc/include-prefixes
are additionally required in order to build device trees with the header
package.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Riku Voipio <riku.voipio@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/package/builddeb |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -325,7 +325,7 @@ fi
 
 # Build kernel header package
 (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find arch/*/include include scripts -type f) >> "$objtree/debian/hdrsrcfiles"
+(cd $srctree; find arch/*/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
 if grep -q '^CONFIG_STACK_VALIDATION=y' $KCONFIG_CONFIG ; then
