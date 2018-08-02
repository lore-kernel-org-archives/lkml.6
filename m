Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1112146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1112146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeHBJ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:57:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHBJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:57:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72874LI3430546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:07:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72873p23430543;
        Thu, 2 Aug 2018 01:07:03 -0700
Date:   Thu, 2 Aug 2018 01:07:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-90am4vm8hh1osms894dp2otr@git.kernel.org>
Cc:     wangnan0@huawei.com, dsahern@gmail.com, adrian.hunter@intel.com,
        tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: dsahern@gmail.com, wangnan0@huawei.com, adrian.hunter@intel.com,
          namhyung@kernel.org, tglx@linutronix.de, acme@redhat.com,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Default header_dir to cwd to
 work without parms
Git-Commit-ID: 61b229ce2c152e7700ca603c7b86cdd99619db01
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

Commit-ID:  61b229ce2c152e7700ca603c7b86cdd99619db01
Gitweb:     https://git.kernel.org/tip/61b229ce2c152e7700ca603c7b86cdd99619db01
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Jul 2018 14:24:02 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 09:56:46 -0300

perf trace beauty: Default header_dir to cwd to work without parms

Useful when checking the effects of header synchs for the files it uses
as a input to generate string tables, in retrospect this is how it
should've been done from day 1, not requiring the header_dir to be set
on the Makefile, will change everything later, so that the only parm,
common to all generators will be $(srctree) and $(beauty_outdir).

So, to see what it generates, just call it without any parameters:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh
  static const char *vhost_virtio_ioctl_cmds[] = {
	[0x00] = "SET_FEATURES",
	[0x01] = "SET_OWNER",
	[0x02] = "RESET_OWNER",
	[0x03] = "SET_MEM_TABLE",
	[0x04] = "SET_LOG_BASE",
	[0x07] = "SET_LOG_FD",
	[0x10] = "SET_VRING_NUM",
	[0x11] = "SET_VRING_ADDR",
	[0x12] = "SET_VRING_BASE",
	[0x13] = "SET_VRING_ENDIAN",
	[0x14] = "GET_VRING_ENDIAN",
	[0x20] = "SET_VRING_KICK",
	[0x21] = "SET_VRING_CALL",
	[0x22] = "SET_VRING_ERR",
	[0x23] = "SET_VRING_BUSYLOOP_TIMEOUT",
	[0x24] = "GET_VRING_BUSYLOOP_TIMEOUT",
	[0x30] = "NET_SET_BACKEND",
	[0x40] = "SCSI_SET_ENDPOINT",
	[0x41] = "SCSI_CLEAR_ENDPOINT",
	[0x42] = "SCSI_GET_ABI_VERSION",
	[0x43] = "SCSI_SET_EVENTS_MISSED",
	[0x44] = "SCSI_GET_EVENTS_MISSED",
	[0x60] = "VSOCK_SET_GUEST_CID",
	[0x61] = "VSOCK_SET_RUNNING",
  };
  static const char *vhost_virtio_ioctl_read_cmds[] = {
	[0x00] = "GET_FEATURES",
	[0x12] = "GET_VRING_BASE",
  };
  $

Or:

  $ tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
  static const char *sndrv_pcm_ioctl_cmds[] = {
	[0x00] = "PVERSION",
	[0x01] = "INFO",
	[0x02] = "TSTAMP",
	[0x03] = "TTSTAMP",
	[0x04] = "USER_PVERSION",
	[0x10] = "HW_REFINE",
	[0x11] = "HW_PARAMS",
	[0x12] = "HW_FREE",
	[0x13] = "SW_PARAMS",
	[0x20] = "STATUS",
	[0x21] = "DELAY",
	[0x22] = "HWSYNC",
	[0x23] = "SYNC_PTR",
	[0x24] = "STATUS_EXT",
	[0x32] = "CHANNEL_INFO",
	[0x40] = "PREPARE",
	[0x41] = "RESET",
	[0x42] = "START",
	[0x43] = "DROP",
	[0x44] = "DRAIN",
	[0x45] = "PAUSE",
	[0x46] = "REWIND",
	[0x47] = "RESUME",
	[0x48] = "XRUN",
	[0x49] = "FORWARD",
	[0x50] = "WRITEI_FRAMES",
	[0x51] = "READI_FRAMES",
	[0x52] = "WRITEN_FRAMES",
	[0x53] = "READN_FRAMES",
	[0x60] = "LINK",
	[0x61] = "UNLINK",
  };
  $

Etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-90am4vm8hh1osms894dp2otr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/drm_ioctl.sh                | 9 +++++----
 tools/perf/trace/beauty/kcmp_type.sh                | 2 +-
 tools/perf/trace/beauty/kvm_ioctl.sh                | 4 ++--
 tools/perf/trace/beauty/madvise_behavior.sh         | 2 +-
 tools/perf/trace/beauty/perf_ioctl.sh               | 2 +-
 tools/perf/trace/beauty/pkey_alloc_access_rights.sh | 2 +-
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh          | 4 ++--
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh          | 4 ++--
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh       | 6 +++---
 9 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/perf/trace/beauty/drm_ioctl.sh b/tools/perf/trace/beauty/drm_ioctl.sh
index 2149d3a98e42..9d3816815e60 100755
--- a/tools/perf/trace/beauty/drm_ioctl.sh
+++ b/tools/perf/trace/beauty/drm_ioctl.sh
@@ -1,13 +1,14 @@
 #!/bin/sh
 
-drm_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/drm/
+
 printf "#ifndef DRM_COMMAND_BASE\n"
-grep "#define DRM_COMMAND_BASE" $drm_header_dir/drm.h
+grep "#define DRM_COMMAND_BASE" $header_dir/drm.h
 printf "#endif\n"
 
 printf "static const char *drm_ioctl_cmds[] = {\n"
-grep "^#define DRM_IOCTL.*DRM_IO" $drm_header_dir/drm.h | \
+grep "^#define DRM_IOCTL.*DRM_IO" $header_dir/drm.h | \
 	sed -r 's/^#define +DRM_IOCTL_([A-Z0-9_]+)[	 ]+DRM_IO[A-Z]* *\( *(0x[[:xdigit:]]+),*.*/	[\2] = "\1",/g'
-grep "^#define DRM_I915_[A-Z_0-9]\+[	 ]\+0x" $drm_header_dir/i915_drm.h | \
+grep "^#define DRM_I915_[A-Z_0-9]\+[	 ]\+0x" $header_dir/i915_drm.h | \
 	sed -r 's/^#define +DRM_I915_([A-Z0-9_]+)[	 ]+(0x[[:xdigit:]]+)/\t[DRM_COMMAND_BASE + \2] = "I915_\1",/g'
 printf "};\n"
diff --git a/tools/perf/trace/beauty/kcmp_type.sh b/tools/perf/trace/beauty/kcmp_type.sh
index 40d063b8c082..a3c304caa336 100755
--- a/tools/perf/trace/beauty/kcmp_type.sh
+++ b/tools/perf/trace/beauty/kcmp_type.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *kcmp_types[] = {\n"
 regex='^[[:space:]]+(KCMP_(\w+)),'
diff --git a/tools/perf/trace/beauty/kvm_ioctl.sh b/tools/perf/trace/beauty/kvm_ioctl.sh
index bd28817afced..c4699fd46bb6 100755
--- a/tools/perf/trace/beauty/kvm_ioctl.sh
+++ b/tools/perf/trace/beauty/kvm_ioctl.sh
@@ -1,10 +1,10 @@
 #!/bin/sh
 
-kvm_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *kvm_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${kvm_header_dir}/kvm.h	| \
+egrep $regex ${header_dir}/kvm.h	| \
 	sed -r "s/$regex/\2 \1/g"	| \
 	egrep -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
diff --git a/tools/perf/trace/beauty/madvise_behavior.sh b/tools/perf/trace/beauty/madvise_behavior.sh
index 60ef8640ee70..431639eb4d29 100755
--- a/tools/perf/trace/beauty/madvise_behavior.sh
+++ b/tools/perf/trace/beauty/madvise_behavior.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/asm-generic/
 
 printf "static const char *madvise_advices[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MADV_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
diff --git a/tools/perf/trace/beauty/perf_ioctl.sh b/tools/perf/trace/beauty/perf_ioctl.sh
index faea4237c793..6492c74df928 100755
--- a/tools/perf/trace/beauty/perf_ioctl.sh
+++ b/tools/perf/trace/beauty/perf_ioctl.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *perf_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+PERF_EVENT_IOC_(\w+)[[:space:]]+_IO[RW]*[[:space:]]*\([[:space:]]*.\$.[[:space:]]*,[[:space:]]*([[:digit:]]+).*'
diff --git a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
index 62e51a02b839..e0a51aeb20b2 100755
--- a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
+++ b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/asm-generic/
 
 printf "static const char *pkey_alloc_access_rights[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+PKEY_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*'
diff --git a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
index aad5ab130539..eb511bb5fbd3 100755
--- a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 
-sound_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
 
 printf "static const char *sndrv_ctl_ioctl_cmds[] = {\n"
-grep "^#define[\t ]\+SNDRV_CTL_IOCTL_" $sound_header_dir/asound.h | \
+grep "^#define[\t ]\+SNDRV_CTL_IOCTL_" $header_dir/asound.h | \
 	sed -r 's/^#define +SNDRV_CTL_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.U., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
 printf "};\n"
diff --git a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
index b7e9ef6b2f55..6818392968b2 100755
--- a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 
-sound_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
 
 printf "static const char *sndrv_pcm_ioctl_cmds[] = {\n"
-grep "^#define[\t ]\+SNDRV_PCM_IOCTL_" $sound_header_dir/asound.h | \
+grep "^#define[\t ]\+SNDRV_PCM_IOCTL_" $header_dir/asound.h | \
 	sed -r 's/^#define +SNDRV_PCM_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.A., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
 printf "};\n"
diff --git a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
index 76f1de697787..0f6a5197d0be 100755
--- a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
+++ b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
@@ -1,17 +1,17 @@
 #!/bin/sh
 
-vhost_virtio_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *vhost_virtio_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${vhost_virtio_header_dir}/vhost.h | \
+egrep $regex ${header_dir}/vhost.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
 
 printf "static const char *vhost_virtio_ioctl_read_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?R\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${vhost_virtio_header_dir}/vhost.h | \
+egrep $regex ${header_dir}/vhost.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
