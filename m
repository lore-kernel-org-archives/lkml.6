Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFAB20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRmiCd0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFAB20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJEBz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:55:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43439 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEBz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:55:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so3561094pgh.10;
        Thu, 04 Oct 2018 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DS+YLJeEAd9gX/DQDVYCNjj3rD4PSxfAxpuKhftJ/Ys=;
        b=mRmiCd0bVYlng1a+bzJ9AoCSy5jlu2fiwkQW7tYVFo0t/NJLoHgwcCGOPhxjnxIH6V
         bEpeyEAntmK229KoBhKm4/BAyqS+4Z03XETjuIeTrvYMFeTIe/HFbFMJOXyMiKKaSNvP
         E+Pv/CQ6e23AosthWyo2dfeL3o5pU7fi67nffbSM8A/9BG9G3j+hoWi2fi3oobCe9xQv
         5MDPZcEXa1BAatydIE/y6QBu7UNomhfvlAwdh8hMgJKfNEYuP28gy0pCfOITly5AREzE
         JbUxlOYuCoCQPke2rOJmxp2jKVryzS4oIgLhESlzNmhWhFRIatOojZacU1ec7bgsF9xt
         nfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DS+YLJeEAd9gX/DQDVYCNjj3rD4PSxfAxpuKhftJ/Ys=;
        b=hwhl7S6uVmouG+CRdJkSyGKyIdKe9edRDt4FvFPx0v1TmvzLs9oFSBCTSHJ4S11SJC
         7DRAnbDvJAG35jn/Vz699eQD3QSPeOZOgUgA11rvq6IeENTk9dUtDtX75Pu61dXJWh9T
         i/BOglBTcLq8Ipz5CXyAcYfDwxznsla1wi7Qu1XwDC7qUoBaVmNcQRZCTlM1KyBCJEN1
         2dzNoyEAAjVW6qkZSPNlB2F1vSrgf6X7U3lxia9CFd8a60oeSXhmCWGx2/93Z4taLSLZ
         IRABPmRYGdcv/SoY4MdwUBd5tC8p53eTUmMplyDLov8oakHADy46RgEt3lKjZU+WXriM
         8AYg==
X-Gm-Message-State: ABuFfogOsgje6ZjEDfP5oBAzrLaY/G5EWCg4EAQsg+PKcUXiw7yUZPrz
        TzfIMtuCK4Ihg0U69BEYGIg=
X-Google-Smtp-Source: ACcGV62QUgTm75grotw1XKJ5QhiCpYgZJp0IAk4mxkxUnUXugoLZda9LXzi+MeOJcwfhELI5F81zqw==
X-Received: by 2002:a62:7a81:: with SMTP id v123-v6mr8271388pfc.240.1538679683160;
        Thu, 04 Oct 2018 12:01:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l2-v6sm5565727pgp.20.2018.10.04.12.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 12:01:22 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:01:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: reserve 2 events code because of HID
Message-ID: <20181004190119.GB233675@dtor-ws>
References: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:34:30PM +0200, Benjamin Tissoires wrote:
> Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> a duplicate is found") from the v4.18 kernel, HID used to shift the
> event codes if a duplicate usage was found. This ended up in a situation
> where a device would export a ton of ABS_MISC+n event codes, or a ton
> of REL_MISC+n event codes.
> 
> This is now fixed, however userspace needs to detect those situation.
> Fortunately, ABS_MT_SLOT-1 (ABS_MISC+6) was never assigned a code, and
> so libinput can detect fake multitouch devices from genuine ones by
> checking if ABS_MT_SLOT-1 is set.
> 
> Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> true high res mice from some other device in a pre-v4.18 kernel.
> 
> Set in stone that the ABS_MISC+6 and REL_MISC+1 are reserved and should not
> be used so userspace can properly work around those old kernels.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Dmitry, I did not take your Acked-by, as I added 2 new events and wanted to
> be sure you are still OK.

Yes, this is still fine.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> Jiri, this will still need to go through your tree, as the input-event-codes
> changes that introduce REL_WHEEL_HI_RES are in your for-4.20/logitech-highres.
> 
> Cheers,
> Benjamin
> 
>  include/uapi/linux/input-event-codes.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 29fb891ea337..b5e0e9856c47 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -708,7 +708,15 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> -#define REL_WHEEL_HI_RES	0x0a
> +/*
> + * 0x0a is reserved and should not be used in input drivers.
> + * It was used by HID as REL_MISC+1 and userspace needs to detect if
> + * the next REL_* event is correct or is just REL_MISC + n.
> + * We define here REL_RESERVED so userspace can rely on it and detect
> + * the situation described above.
> + */
> +#define REL_RESERVED		0x0a
> +#define REL_WHEEL_HI_RES	0x0b
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> @@ -745,6 +753,15 @@
>  
>  #define ABS_MISC		0x28
>  
> +/*
> + * 0x2e is reserved and should not be used in input drivers.
> + * It was used by HID as ABS_MISC+6 and userspace needs to detect if
> + * the next ABS_* event is correct or is just ABS_MISC + n.
> + * We define here ABS_RESERVED so userspace can rely on it and detect
> + * the situation described above.
> + */
> +#define ABS_RESERVED		0x2e
> +
>  #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
>  #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
>  #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
> -- 
> 2.14.3
> 

-- 
Dmitry
