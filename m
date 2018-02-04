Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeBDDUx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 22:20:53 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40571 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeBDDUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 22:20:46 -0500
X-Google-Smtp-Source: AH8x225n6AHc3b8ya1mufcz0gShq84dF0a7i7CJp1/lxGlJUYKmTHM6aCIF9mpHNtiNBnzg3dn6V2A==
From: sztsian@gmail.com
To: rostedt@goodmis.org
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com, sztsian@gmail.com
Subject: [PATCH 1/2] trace-cmd: Fix the detection for swig
Date: Sun,  4 Feb 2018 11:20:13 +0800
Message-Id: <20180204032014.6962-2-sztsian@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180204032014.6962-1-sztsian@gmail.com>
References: <20180204032014.6962-1-sztsian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zamir SUN <sztsian@gmail.com>

The current detection for swig will cause output to be
/usr/bin/swig
y
So this will never be equal to y. With this patch, the swig path is
removed from output, so the detection can work as expected.

Fixes 3bf187a43b7e6302592552ecbc294e5820249687

Signed-off-by: Zamir SUN (Red Hat) <sztsian@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a5d2c38..7c0d1a6 100644
--- a/Makefile
+++ b/Makefile
@@ -105,7 +105,7 @@ PYTHON_GUI	:= ctracecmd.so ctracecmdgui.so
 PYTHON_VERS ?= python
 
 # Can build python?
-ifeq ($(shell sh -c "pkg-config --cflags $(PYTHON_VERS) > /dev/null 2>&1 && which swig && echo y"), y)
+ifeq ($(shell sh -c "pkg-config --cflags $(PYTHON_VERS) > /dev/null 2>&1 && which swig > /dev/null && echo y"), y)
 	PYTHON_PLUGINS := plugin_python.so
 	BUILD_PYTHON := $(PYTHON) $(PYTHON_PLUGINS)
 	PYTHON_SO_INSTALL := ctracecmd.install
-- 
2.14.3
