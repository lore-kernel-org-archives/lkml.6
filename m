Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F79C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00092087A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v/rNg0h5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00092087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeI1Uxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:53:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37511 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeI1Uxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:53:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26-v6so2446855wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYpntDMKXAKcCKlhpT/fz4W/lhfdfR3RD1PAmN/mRvc=;
        b=v/rNg0h5335NdtMw+IV/VLuea9ZAKNz5+D2G0ezusGWyrbQ3Ay7/MlXBCKxOdpIKzp
         Cev0h1XjJQHbnS3nAXLoFiQH2u8cDUkDj6a9AeIn2iTtHGo1zKxUvZb4qRZHk44kB8IX
         2kfvE38lIkUK5OenSbk6JXvHh5KIvCos77QGSdFyrYt/jFPxzHFP0M5sXwWRt9NHXQ6t
         Sh4ubUvFjjQjqVNo5XeWjZjKIB3ujstJM9kWM0T7ogE42wOZw3/UrjIgXV5qbbYJGj2e
         uJGSZZhks0ELX7OzpymRshByw46GMaj1A7ZEGZqn/58QvlOt/d7PyFM+en7tXFp2a0Ty
         R+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYpntDMKXAKcCKlhpT/fz4W/lhfdfR3RD1PAmN/mRvc=;
        b=swoc3iPoQ59k0/LrfqOKIS+ADMIWeSiDYgx8pdVIEEUo8ImdL2q5yhrqcO2mWmlN+B
         +aGfe5uBAmVvh210U/cSAhqGLRy9wOSsKFkGnle+tqkjPVSXkt9tctI52Sg8gRSJHXuj
         dT1YbdqfNfcSkRiYvWKf7XR6YrA2fPnH8+1iL3UlsqVfkJUXiKvfy0rn5X4yNcxzKaqf
         /oqxCrE8niPkioRIb7ChUO1G+fOKcLBMKc8Xox839pUQerG4EnMK56fTopu6NQwj/Lhr
         bQl3x+JS58YnTopWE9jIgOSg1BqsLV2L1tlIED9SyCMHPkqccl+RCYjx/5Gfy8HMriWH
         Yfwg==
X-Gm-Message-State: ABuFfogNuuR/KEAFXSDwkh2qKwxc5IxnFRuDG6h423KpUNBXVMoQt72V
        MsMHE9ZI8Oslgab5Y5xeZEf9Jw==
X-Google-Smtp-Source: ACcGV61gTd25g4we8Ym9rbWoRzWy+TAurribrfeHIaUhbMssyf6o7Kziuo400MBCWfaz947G3LW1Sw==
X-Received: by 2002:a1c:ef15:: with SMTP id n21-v6mr1836374wmh.151.1538144966421;
        Fri, 28 Sep 2018 07:29:26 -0700 (PDT)
Received: from localhost.localdomain (ip-123.net-89-3-157.rev.numericable.fr. [89.3.157.123])
        by smtp.gmail.com with ESMTPSA id w72-v6sm6827477wrc.52.2018.09.28.07.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:29:25 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Add Amlogic video decoder driver
Date:   Fri, 28 Sep 2018 16:28:13 +0200
Message-Id: <20180928142816.4311-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This canvas series is merged in Kevin Hilman's tree with a tag:
Repo: https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git
Tag:  amlogic-drivers-canvas

The v4l2-compliance results are available below the patch diff.

Changes since v2 [1]:
 - Override capture queue's min_buffers_needed in queue_setup
 The HW needs the full buffer list to be available when doing start_streaming
 - Fix the draining sequence
 The blob that we write to the ESPARSER to trigger drain is codec-dependent.
 The one that was sent in v1 is specific to H.264 and isn't guaranteed to
 trigger drain for MPEG2. For the latter, a simple MPEG2 EOS code
 should be sent to the ESPARSER instead.
 - Slight enhancements to the way we do vififo offset<=>timestamp matching

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
[1] https://patchwork.kernel.org/cover/10595803/

Maxime Jourdan (3):
  dt-bindings: media: add Amlogic Video Decoder Bindings
  media: meson: add v4l2 m2m video decoder driver
  MAINTAINERS: Add meson video decoder

 .../bindings/media/amlogic,vdec.txt           |   71 ++
 MAINTAINERS                                   |    8 +
 drivers/media/platform/Kconfig                |   10 +
 drivers/media/platform/meson/Makefile         |    1 +
 drivers/media/platform/meson/vdec/Makefile    |    8 +
 .../media/platform/meson/vdec/codec_mpeg12.c  |  209 ++++
 .../media/platform/meson/vdec/codec_mpeg12.h  |   14 +
 drivers/media/platform/meson/vdec/dos_regs.h  |   98 ++
 drivers/media/platform/meson/vdec/esparser.c  |  322 ++++++
 drivers/media/platform/meson/vdec/esparser.h  |   32 +
 drivers/media/platform/meson/vdec/vdec.c      | 1024 +++++++++++++++++
 drivers/media/platform/meson/vdec/vdec.h      |  251 ++++
 drivers/media/platform/meson/vdec/vdec_1.c    |  231 ++++
 drivers/media/platform/meson/vdec/vdec_1.h    |   14 +
 .../media/platform/meson/vdec/vdec_helpers.c  |  412 +++++++
 .../media/platform/meson/vdec/vdec_helpers.h  |   48 +
 .../media/platform/meson/vdec/vdec_platform.c |  101 ++
 .../media/platform/meson/vdec/vdec_platform.h |   30 +
 18 files changed, 2884 insertions(+)
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
 
root@hardkernel-odroidc2:~# v4l2-compliance -d /dev/video0 
v4l2-compliance SHA: 7bde5ef172bd4a09b9544788ba9c5dbb1aa9994a, 64 bits

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
2.19.0

