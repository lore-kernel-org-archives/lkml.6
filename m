Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54774C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0272086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HD+aw0Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0272086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIKUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:09:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44022 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeIKUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:09:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so26421523wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JKs3NDGL8iqqz0I+G9xiz+dNNdbLmBVlO1jvFs8hl5w=;
        b=HD+aw0VqekEPaBsx5ql88mC2qXrO2h5iliQevNSXUlmTtWilonAlM8Uyn+ouqI6y7S
         YoQ0uB62egbd+wjzs2/DqBzi2PFrEJtnlPiujJWSN8F9XwGMMhNy6V6vLxtyx1jPxTzH
         7d1t2Hu/nEKS8xzUWjW0ehRLuo0tSMsX7yQXimrOga6rvqXJfNDHN9VQlmkd+FOzk7rM
         daNPFgN2IbD9FaF8Zd/df6tIecJpXn5RidjaNnO0YESft/3ue1CVDhusiX55pg8e0+EW
         Pc9nBo04f4ikK6guV7hILacN+f1oWeTA38Gg4mFIwjwYtW02Zm9DkMgK5nY1GA9lcmRO
         dmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JKs3NDGL8iqqz0I+G9xiz+dNNdbLmBVlO1jvFs8hl5w=;
        b=HGknoczhlOgI5Mi+Pe/6vMq6TTybgRbxnFK9lIWvC6Uw2/99jE4buZOV5ACA/IZAN4
         sF/F9tmKheF/lfC2zuI21cpbpbfhIx7a0+Sh/j0U2AliGQzSnY8Zglnvkdd4lnyYrHw8
         fGKCUVMtON8qZ91ts72haGOxwwjVvmo8P9x+QnvUwlFt4qCpljfkel1mAO6SVho119df
         SaWdEmeSysABceCG0mTbkHcgd+x3ks2oUpiXDYyATf1GaPVPtWMyQjgQhwfv8jhI4n8w
         LF3Zc0OPl3786p0dz335oP9QMnXOMSSLyThza6ahsU6O4fwPSmqQb/sYK4SvoHuj/BVv
         dg6w==
X-Gm-Message-State: APzg51D4NxMvsnulxQwbR3viheQx40wxNGKJk/qqFJ/nhl/eUksdzYZP
        gZ/FmH6vCwsnTZB3PNufpjlmjQ==
X-Google-Smtp-Source: ANB0VdbVsTAT+K5nYzHuTfB4Ag+xFssgPOiGF7okEirlU+MCRM6rURQynM8nWSTH8LFfU6TiJkD6yw==
X-Received: by 2002:a5d:4e8b:: with SMTP id e11-v6mr20347269wru.32.1536678588823;
        Tue, 11 Sep 2018 08:09:48 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id x65-v6sm618625wmg.39.2018.09.11.08.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:09:47 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 0/3] Add Amlogic video decoder driver
Date:   Tue, 11 Sep 2018 17:09:35 +0200
Message-Id: <20180911150938.3844-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patch series adds support for the Amlogic video decoder,
as well as the corresponding dt bindings for GXBB/GXL/GXM chips.

It features decoding for the following formats:
- MPEG 1
- MPEG 2

The following formats will be added in future patches:
- MJPEG
- MPEG 4 (incl. Xvid, H.263)
- H.264
- HEVC (incl. 10-bit)

The following formats' development has still not started, but they are
supported by the hardware:
- VC1
- VP9

The code was made in such a way to allow easy inclusion of those formats
in the future.

The decoder is single instance.

Files:
 - vdec.c handles the V4L2 M2M logic
 - esparser.c manages the hardware bitstream parser
 - vdec_helpers.c provides helpers to DONE the dst buffers as well as
 various common code used by the codecs
 - vdec_1.c manages the VDEC_1 block of the vdec IP
 - codec_mpeg12.c enables decoding for MPEG 1/2.
 - vdec_platform.c links codec units with vdec units
 (e.g vdec_1 with codec_mpeg12) and lists all the available
 src/dst formats and requirements (max width/height, etc.),
 per compatible chip.

Firmwares are necessary to run the vdec. They can currently be found at:
https://github.com/chewitt/meson-firmware

It was tested primarily with ffmpeg's v4l2-m2m implementation. For instance:
$ ffmpeg -c:v mpeg2_v4l2m2m -i sample_mpeg2.mkv -f null -

Note: This patch series depends on
"[PATCH v3 0/3] soc: amlogic: add meson-canvas"
https://patchwork.kernel.org/cover/10573763/

The v4l2-compliance results are available below the patch diff.

Changes since v1 [0]:
 - use named interrupts in the bindings
 - rewrite description in the bindings doc
 - don't include the dts changes in the patch series
 - fill the vb2 queues locks
 - fill the video_device lock
 - use helpers for wait_prepare and wait_finish vb2_ops
 - remove unnecessary usleep in between esparser writes.
 Extensive testing of every codec on GXBB/GXL didn't reveal
 any fails without it, so just remove it.
 - compile v4l2_compliance inside the git repo
 - Check for plane number/plane size to pass the latest v4l2-compliance test
 - Moved the single instance check (returning -EBUSY) to start/stop streaming
 The check was previously in queue_setup but there was no great location to
 clear it except for .close().
 - Slight rework of the way CAPTURE frames are timestamped for better accuracy
 - Implement PAR reporting via VIDIOC_CROPCAP

[0] https://patchwork.kernel.org/cover/10583391/

Maxime Jourdan (3):
  dt-bindings: media: add Amlogic Video Decoder Bindings
  media: meson: add v4l2 m2m video decoder driver
  MAINTAINERS: Add meson video decoder

 .../bindings/media/amlogic,vdec.txt           |   71 ++
 MAINTAINERS                                   |    8 +
 drivers/media/platform/Kconfig                |   10 +
 drivers/media/platform/meson/Makefile         |    1 +
 drivers/media/platform/meson/vdec/Makefile    |    8 +
 .../media/platform/meson/vdec/codec_mpeg12.c  |  200 ++++
 .../media/platform/meson/vdec/codec_mpeg12.h  |   14 +
 drivers/media/platform/meson/vdec/dos_regs.h  |   98 ++
 drivers/media/platform/meson/vdec/esparser.c  |  366 ++++++
 drivers/media/platform/meson/vdec/esparser.h  |   32 +
 drivers/media/platform/meson/vdec/vdec.c      | 1013 +++++++++++++++++
 drivers/media/platform/meson/vdec/vdec.h      |  247 ++++
 drivers/media/platform/meson/vdec/vdec_1.c    |  235 ++++
 drivers/media/platform/meson/vdec/vdec_1.h    |   14 +
 .../media/platform/meson/vdec/vdec_helpers.c  |  437 +++++++
 .../media/platform/meson/vdec/vdec_helpers.h  |   48 +
 .../media/platform/meson/vdec/vdec_platform.c |  101 ++
 .../media/platform/meson/vdec/vdec_platform.h |   30 +
 18 files changed, 2933 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt
 create mode 100644 drivers/media/platform/meson/vdec/Makefile
 create mode 100644 drivers/media/platform/meson/vdec/codec_mpeg12.c
 create mode 100644 drivers/media/platform/meson/vdec/codec_mpeg12.h
 create mode 100644 drivers/media/platform/meson/vdec/dos_regs.h
 create mode 100644 drivers/media/platform/meson/vdec/esparser.c
 create mode 100644 drivers/media/platform/meson/vdec/esparser.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec_1.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec_1.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec_helpers.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec_helpers.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec_platform.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec_platform.h

root@libretech-cc:~# v4l2-compliance -d /dev/video0 
v4l2-compliance SHA: d26e4941419b05fcb2b6708ee32aef367c2ec4af, 64 bits

Compliance test for device /dev/video0:

Driver Info:
	Driver name      : meson-vdec
	Card type        : Amlogic Video Decoder
	Bus info         : platform:meson-vdec
	Driver version   : 4.19.0
	Capabilities     : 0x84204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format

Required ioctls:
	test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
	test second /dev/video0 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK

Total: 43, Succeeded: 43, Failed: 0, Warnings: 0

-- 
2.18.0

