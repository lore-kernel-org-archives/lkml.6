Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F395C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742152173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBGQlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:41:21 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:41:19 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWitM-1gcKHK1hBg-00X472; Thu, 07 Feb 2019 17:41:14 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Subject: [PATCH 4/4] debian: add generic rule file
Date:   Thu,  7 Feb 2019 17:40:59 +0100
Message-Id: <1549557659-19137-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549557659-19137-1-git-send-email-info@metux.net>
References: <1549557659-19137-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:tFnabiaUtbp/cdoenDb6JQzVK6HRa5zPuE586L5eTkEZ+a4xivy
 BYyBg+0om+nYbEB1hN1oCHX3RW200OtypDKrP5t7ySCMjgBEcdmoLQ56SRpnHT1hWCYRMgl
 ehtRWSB6QqKsJAEohn7vEZ/zt0EOGU0kfJNZs9C2FIONmPj2xbzPh14gFhrpmEiy67+3jVQ
 7WvY9I4p2+LnotxfyxtFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4BETYNcZJLo=:pPNX8M1pA+guoyVZVxwA3J
 5w4zQ4fdDW+f0S4Czegv/RgELSqlmAEzsKuCB0js2l8mPz8ndcGvmfD4O0iXNcL5VONPWHauU
 JUECczDt6lEOVNMN7/bmBwD9JiZFBsg/GDw7+5iWRa/VIKCp+1wf04tJeGtYWPh+0goi5S/+a
 yfyrP6zjhL4I6+g0IzuPF5fXmP2T5NmbDOdETBB9npTObdaOahvRKbCbIEf6UKHYH7Zzm5W05
 FDLr/Ka69pl0G7KVautBL6HqIaP+YUpIQMdyIZ9eT8VWAy3ylpSAOQTGUyUU0Y5yK8fSmaBjp
 cprh/7PgmWWBN1MO8V4yDKF+84fBAHQK4n2elIkqTEkhnMsxTw14UXxGVNQ898OWTcRotUCHl
 GQNypNYMxAhp6jhP3ZoF7+j9qAK+1f+LwcRWbs+5ImGFU40YhybqLsDl9o3YQd0zLqz2kTKp0
 Ojgdr8syOOv3viwRvtgIsH/CjUYKByA9SK4jOSDVfC9O0n4otO7ALSZDEaiIZkLlIq4kRfDGP
 wJbi6vacBifsOkFKkDdLy8ic6Gj856/ROHUtRw53LVvj5axZo5XnSKcWcGnzYGp9GW4niq68p
 7XdZMIU7Pj4B2MMe067jP3KgyLqiFq2pTqW3vHDBb6Xs65hGDBmpwbR9SS4zdGEX75oNM96fM
 W82h/aJvvZifxCuZ9dzCv9Gs3dsKB4Irq2XHhM7YLQxVgjG6XyJnCgnPOycdY5W+ldiqFpk02
 +cYwJ4pnUuWwCmyEIB5fwUPTCKgSUIPCGaiThQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a generic debian rule file, so we can build the directly
via usual Debian package build tools (eg. git-buildpackage,
dck-buildpackage, etc). It expects the .config file already
placed in the source tree.

The rule file contains a rule for creating debian/control and
other metadata - this is done similar to the 'deb-pkg' make rule,
scripts/packaging/mkdebian.
---
 .gitignore   |  1 +
 debian/rules | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100755 debian/rules

diff --git a/.gitignore b/.gitignore
index a20ac26..2d8081f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,6 +68,7 @@ modules.builtin
 # Debian directory (make deb-pkg)
 #
 /debian/
+!/debian/rules
 
 #
 # Snap directory (make snap-pkg)
diff --git a/debian/rules b/debian/rules
new file mode 100755
index 0000000..eeb58f7
--- /dev/null
+++ b/debian/rules
@@ -0,0 +1,26 @@
+#!/usr/bin/make -f
+
+export MAKE
+export KERNELARCH           = $(shell $(MAKE) kernelarch)
+export KERNELRELEASE        = $(shell $(MAKE) kernelrelease)
+export KBUILD_DEBARCH       = $(shell dpkg-architecture -qDEB_HOST_ARCH)
+export KBUILD_BUILD_VERSION = $(shell $(MAKE) kernellocalversion)
+export KDEB_RULES           = debian/rules.auto
+export KDEB_SOURCENAME      = linux-source
+export ARCH                 = $(KERNELARCH)
+
+debian/control debian/changelong debian/arch debian/copyright:
+debian/control:
+	./scripts/package/mkdebian
+
+build:	debian/control
+	$(MAKE) KERNELRELEASE=$(KERNELRELEASE) ARCH=$(KERNELARCH) KBUILD_BUILD_VERSION=$(KBUILD_BUILD_VERSION) KBUILD_SRC=
+
+binary-arch:	debian/control
+	$(MAKE) KERNELRELEASE=$(KERNELRELEASE) ARCH=$(KERNELARCH) KBUILD_BUILD_VERSION=$(KBUILD_BUILD_VERSION) KBUILD_SRC= intdeb-pkg
+
+clean:
+	rm -rf debian/*tmp debian/files debian/changelog debian/control debian/copyright debian/rules.auto debian/arch
+	$(MAKE) clean
+
+binary: binary-arch
-- 
1.9.1

