Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403EFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7212083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7212083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeHaNHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:07:07 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:49600 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbeHaNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:07:06 -0400
Received: from [192.168.1.10] ([80.101.105.217])
        by smtp-cloud8.xs4all.net with ESMTPA
        id vfIAflteSaLLbvfIBf1WHK; Fri, 31 Aug 2018 11:00:36 +0200
Subject: Re: [PATCH 0/4] Add Amlogic video decoder driver
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20180831085205.14760-1-mjourdan@baylibre.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <386d4bc2-96a7-826f-392f-e54d3367e217@xs4all.nl>
Date:   Fri, 31 Aug 2018 11:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831085205.14760-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGuTkl+gJdltSI5bhA/aFjYxdXJXnVRkrCs8SCQJ49nbKCrKcwj8gxZ2xakTCKqLHKp/Rs68r9FuwoSsXsG0C83E/iWHKpQOsF/TX03fKlHGV12FNgNy
 YV7BbLjGMcX8MPM1w1LZa6wKL6Hfskbe7iBiKqavYyKzgUwJHESsnHHIVnxJ0t222IoxLRmODTYxlAaIPMUkbpMHQupAzM16HYyG+HTdv2gXa/AvSCFZfW5V
 DUBPsen/k90lw4XRJ1/pkAcitTiPEmBnb/g6TQEm+lePSGZrzo6pMOlit+BNSiFFfkurPSy6LvLTycRlqcUncS/Vnwdyfji2kiEmc6TOV/gaXj1YS1VJb5mE
 QPkvJwa+lL1lrXc6Oo0kmp9MxO5sWGeULBX86FogtS5yEmXiKlxntBzzr3SWitIJquwh+MIkw7yjUJDlBI9z0gPGn+mnH5i3czYJhLz40JsjUsIOx7cywPks
 uNl4r1+maq0t0xHbw14ypQlTIDRNA1K0CcKvDv+tYshOc+38SnUAI5TBJSoGcR7t3nLvSZU6uBsMOa1NBGFFnkTCjpQCZiY5FC51l5K6O5h+cSdABWRLs1xh
 JY+zJ8eN38ZMygORxnkFI3dooMVvmBGMwKKz9ZvJ/ZDCq/ePAZ8m6iDPgk1fuwmN4i0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 10:52 AM, Maxime Jourdan wrote:
> Hi everyone,
> 
> This patch series adds support for the Amlogic video decoder,
> as well as the corresponding dt bindings for GXBB/GXL/GXM chips.
> 
> It features decoding for the following formats:
> - MPEG 1
> - MPEG 2
> 
> The following formats will be added in future patches:
> - MJPEG
> - MPEG 4 (incl. Xvid, H.263)
> - H.264
> - HEVC (incl. 10-bit)
> 
> The following formats' development has still not started, but they are
> supported by the hardware:
> - VC1
> - VP9
> 
> The code was made in such a way to allow easy inclusion of those formats
> in the future.
> 
> The decoder is single instance.
> 
> Files:
>  - vdec.c handles the V4L2 M2M logic
>  - esparser.c manages the hardware bitstream parser
>  - vdec_helpers.c provides helpers to DONE the dst buffers as well as
>  various common code used by the codecs
>  - vdec_1.c manages the VDEC_1 block of the vdec IP
>  - codec_mpeg12.c enables decoding for MPEG 1/2.
>  - vdec_platform.c links codec units with vdec units
>  (e.g vdec_1 with codec_mpeg12) and lists all the available
>  src/dst formats and requirements (max width/height, etc.),
>  per compatible chip.
> 
> Firmwares are necessary to run the vdec. They can currently be found at:
> https://github.com/chewitt/meson-firmware
> 
> It was tested primarily with ffmpeg's v4l2-m2m implementation. For instance:
> $ ffmpeg -c:v mpeg2_v4l2m2m -i sample_mpeg2.mkv -f null -
> 
> Note: This patch series depends on
> "[PATCH v3 0/3] soc: amlogic: add meson-canvas"
> https://patchwork.kernel.org/cover/10573763/
> 
> The v4l2-compliance results are available below the patch diff.
> 
> Maxime Jourdan (4):
>   dt-bindings: media: add Amlogic Video Decoder Bindings
>   media: meson: add v4l2 m2m video decoder driver
>   ARM64: dts: meson-gx: add vdec entry
>   ARM64: dts: meson: add vdec entries
> 
>  .../bindings/media/amlogic,vdec.txt           |  63 ++
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  13 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  11 +
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  11 +
>  arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    |   4 +
>  drivers/media/platform/Kconfig                |  10 +
>  drivers/media/platform/meson/Makefile         |   1 +
>  drivers/media/platform/meson/vdec/Makefile    |   8 +
>  .../media/platform/meson/vdec/codec_mpeg12.c  | 169 +++
>  .../media/platform/meson/vdec/codec_mpeg12.h  |  13 +
>  drivers/media/platform/meson/vdec/dos_regs.h  |  97 ++
>  drivers/media/platform/meson/vdec/esparser.c  | 367 +++++++
>  drivers/media/platform/meson/vdec/esparser.h  |  27 +
>  drivers/media/platform/meson/vdec/vdec.c      | 987 ++++++++++++++++++
>  drivers/media/platform/meson/vdec/vdec.h      | 233 +++++
>  drivers/media/platform/meson/vdec/vdec_1.c    | 227 ++++
>  drivers/media/platform/meson/vdec/vdec_1.h    |  13 +
>  .../media/platform/meson/vdec/vdec_helpers.c  | 353 +++++++
>  .../media/platform/meson/vdec/vdec_helpers.h  |  44 +
>  .../media/platform/meson/vdec/vdec_platform.c | 100 ++
>  .../media/platform/meson/vdec/vdec_platform.h |  29 +
>  21 files changed, 2780 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt
>  create mode 100644 drivers/media/platform/meson/vdec/Makefile
>  create mode 100644 drivers/media/platform/meson/vdec/codec_mpeg12.c
>  create mode 100644 drivers/media/platform/meson/vdec/codec_mpeg12.h
>  create mode 100644 drivers/media/platform/meson/vdec/dos_regs.h
>  create mode 100644 drivers/media/platform/meson/vdec/esparser.c
>  create mode 100644 drivers/media/platform/meson/vdec/esparser.h
>  create mode 100644 drivers/media/platform/meson/vdec/vdec.c
>  create mode 100644 drivers/media/platform/meson/vdec/vdec.h
>  create mode 100644 drivers/media/platform/meson/vdec/vdec_1.c
>  create mode 100644 drivers/media/platform/meson/vdec/vdec_1.h
>  create mode 100644 drivers/media/platform/meson/vdec/vdec_helpers.c
>  create mode 100644 drivers/media/platform/meson/vdec/vdec_helpers.h
>  create mode 100644 drivers/media/platform/meson/vdec/vdec_platform.c
>  create mode 100644 drivers/media/platform/meson/vdec/vdec_platform.h
> 
> root@libretech-cc:~/v4l-utils# v4l2-compliance -d /dev/video0 
> v4l2-compliance SHA: not available, 64 bits

I see that there is no SHA, so you probably didn't compile this from a
checked-out git repo. Please do so, since without a SHA I don't know
whether or not you used the latest v4l2-compliance version.

Regards,

	Hans

> 
> Compliance test for device /dev/video0:
> 
> Driver Info:
> 	Driver name      : meson-vdec
> 	Card type        : Amlogic Video Decoder
> 	Bus info         : platform:meson-vdec
> 	Driver version   : 4.18.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 
> Required ioctls:
> 	test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
> 	test second /dev/video0 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
> 	test VIDIOC_QUERYCTRL: OK (Not Supported)
> 	test VIDIOC_G/S_CTRL: OK (Not Supported)
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 0 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 
> Total: 43, Succeeded: 43, Failed: 0, Warnings: 0
> 

