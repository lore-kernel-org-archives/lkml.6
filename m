Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D463B21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFwKmwbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfAVR3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:29:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33215 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAVR3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:29:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so11376197pgu.0;
        Tue, 22 Jan 2019 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pKolkDkzQZWKrYyCQSIvZW7bJreVHMPVec+TmL/YUY=;
        b=OFwKmwbnnrJEOCtyGtO7ATF6EeU5fqHIRMp9mtq1RPIi6xwyan62N43d4K2m4QLRZX
         Ls89khGFsgcJm1bm4HGQ489LxnToFNMM3M9OggqXqqkyiCYhJTs7kg9dAfkz3BzOz74S
         lwiB9k6Vt6Luj0Lqyn3WUuYsF2Lg7fzNo1iMNmyiD7exqJnDCfO3pHTw1i9M27oUCT3o
         77rCnOHamI4kfoRbWMD6RS2sUfTKGi4v7v+FA4q3GSRjTbYlJnXJK/4maSxUPCITgs+u
         moLy1ngvG5HKEd48lCTj6h66aWDPucHlJOyu2H2D3baVqF5tbtZXi1Vl4jsYE3jFaz9u
         mfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pKolkDkzQZWKrYyCQSIvZW7bJreVHMPVec+TmL/YUY=;
        b=pUZt0kPv//xW7PhYXY60kMQ2BCt2tIOwOFUq0v0EpIKjuYijZJEI2zYBNv3zH3Gwl/
         EefXJG5i73wTYXuXK1sNDwcJkjYRP94gZTHmdUWRqtDzQVFZNs7qt9qulphlOeRuCLO5
         ypTWcAFPx5S0eWKXeVjGLwUEj4q7mud6xviKn8Cj3DkvtlkRX+f6yBQIOW3VvTe5iAfT
         yV2ZfRU13zPJU0SEMzdhAd6x09C1OaOuR0EZJBk0G05BrKZqzRfADve3zxlKjrtUbVtq
         GWCWh1IOH1GdWzv9h0TxYVru9ZvJhwttKC3mbS6UyKbdBrFqm5FpljRabYrr6sJPK3Ib
         M4Nw==
X-Gm-Message-State: AJcUuke4gyZ5XYobNA1EuT5COXKkjKfHj1VFtLQ/ohfgUBdC3PSavom1
        e/gUW3TeZllQPI2gtTkeRwY=
X-Google-Smtp-Source: ALg8bN5y72Tx0hwHvGa7rE0MvxFcn7+tQZKrr2MiKsi9PlehMcEHyfoFpp5DzJ7ILaxmrAj2/O0r2A==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr32961434pgd.57.1548178177040;
        Tue, 22 Jan 2019 09:29:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t24sm32713763pfm.127.2019.01.22.09.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 09:29:36 -0800 (PST)
Date:   Tue, 22 Jan 2019 09:29:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Esben Haabendal <esben@haabendal.dk>,
        "martin@hundeboll.net" <martin@hundeboll.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH v9 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Message-ID: <20190122172935.GA4964@roeck-us.net>
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
 <20190121204527.5548-1-rasmus.villemoes@prevas.dk>
 <20190121204527.5548-2-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121204527.5548-2-rasmus.villemoes@prevas.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 08:45:39PM +0000, Rasmus Villemoes wrote:
> The watchdog framework takes care of feeding a hardware watchdog until
> userspace opens /dev/watchdogN. If that never happens for some reason
> (buggy init script, corrupt root filesystem or whatnot) but the kernel
> itself is fine, the machine stays up indefinitely. This patch allows
> setting an upper limit for how long the kernel will take care of the
> watchdog, thus ensuring that the watchdog will eventually reset the
> machine.
> 
> A value of 0 (the default) means infinite timeout, preserving the
> current behaviour.
> 
> This is particularly useful for embedded devices where some fallback
> logic is implemented in the bootloader (e.g., use a different root
> partition, boot from network, ...).
> 
> There is already handle_boot_enabled serving a similar purpose. However,
> such a binary choice is unsuitable if the hardware watchdog cannot be
> programmed by the bootloader to provide a timeout long enough for
> userspace to get up and running. Many of the embedded devices we see use
> external (gpio-triggered) watchdogs with a fixed timeout of the order of
> 1-2 seconds.
> 
> The open timeout is also used as a maximum time for an application to
> re-open /dev/watchdogN after closing it. Again, while the kernel already
> has a nowayout mechanism, using that means userspace is at the mercy of
> whatever timeout the hardware has.
> 
> Being a module parameter, one can revert to the ordinary behaviour of
> having the kernel maintain the watchdog indefinitely by simply writing 0
> to /sys/... after initially opening /dev/watchdog; conversely, one can
> of course also have the current behaviour of allowing indefinite time
> until the first open, and then set that module parameter.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  .../watchdog/watchdog-parameters.txt          |  8 +++++
>  drivers/watchdog/watchdog_dev.c               | 30 +++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 0b88e333f9e1..907c4bb13810 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -8,6 +8,14 @@ See Documentation/admin-guide/kernel-parameters.rst for information on
>  providing kernel parameters for builtin drivers versus loadable
>  modules.
>  
> +The watchdog core parameter watchdog.open_timeout is the maximum time,
> +in seconds, for which the watchdog framework will take care of pinging
> +a hardware watchdog until userspace opens the corresponding
> +/dev/watchdogN device. A value of 0 (the default) means an infinite
> +timeout. Setting this to a non-zero value can be useful to ensure that
> +either userspace comes up properly, or the board gets reset and allows
> +fallback logic in the bootloader to try something else.
> +

This is misleading. Unless I am missing something, the above only applies
if the watchdog is already runnning at boot, and after it has been opened
and closed once.

FWIW, I find this operation quite confusing. What is the rationale for not
starting the watchdog at boot time if it is not running and open_timeout
is set, but then refusing to stop it after it has been started once ?

>  
>  -------------------------------------------------
>  acquirewdt:
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index f6c24b22b37c..ab2ad20f13eb 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -69,6 +69,7 @@ struct watchdog_core_data {
>  	struct mutex lock;
>  	ktime_t last_keepalive;
>  	ktime_t last_hw_keepalive;
> +	ktime_t open_deadline;
>  	struct hrtimer timer;
>  	struct kthread_work work;
>  	unsigned long status;		/* Internal status bits */
> @@ -87,6 +88,19 @@ static struct kthread_worker *watchdog_kworker;
>  static bool handle_boot_enabled =
>  	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
>  
> +static unsigned open_timeout;
> +
> +static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
> +{
> +	return ktime_after(ktime_get(), data->open_deadline);
> +}
> +
> +static void watchdog_set_open_deadline(struct watchdog_core_data *data)
> +{
> +	data->open_deadline = open_timeout ?
> +		ktime_get() + ktime_set(open_timeout, 0) : KTIME_MAX;
> +}
> +
>  static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>  {
>  	/* All variables in milli-seconds */
> @@ -211,7 +225,13 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
>  {
>  	struct watchdog_device *wdd = wd_data->wdd;
>  
> -	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
> +	if (!wdd)
> +		return false;
> +
> +	if (watchdog_active(wdd))
> +		return true;
> +
> +	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wd_data);
>  }
>  
>  static void watchdog_ping_work(struct kthread_work *work)
> @@ -297,7 +317,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
>  		return -EBUSY;
>  	}
>  
> -	if (wdd->ops->stop) {
> +	if (wdd->ops->stop && !open_timeout) {

This changes the semantics of WDIOC_SETOPTIONS / WDIOS_DISABLECARD.
"Turn off the watchdog timer" is well defined and doesn't leave
the option of setting a timeout on it.

>  		clear_bit(WDOG_HW_RUNNING, &wdd->status);
>  		err = wdd->ops->stop(wdd);
>  	} else {
> @@ -883,6 +903,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  		watchdog_ping(wdd);
>  	}
>  
> +	watchdog_set_open_deadline(wd_data);
>  	watchdog_update_worker(wdd);
>  
>  	/* make sure that /dev/watchdog can be re-opened */
> @@ -983,6 +1004,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>  
>  	/* Record time of most recent heartbeat as 'just before now'. */
>  	wd_data->last_hw_keepalive = ktime_sub(ktime_get(), 1);
> +	watchdog_set_open_deadline(wd_data);
>  
>  	/*
>  	 * If the watchdog is running, prevent its driver from being unloaded,
> @@ -1181,3 +1203,7 @@ module_param(handle_boot_enabled, bool, 0444);
>  MODULE_PARM_DESC(handle_boot_enabled,
>  	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
>  	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
> +
> +module_param(open_timeout, uint, 0644);
> +MODULE_PARM_DESC(open_timeout,
> +	"Maximum time (in seconds, 0 means infinity) for userspace to take over a running watchdog (default=0)");

The description is misleading. After the initial open, a subsequent close no
longer really stops the watchdog.

> -- 
> 2.20.1
> 
