Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53767C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2474A214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2474A214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeKVBjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:39:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeKVBjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:39:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wALF46tX3418522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 07:04:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wALF45u83418519;
        Wed, 21 Nov 2018 07:04:05 -0800
Date:   Wed, 21 Nov 2018 07:04:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zin76fe6iykqsilvo6u47f9o@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, wangnan0@huawei.com, mingo@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
        dsahern@gmail.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          jolsa@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
          gregkh@linuxfoundation.org, tglx@linutronix.de,
          dsahern@gmail.com, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, nicolas.ferre@microchip.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools uapi asm-generic: Synchronize ioctls.h
Git-Commit-ID: 83d9bdeaedd8f7aa9749828364f0018cacd1dad3
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

Commit-ID:  83d9bdeaedd8f7aa9749828364f0018cacd1dad3
Gitweb:     https://git.kernel.org/tip/83d9bdeaedd8f7aa9749828364f0018cacd1dad3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 19 Nov 2018 12:31:45 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Nov 2018 12:31:45 -0800

tools uapi asm-generic: Synchronize ioctls.h

To pick up the changes in:

  ad8c0eaa0a41 ("tty/serial_core: add ISO7816 infrastructure")

That is a change that imply a change to be made in tools/perf/trace/beauty/ioctl.c to
make 'perf trace' ioctl syscall argument beautifier to support these new
commands:  TIOCGISO7816 and TIOCSISO7816.

This is not yet done automatically by a script like is done for some
other headers, for instance:

  $ tools/perf/trace/beauty/drm_ioctl.sh | head
  #ifndef DRM_COMMAND_BASE
  #define DRM_COMMAND_BASE                0x40
  #endif
  static const char *drm_ioctl_cmds[] = {
	[0x00] = "VERSION",
	[0x01] = "GET_UNIQUE",
	[0x02] = "GET_MAGIC",
	[0x03] = "IRQ_BUSID",
	[0x04] = "GET_MAP",
	[0x05] = "GET_CLIENT",
  $

So we will need to change tools/perf/trace/beauty/ioctl.c in a follow up
patch until we switch to a generator script.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zin76fe6iykqsilvo6u47f9o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/ioctls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/asm-generic/ioctls.h b/tools/include/uapi/asm-generic/ioctls.h
index 040651735662..cdc9f4ca8c27 100644
--- a/tools/include/uapi/asm-generic/ioctls.h
+++ b/tools/include/uapi/asm-generic/ioctls.h
@@ -79,6 +79,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
