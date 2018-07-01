Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9CFC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F170824E20
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F170824E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeGAQLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:11:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeGAQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0088BACD;
        Sun,  1 Jul 2018 16:11:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Michal Marek <mmarek@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 01/85] tools build: No need to make libapi for perf explicitly
Date:   Sun,  1 Jul 2018 18:01:19 +0200
Message-Id: <20180701153122.425960620@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 379a9a28a1b4364ab08fec35c84d39cf4995c509 upstream.

The perf build handles its dependencies by itself.

Also renaming libapi libapikfs to libapi as it got
changed just recently.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org
Link: http://lkml.kernel.org/r/1429389280-18720-2-git-send-email-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/Makefile |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/tools/Makefile
+++ b/tools/Makefile
@@ -51,10 +51,10 @@ cgroup firewire hv guest usb virtio vm n
 liblockdep: FORCE
 	$(call descend,lib/lockdep)
 
-libapikfs: FORCE
+libapi: FORCE
 	$(call descend,lib/api)
 
-perf: libapikfs FORCE
+perf: FORCE
 	$(call descend,$@)
 
 selftests: FORCE
@@ -106,10 +106,10 @@ cgroup_clean hv_clean firewire_clean lgu
 liblockdep_clean:
 	$(call descend,lib/lockdep,clean)
 
-libapikfs_clean:
+libapi_clean:
 	$(call descend,lib/api,clean)
 
-perf_clean: libapikfs_clean
+perf_clean:
 	$(call descend,$(@:_clean=),clean)
 
 selftests_clean:


