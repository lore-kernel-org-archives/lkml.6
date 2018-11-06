Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D37C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1166C2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IYI4EAyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1166C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbeKFRXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:23:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45412 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:23:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so9341057wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvWPY8lD+uDPSGpeopEgtycdO4yrSvFjSZp0WZ61amQ=;
        b=IYI4EAyvAdE33p/6PxJfuYk2+TRQdM89NWN5jUdf5D26+dArWJlmgmkBuFDteoIY4m
         jb120oKaCAIV4rMXaGNB6E7cdz60tMrGl0jPdI4JoG4ktipGYtrhUMsI2OQx2BppXFKo
         /r+Xn1zbeK6hOF+wpVS31JJ1v45qBzFgkirDJb3XaXoYQ9GzRnYzgmVu5Oofzp9KX/Ky
         yP4KzmW/QA+kS3H+SXhHD3pppBEiRdfHhLRfVRPFKcRNUQ0ejPNQnyDsvJmlXukoNxSY
         oXL0HdsXQ4wNJch+kIleovSfuHdMkV/NzEMBiRD0cJHcvI9+U3170K9StohOpPEuG0Gt
         BvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvWPY8lD+uDPSGpeopEgtycdO4yrSvFjSZp0WZ61amQ=;
        b=tCm15pHzHoESBmnbHvQPXFunhHjEEc6vilIKqCYOpSB00p2e5Ft/6Q1gKC4Cq9YENA
         F7nazky1DGFenN7rcMEKgK7wZnAh8UDl0VUnYMYWi2naipagnIwFPLZpYxXn1JgKDzIb
         kYdgmAbaPViV0FrOQlk/e7yfK2sllt+V3ERwSflEG+pD4FtGgJpVgHEkrv0ipE45VoBJ
         CcIkvLbwS6biK6huXadbTjK4fJW1U+lha1OlY20MdoAfThles3pdjFh87CJG7fvexwis
         gOVVm3VX8su2/ha/UifKX8QyCUx5PYOUWjkCy1aVDOOhhCeHQTm8QdzDDAASfC2vZ8IH
         laiw==
X-Gm-Message-State: AGRZ1gIoDEitgVF/XpFQKgSWlwUCu08rNs4ls1gbFSrhqSOlS3TeG2EJ
        P4U1TKHl4mUCAt7nWMtQkrNJzg==
X-Google-Smtp-Source: AJdET5enZVcBD2a71942Nh8r2uW3BoP0bQWNoa3OBG/jpNNFAQ1i+LXcHJ2IM/RC10egGS/BJ1VYRg==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr24071500wre.157.1541491180503;
        Mon, 05 Nov 2018 23:59:40 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id z16-v6sm918171wmc.0.2018.11.05.23.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 23:59:39 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 0/3] Add Amlogic video decoder driver
Date:   Tue,  6 Nov 2018 08:59:23 +0100
Message-Id: <20181106075926.19269-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.1
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
There is an ongoing effort to bring those firmwares to linux-firmware
but they're not in yet, currently blocked by licensing issues.

It was tested primarily with ffmpeg's v4l2-m2m implementation. For instance:
$ ffmpeg -c:v mpeg2_v4l2m2m -i sample_mpeg2.mkv -f null -

The v4l2-compliance results are available below the patch diff.

Changes since v3 [2]:
 - strlcpy -> strscpy
 - queue_setup: account for existing buffers when clamping *num_buffers
 - removed support for CREATE_BUFS. This caused issues with gstreamer and allowed
 userspace to alloc more buffers than the decoder can handle in its fixed list.
 So for now we just disable it and only allow allocating via REQBUFS.
 - rebased & tested with 4.20-rc1

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

[2] https://lore.kernel.org/patchwork/cover/993093/
[1] https://patchwork.kernel.org/cover/10595803/
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
 .../media/platform/meson/vdec/codec_mpeg12.c  |  209 ++++
 .../media/platform/meson/vdec/codec_mpeg12.h  |   14 +
 drivers/media/platform/meson/vdec/dos_regs.h  |   98 ++
 drivers/media/platform/meson/vdec/esparser.c  |  322 +++++
 drivers/media/platform/meson/vdec/esparser.h  |   32 +
 drivers/media/platform/meson/vdec/vdec.c      | 1034 +++++++++++++++++
 drivers/media/platform/meson/vdec/vdec.h      |  251 ++++
 drivers/media/platform/meson/vdec/vdec_1.c    |  231 ++++
 drivers/media/platform/meson/vdec/vdec_1.h    |   14 +
 .../media/platform/meson/vdec/vdec_helpers.c  |  412 +++++++
 .../media/platform/meson/vdec/vdec_helpers.h  |   48 +
 .../media/platform/meson/vdec/vdec_platform.c |  101 ++
 .../media/platform/meson/vdec/vdec_platform.h |   30 +
 18 files changed, 2894 insertions(+)
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

root@libretech-cc:~/v4l-utils# v4l2-compliance -d /dev/video0 
v4l2-compliance SHA: 0aa28f4293ee3306b34ea2866ef5f26fa75d2ed0, 64 bits

Compliance test for device /dev/video0:

Driver Info:
	Driver name      : meson-vdec
	Card type        : Amlogic Video Decoder
	Bus info         : platform:meson-vdec
	Driver version   : 4.20.0
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
		warn: v4l2-test-buffers.cpp(504): VIDIOC_CREATE_BUFS not supported
		warn: v4l2-test-buffers.cpp(504): VIDIOC_CREATE_BUFS not supported
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK

Total: 43, Succeeded: 43, Failed: 0, Warnings: 2

-- 
2.19.1

