Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF5C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3BF25451
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3BF25451
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeGBBLG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:11:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:34383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932354AbeGBBLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:11:05 -0400
Received: from [172.17.46.209] ([122.224.77.194]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Ltqb7-1gIee13NVV-011EcQ; Mon, 02
 Jul 2018 03:11:01 +0200
Subject: Re: [PATCH] kernel/power: cast PAGE_SIZE to int when comparing with
 error code
To:     rjw@rjwysocki.net
Cc:     pavel@ucw.cz, cgxu519@gmx.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180625053058.25206-1-cgxu519@gmx.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <0a812d02-d85d-f685-6e7f-f4dfe22f9629@gmx.com>
Date:   Mon, 2 Jul 2018 09:10:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625053058.25206-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:CvyVtmqWLvgC9lG71PAbpGIcbsnQIA6t1gByO/Gi1hzoaOzrybC
 qpsCmgus0ip6C/4v21k60MtIEJYverszmSW7YuxhpsNkDKPP6nPjdE2UlkC7RU+GPLsS/gB
 wTHjC6h1lDZz3U4LzxHlJiQ1in7+QKE0ADfc2SDJ1M0v2RiGY/7PbwlaNSK8mECdJaqE0OF
 kNY/X/rGbJ6S3VqBk6UwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tgB2VTSADlg=:5m2tuVAKOXM2o8cH58rV61
 AmwqW4jPQUD9SBuqKTyiUiH5MYJjEUhEAecLiHWhNHao4P62k/Z1xuLFhQB1FiW4ysBDkLxwN
 w0hoomeJj9uXo/93yPkOrX9htLAH6cU5lqRRQa8tbJ3KDBHcWKA4CjVg1ne3DUK+s31Lf8Gbs
 biK5e3YN0wyfmjZEbu9UmtwVungeri/ke93VO73+XXSXp2gANZqPb3alPqCQx+1uAcGzjXYPT
 2uSBBHsZH7OdHx7dd3eRQoO8Hg1THyeVifS2fKGbEEM5SVREfsb8x4yAe8lUXe3+cFRqI+A/x
 CnTnQ3pZGx8LBo13i6t58wPv4EHrB9OkPxRhvMPeI8gTWrZYdEqwiPyDq7z5D35BdjlydD0C1
 V/WFhQROy2bXZ9Vvzs3BBY20HyJydqWX9tUBwx/S6rhWg/8OzyO3RE72y4lLP7BqnL7zme/v1
 4tsVrcdrz9WdCtrY72kU4e9pWqqsI2QrukGVxLuoHwme3dRuYQBJwwfjk8pUm6fYuDECVrefZ
 No2WD3ALF/IIGzYlQqy9BNfPq1q+BZ/0uQxmZ8/0rhcRpeZpR6u74ezSIJhX9NvZsO6oVMFZC
 xiq/wlbVY8JnLIUKxR5EfNEdZURs5BBc0NvzdsdTBn8b8wh8gaPhZ29mOGvbqfzBvVFLb0GeM
 icLFnPuySov0Cbbdq95hAkYJ7YDCnUT88bxMrHv83v26uw8A5Uf9x/9QTtquXZmYArq9z+HKA
 kxrEIwA8mItNVMlANJlfPQIqRk9lqNuhWmQtGSXCVvS7zNYydybYdT9CZwzm+XSiy8CHQkb+r
 Jgo+IlM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Could you have a look at this simple patch?

Thanks,
Chengguang


On 06/25/2018 01:30 PM, Chengguang Xu wrote:
> If PAGE_SIZE is unsigned type then negative error code will be
> larger than PAGE_SIZE.
>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>   kernel/power/swap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index c2bcf97d24c8..d7f6c1a288d3 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -923,7 +923,7 @@ int swsusp_write(unsigned int flags)
>   	}
>   	memset(&snapshot, 0, sizeof(struct snapshot_handle));
>   	error = snapshot_read_next(&snapshot);
> -	if (error < PAGE_SIZE) {
> +	if (error < (int)PAGE_SIZE) {
>   		if (error >= 0)
>   			error = -EFAULT;
>   
> @@ -1483,7 +1483,7 @@ int swsusp_read(unsigned int *flags_p)
>   
>   	memset(&snapshot, 0, sizeof(struct snapshot_handle));
>   	error = snapshot_write_next(&snapshot);
> -	if (error < PAGE_SIZE)
> +	if (error < (int)PAGE_SIZE)
>   		return error < 0 ? error : -EFAULT;
>   	header = (struct swsusp_info *)data_of(snapshot);
>   	error = get_swap_reader(&handle, flags_p);

