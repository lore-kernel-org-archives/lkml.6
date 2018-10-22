Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2DC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9273C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvb2mcyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9273C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeJWBRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:17:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:17:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so19295961pgq.5;
        Mon, 22 Oct 2018 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfEzUd4enn/+eDaO7WiqqdsVKsRFJAQsdhSQIJoSpgY=;
        b=jvb2mcyGoPdYozBz3Td5isVqAg/xoCp14Rs1GBmUvjVZGlxQTFdOoMY5i1/ZaVdXki
         VQTxMctB4sYgh5k66L9RKZr/kZzrYl5wAU5zOEU5D3qz/MxWxi88lQadxI0eSuCtve9c
         lEvGnN8O+a/C+YpHnE074nTo2wD6vmCsHcR0KqFB+eRs83cfXOehlhryvG9SYBnd11rg
         GGm9cpEScLwGv0SPn/OUJARu65Z/l14bKsy6hUU/I40K7umH1rEBmlUFL7/HjktQa+f2
         ikJERFJIBsRFy0kIC0VlEkuZlUcihHUpGGZ8/L3G1ouq6/3qeLOhZJXIR+34BTN3UILx
         sW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfEzUd4enn/+eDaO7WiqqdsVKsRFJAQsdhSQIJoSpgY=;
        b=Z6hHGeudoQCyvuyYh5AduspvI0aKquv66j/7F0LFyMXwQQAdWxBXYy33KKSPnGAh5/
         xUR10EmMAnbvkaISni+L1jBCB+u60Vmynp8FrjShJ/BPidU+YHitNf1MBMCdvFL7oDJS
         0bb8nJwjpqPQHDSwQTaIGGU2DX4wMu8wQ4+KLxAatVThjhCr9NPi6oapWuqGy1fBVvKW
         cD7IF1wKHcuOzTBMfOrzxT0tLxACS3VrXbWCXbRlIbvTk9eGXE60Wl1YR7u0zRYDsF5k
         ahyMJ2kPMn8utEpWmQd4jiipdth0wwpqb9hrDle0Lt6p+7lvlZ51/eamBOVLJwhXqGMr
         fn9A==
X-Gm-Message-State: AGRZ1gKzG9earXEL1K9IdBzc1WgHoKpGiH+S+xu1Q6qrIe4sZH+XUjau
        muiqWlgRtAIHXmxi0HSZHkC7w1cp/zM=
X-Google-Smtp-Source: AJdET5fz4ho22byoi0Z7Fc2JFWyWsMsf9zYSRel6v3JtxTIhvh7v/vFtJqh+5eVjaCj/PH70cygZrw==
X-Received: by 2002:a63:6150:: with SMTP id v77mr4677114pgb.266.1540227505394;
        Mon, 22 Oct 2018 09:58:25 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q8-v6sm34850218pgv.65.2018.10.22.09.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 09:58:24 -0700 (PDT)
Date:   Mon, 22 Oct 2018 09:58:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH AUTOSEL 4.18 04/27] Input: i8042 - enable keyboard
 wakeups by default when s2idle is used
Message-ID: <20181022165821.GA27929@dtor-ws>
References: <20181022101924.40531-1-sashal@kernel.org>
 <20181022101924.40531-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022101924.40531-4-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, Oct 22, 2018 at 06:19:01AM -0400, Sasha Levin wrote:
> From: Daniel Drake <drake@endlessm.com>
> 
> [ Upstream commit 684bec1092b6991ff2a7751e8a763898576eb5c2 ]
> 
> Previously, on typical consumer laptops, pressing a key on the keyboard
> when the system is in suspend would cause it to wake up (default or
> unconditional behaviour). This happens because the EC generates a SCI
> interrupt in this scenario.
> 
> That is no longer true on modern laptops based on Intel WhiskeyLake,
> including Acer Swift SF314-55G, Asus UX333FA, Asus UX433FN and Asus
> UX533FD. We confirmed with Asus EC engineers that the "Modern Standby"
> design has been modified so that the EC no longer generates a SCI
> in this case; the keyboard controller itself should be used for wakeup.
> 
> In order to retain the standard behaviour of being able to use the
> keyboard to wake up the system, enable serio wakeups by default on
> platforms that are using s2idle.

I disagree that this should be included in stable as it does not fix a
regression on the aforementioned platforms and has a potential to alter
the behavior. The fact that the system does not wake up on keyboard is
not a showstopper, wakeup usually happens on lid open anyway.

It is hitting 4.19 LTS train and that should be enough. Please do not
pick up for earlier stables.

Thanks.

> 
> Link: https://lkml.kernel.org/r/CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/serio/i8042.c | 29 ++++++++++++++++++++---------
>  include/linux/suspend.h     |  2 ++
>  kernel/power/suspend.c      |  6 ++++++
>  3 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 824f4c1c1f31..6462f1798fbb 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -1392,15 +1392,26 @@ static void __init i8042_register_ports(void)
>  	for (i = 0; i < I8042_NUM_PORTS; i++) {
>  		struct serio *serio = i8042_ports[i].serio;
>  
> -		if (serio) {
> -			printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
> -				serio->name,
> -				(unsigned long) I8042_DATA_REG,
> -				(unsigned long) I8042_COMMAND_REG,
> -				i8042_ports[i].irq);
> -			serio_register_port(serio);
> -			device_set_wakeup_capable(&serio->dev, true);
> -		}
> +		if (!serio)
> +			continue;
> +
> +		printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
> +			serio->name,
> +			(unsigned long) I8042_DATA_REG,
> +			(unsigned long) I8042_COMMAND_REG,
> +			i8042_ports[i].irq);
> +		serio_register_port(serio);
> +		device_set_wakeup_capable(&serio->dev, true);
> +
> +		/*
> +		 * On platforms using suspend-to-idle, allow the keyboard to
> +		 * wake up the system from sleep by enabling keyboard wakeups
> +		 * by default.  This is consistent with keyboard wakeup
> +		 * behavior on many platforms using suspend-to-RAM (ACPI S3)
> +		 * by default.
> +		 */
> +		if (pm_suspend_via_s2idle() && i == I8042_KBD_PORT_NO)
> +			device_set_wakeup_enable(&serio->dev, true);
>  	}
>  }
>  
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 440b62f7502e..206b735f383f 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -251,6 +251,7 @@ static inline bool idle_should_enter_s2idle(void)
>  	return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
>  }
>  
> +extern bool pm_suspend_via_s2idle(void);
>  extern void __init pm_states_init(void);
>  extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
>  extern void s2idle_wake(void);
> @@ -282,6 +283,7 @@ static inline void pm_set_suspend_via_firmware(void) {}
>  static inline void pm_set_resume_via_firmware(void) {}
>  static inline bool pm_suspend_via_firmware(void) { return false; }
>  static inline bool pm_resume_via_firmware(void) { return false; }
> +static inline bool pm_suspend_via_s2idle(void) { return false; }
>  
>  static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
>  static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 87331565e505..3eeafaff190a 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -63,6 +63,12 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>  enum s2idle_states __read_mostly s2idle_state;
>  static DEFINE_RAW_SPINLOCK(s2idle_lock);
>  
> +bool pm_suspend_via_s2idle(void)
> +{
> +	return mem_sleep_current == PM_SUSPEND_TO_IDLE;
> +}
> +EXPORT_SYMBOL_GPL(pm_suspend_via_s2idle);
> +
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
>  {
>  	lock_system_sleep();
> -- 
> 2.17.1
> 

-- 
Dmitry
