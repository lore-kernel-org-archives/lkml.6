Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C66C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3038225180
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onNn4kaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3038225180
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936916AbeF3Kcg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:32:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45569 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936856AbeF3Kce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:32:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id g15-v6so4235488edr.12;
        Sat, 30 Jun 2018 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+7o6AafecknpgpTbvLuI1ED9Q1ihRtVvG4DnM/H/qA=;
        b=onNn4kaDaMRnG0ss9Lygo5Hig/iI0rZuqjrNhwNYNja3ZVU3s6LNfhE0NVcso6596x
         Z+v6AmsKkYKBvLfYIWcQcLBAc2kH0lEpolaj2TKgArmDJnTICoiUa63H5YUVqnDwNKpK
         czBlBr8Hy9xyS/h5K/P6DustzKE5ggK5YHl4o45GGNqJqfqBuA/kOrul3kBsNWrC1Cwe
         44REFUAsp0x5uEvP8ruyvn35hHvk8oBWhzH13aOYBFtMcc3/p2JQwUMvxoTzhsU+C6j5
         KIlMPZV6RzYKKuXkNp4QUM92S2A8qCsvEkAv6B1jMhzS5diZetvqZLkaCj3g6dILOK79
         +dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+7o6AafecknpgpTbvLuI1ED9Q1ihRtVvG4DnM/H/qA=;
        b=sPwT1PhygH3hNLQDhu6YePmnnYfzTdNclIoCWyOMKenXqgMRZCmM3OAJfo7slk75Ec
         dFLmnqiPJuZ+5wCZZHchMQ9WAd9koc7ST7s0ASo7sgbqmIUCxqnkg6PLOTpBMNBw+EsN
         NEGVvLx5aEIiUhTgxVYFinw4QGxCdiCfch+TxMBc77TzP28gb/qYL0y6zj9+nP+KI0H/
         Up1/9WrnjKW4zvxJuWB7gHIrPJ8uKHHEwrfuFR7H7qSC3TgkNzrdeRNlnRLqWYroBuDo
         Ha1PrRmXrhzXky5o6x0K/+OSI1v+nKeez0/uDJzL2cgwdtZ3NWvxZEFJa8MJzlxw4bTB
         +PJw==
X-Gm-Message-State: APt69E3iNfhNMwZe7i+Kg09U9/vBC+gsHBeuRgQCXWOW5K4Qpz+WeJpc
        JYCP0AROIhWfbxJ4dQqyrzKP60J4
X-Google-Smtp-Source: AAOMgpcUBzEH3/wXMIoN3Ns8DgsUAvJ9618I0RBL8ZT50NVrkyKl5YW4FsMsK0q7JIb3ZH1/ozswEw==
X-Received: by 2002:a50:ec94:: with SMTP id e20-v6mr16203950edr.119.1530354752729;
        Sat, 30 Jun 2018 03:32:32 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.googlemail.com with ESMTPSA id b8-v6sm1607252edd.13.2018.06.30.03.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 03:32:31 -0700 (PDT)
Subject: Re: [PATCH v2 fbdev-for-next 1/2] fbcon: introduce
 for_each_registered_fb() helper
To:     Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, david@lechnology.com
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
From:   Hans de Goede <j.w.r.degoede@gmail.com>
Message-ID: <239d5e46-b9b3-d493-253d-ee19d6e4cb29@gmail.com>
Date:   Sat, 30 Jun 2018 12:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-06-18 09:29, Yisheng Xie wrote:
> Following pattern is often used:
> 
>   for (i = 0; i < FB_MAX; i++) {
>          if (registered_fb[i]) {
>                  ...
>          }
>   }
> 
> Therefore, as Andy's suggestion, for_each_registered_fb() helper can
> be introduced to make the code easier to read and write by reducing
> indentation level. It also saves few lines of code in each occurrence.
> 
> This patch convert all part here at the same time.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yisheng Xie <ysxie@foxmail.com>

Both patches look good to me, and both are:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> v2:
>   - rebase it to fbdev-for-next branch and add one more loop to replace - per Hans
>   - Macro should be protected against nested conditionals. - per Andy
>   drivers/video/fbdev/core/fbcon.c | 31 +++++++++++--------------------
>   drivers/video/fbdev/core/fbmem.c |  4 +---
>   include/linux/fb.h               |  4 ++++
>   3 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 5fb156b..e30d3a1 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2234,8 +2234,8 @@ static int fbcon_switch(struct vc_data *vc)
>   	 *
>   	 * info->currcon = vc->vc_num;
>   	 */
> -	for (i = 0; i < FB_MAX; i++) {
> -		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
> +	for_each_registered_fb(i) {
> +		if (registered_fb[i]->fbcon_par) {
>   			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
>   
>   			o->currcon = vc->vc_num;
> @@ -3124,11 +3124,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>   	if (idx == info_idx) {
>   		info_idx = -1;
>   
> -		for (i = 0; i < FB_MAX; i++) {
> -			if (registered_fb[i] != NULL) {
> -				info_idx = i;
> -				break;
> -			}
> +		for_each_registered_fb(i) {
> +			info_idx = i;
> +			break;
>   		}
>   	}
>   
> @@ -3609,10 +3607,8 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>   	deferred_takeover = false;
>   	logo_shown = FBCON_LOGO_DONTSHOW;
>   
> -	for (i = 0; i < FB_MAX; i++) {
> -		if (registered_fb[i])
> -			fbcon_fb_registered(registered_fb[i]);
> -	}
> +	for_each_registered_fb(i)
> +		fbcon_fb_registered(registered_fb[i]);
>   
>   	return NOTIFY_OK;
>   }
> @@ -3638,11 +3634,9 @@ static void fbcon_start(void)
>   
>   		console_lock();
>   
> -		for (i = 0; i < FB_MAX; i++) {
> -			if (registered_fb[i] != NULL) {
> -				info_idx = i;
> -				break;
> -			}
> +		for_each_registered_fb(i) {
> +			info_idx = i;
> +			break;
>   		}
>   
>   		do_fbcon_takeover(0);
> @@ -3669,15 +3663,12 @@ static void fbcon_exit(void)
>   	kfree((void *)softback_buf);
>   	softback_buf = 0UL;
>   
> -	for (i = 0; i < FB_MAX; i++) {
> +	for_each_registered_fb(i) {
>   		int pending = 0;
>   
>   		mapped = 0;
>   		info = registered_fb[i];
>   
> -		if (info == NULL)
> -			continue;
> -
>   		if (info->queue.func)
>   			pending = cancel_work_sync(&info->queue);
>   		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 609438d..645c6ac 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1593,10 +1593,8 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
>   	int i, ret;
>   
>   	/* check all firmware fbs and kick off if the base addr overlaps */
> -	for (i = 0 ; i < FB_MAX; i++) {
> +	for_each_registered_fb(i) {
>   		struct apertures_struct *gen_aper;
> -		if (!registered_fb[i])
> -			continue;
>   
>   		if (!(registered_fb[i]->flags & FBINFO_MISC_FIRMWARE))
>   			continue;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index aa74a22..fd31e6f 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
>   extern int num_registered_fb;
>   extern struct class *fb_class;
>   
> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (!registered_fb[i]) {} else
> +
>   extern int lock_fb_info(struct fb_info *info);
>   
>   static inline void unlock_fb_info(struct fb_info *info)
> 
