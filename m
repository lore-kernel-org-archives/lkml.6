Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeBVKFK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:05:10 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:57093 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753088AbeBVKFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:05:07 -0500
Subject: Re: [PATCH v10 03/10] media: platform: Add Renesas CEU driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com,
        geert@glider.be, mchehab@kernel.org, festevam@gmail.com,
        sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com,
        pombredanne@nexb.com
Cc: linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1519235284-32286-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519235284-32286-4-git-send-email-jacopo+renesas@jmondi.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <bb33d217-76a8-71a6-e7fd-6d449d662784@xs4all.nl>
Date: Thu, 22 Feb 2018 11:05:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519235284-32286-4-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGYaAbTwpHNc4C3JZbIGOfsJ7iu8Q/sZUUrkjcSKEQu/iqXxM4rlPHAjpVdpYC4aIMseMRWAhR5di56/Rjsf8PhPSYmkw1KDrL33E/PL6/wAKkLeWg5X
 eqn36GltiSt+6fZUA7jAhKcIDcPeI+ZO1B6MPtjso99YDt6CN68/5O3asj2RuErodrlKoqZRcJmAs/SGpW9hiUffJoaU5oMJnE6MZHg6ZlFRGzcjG8zRmc1o
 2yLYuxUQM+TkbFA5MJ7Olbgy+wNSH2nD6HXU6gC9HdtHv/Q4stN7fAxZCHJk6istbBOlK1DiNe3N98HKO430eD/jTvIjiZSkIa31DrfM6LqpSaYpIo8xbYc3
 yiWpKhqcJKA/woPxYdSNp8u9QSOeZo9ctJYeFxjnSiEBy4b4uClE3hyunnIfBxXXGoII6XRptcYaOkHNVl7QWfDEIagq3Q3SgM+ZJ0zUnZ54WkUuV6rjmeDr
 5usabxUdTuhBFRryY+HsseHrtPWWg0EiRqymxBZJK7PuzxZNYMfEpeZFperDZaUM3JMurP5ZLoqaprIirKkfDeF6ZDS9OKEAVpvO14HHaJzXWz3vVmqqx/GZ
 Vin3dcYrX63TvG4xYFJ8nwuA6JYtT7cFgHQbzxpr5WE95mAxuM7X2i3aFjwtedM3Yays0tO/3SQosX1JDFdOx64BgEr8qhVeC3IM76PjbRZ44lTFoAVHCKIW
 2+38p7jgc4BMK5rwhhFMTmXY76c4+jlhRdAWeNS+3Xn9vAvr16dC7MigEDf7TruWC4h7jy0HgtmFVDeesg4aAXpApcpfZxcpE+Ib2n0f20fgRGxt4V2vVQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/18 18:47, Jacopo Mondi wrote:
> Add driver for Renesas Capture Engine Unit (CEU).
> 
> The CEU interface supports capturing 'data' (YUV422) and 'images'
> (NV[12|21|16|61]).
> 
> This driver aims to replace the soc_camera-based sh_mobile_ceu one.
> 
> Tested with ov7670 camera sensor, providing YUYV_2X8 data on Renesas RZ
> platform GR-Peach.
> 
> Tested with ov7725 camera sensor on SH4 platform Migo-R.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I get these warnings when I try to compile this driver:


  CC [M]  drivers/media/platform/renesas-ceu.o
drivers/media/platform/renesas-ceu.c: In function ‘ceu_start_streaming’:
drivers/media/platform/renesas-ceu.c:290:2: warning: ‘cdwdr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  iowrite32(data, priv->base + reg_offs);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/platform/renesas-ceu.c:338:27: note: ‘cdwdr’ was declared here
  u32 camcr, cdocr, cfzsr, cdwdr, capwr;
                           ^~~~~
drivers/media/platform/renesas-ceu.c:290:2: warning: ‘cfzsr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  iowrite32(data, priv->base + reg_offs);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/platform/renesas-ceu.c:338:20: note: ‘cfzsr’ was declared here
  u32 camcr, cdocr, cfzsr, cdwdr, capwr;
                    ^~~~~
drivers/media/platform/renesas-ceu.c:418:8: warning: ‘camcr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  camcr |= mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW ? 1 << 0 : 0;
  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/platform/renesas-ceu.c:338:6: note: ‘camcr’ was declared here
  u32 camcr, cdocr, cfzsr, cdwdr, capwr;
      ^~~~~
drivers/media/platform/renesas-ceu.c: In function ‘ceu_probe’:
drivers/media/platform/renesas-ceu.c:1632:9: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret;
         ^~~
cc1: some warnings being treated as errors

The last warning is indeed correct.

The others are only right if pixelformat is illegal, which can't happen.
I'd add a:

	default:
		return -EINVAL;

to the switch, this shuts up the warnings.

So I need a v11 (just for this patch) after all.

Regards,

	Hans
