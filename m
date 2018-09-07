Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B34A2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6+B9bUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B34A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeIGWRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:17:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39651 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeIGWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:17:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so7343365pff.6;
        Fri, 07 Sep 2018 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IjX6ru9EF51TP19f4jfIgUkVjFK+B9XjIAX845dcbzs=;
        b=G6+B9bUdPqX3/iL91cmTKQqZPAEsaHcsNKaFukxFzuMp4T3DUwsDoGzTx7SSMGUcJO
         SSO+LzbT96oNpzFUiN/pFev4R58GuFbumG0KUxtY/tMw8KQ2B/FtoKjKLBGzMIZOTb5c
         mqqgUW8DmAv2Hd3scm9hC6w2qQDF7RWfVVahGZ3avhCYMTl0lPFYaPEbi1QKwkoFUbtZ
         8HDemJFN+vDvogH/EWG4YkHFdYuHv8SH61FV/+n1iDSMPN15TNjkqB4I+FAxct0komzD
         SZEkcnJI3QTP5dAdfQn91PTYq5K5iZfv5FCzi0y+0vHaDSNvSwoJoK7DlbHZIc+YGajE
         3W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IjX6ru9EF51TP19f4jfIgUkVjFK+B9XjIAX845dcbzs=;
        b=O2Ma8mb3P3u+tbcaHYNzqWpmv/s+9TqQDMAXZd+9+MeLFTO9fXMw7L7r1DoEwviCmr
         PShXI4kCBnmDs/j9XUlJyqE+Wtv/QnTIkMbdCzZTr4qCxJ3hxGi9dJ/30BJVA4qGY8q1
         Te91aulxUApB1n2hxa7m9YzwI3AryPNtWEGffNSD5PkrKtKeTywzOEsI+wn46AvRhWBV
         TYvcM7Ga0KT8JuTO5JbldVg0uRkWq7YY0JRX8SFVyzA51FzmYmVxqvA/Pq9TefwjnY+o
         YJXhlWZvL8ZbWL9Q5w1V9KAZWJOwG+cSympOK/44PWFaG6/gDnTo9c1l4sIZ406r1z1B
         6QJw==
X-Gm-Message-State: APzg51C0dk6cjXSVrp+OhC04tGfN7JY7VgL2X35WMnIAET1UxWIGooU8
        r3rUu0ZSrmN6B7FvmCUjEXM=
X-Google-Smtp-Source: ANB0VdbioKx51LCzgksALb4NMJ+IUEUCa5qTYF6dGKtjcshtPmP9BQOYgYubFKgz/JEUY/1GTeoI1w==
X-Received: by 2002:a63:d150:: with SMTP id c16-v6mr9478060pgj.188.1536341709202;
        Fri, 07 Sep 2018 10:35:09 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e14-v6sm10927877pff.128.2018.09.07.10.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:35:07 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:35:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: reserve 2 events code because of HID
Message-ID: <20180907173505.GA261528@dtor-ws>
References: <20180907085115.30242-1-benjamin.tissoires@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907085115.30242-1-benjamin.tissoires@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:51:15AM +0200, Benjamin Tissoires wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> a duplicate is found") from the v4.18 kernel, HID used to shift the
> event codes if a duplicate usage was found. This ended up in a situation
> where a device would export a ton of ABS_MISC+n event codes, or a ton
> of REL_MISC+n event codes.
> 
> This is now fixed, however userspace needs to detect those situation.
> Fortunately, ABS_MISC+1 was never assigned a code, and so libinput
> can detect fake multitouch devices from genuine ones by checking is
> ABS_MISC+1 is set.
> 
> Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> true high res mice from some other device in a pre-v4.18 kernel.
> 
> Set in stone that the ABS_MISC+1 and REL_MISC+1 are reserved and should not
> be used so userspace can properly work around those old kernels.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi,
> 
> while reviewing my local tree, I realize that we might want to be able
> to differentiate older kernels from new ones that export REL_WHEEL_HI_RES.
> 
> I know Dmitry was against adding several REL_MISC, so I hope just moving
> REL_WHEEL_HI_RES by one and reserving the faulty event codes would be good
> this time.
> 
> This patch applies on top of the branch for-4.20/logitech-highres from
> Jiri's tree. It should go through Jiri's tree as well.

Hm, this is a bit ugly, bit I guess we could spare an event code.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> Cheers,
> Benjamin
> 
>  include/uapi/linux/input-event-codes.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 29fb891ea337..30149939249a 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -708,7 +708,12 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> -#define REL_WHEEL_HI_RES	0x0a
> +/*
> + * 0x0a is reserved and should not be used.
> + * It was used by HID as REL_MISC+1 and usersapce needs to detect if
> + * the next REL_* event is correct or is just REL_MISC + n.
> + */
> +#define REL_WHEEL_HI_RES	0x0b
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> @@ -745,6 +750,12 @@
>  
>  #define ABS_MISC		0x28
>  
> +/*
> + * 0x29 is reserved and should not be used.
> + * It was used by HID as ABS_MISC+1 and usersapce needs to detect if
> + * the next ABS_* event is correct or is just ABS_MISC + n.
> + */
> +
>  #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
>  #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
>  #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
> -- 
> 2.14.3
> 

-- 
Dmitry
