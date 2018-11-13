Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D41CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CE1223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dKBv2dv6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hHZFJ/mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CE1223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeKMRYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:24:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeKMRYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:24:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8861C60A33; Tue, 13 Nov 2018 07:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542094083;
        bh=FjY3fMs4x63SLlvED+p1ixhAHNY3Ny7qMNq2rLYRiiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dKBv2dv6nfZ//8iOz6aEMjjbspH2b2mRCDFEd+KQQfq3NeMb0f8d5zVDi8IZYx6jc
         KX6kFZnEkXddQhoqUYH5ci0GaM4IWQoYHlBW/QZR2csoYJNLkqmjy37wDJuj2KpGCY
         aMT5GEMO24BkD6sd2WPNnXKhGicOtcx+GGpXvQbk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A76526085F;
        Tue, 13 Nov 2018 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542094082;
        bh=FjY3fMs4x63SLlvED+p1ixhAHNY3Ny7qMNq2rLYRiiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hHZFJ/mpCbA89CquZZK8AYaIcTPaq0uZyDX1YlbqAj5lzrVFSQDLQa06xqQytrb7B
         42bzoHqGJH1RPDP4TWa9zoGxvUZT0KK9ZuYm8FSvMtHb94kaLqmrx4lKFvhlihnbI2
         yMqdmWn/J6tSbNGYvKaduFANv2CDT0cazi1apDF0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Nov 2018 12:58:02 +0530
From:   mgottam@codeaurora.org
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
In-Reply-To: <8fe1d205-c5e7-01a0-9569-d3268911cddd@linaro.org>
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
 <8fe1d205-c5e7-01a0-9569-d3268911cddd@linaro.org>
Message-ID: <38dfc098517b3ddb5d96195f2e27429d@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-12 18:04, Stanimir Varbanov wrote:
> Hi Tomasz,
> 
> On 10/23/2018 05:50 AM, Tomasz Figa wrote:
>> Hi Malathi,
>> 
>> On Tue, Oct 9, 2018 at 4:58 PM Malathi Gottam <mgottam@codeaurora.org> 
>> wrote:
>>> 
>>> For lower resolutions, incase of encoder, the compressed
>>> frame size is more than half of the corresponding input
>>> YUV. Keep the size as same as YUV considering worst case.
>>> 
>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/media/platform/qcom/venus/helpers.c 
>>> b/drivers/media/platform/qcom/venus/helpers.c
>>> index 2679adb..05c5423 100644
>>> --- a/drivers/media/platform/qcom/venus/helpers.c
>>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>>> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 
>>> width, u32 height)
>>>         }
>>> 
>>>         if (compressed) {
>>> -               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 
>>> 2;
>>> +               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
>>>                 return ALIGN(sz, SZ_4K);
>>>         }
>> 
>> Note that the driver should not enforce one particular buffer size for
>> bitstream buffers unless it's a workaround for broken firmware or
>> hardware. The userspace should be able to select the desired size.
> 
> Good point! Yes, we have to extend set_fmt to allow bigger sizeimage 
> for
> the compressed buffers (not only for encoder).

So Stan you meant to say that we should allow s_fmt to accept client 
specified size?
If so should we set the inst->input_buf_size here in venc_s_fmt?

@@ -333,10 +333,10 @@static const struct venus_format *
venc_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)

         pixmp->num_planes = fmt->num_planes;
         pixmp->flags = 0;
-
-       pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
-                                                    pixmp->width,
-                                                    pixmp->height);
+       if (!pfmt[0].sizeimage)
+               pfmt[0].sizeimage = 
venus_helper_get_framesz(pixmp->pixelformat,
+                                                            
pixmp->width,
+                                                            
pixmp->height);

         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
                 pfmt[0].bytesperline = ALIGN(pixmp->width, 128);
@@ -387,6 +387,7 @@ static int venc_s_fmt(struct file *file, void *fh, 
struct v4l2_format *f)
         venc_try_fmt_common(inst, &format);

         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+               inst->input_buf_size = pixmp->plane_fmt[0].sizeimage;
                 inst->out_width = format.fmt.pix_mp.width;
                 inst->out_height = format.fmt.pix_mp.height;

Similar implementation is already handled in case of decoder.

Then in queue setup, we can compare this against calculated size to 
obtain final buffer size

@@ -899,7 +900,8 @@ static int venc_queue_setup(struct vb2_queue *q,
                 sizes[0] = 
venus_helper_get_framesz(inst->fmt_out->pixfmt,
                                                     inst->width,
                                                     inst->height);
-               inst->input_buf_size = sizes[0];
+               if(inst->input_buf_size < sizes[0])
+                       inst->input_buf_size = sizes[0];
                 break;

I hope this meets are requirements.
