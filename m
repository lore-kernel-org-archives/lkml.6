Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5FBC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF30A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF30A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeKTVuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:50:54 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:59268 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbeKTVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:50:54 -0500
Received: from [IPv6:2001:983:e9a7:1:1da9:d909:50bf:c42e] ([IPv6:2001:983:e9a7:1:1da9:d909:50bf:c42e])
        by smtp-cloud8.xs4all.net with ESMTPA
        id P46eghGLzcvkSP46fgh0Rl; Tue, 20 Nov 2018 12:22:13 +0100
Subject: Re: [RFC PATCH v8 3/4] media: media.h: Enable ALSA MEDIA_INTF_T*
 interface types
To:     shuah@kernel.org, mchehab@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1541118238.git.shuah@kernel.org>
 <0f47952fd84fd275646e3c9a18e208ced08dd6bb.1541109584.git.shuah@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <76e1a986-fb47-869d-ee7e-8c9b919718cb@xs4all.nl>
Date:   Tue, 20 Nov 2018 12:22:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0f47952fd84fd275646e3c9a18e208ced08dd6bb.1541109584.git.shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL2nHKGoyr3N8VqSFWhVIc/Jqw/nS1ChyryR/qcUZQssUucnYrFYQo+jpUnbBtlc45lRG0FAI7hADNIISRCi09Yn3gZ6z4+uTSs2Y+2WnBfa8RamgtqQ
 BRaz88QqoV1UPJs5pjlEXXVlRNjHHM+cfjQTR82jh0HsIz1oc9pQbxqcZgIRBRAAl0WvYOtZfh3k2hrE3O4LSO2ixIfv+5ewCUfo+bMsGuwpUWxOqPhvdH5S
 /04N/w2tIvLAIfnN1hAKa/EV9ctg1tRVQZrGq95aZ9zcp9Vvyt2ctwK/SGB7nrtbr7JH+Aw15ojVALuvc23j1S8KK7/lbQw9O5/RTUpp+XCNqLdvGFrp77xA
 5tyFgS8dms6VZepW5D4HhFQpHvMQgFFgTmbijToEVM+bzU5MH932OX14q0Bu2patbNPfS5VqC2hHDaG2eKCUFfR8efJ+W6f0PQI5qe1jUWFEXBrW0TA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2018 01:31 AM, shuah@kernel.org wrote:
> From: Shuah Khan <shuah@kernel.org>
> 
> Move ALSA MEDIA_INTF_T* interface types back into __KERNEL__ scope
> to get ready for adding ALSA support to the media controller.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  include/uapi/linux/media.h | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
> index 36f76e777ef9..07be07263597 100644
> --- a/include/uapi/linux/media.h
> +++ b/include/uapi/linux/media.h
> @@ -262,6 +262,16 @@ struct media_links_enum {
>  #define MEDIA_INTF_T_V4L_SWRADIO		(MEDIA_INTF_T_V4L_BASE + 4)
>  #define MEDIA_INTF_T_V4L_TOUCH			(MEDIA_INTF_T_V4L_BASE + 5)
>  
> +#define MEDIA_INTF_T_ALSA_BASE			0x00000300
> +#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
> +#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
> +#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
> +#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
> +#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
> +#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
> +#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
> +#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
> +

I would only enable those defines that you need for the next patch.

Regards,

	Hans

>  #if defined(__KERNEL__)
>  
>  /*
> @@ -404,21 +414,6 @@ struct media_v2_topology {
>  
>  #define MEDIA_ENT_F_DTV_DECODER			MEDIA_ENT_F_DV_DECODER
>  
> -/*
> - * There is still no ALSA support in the media controller. These
> - * defines should not have been added and we leave them here only
> - * in case some application tries to use these defines.
> - */
> -#define MEDIA_INTF_T_ALSA_BASE			0x00000300
> -#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
> -#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
> -#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
> -#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
> -#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
> -#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
> -#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
> -#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
> -
>  /* Obsolete symbol for media_version, no longer used in the kernel */
>  #define MEDIA_API_VERSION			((0 << 16) | (1 << 8) | 0)
>  
> 

