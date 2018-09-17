Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9C6ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E450C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E450C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeIQUTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:19:46 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:54591 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbeIQUTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:19:45 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 1usWg410zbst71usZgKRls; Mon, 17 Sep 2018 16:52:03 +0200
Subject: Re: [PATCH v2 0/3] Add Amlogic video decoder driver
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20180911150938.3844-1-mjourdan@baylibre.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9c33c57e-2ce2-8752-b851-f85c03a7d761@xs4all.nl>
Date:   Mon, 17 Sep 2018 16:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180911150938.3844-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKIosNjz1fyf16Ct9+J6bDRp/9A0YydbCDoOubMrb+K4XUuTYF1QDtlbHEUZfvj6yrW5gykJAdodh7PbYSVj41uvGhRlnFqDhPwDDlu8wKrnNVC1iPj1
 2YfSzmVXYcTnSrpN5gKkZhgGAtUSe7RqF4P8GKwpyOkJV79HPFlUjdV7+c7KLqEHvgnagt/SwTP80pLksVWcfzhu8JZ00mNDKnO17ryl36E7+5tvca7ZTrRX
 /LaoiI9KpIaT+9dllgUtuYYgLVlD+Spw/WFjQVUY1o5wuvd9H1E8qM9qMPCUN9nq3AmPUUVgYsIgcZjA+bY5eLkrhrD+jJ5GzWiFp0yGIrjJOMOCNOm/h0SX
 3h+iOgV1AmEnwq+/pDuABVXzsadMvSrBIlwD5B2y0SdBXTkaOFEYRbHeeNng4JE3xFzQ3ltaJXzxTKps7uBjHRzTQD5Thg5oHbvRB/AADswMdNl+ljoRhhbO
 FlOzCjCZsy0RfAgR9BY0E1vcUyvV16MJ+Ck7qwt8wViYSJLZxQfnIHDnfAvatdJc5s5gqgv3qP2yXqAwpjYVQGVv+hTivhOdZU/ktAaYCDxPfTuBv79bJVqJ
 yj04zTmAujEJ2VAKu4FTtxyn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 05:09 PM, Maxime Jourdan wrote:
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
> Changes since v1 [0]:
>  - use named interrupts in the bindings
>  - rewrite description in the bindings doc
>  - don't include the dts changes in the patch series
>  - fill the vb2 queues locks
>  - fill the video_device lock
>  - use helpers for wait_prepare and wait_finish vb2_ops
>  - remove unnecessary usleep in between esparser writes.
>  Extensive testing of every codec on GXBB/GXL didn't reveal
>  any fails without it, so just remove it.
>  - compile v4l2_compliance inside the git repo
>  - Check for plane number/plane size to pass the latest v4l2-compliance test
>  - Moved the single instance check (returning -EBUSY) to start/stop streaming
>  The check was previously in queue_setup but there was no great location to
>  clear it except for .close().

Actually, you can clear it by called VIDIOC_REQBUFS with count set to 0. That
freed all buffers and clears this.

Now, the difference between queue_setup and start/stop streaming is that if you
do this in queue_setup you'll know early on that the device is busy. It is
reasonable to assume that you only allocate buffers when you also want to start
streaming, so that it a good place to know this quickly.

Whereas with start_streaming you won't know until you call STREAMON, or even later
if you start streaming with no buffers queued, since start_streaming won't
be called until you have at least 'min_buffers_needed' buffers queued (1 for this
driver). So in that case EBUSY won't be returned until the first VIDIOC_QBUF.

My preference is to check this in queue_setup, but it is up to you to decide.
Just be aware of the difference between the two options.

Regards,

	Hans
