Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1266D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1266D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeHaMf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:35:28 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:33310 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727191AbeHaMf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:35:28 -0400
Received: from [192.168.1.10] ([80.101.105.217])
        by smtp-cloud8.xs4all.net with ESMTPA
        id vengflgRUaLLbvenif1OQ1; Fri, 31 Aug 2018 10:29:07 +0200
Subject: Re: [PATCH 3/5] media: cec: move compat_ioctl handling to cec-api.c
To:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org
Cc:     y2038@lists.linaro.org, awalls@md.metrocast.net,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20180827195649.4170969-1-arnd@arndb.de>
 <20180827195649.4170969-3-arnd@arndb.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9fb23fab-4d52-a35d-03bf-ddd49c238ff3@xs4all.nl>
Date:   Fri, 31 Aug 2018 10:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827195649.4170969-3-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNd/jwRtgUbx0mO+JAjfTDopSqzedFYfc7ni/ZbDTaLIwJD4pOkiOwrBXzL3UZ2f6xGZIQrosjI5CyZ0sd9VrP35HBpBNJnbUHHN0ntNxQlTcQczKrhl
 N9pgL8RnpjzH/Z0Z3H5hz41nPOWLreQxRP5rFTXP+9ir8j7LvAr8VT9brvdFvKIelSqIbs3x9wsqhBmjP+gyqZUwOeVcj8cekCbAzzQ/j3yDQmwz6JWgtVEi
 ZaKbnT+Z8oDl4WBOZqCWGXVYbxTkW+Xj7pwSLXFL/sfpHs8/NtgrCMwJWv7w6KwCXYE1jYgt3Wbu2d1KlT/t7uMraM958Plq80PeeivUfru5VnLtMvSsHXsG
 exQGdJDQzuTqTQO21XP0stoxDayo/lfLCp82b8PQ30jjNvdh3GSbKWmu6xo7a1cQjLjA9dqxctjMOA9aXcXSUFnXwPLcsRUGCXgwCKHXev5XwqMV78M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 09:56 PM, Arnd Bergmann wrote:
> All the CEC ioctls are compatible, and they are only implemented
> in one driver, so we can simply let this driver handle them
> natively.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>

Mauro, feel free to pick this up when you process the others in this
patch series.

Regards,

	Hans

> ---
>  drivers/media/cec/cec-api.c |  1 +
>  fs/compat_ioctl.c           | 12 ------------
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/media/cec/cec-api.c b/drivers/media/cec/cec-api.c
> index b6536bbad530..9067728feb60 100644
> --- a/drivers/media/cec/cec-api.c
> +++ b/drivers/media/cec/cec-api.c
> @@ -665,6 +665,7 @@ const struct file_operations cec_devnode_fops = {
>  	.owner = THIS_MODULE,
>  	.open = cec_open,
>  	.unlocked_ioctl = cec_ioctl,
> +	.compat_ioctl = cec_ioctl,
>  	.release = cec_release,
>  	.poll = cec_poll,
>  	.llseek = no_llseek,
> diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
> index e38e6c785459..33f48933a865 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -1195,18 +1195,6 @@ COMPATIBLE_IOCTL(VIDEO_CLEAR_BUFFER)
>  COMPATIBLE_IOCTL(VIDEO_SET_STREAMTYPE)
>  COMPATIBLE_IOCTL(VIDEO_SET_FORMAT)
>  COMPATIBLE_IOCTL(VIDEO_GET_SIZE)
> -/* cec */
> -COMPATIBLE_IOCTL(CEC_ADAP_G_CAPS)
> -COMPATIBLE_IOCTL(CEC_ADAP_G_LOG_ADDRS)
> -COMPATIBLE_IOCTL(CEC_ADAP_S_LOG_ADDRS)
> -COMPATIBLE_IOCTL(CEC_ADAP_G_PHYS_ADDR)
> -COMPATIBLE_IOCTL(CEC_ADAP_S_PHYS_ADDR)
> -COMPATIBLE_IOCTL(CEC_G_MODE)
> -COMPATIBLE_IOCTL(CEC_S_MODE)
> -COMPATIBLE_IOCTL(CEC_TRANSMIT)
> -COMPATIBLE_IOCTL(CEC_RECEIVE)
> -COMPATIBLE_IOCTL(CEC_DQEVENT)
> -
>  /* joystick */
>  COMPATIBLE_IOCTL(JSIOCGVERSION)
>  COMPATIBLE_IOCTL(JSIOCGAXES)
> 

