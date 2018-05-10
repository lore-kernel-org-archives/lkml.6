Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966352AbeEJPiU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:38:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40729 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966209AbeEJPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:38:18 -0400
X-Google-Smtp-Source: AB8JxZpqRgJQVde0j9z42a/6W+CTaq5AX7mc/J+yacvK9m5RuFFSdTPo1EkEne0MKe5hHQPY59ZZnw==
Subject: Re: media: uvcvideo: Support realtek's UVC 1.5 device
To: ming_qian@realsil.com.cn,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1525831988-32017-1-git-send-email-ming_qian@realsil.com.cn>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b2f5c769-be06-0334-9ef8-328973a10a30@redhat.com>
Date: Thu, 10 May 2018 17:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525831988-32017-1-git-send-email-ming_qian@realsil.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-05-18 04:13, ming_qian@realsil.com.cn wrote:
> From: ming_qian <ming_qian@realsil.com.cn>
> 
> The length of UVC 1.5 video control is 48, and it id 34 for UVC 1.1.
> Change it to 48 for UVC 1.5 device,
> and the UVC 1.5 device can be recognized.
> 
> More changes to the driver are needed for full UVC 1.5 compatibility.
> However, at least the UVC 1.5 Realtek RTS5847/RTS5852 cameras have
> been reported to work well.
> 
> Signed-off-by: ming_qian <ming_qian@realsil.com.cn>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/media/usb/uvc/uvc_video.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index aa0082f..32dfb32 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -171,6 +171,8 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
>   	int ret;
>   
>   	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
> +	if (stream->dev->uvc_version >= 0x0150)
> +		size = 48;
>   	if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
>   			query == UVC_GET_DEF)
>   		return -EIO;
> @@ -259,6 +261,8 @@ static int uvc_set_video_ctrl(struct uvc_streaming *stream,
>   	int ret;
>   
>   	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
> +	if (stream->dev->uvc_version >= 0x0150)
> +		size = 48;
>   	data = kzalloc(size, GFP_KERNEL);
>   	if (data == NULL)
>   		return -ENOMEM;
> 
