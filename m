Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeBFOKS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:10:18 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:45772 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751725AbeBFOKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:10:11 -0500
Subject: Re: [PATCH v5 00/16] Rockchip ISP1 Driver
To: Shunqian Zheng <zhengsq@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        allon.huang@rock-chips.com, devicetree@vger.kernel.org,
        heiko@sntech.de, robh+dt@kernel.org, Joao.Pinto@synopsys.com,
        Luis.Oliveira@synopsys.com, Jose.Abreu@synopsys.com,
        jacob2.chen@rock-chips.com
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <e479af2f-66d7-0f1e-6eaa-a76e593eea46@xs4all.nl>
Date: Tue, 6 Feb 2018 15:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLQJ+4o4KcxGPmp6bPfP8pY378gUMKvVGHGSQm+Iiw6QALKnahKkCwmsOu5s4tB8brrpC+Bn38DXjxKW4si1xtH4p33n7naEB0ZSaCgrYTFIz8nxW1o+
 xwaLTMwddX1XGy1Xv8j+hngDbPT+A636249Lw0TGJib8MqL1WnnDJPtVQmBljIyIl4/SmBIIwPfuW1ErajhLlexy7cuskE3eZYgBsalg1f+YrzSPN851y8ES
 jqGlMAVmiJ4qoZuz2kApAN1Sm49753SNC7tLks0QY0/t9Q5tgf8ifDDJK6jsi/eJYRBG5hdd4M455pUjr8YYnIcAHyRY7C6F8TqkWaL5ZAGsK+Yt7PwASXzH
 d4gbn3r9nHRZ+t6S8IT4AHOM53m/lepr1qo1rlvHLJJXPEkg8eatbXxhQgmye4wFeEFy1WJqcsJ1hmcKYxMtNA0wKOJY9JGQQ1rDm2da98vpIGOnYiwZ+hoE
 B56DVmSPjA0l2ojDWZDZB9sWE88Gs7SWlUUpzLEnCD+hBNx5UwFPV7fimkdpEMU4eOMR3n6QTPgXamJfvQJufpV2FbqkEsMAbX7FbnXkXARrGbnP0Lv72DBj
 Opd/WSn0Dv+6FmUuUs1KayucFQqzPUB9bU2po30dXjZaiMIPXQfnv11zgGL+l/7AhIl/dHoBfcT09D/NKg9731KyY8fl6v981Rws9jNLLF9UOapbT/Es7TD6
 N8bQg9Oo3UELSzJoG4/Clk13kgHV84q4Xx2oze+PxBk2mjL0/Fp1yrm9F8Ohx1ZcdQhoUHjo7MPk8YYw8KSxNw8rsKHljW8bjZ2ZxH42We2uUbRkr94O5kNm
 zmTp+R0sdD0aikF06MB3DSJz97SYy2yYKdszi7P45JxRu5U80m/w1TvetxAvJ1790xtKT6y267tfxmeJEOBu3W8b4jBTmb3M4p2+4cmjxtCEjZ5oY5K4beH7
 XKnhfBRIoLAjdBzsmysdAxucNW4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shunqian Zheng,

Thank you for this patch series. My apologies for the late reply, it arrived
in the middle of my Christmas vacation and completely forgot about it afterwards.

I finished my review. Besides small stuff I have basically two things that need
resolving: proof that the param/stats meta data has the same layout for 32 and
64 bit ARM compilers and the use of the deprecated g_mbus_config op. I'll discuss
the latter with Thomas tomorrow.

For v6 I would like to see the output of v4l2-compliance for this driver included
in the cover letter. If the regular v4l2-compliance (no arguments other than -d)
passes, then you can also try v4l2-compliance -s, and if that passes than try -f.
The last one cycles through all formats.

Always compile v4l2-compliance from the latest v4l-utils.git.

It's even more important than usual since I added tests for /dev/v4l-subdevX and
/dev/mediaX devices last weekend.

You'll need to apply these two patches first if you want to test such devices:

https://patchwork.linuxtv.org/patch/46817/
https://patchwork.linuxtv.org/patch/46822/

It's brand new code, so there may be bugs in the tests themselves.

BTW, next time if you don't hear from me for more than 2 weeks, then ping me.

Regards,

	Hans

On 12/29/17 08:52, Shunqian Zheng wrote:
> changes in V5: Sync with local changes,
>   - fix the SP height limit
>   - speed up the second stream capture
>   - the second stream can't force sync for rsz when start/stop streaming
>   - add frame id to param vb2 buf
>   - enable luminance maximum threshold
> 
> changes in V4:
>   - fix some bugs during development
>   - move quantization settings to rkisp1 subdev
>   - correct some spelling problems
>   - describe ports in dt-binding documents
> 
> changes in V3:
>   - add some comments
>   - fix wrong use of v4l2_async_subdev_notifier_register
>   - optimize two paths capture at a time
>   - remove compose
>   - re-struct headers
>   - add a tmp wiki page: http://opensource.rock-chips.com/wiki_Rockchip-isp1
> 
> changes in V2:
>   mipi-phy:
>     - use async probing
>     - make it be a child device of the GRF
>   isp:
>     - add dummy buffer
>     - change the way to get bus configuration, which make it possible to
>             add parallel sensor support in the future(without mipi-phy driver).
> 
> This patch series add a ISP(Camera) v4l2 driver for rockchip rk3288/rk3399 SoC.
> 
> Wiki Pages:
> http://opensource.rock-chips.com/wiki_Rockchip-isp1
> 
> Jacob Chen (12):
>   media: doc: add document for rkisp1 meta buffer format
>   media: rkisp1: add Rockchip MIPI Synopsys DPHY driver
>   media: rkisp1: add Rockchip ISP1 subdev driver
>   media: rkisp1: add ISP1 statistics driver
>   media: rkisp1: add ISP1 params driver
>   media: rkisp1: add capture device driver
>   media: rkisp1: add rockchip isp1 core driver
>   dt-bindings: Document the Rockchip ISP1 bindings
>   dt-bindings: Document the Rockchip MIPI RX D-PHY bindings
>   ARM: dts: rockchip: add isp node for rk3288
>   ARM: dts: rockchip: add rx0 mipi-phy for rk3288
>   MAINTAINERS: add entry for Rockchip ISP1 driver
> 
> Jeffy Chen (1):
>   media: rkisp1: Add user space ABI definitions
> 
> Shunqian Zheng (3):
>   media: videodev2.h, v4l2-ioctl: add rkisp1 meta buffer format
>   arm64: dts: rockchip: add isp0 node for rk3399
>   arm64: dts: rockchip: add rx0 mipi-phy for rk3399
> 
>  .../devicetree/bindings/media/rockchip-isp1.txt    |   69 +
>  .../bindings/media/rockchip-mipi-dphy.txt          |   88 +
>  Documentation/media/uapi/v4l/meta-formats.rst      |    2 +
>  .../media/uapi/v4l/pixfmt-meta-rkisp1-params.rst   |   17 +
>  .../media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst     |   18 +
>  MAINTAINERS                                        |   10 +
>  arch/arm/boot/dts/rk3288.dtsi                      |   24 +
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   25 +
>  drivers/media/platform/Kconfig                     |   10 +
>  drivers/media/platform/Makefile                    |    1 +
>  drivers/media/platform/rockchip/isp1/Makefile      |    8 +
>  drivers/media/platform/rockchip/isp1/capture.c     | 1728 ++++++++++++++++++++
>  drivers/media/platform/rockchip/isp1/capture.h     |  194 +++
>  drivers/media/platform/rockchip/isp1/common.h      |  137 ++
>  drivers/media/platform/rockchip/isp1/dev.c         |  653 ++++++++
>  drivers/media/platform/rockchip/isp1/dev.h         |  120 ++
>  drivers/media/platform/rockchip/isp1/isp_params.c  | 1553 ++++++++++++++++++
>  drivers/media/platform/rockchip/isp1/isp_params.h  |   76 +
>  drivers/media/platform/rockchip/isp1/isp_stats.c   |  522 ++++++
>  drivers/media/platform/rockchip/isp1/isp_stats.h   |   85 +
>  .../media/platform/rockchip/isp1/mipi_dphy_sy.c    |  787 +++++++++
>  drivers/media/platform/rockchip/isp1/regs.c        |  266 +++
>  drivers/media/platform/rockchip/isp1/regs.h        | 1577 ++++++++++++++++++
>  drivers/media/platform/rockchip/isp1/rkisp1.c      | 1205 ++++++++++++++
>  drivers/media/platform/rockchip/isp1/rkisp1.h      |  132 ++
>  drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +
>  include/uapi/linux/rkisp1-config.h                 |  757 +++++++++
>  include/uapi/linux/videodev2.h                     |    4 +
>  28 files changed, 10070 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip-isp1.txt
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
>  create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
>  create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
>  create mode 100644 drivers/media/platform/rockchip/isp1/Makefile
>  create mode 100644 drivers/media/platform/rockchip/isp1/capture.c
>  create mode 100644 drivers/media/platform/rockchip/isp1/capture.h
>  create mode 100644 drivers/media/platform/rockchip/isp1/common.h
>  create mode 100644 drivers/media/platform/rockchip/isp1/dev.c
>  create mode 100644 drivers/media/platform/rockchip/isp1/dev.h
>  create mode 100644 drivers/media/platform/rockchip/isp1/isp_params.c
>  create mode 100644 drivers/media/platform/rockchip/isp1/isp_params.h
>  create mode 100644 drivers/media/platform/rockchip/isp1/isp_stats.c
>  create mode 100644 drivers/media/platform/rockchip/isp1/isp_stats.h
>  create mode 100644 drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c
>  create mode 100644 drivers/media/platform/rockchip/isp1/regs.c
>  create mode 100644 drivers/media/platform/rockchip/isp1/regs.h
>  create mode 100644 drivers/media/platform/rockchip/isp1/rkisp1.c
>  create mode 100644 drivers/media/platform/rockchip/isp1/rkisp1.h
>  create mode 100644 include/uapi/linux/rkisp1-config.h
> 
