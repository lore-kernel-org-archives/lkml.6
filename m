Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755115AbeDTN7b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:59:31 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:55259 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754888AbeDTN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:59:28 -0400
Subject: Re: [PATCH v2 06/10] media: v4l: Add definition for Allwinner's
 MB32-tiled NV12 format
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-2-paul.kocialkowski@bootlin.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <198e991c-1052-5bfb-f397-0e7d388b3c00@xs4all.nl>
Date: Fri, 20 Apr 2018 15:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180419154536.17846-2-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF7JSTUyU5LEHYW+Y+3xC+RVIGri3J0YtWg2nQdJyT/314fP6WmyojYlvK2lelPACs7X/BGqkheJ2xE1z8cmwdPgWRXdpb+2pgpntF/KPW665Pet/4eB
 XoPMVclv2in3GpKOmQihg1/gJjie2S8e6aLG5cI5t5eDqxLQ4ITdWtY4D4OYfVEOPsBCDjoWZPfILx9LbVerikBLvWpRY9GDPWVXHDsBAKoP6nYKJQPouu0n
 AIf69GL0/HnvmAptALa9D19++2hKh9mmzARfFjw4i/GyZY/GSvNSmQCI/p9cRtmwIWri/AmYkWGi4x06NK8j2kKfrG4BaP14B5VNRSijaVG8ZINgwPGfy5dz
 rJF2TFyXsvBAKM8LKmGITnbl/3XvVXOsgeoDxBUd31VLZnrcPZ6z7QunOO7j1PS/y+r1+JU16n8/Bw15V0MV4lHPZoeAPYcCE7QNXjvPGtOsOMu47SsWvLbC
 fIAtut4Ug00f+wLhx85rHDHq0sT32rKjWw0OquYm8IOCHq7AJvNzI/3mfbd+LHhVn5ITPLVi7GJNZ9VX7QqAKiupwvGnwBjZB+UrfZuUgfinCtHS+HFyTj6B
 hEwzJss91hXqzs+5k4eIjxbL8Knw9CtJu/k4WtpDHVdnsqDtszXuokpc5cOSJSwnJohNEG4Corg3532GYbbLfpB5m4ys+ARTxkpsEzrL8t8SktiFp54WD4pa
 wBBFz4CJbwXAG30innkQuG69qqIrBa4LTaQfU5bRRKH+KXkgFn7aIcLdXpvy6+rEomaNbf0dWbylG2oNb9aFFKXSFWffGPDVq59MP9n4hmu6iaRduYcz9WVk
 f6bX7W5BdwiqsHvVNwC7Fjs7h1xWxNYSW8S0Ay19D4XzSkZqr5TIeut1E3c++dKmBnECBlzP116TUZn7vbhWNcZfFrZLkEhHVFI3BUHxko7rPiS0GeyvqES9
 19JjYWoYVhsf+ZetNGfKKaouNDQH+9nnbL9SK25a5eZ4qPVfjL19e8g1l2NpnpH7qMuETS/HEbezHiedzgl+v1JiFlhHUlAvKM9YHOin/5aXiMM+sQSmhRDR
 2Isuo23SMl8S6tf3XVEVRwGiH9clhLDj9WapOnQt7loOjWQiOwVpo1Zy
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/18 17:45, Paul Kocialkowski wrote:
> This introduces support for Allwinner's MB32-tiled NV12 format, where
> each plane is divided into macroblocks of 32x32 pixels. Hence, the size
> of each plane has to be aligned to 32 bytes. The pixels inside each
> macroblock are coded as they would be if the macroblock was a single
> plane, line after line.
> 
> The MB32-tiled NV12 format is used by the video engine on Allwinner
> platforms: it is the default format for decoded frames (and the only one
> available in the oldest supported platforms).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  include/uapi/linux/videodev2.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 4b8336f7bcf0..43993a116e2b 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -669,6 +669,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
>  #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
> +#define V4L2_PIX_FMT_MB32_NV12 v4l2_fourcc('M', 'N', '1', '2') /* Allwinner NV12 in 32x32 macroblocks */
>  
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
> 

Add an entry for this to v4l_fill_fmtdesc() in v4l2-ioctl.c.

It also needs to be documented in the spec.

Regards,

	Hans
