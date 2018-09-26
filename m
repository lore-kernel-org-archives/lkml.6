Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF9DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8829920666
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8829920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIZSQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:16:01 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:50482 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbeIZSQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:16:01 -0400
Received: from [IPv6:2001:983:e9a7:1:d896:2898:282a:e34b] ([IPv6:2001:983:e9a7:1:d896:2898:282a:e34b])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 58XEglbtmgyCD58XFgPb0r; Wed, 26 Sep 2018 14:03:19 +0200
Subject: Re: [PATCH v3 0/2] media: platform: Add Aspeed Video Engine Driver
To:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org, joel@jms.id.au
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <337a1869-4c16-edb0-976e-755f786afb01@xs4all.nl>
Date:   Wed, 26 Sep 2018 14:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMyNwsMvhboHr6LjXgchqLJEbzEVdy0v4WYaJuJOznXLZEUXxCE5n4j0+qB0L86lAN8XjyIsBAdxXhKAXPx/dwvCSTRl02GRTgUxnrcaEvhXsOB+URsf
 HW8IjIlp12BoQnVttgOEbvTajwQHQrN6KHyniYCgi7pviF3W7my30deSsMX9MBY/QS3gwd43GPH6lhmh8uMDN/C6AydGsccHIDmtnUPL+vRTogwkwiliug7U
 bDU58F9aES2Nudt7IrwbdrZuDover64y25msmRjGP3j8z2bBerQkONDwuCph/8vMlfPyQ6iCnbXGD1kFEI7WP1IklHdE1kjtI+aCqLY3VUPCy5neztSXZ2XD
 X0Yb+xtS1qdWU54g3oSN9A1JcbepuXJX0+FW8PWGBKOzEM54pLhX6PkhgFs+Q02sUnmlYl0JJmH4YJ3ONxSWAzoNzkrYrqnUKZwuiMSuVbgsfzvoRTY9Gh7n
 9+sDewUuzvz5GIEI2DA4yBpt1qxRxH01r7ioiK0bXOzumgUAGntAx78MKpqSjn0vCK5IFSNInDSkqczt8jw1Igi5W+Qsj1gCLPVy/jvCBGBkery4qjQBbnXJ
 04P5slxGLAiW/CdFdzETGtZy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 09:27 PM, Eddie James wrote:
> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
> can capture and compress video data from digital or analog sources. With
> the Aspeed chip acting as a service processor, the Video Engine can
> capture the host processor graphics output.
> 
> This series adds a V4L2 driver for the VE, providing the usual V4L2 streaming
> interface by way of videobuf2. Each frame, the driver triggers the hardware to
> capture the host graphics output and compress it to JPEG format.
> 
> I was unable to cross compile v4l2-compliance for ARM with our OpenBMC
> toolchain. Although bootstrap, configure, and make were successful, no binaries
> were generated... I was able to build v4l-utils 1.12.3 from the OpenEmbedded
> project, with the output below:

You can also try to build it manually:

g++ -o v4l2-compliance -DNO_LIBV4L2 v4l2-compliance.cpp v4l2-test-debug.cpp v4l2-test-input-output.cpp v4l2-test-controls.cpp v4l2-test-io-config.cpp v4l2-test-formats.cpp v4l2-test-buffers.cpp
v4l2-test-codecs.cpp v4l2-test-colors.cpp v4l2-test-media.cpp v4l2-test-subdevs.cpp media-info.cpp v4l2-info.cpp -I../.. -I../../include -I../common

(replace g++ with your cross compiler)

Hopefully that will work since 1.12.3 is way too old.

Regards,

	Hans

> 
> v4l2-compliance SHA   : not available
> 
> Driver Info:
> 	Driver name   : aspeed-video
> 	Card type     : Aspeed Video Engine
> 	Bus info      : platform:aspeed-video
> 	Driver version: 4.18.8
> 	Capabilities  : 0x85200001
> 		Video Capture
> 		Read/Write
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps   : 0x05200001
> 		Video Capture
> 		Read/Write
> 		Streaming
> 		Extended Pix Format
> 
> Compliance test for device /dev/video0 (not using libv4l2):
> 
> Required ioctls:
> 	test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
> 	test second video open: OK
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
> 	test VIDIOC_G/S/ENUMINPUT: OK
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 1 Audio Inputs: 0 Tuners: 0
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
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK
> 	test VIDIOC_DV_TIMINGS_CAP: OK
> 	test VIDIOC_G/S_EDID: OK
> 
> Test input 0:
> 
> 	Control ioctls:
> 		test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 		test VIDIOC_QUERYCTRL: OK
> 		test VIDIOC_G/S_CTRL: OK
> 		test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 		warn: ../../../v4l-utils-1.12.3/utils/v4l2-compliance/v4l2-test-controls.cpp(811): V4L2_CID_DV_RX_POWER_PRESENT not found for input 0
> 		test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 		test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 		Standard Controls: 3 Private Controls: 0
> 
> 	Format ioctls:
> 		test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 		test VIDIOC_G/S_PARM: OK
> 		test VIDIOC_G_FBUF: OK (Not Supported)
> 		test VIDIOC_G_FMT: OK
> 		test VIDIOC_TRY_FMT: OK
> 		test VIDIOC_S_FMT: OK
> 		test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 		test Cropping: OK (Not Supported)
> 		test Composing: OK (Not Supported)
> 		test Scaling: OK (Not Supported)
> 
> 	Codec ioctls:
> 		test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 		test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 		test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> 	Buffer ioctls:
> 		test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 		test VIDIOC_EXPBUF: OK (Not Supported)
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK
> 	test MMAP: OK                                     
> 	test USERPTR: OK (Not Supported)
> 	test DMABUF: OK (Not Supported)
> 
> 
> Total: 47, Succeeded: 47, Failed: 0, Warnings: 1
> 
> Changes since v2:
>  - Switch to streaming interface. This involved a lot of changes.
>  - Rework memory allocation due to using videobuf2 buffers, but also only
>    allocate the necessary size of source buffer rather than the max size
> 
> Changes since v1:
>  - Removed le32_to_cpu calls for JPEG header data
>  - Reworked v4l2 ioctls to be compliant.
>  - Added JPEG controls
>  - Updated devicetree docs according to Rob's suggestions.
>  - Added myself to MAINTAINERS
> 
> Eddie James (2):
>   dt-bindings: media: Add Aspeed Video Engine binding documentation
>   media: platform: Add Aspeed Video Engine driver
> 
>  .../devicetree/bindings/media/aspeed-video.txt     |   26 +
>  MAINTAINERS                                        |    8 +
>  drivers/media/platform/Kconfig                     |    8 +
>  drivers/media/platform/Makefile                    |    1 +
>  drivers/media/platform/aspeed-video.c              | 1645 ++++++++++++++++++++
>  5 files changed, 1688 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>  create mode 100644 drivers/media/platform/aspeed-video.c
> 

