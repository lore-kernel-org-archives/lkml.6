Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D575ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159E821523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="sZzuG9kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159E821523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbeITNON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:14:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46343 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbeITNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:14:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so6955375edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eWe1POa+kHnX3ug+aCVIkixACcAmkdW+8pvCFQHnG0k=;
        b=sZzuG9kqvoKGvyWQpr7bcaCDJwDqCn7OBTK7K3IZJhp8fCDWanIXPb7wjCoh1eLxbq
         6uou0K6hIUy7KfF2Rmf+TGKtRQ7ApqmDmsd7G/PWV5U0Q70FDcvLEobqvKVYyv8UWdqY
         Z4yg5vBvumDCqNe1Bm3BzP02VIpP3v1gsqD4cp9WTUPCBUHz43FSoyBvs/OeqCJlu1ID
         QEhr75UC+NT+z4P4KIBB+g7KnpQrgxFgFz+7jbDyn+E/Trwrw64p4JG4FWZPby6vQf19
         46TYUIrKLKb+/lprM7YG+U+sPsJErHiCwNgV4TdlzeP/ohV/57SY5XDVnQJbsk5cFnQl
         297Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eWe1POa+kHnX3ug+aCVIkixACcAmkdW+8pvCFQHnG0k=;
        b=XIZPPtzrY8PuRU8IHwfQJnYKOU+3eJOFdB7Nk5BbHWCuPyxoJHUSXsN4A68X92KCP3
         yNw3eO88T9B0DXxCfSeiaSDzAT5UDF7KQi29slk6SMaMawXRyQ2pwHtfR0RuoSNv7inQ
         5DqIK9xlmctIY+zwN3gd+Zyay+l57njF0D4ICH0wblUpvYiLU5vdu4dhA9OqhzEqYyhB
         0z96lkrFw7BNyN6KrXXVoCzeH4grV8Tw/+pz4ig5QUSW2ty1+AVKEOemCrZZPBldBf1n
         sqgpQ5yHw+o7qCryr8VbR36xPQkmbvyi8ux6MbdP/BLlz/S8pQZ7LsgEVMrN5fRuGW5r
         mWWw==
X-Gm-Message-State: APzg51BXsoNQriPptM7BpKlg7yQsxaW6WBNWsLil8voXxQy9xKi61Tsk
        feHLbYlDOEULEGZpJmiYobDNXS1yyl1GgvtyGoLAOg==
X-Google-Smtp-Source: ANB0VdZBzzsYue33XEwnnK9uTV4oVdsM+1HtNTtZ7jMmRvjZ3DYoMf4CuJDBDxO5wYhQhuGdw3o7OWzHH49eovjuWlM=
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr2643123edd.30.1537428726601;
 Thu, 20 Sep 2018 00:32:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:94ae:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 00:32:06
 -0700 (PDT)
In-Reply-To: <87k1nhy9ie.fsf@intel.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <20180705144009.GC5565@intel.com> <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com>
 <CAB4CAwdjPFLTj+bL+bAeXw2cwAtk9tWFxPPaATpQ4QbuZsM0ew@mail.gmail.com>
 <87tvnjlsap.fsf@intel.com> <CAB4CAwdUiFrPVTFsz3iC=x2yTTis0n1V4BzozXPMf7EeD52gvA@mail.gmail.com>
 <CAB4CAwdfTZ879LXpXGMiMrYi4kCJJBxggGGTi_REYkuRMvz2PQ@mail.gmail.com> <87k1nhy9ie.fsf@intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 20 Sep 2018 15:32:06 +0800
Message-ID: <CAB4CAwfAQvEV-DEW-A6bBgcYJB+HYe1JrFZam_eEwUQhmZHfuA@mail.gmail.com>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 8:08 PM, Jani Nikula <jani.nikula@intel.com> wrote:
> On Wed, 19 Sep 2018, Chris Chiu <chiu@endlessm.com> wrote:
>> I tried to add a slight delay in the hotplug work as follows
>>
>> --- a/drivers/gpu/drm/i915/intel_hotplug.c
>> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
>> @@ -378,6 +378,8 @@ static void do_i915_hotplug_check(struct work_struct *work,
>>
>>         spin_unlock_irq(&dev_priv->irq_lock);
>>
>> +       msleep(100);
>> +
>>         drm_connector_list_iter_begin(dev, &conn_iter);
>>         drm_for_each_connector_iter(connector, &conn_iter) {
>>                 intel_connector = to_intel_connector(connector);
>>
>> It does work in most cases, but still fail to update the status if I
>> unplug the HDMI
>> cable very slow. I basically pull the HDMI cable in loose connected
>> state first, and
>> hold in that state ~1 second, totally unplug after that. The status in
>> sysfs will report
>> connected as it used to. There was no problem when I tried the patch
>> https://bugs.freedesktop.org/show_bug.cgi?id=107125#c8
>>
>> I'll try to modify this patch a little bit and send upstream for
>> discussion later. Please
>> advise if any. Thanks.
>
> Please let's not add excessive msleeps in work functions.
>
> My idea was more along the lines of making the hotplug function run in a
> delayed work. After a chat with Ville, below is what I came up with.
>
> Please let me know how it works. Feel free to toy with the
> delay. However, 1-2 seconds or more seems too much.
>
> BR,
> Jani.
>

Thanks to the patch. It works in most cases on my problematic laptops.
After lots
of experiments, ex. pull the cable out with different paces, range
delay from 300 to
800 msec, it makes no significant difference for a longer delay. So
300 msec is good
enough for most cases. It at least updates the status correctly with a
visible quick
display blink when disconnecting HDMI. And compared to other machines which have
no such problem, the HDMI cable slow pull out also result in the same
problem. I'll
say the test result is OK for me. Thanks.

Chris

>
>
> From 72515b3e856171e52e96bb74796774f595a7f418 Mon Sep 17 00:00:00 2001
> From: Jani Nikula <jani.nikula@intel.com>
> Date: Tue, 18 Sep 2018 13:12:34 +0300
> Subject: [PATCH] drm/i915: delay hotplug scheduling
> Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
> Cc: Jani Nikula <jani.nikula@intel.com>
>
> On some systems we get the hotplug irq on unplug before the DDC pins
> have been disconnected, resulting in connector status remaining
> connected. Since previous attempts at using hotplug live status before
> DDC have failed, the only viable option is to reduce the window for
> mistakes. Delay the hotplug processing.
>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h      |  2 +-
>  drivers/gpu/drm/i915/intel_hotplug.c | 15 ++++++++++-----
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 7d4daa7412f1..27f579abddae 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -286,7 +286,7 @@ enum hpd_pin {
>  #define HPD_STORM_DEFAULT_THRESHOLD 5
>
>  struct i915_hotplug {
> -       struct work_struct hotplug_work;
> +       struct delayed_work hotplug_work;
>
>         struct {
>                 unsigned long last_jiffies;
> diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
> index 648a13c6043c..3af64daa5cfc 100644
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -110,6 +110,8 @@ enum hpd_pin intel_hpd_pin_default(struct drm_i915_private *dev_priv,
>         }
>  }
>
> +#define HOTPLUG_DELAY_MS               300
> +
>  #define HPD_STORM_DETECT_PERIOD                1000
>  #define HPD_STORM_REENABLE_DELAY       (2 * 60 * 1000)
>
> @@ -319,7 +321,8 @@ static void i915_digport_work_func(struct work_struct *work)
>                 spin_lock_irq(&dev_priv->irq_lock);
>                 dev_priv->hotplug.event_bits |= old_bits;
>                 spin_unlock_irq(&dev_priv->irq_lock);
> -               schedule_work(&dev_priv->hotplug.hotplug_work);
> +               schedule_delayed_work(&dev_priv->hotplug.hotplug_work,
> +                                     msecs_to_jiffies(HOTPLUG_DELAY_MS));
>         }
>  }
>
> @@ -329,7 +332,7 @@ static void i915_digport_work_func(struct work_struct *work)
>  static void i915_hotplug_work_func(struct work_struct *work)
>  {
>         struct drm_i915_private *dev_priv =
> -               container_of(work, struct drm_i915_private, hotplug.hotplug_work);
> +               container_of(work, struct drm_i915_private, hotplug.hotplug_work.work);
>         struct drm_device *dev = &dev_priv->drm;
>         struct intel_connector *intel_connector;
>         struct intel_encoder *intel_encoder;
> @@ -466,7 +469,8 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
>         if (queue_dig)
>                 queue_work(dev_priv->hotplug.dp_wq, &dev_priv->hotplug.dig_port_work);
>         if (queue_hp)
> -               schedule_work(&dev_priv->hotplug.hotplug_work);
> +               schedule_delayed_work(&dev_priv->hotplug.hotplug_work,
> +                                     msecs_to_jiffies(HOTPLUG_DELAY_MS));
>  }
>
>  /**
> @@ -586,7 +590,8 @@ void intel_hpd_poll_init(struct drm_i915_private *dev_priv)
>
>  void intel_hpd_init_work(struct drm_i915_private *dev_priv)
>  {
> -       INIT_WORK(&dev_priv->hotplug.hotplug_work, i915_hotplug_work_func);
> +       INIT_DELAYED_WORK(&dev_priv->hotplug.hotplug_work,
> +                         i915_hotplug_work_func);
>         INIT_WORK(&dev_priv->hotplug.dig_port_work, i915_digport_work_func);
>         INIT_WORK(&dev_priv->hotplug.poll_init_work, i915_hpd_poll_init_work);
>         INIT_DELAYED_WORK(&dev_priv->hotplug.reenable_work,
> @@ -604,7 +609,7 @@ void intel_hpd_cancel_work(struct drm_i915_private *dev_priv)
>         spin_unlock_irq(&dev_priv->irq_lock);
>
>         cancel_work_sync(&dev_priv->hotplug.dig_port_work);
> -       cancel_work_sync(&dev_priv->hotplug.hotplug_work);
> +       cancel_delayed_work_sync(&dev_priv->hotplug.hotplug_work);
>         cancel_work_sync(&dev_priv->hotplug.poll_init_work);
>         cancel_delayed_work_sync(&dev_priv->hotplug.reenable_work);
>  }
> --
> 2.11.0
>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
