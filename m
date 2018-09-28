Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E778C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40EF216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40EF216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeI1SIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:08:50 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:57047 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729308AbeI1SIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:08:50 -0400
Received: from [192.168.1.10] ([80.101.105.217])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 5rD1gEuQ2S9Y35rD2g1kcl; Fri, 28 Sep 2018 13:45:24 +0200
Subject: Re: [PATCH v3 0/2] media: platform: Add Aspeed Video Engine Driver
To:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org, joel@jms.id.au
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <71bf665e-6d9b-a8f9-8e8f-7354dd095cc9@xs4all.nl>
Date:   Fri, 28 Sep 2018 13:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFy5YvZnxCuf3QI2vKLC0sBQWEwGy1uyJcPe4JZvDFZ2iPzpKf4KuXtJRkOVhWrH0XZI+ffBsGw+sNNyi48b0ChCpZY3qk6+5Pm1T47smYiThoaag2Wy
 lVEvj4sF07Nkgjd6/SU9StxKVdPmO9pl/SHSismz5QwYl81T8UIQ6v442d0eIwu/j68rizZykanO84Y0pdn2RUz38Uy6ZyG/cjvs4w0IAcvga6WY6/x7VF0J
 d7MgKRl52uefulHiQsVi9EumTqTL61wR1rq7Ih3GCz95SFFRg1QPE5DdoZGZQT6U9t3sDo7+MU0ycHyLFiLY8RghLPU2Z916M80YHibskx/LpNOyoml3fWOD
 s3f0iOi0k/yCStt9RGCDKwsf66dUpyokmRZJCLalmko7Wn0Y7Ihjkt9sibfamAgOzHoRvzJicuxJCoGsScVKZwhh9IuGdfrJq0Hlc3Q1cs7I+/sZjS8GEPiW
 mVrjeDvDnjZSBY2BXdhiOYOstsuI38KaMc3fxpPtkCxtWKy+pOufcwJZzjw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

On 09/25/2018 09:27 PM, Eddie James wrote:
> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
> can capture and compress video data from digital or analog sources. With
> the Aspeed chip acting as a service processor, the Video Engine can
> capture the host processor graphics output.
> 
> This series adds a V4L2 driver for the VE, providing the usual V4L2 streaming
> interface by way of videobuf2. Each frame, the driver triggers the hardware to
> capture the host graphics output and compress it to JPEG format.

This is starting to look really nice. Are the performance issues you had originally
with the streaming API now solved?

I reviewed patch 2/2 and I think it is best if you incorporate my comments and post
a v4. At that point I will take a closer look at the DV_TIMINGS implementation in the
driver, esp. enum_dv_timings and dv_timings_cap.

In any case, I am much happier about this v3, this was a big step forward.

Thank you for all your work!

	Hans

> 
> I was unable to cross compile v4l2-compliance for ARM with our OpenBMC
> toolchain. Although bootstrap, configure, and make were successful, no binaries
> were generated... I was able to build v4l-utils 1.12.3 from the OpenEmbedded
> project, with the output below:
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

