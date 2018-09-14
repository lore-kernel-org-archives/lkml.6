Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C64C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6F020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6F020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeINMMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:12:33 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:48646 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbeINMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:12:33 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 0i4ZgQwvCrjlY0i4cgrY7v; Fri, 14 Sep 2018 08:59:27 +0200
Subject: Re: [PATCH v2 0/2] media: platform: Add Aspeed Video Engine Driver
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au
References: <1536866964-71593-1-git-send-email-eajames@linux.vnet.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3fe3a367-5e63-446b-faba-fa6ac7a007cd@xs4all.nl>
Date:   Fri, 14 Sep 2018 08:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1536866964-71593-1-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEEGP8gPItKWEQoX876cN9wfAprAPA2ePgGm/cLgko+pCTGJY/xy0rL2Ux6FEx1nGh/6pNqo2ePi3dNbPv5w0DXZn6RbeB6CCiVqBSnIvluiB9zWfJgr
 MMRCOqhxjaFd/3B+P18QimqSbUbaqnI29q5rfhGOzk56q9t+1nCxzkpcIHWqvvntrqR839No7AX+VgQyY0KSEbl/DBrjR9fCKR/VpPI49SSYbjEW9p+gQw6C
 Vk//gV6oIm1/NCzSiyndIFBEcyF3/W3eGSPtD3frKLPSuIs3LTxrDjNo6tp7LizWGHyxjx/WzVsjyZvvkVpfxtAWozBbg6mns8V7VCy8guBDgRRcJxA4zFET
 o4RZxhuCRyrn46IRQnON5N6uJM6h7Nm218IW6q0iWRXi5PZWovcAlTWvbSvOJE1kZCIZwhiF0mZJn6wruei5GLZAQ3qcvRuGaMDKZwwtFWc75JRBa9R1IzMG
 ce7xSN7Q4Ogt+qkgkG/wNZl45bYamAm8KIKU4yGSoPbDg1F18c71hdf8jMs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 09:29 PM, Eddie James wrote:
> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
> can capture and compress video data from digital or analog sources. With
> the Aspeed chip acting as a service processor, the Video Engine can
> capture the host processor graphics output.
> 
> This series adds a V4L2 driver for the VE, providing a read() interface
> only. The driver triggers the hardware to capture the host graphics output
> and compress it to JPEG format.
> 
> 
> v4l2-compliance output:
> 
> v4l2-compliance SHA   : not available

There should be a SHA here. "not available" indicates that you didn't compile
from the git repository directly, and now I do not know how old this compliance
test is. Always compile from the latest git repo, never use a version from e.g.
a distro as they tend to be old and missing tests.

It would be great if you can do this and reply with the new compliance output.

Thanks!

	Hans

> 
> Driver Info:
> 	Driver name   : aspeed-video
> 	Card type     : Aspeed Video Engine
> 	Bus info      : platform:aspeed-video
> 	Driver version: 4.18.7
> 	Capabilities  : 0x81200001
> 		Video Capture
> 		Read/Write
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps   : 0x01200001
> 		Video Capture
> 		Read/Write
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
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Test input 0:
> 
> 	Control ioctls:
> 		test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 		test VIDIOC_QUERYCTRL: OK
> 		test VIDIOC_G/S_CTRL: OK
> 		test VIDIOC_G/S/TRY_EXT_CTRLS: OK
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
> 		test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
> 		test VIDIOC_EXPBUF: OK (Not Supported)
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK
> 	test MMAP: OK (Not Supported)
> 	test USERPTR: OK (Not Supported)
> 	test DMABUF: OK (Not Supported)
> 
> 
> Total: 47, Succeeded: 47, Failed: 0, Warnings: 0
> 
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
>  drivers/media/platform/aspeed-video.c              | 1469 ++++++++++++++++++++
>  5 files changed, 1512 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>  create mode 100644 drivers/media/platform/aspeed-video.c
> 

