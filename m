Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeBET4s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBET4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:56:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A51217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Namhyung Kim <namhyung@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/10] tools headers: Synchronize sound/asound.h
Date: Mon,  5 Feb 2018 16:56:11 -0300
Message-Id: <20180205195620.9010-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from this cset:

  823dbb6eb08a ("ALSA: pcm: add SNDRV_PCM_FORMAT_{S,U}20")

It doesn't affect how the tools are built, this os done just to silence
this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'

Right now tools/perf uses this header to generate string tables to
translate ioctl commands in 'perf trace', see
tools/perf/trace/beauty/sndrv_pcm_ioctl.sh, here is an example
of a strace like system wide session, for one second:

  # perf trace -a -e ioctl sleep 1
     0.000 ( 0.019 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
     0.081 ( 0.006 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
     0.092 ( 0.006 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_STATUS_EXT, arg: 0x7f6745ec4ae0) = 0
    10.178 ( 0.013 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    10.229 ( 0.005 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    10.238 ( 0.013 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_STATUS_EXT, arg: 0x7f6745ec4ae0) = 0
    10.368 ( 0.009 ms): threaded-ml/26440 ioctl(fd: 141<socket:[111353]>, cmd: TIOCLINUX, arg: 0x7f8f70d2e1a4) = 0
    10.495 ( 0.018 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    10.526 ( 0.005 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    19.695 ( 0.018 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    19.757 ( 0.006 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    19.767 ( 0.005 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_STATUS_EXT, arg: 0x7f6745ec4ae0) = 0
<BIG SNIP>
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sfpeesn8w0pyn3fe7vf2xmfl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index c227ccba60ae..07d61583fd02 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -214,6 +214,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
 #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
 #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
+#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* in four bytes, LSB justified */
+/* gap in the numbering for a future standard linear format */
 #define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
 #define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
@@ -248,6 +253,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_LE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
@@ -259,6 +266,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_BE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
 #endif
 
 typedef int __bitwise snd_pcm_subformat_t;
-- 
2.14.3
