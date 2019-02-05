Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F51BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D202080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfBEMqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:46:36 -0500
Received: from mx.kolk.cc ([212.83.177.64]:57872 "EHLO mx.kolk.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBEMqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:46:36 -0500
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 07:46:35 EST
Received: from localhost (localhost [127.0.0.1])
        by mx.kolk.cc (Postfix) with ESMTP id 0CA3924A3;
        Tue,  5 Feb 2019 13:37:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx.kolk.cc
Received: from mx.kolk.cc ([127.0.0.1])
        by localhost (mx.kolk.cc [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fumb7DHlVPPT; Tue,  5 Feb 2019 13:37:11 +0100 (CET)
Received: from localhost (user-5-173-176-164.play-internet.pl [5.173.176.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.kolk.cc (Postfix) with ESMTPSA;
        Tue,  5 Feb 2019 13:37:11 +0100 (CET)
From:   =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        kacper@kolodziej.it
Subject: [PATCH] kbuild: [bin]deb-pkg: add DPKG_FLAGS variable
Date:   Tue,  5 Feb 2019 13:37:52 +0100
Message-Id: <20190205123752.25432-1-kacper@kolodziej.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPKG_FLAGS variable lets user to add more flags to dpkg-buildpackage
command in deb-pkg and bindeb-pkg.

Signed-off-by: Kacper Kołodziej <kacper@kolodziej.it>
---
 scripts/package/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 453fecee62f0..6963eacb323c 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -72,11 +72,11 @@ deb-pkg: FORCE
 	$(call cmd,src_tar,$(KDEB_SOURCENAME))
 	origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
 		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) -i.git -us -uc
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -i.git -us -uc
 
 bindeb-pkg: FORCE
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) -b -nc -uc
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -b -nc -uc
 
 intdeb-pkg: FORCE
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
-- 
2.20.1

