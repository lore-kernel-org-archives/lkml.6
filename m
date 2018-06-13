Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4F890C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D732086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D732086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935078AbeFMRRn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:17:43 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43570 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbeFMRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:17:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id AF37F41258;
        Wed, 13 Jun 2018 17:17:40 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CHAhB73pKITc; Wed, 13 Jun 2018 17:17:40 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 10BA741378;
        Wed, 13 Jun 2018 17:17:35 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest update 2 for Linux 4.18-rc1
Message-ID: <71fff95c-e017-da84-59ea-c4b8612d380a@kernel.org>
Date:   Wed, 13 Jun 2018 11:17:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8D009D9C2384C26B6E3177B3"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8D009D9C2384C26B6E3177B3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update 2 for 4.18-rc1

This second Kselftest update for Linux 4.18-rc1:

- fixes a signedness bug in cgroups test
- adds ppc support for kprobe args tests

diff is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------
The following changes since commit fa32156921daa5c175228e2cac7679d50efd6c52:

  selftests: lib: fix prime_numbers module search and skip logic (2018-05-30 21:32:55 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.18-rc1-2

for you to fetch changes up to 53c3daf8cfeae4b1289723c7abeb9540c1630cf8:

  kselftest/cgroup: fix a signedness bug (2018-06-07 13:44:30 -0600)

----------------------------------------------------------------
linux-kselftest-4.18-rc1-2

This second Kselftest update for Linux 4.18-rc1:

- fixes a signedness bug in cgroups test
- adds ppc support for kprobe args tests

----------------------------------------------------------------
Dan Carpenter (1):
      kselftest/cgroup: fix a signedness bug

Naveen N. Rao (1):
      selftests/ftrace: Add ppc support for kprobe args tests

 tools/testing/selftests/cgroup/cgroup_util.c                      | 4 ++--
 .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc  | 8 ++++++++
 .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc  | 7 +++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

-----------------------------------------------------------------------------------

--------------8D009D9C2384C26B6E3177B3
Content-Type: text/x-patch;
 name="linux-kselftest-4.18-rc1-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.18-rc1-2.diff"

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index b69bdeb4b9fe..1e9e3c470561 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -35,7 +35,7 @@ static ssize_t read_text(const char *path, char *buf, size_t max_len)
 	return len;
 }
 
-static ssize_t write_text(const char *path, char *buf, size_t len)
+static ssize_t write_text(const char *path, char *buf, ssize_t len)
 {
 	int fd;
 
@@ -140,7 +140,7 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key)
 int cg_write(const char *cgroup, const char *control, char *buf)
 {
 	char path[PATH_MAX];
-	size_t len = strlen(buf);
+	ssize_t len = strlen(buf);
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 5ba73035e1d9..a0002563e9ee 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -24,6 +24,14 @@ arm*)
   ARG2=%r1
   OFFS=4
 ;;
+ppc64*)
+  ARG2=%r4
+  OFFS=8
+;;
+ppc*)
+  ARG2=%r4
+  OFFS=4
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 231bcd2c4eb5..d026ff4e562f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -34,6 +34,13 @@ arm*)
   GOODREG=%r0
   BADREG=%ax
 ;;
+ppc*)
+  GOODREG=%r3
+  BADREG=%msr
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
 esac
 
 test_goodarg() # Good-args

--------------8D009D9C2384C26B6E3177B3--
