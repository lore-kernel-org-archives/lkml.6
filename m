Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D39C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC7E277F3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYD2yY4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC7E277F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967975AbeF1SuK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:50:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34355 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966880AbeF1SuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:50:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id q24-v6so5784619edr.1;
        Thu, 28 Jun 2018 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0vy0HaglagC6Mgbh6hZL8IjzsxT1+7lGfi/NnLgk5Ng=;
        b=QYD2yY4i2FG/cBvztSf8KKbzEqWOtRcmX05B+WrqrYa3cUzum3DAy8VBOHIGxRB6qD
         9xWFLqVWSWod/A8wVFEtchLAtADloZiejPq+SXLJRrSw5dO3LbRry1qbP7dLySOwdJmy
         uqObTnIRcscm0DhWjxBMuIsH9mzytGP9sJcTdeTu+nZQFt2iFgK5a6qUpT9R5lSph6XR
         KrMCZaKVZjFXsenxPvS6uTddoM9fh+FeZZVV3nDfLZ3syX5+5/QWlLFJR2bz4f9ELBr0
         sPGwPUL0v2/RD5ixSqv6myy8UP24QYvurupsleZxmScd1ywjooMzwV78AKBxrHjTLUtB
         o4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vy0HaglagC6Mgbh6hZL8IjzsxT1+7lGfi/NnLgk5Ng=;
        b=mRH0MqhFvmKCprC0Ur9gyPGg3PWVFkP50cZ3v03mVNlJmjiGlVmPIdbKVrrtIdgHoU
         xLn7AoXxtIuFmfy0F4J5FFt6U/ehkpCbG30dYhyYpQ2BSbeoN7UqweK7nox9prZtJh/z
         EUNelpCX6rGPgk7rZPZYR14k1JywdSlN1i+Ti6jcVBM66Sp46aPIwr2zwYIwA32cVt9n
         SrJyLO5jDuKrdhw0rCjp0FXJ5hHJt9KszE3fI2xGByJyg0vmZ4z23HrUVSZLNSg18LLa
         Xacxon38uRYT3HIZBugha5ng7hriZu6422bmc0moj4jTu/dM8likIl1POBf5z7nhODGv
         7Shg==
X-Gm-Message-State: APt69E0OLXuKYuVM4kTL9G+UYwE4Ax5enUEBTusmQXFlVR17GpaTYvb7
        6cWOcwYe8WtyyIRml8CNkxM/B/B2
X-Google-Smtp-Source: AAOMgpcWs3++gdn2Gq+aisjyyCx9D6yAI4Qcdz/l7dfOf35tA2Bz9JiGrFTJA/wnym4GPey9fb/e3w==
X-Received: by 2002:a50:95ab:: with SMTP id w40-v6mr9778219eda.33.1530211806917;
        Thu, 28 Jun 2018 11:50:06 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.googlemail.com with ESMTPSA id h24-v6sm3199570eds.18.2018.06.28.11.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:50:06 -0700 (PDT)
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
To:     Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, david@lechnology.com
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
From:   Hans de Goede <j.w.r.degoede@gmail.com>
Message-ID: <0a591ed5-a990-f6d9-add2-8e22209a3fc2@gmail.com>
Date:   Thu, 28 Jun 2018 20:50:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks good, but you should probably do a new version based on:

https://github.com/bzolnier/linux/tree/fbdev-for-next

This has one more loop to replace, in the fbcon_output_notifier()
function which was introduced by:
https://github.com/bzolnier/linux/commit/83d83bebf40132e2d55ec58af666713cc76f9764

Regards,

Hans



On 28-06-18 18:20, Yisheng Xie wrote:
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
> Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 25 +++++++++----------------
>   drivers/video/fbdev/core/fbmem.c |  4 +---
>   include/linux/fb.h               |  4 ++++
>   3 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c910e74..610853d 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2220,8 +2220,8 @@ static int fbcon_switch(struct vc_data *vc)
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
> @@ -3103,11 +3103,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
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
> @@ -3562,11 +3560,9 @@ static void fbcon_start(void)
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
> @@ -3586,15 +3582,12 @@ static void fbcon_exit(void)
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
> index aa74a22..3e13b95 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
>   extern int num_registered_fb;
>   extern struct class *fb_class;
>   
> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (registered_fb[i])
> +
>   extern int lock_fb_info(struct fb_info *info);
>   
>   static inline void unlock_fb_info(struct fb_info *info)
> 
