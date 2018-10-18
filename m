Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F8AC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E57B205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egfARMgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E57B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJSDtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:49:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45754 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSDtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:49:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id m6-v6so5852452eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQGVUmD5OSb9TYQ+ssKwRAJeQ+u3I7N+6luQa67HLO4=;
        b=egfARMgH+8Ri16SiPsxmML/BDzAK+MoXiWf9Q1YzCkbhFAwlJpOxQTgmJJlc1r8hlO
         HKoj20b31C2/CoKmoWQjiCu5OOMVSx7etPPD27iJO0nTptM/r//Yr9sVJZDS7dcs8ne3
         GPF8xKk9lYRcam+BB2WjvKXzO7XYTQexWNkJbB4Y2/Vk7d4XyxrFxI5hRuQ33lnJxWni
         VVCCGVfARPvSv4XZf6o2p8wm9HwXqKySTvdNxUljQFWv5Vg58SGpLxxGbhXQimC0GN7o
         GDJWpdtQsNP2zLq0u4GlxAE00y+3kjst8Gi/YaBSSlpGMXUOj6dNP/4BnTqY3pFhUZiH
         /ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQGVUmD5OSb9TYQ+ssKwRAJeQ+u3I7N+6luQa67HLO4=;
        b=nzSrCooSY0EsHb829ZRL8ty9/Fk8fJuW3+3/MG4iHKSdX3lqz42Q0zkZgzUqRKn7kV
         kqGcvC2jV5TNBpJFOWiD1YAUgjwjzYo0GymBPADmq98uEh7jATct8KXZq7TSuqq8Nxco
         pcPWkTAS9fpi4KUPiRZtJT0+IUsSSlX2GMgKFGryCL/oNxOONyN9sxqBHOZ3uBM2pTkw
         NbWX29i4sKG82uAu9XVDS2+Bp0Bzq2jLaPMx5I1x+SxqvDZOP2jk3cfHnfSx36VkkkGB
         IFfd+OzPkdbTokcXlyJ/cxouZ3P8YZNOSb9DlE0h3tzecCVzJo4FZpydKG3bAlp3xV+A
         Rp9A==
X-Gm-Message-State: ABuFfoj5sA0lJZiDuYle8Zi+7GhISYaRfjUxSKJX/mOZU2qyxhWIVKfq
        ADwVJNnTDI5pxHP5TJtDZGEYN3aFHqU=
X-Google-Smtp-Source: ACcGV63iPP7SW8IdsBghYamoY0ZJOYucS7LMviWf1h3tLQlwiv5qWzpA+ocN/MF++Q8DKhB9085V7Q==
X-Received: by 2002:a17:906:4452:: with SMTP id i18-v6mr29810479ejp.93.1539892018350;
        Thu, 18 Oct 2018 12:46:58 -0700 (PDT)
Received: from [192.168.1.3] (x4dbc7b03.dyn.telefonica.de. [77.188.123.3])
        by smtp.gmail.com with ESMTPSA id d12-v6sm8846623ede.32.2018.10.18.12.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:46:57 -0700 (PDT)
Subject: Re: [PATCH] staging: bcm2835-audio: interpolate audio delay
To:     Mike Brady <mikebrady@eircom.net>
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com, tiwai@suse.de,
        nishka.dasgupta_ug18@ashoka.edu.in, julia.lawall@lip6.fr,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181018105715.GA6660@ubuntu>
From:   Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <22867d63-12f1-31f7-acb6-ce9a58fcbe71@gmail.com>
Date:   Thu, 18 Oct 2018 21:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181018105715.GA6660@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On 10/18/18 12:57, Mike Brady wrote:
> +	ktime_t now = ktime_get();
> +
> +	/* Give userspace better delay reporting by interpolating between GPU
> +	 * notifications, assuming audio speed is close enough to the clock
> +	 * used for ktime
> +	 */
> +
> +	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
> +	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
> +		u64 interval =
> +			(ktime_to_ns(ktime_sub(now,
> +				alsa_stream->interpolate_start)));
> +		u64 frames_output_in_interval =
> +			div_u64((interval * runtime->rate), 1000000000);
> +		snd_pcm_sframes_t frames_output_in_interval_sized =
> +			-frames_output_in_interval;
> +		runtime->delay = frames_output_in_interval_sized;
> +	}

This doesn't look like a good solution for me. More like a workaround. What is
the root cause of the delay?

Best Regards,
Kirill
