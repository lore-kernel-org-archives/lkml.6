Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44854C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0C02080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeLNUfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:35:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeLNUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:35:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKYpsh1454868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:34:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKYp8F1454865;
        Fri, 14 Dec 2018 12:34:51 -0800
Date:   Fri, 14 Dec 2018 12:34:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-cadb29db628d761b190875e54e9d5b65a30b1925@git.kernel.org>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tstoyanov@vmware.com,
        mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com, acme@redhat.com,
        rostedt@goodmis.org
Reply-To: jolsa@redhat.com, rostedt@goodmis.org, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          tstoyanov@vmware.com, hpa@zytor.com, mingo@kernel.org,
          namhyung@kernel.org, akpm@linux-foundation.org
In-Reply-To: <20181130154647.022471992@goodmis.org>
References: <20181130154647.022471992@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Added support for pkg-config
Git-Commit-ID: cadb29db628d761b190875e54e9d5b65a30b1925
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cadb29db628d761b190875e54e9d5b65a30b1925
Gitweb:     https://git.kernel.org/tip/cadb29db628d761b190875e54e9d5b65a30b1925
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 10:44:05 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 30 Nov 2018 17:14:53 -0300

tools lib traceevent: Added support for pkg-config

This patch implements integration with pkg-config framework.  pkg-config
can be used by the library users to determine required CFLAGS and
LDFLAGS in order to use the library

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.022471992@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile                  | 26 +++++++++++++++++++++++---
 tools/lib/traceevent/libtraceevent.pc.template | 10 ++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 0b4e833088a4..adb16f845ab3 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -25,6 +25,7 @@ endef
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
 $(call allow-override,AR,$(CROSS_COMPILE)ar)
 $(call allow-override,NM,$(CROSS_COMPILE)nm)
+$(call allow-override,PKG_CONFIG,pkg-config)
 
 EXT = -std=gnu99
 INSTALL = install
@@ -47,6 +48,8 @@ prefix ?= /usr/local
 libdir = $(prefix)/$(libdir_relative)
 man_dir = $(prefix)/share/man
 man_dir_SQ = '$(subst ','\'',$(man_dir))'
+pkgconfig_dir ?= $(word 1,$(shell $(PKG_CONFIG) 		\
+			--variable pc_path pkg-config | tr ":" " "))
 
 export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
@@ -270,7 +273,19 @@ define do_generate_dynamic_list_file
 	fi
 endef
 
-install_lib: all_cmd install_plugins
+PKG_CONFIG_FILE = libtraceevent.pc
+define do_install_pkgconfig_file
+	if [ -n "${pkgconfig_dir}" ]; then 					\
+		cp -f ${PKG_CONFIG_FILE}.template ${PKG_CONFIG_FILE}; 		\
+		sed -i "s|INSTALL_PREFIX|${1}|g" ${PKG_CONFIG_FILE}; 		\
+		sed -i "s|LIB_VERSION|${EVENT_PARSE_VERSION}|g" ${PKG_CONFIG_FILE}; \
+		$(call do_install,$(PKG_CONFIG_FILE),$(pkgconfig_dir),644); 	\
+	else 									\
+		(echo Failed to locate pkg-config directory) 1>&2;		\
+	fi
+endef
+
+install_lib: all_cmd install_plugins install_pkgconfig
 	$(call QUIET_INSTALL, $(LIB_TARGET)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIB_INSTALL) $(DESTDIR)$(libdir_SQ)
@@ -279,6 +294,10 @@ install_plugins: $(PLUGINS)
 	$(call QUIET_INSTALL, trace_plugins) \
 		$(call do_install_plugins, $(PLUGINS))
 
+install_pkgconfig:
+	$(call QUIET_INSTALL, $(PKG_CONFIG_FILE)) \
+		$(call do_install_pkgconfig_file,$(prefix))
+
 install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
@@ -289,8 +308,9 @@ install: install_lib
 
 clean:
 	$(call QUIET_CLEAN, libtraceevent) \
-		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd \
-		$(RM) TRACEEVENT-CFLAGS tags TAGS
+		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd; \
+		$(RM) TRACEEVENT-CFLAGS tags TAGS; \
+		$(RM) $(PKG_CONFIG_FILE)
 
 PHONY += force plugins
 force:
diff --git a/tools/lib/traceevent/libtraceevent.pc.template b/tools/lib/traceevent/libtraceevent.pc.template
new file mode 100644
index 000000000000..42e4d6cb6b9e
--- /dev/null
+++ b/tools/lib/traceevent/libtraceevent.pc.template
@@ -0,0 +1,10 @@
+prefix=INSTALL_PREFIX
+libdir=${prefix}/lib64
+includedir=${prefix}/include/traceevent
+
+Name: libtraceevent
+URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+Description: Linux kernel trace event library
+Version: LIB_VERSION
+Cflags: -I${includedir}
+Libs: -L${libdir} -ltraceevent
