Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D127C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A862086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A862086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJIVSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:18:04 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:59864 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbeJIVSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:18:04 -0400
Received: from [IPv6:2001:420:44c1:2579:c4b:279f:e625:3e51] ([IPv6:2001:420:44c1:2579:c4b:279f:e625:3e51])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9sZAgvLbd0ZZE9sZEgBstG; Tue, 09 Oct 2018 16:00:57 +0200
Subject: Re: [PATCH v2] media: vivid: Support 480p for webcam capture
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        tfiga@chromium.org, jcliang@chromium.org, shik@chromium.org
References: <20181009134339.233238-1-keiichiw@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <8b40366d-1358-93a0-a411-1237d7d0cad8@xs4all.nl>
Date:   Tue, 9 Oct 2018 16:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181009134339.233238-1-keiichiw@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMNSLrsd8GCVoHG0KB7rERu0RLlLvWfX0Sdb7VzJlnFhmQmwyY9/FX/W0K4rme0R5LDfu2XYS0oqfDyS23LCWuGeeGgDR8IuV9aGLhM3OJ+fLOYn36Qs
 GqeNgsC5TCS8Yo5fe6BTk5IAAqmlRe0+1zYJDuz8NVvaQO1jbF7GDgo5F/wOaGrK1Rstp47L1RGYJyWdL2QIufyMRLH5qnZqCyaJA0VyTSP6XKr+18Jz8UWo
 gEVChsuTe9ubB0GVtHIBpXBPhOCHn06Ka4iq0DXtgeLAyWak4pZ/U7iX8myK+Wvd3VXcx+13W0p3SFQYIeBmh/ggcwFLOEAee0J1k44b2sgXWrAHcrUTeK96
 h400SYTXVXvL4HYoqDzIGCfRebvZn5ExLQjbF8RfDXGEh3TbO4h3mhmdbY1lR5jDbSxptknf4yxpV6u7JsXhaJNnN0B5VqnrbiF4AU4th6e0bu9GvkbsnPCr
 oKsl34V4O2ZYh41x6AbgnYlYxPIErmqs045lpZRBPe2EtXPRFp0QTxMLpUI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 15:43, Keiichi Watanabe wrote:
> Support 640x480 as a frame size for video input devices of vivid.
> 
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

> ---
>  drivers/media/platform/vivid/vivid-vid-cap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
> index 58e14dd1dcd3..6cf910a60ecf 100644
> --- a/drivers/media/platform/vivid/vivid-vid-cap.c
> +++ b/drivers/media/platform/vivid/vivid-vid-cap.c
> @@ -51,7 +51,7 @@ static const struct vivid_fmt formats_ovl[] = {
>  };
>  
>  /* The number of discrete webcam framesizes */
> -#define VIVID_WEBCAM_SIZES 5
> +#define VIVID_WEBCAM_SIZES 6
>  /* The number of discrete webcam frameintervals */
>  #define VIVID_WEBCAM_IVALS (VIVID_WEBCAM_SIZES * 2)
>  
> @@ -59,6 +59,7 @@ static const struct vivid_fmt formats_ovl[] = {
>  static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
>  	{  320, 180 },
>  	{  640, 360 },
> +	{  640, 480 },
>  	{ 1280, 720 },
>  	{ 1920, 1080 },
>  	{ 3840, 2160 },
> @@ -74,9 +75,11 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>  	{  1, 4 },
>  	{  1, 5 },
>  	{  1, 10 },
> +	{  2, 25 },
>  	{  1, 15 },
>  	{  1, 25 },
>  	{  1, 30 },
> +	{  1, 40 },
>  	{  1, 50 },
>  	{  1, 60 },
>  };
> 

