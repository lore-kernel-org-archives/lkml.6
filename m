Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96524C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4720868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6aUun3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF4720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLFW4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:56:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32987 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFW4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:56:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so912364pfb.0;
        Thu, 06 Dec 2018 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cuuuP3UzJef2SPmfFTopC4S/InN6jVnTmTU6Z8V43u8=;
        b=a6aUun3/t+oHKtEuBA0UrORX0QkQBvKGTI5LU8XPYHyWLYUzC/HY8zLmtxLsfjLyNF
         TrdEtZrGx0i/pNHppOSU3V7cYjp3043AWZ7LIR/X3Exj6IElVchr9Xb+awczUqfJ3q7Y
         JUXW5Qot8yQO7Ow5LvCfXPcdJ81aN75KgYYrIVSXOuIVOiRJo4Xc3bd1dIrdOngMUrZv
         WJvnu6naXhMRCbckuIiefsKigyfqeVRCACx7+llGhXBuAs/eg0A925lvBDFaRETJtY1s
         MPtSZsI90AGY5/GQCUOtXSlkzo1vy3vZwxVL8XtwBEHpIloV5AVljsQ1iaI4rIv00hEo
         RWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cuuuP3UzJef2SPmfFTopC4S/InN6jVnTmTU6Z8V43u8=;
        b=nRdtwDPHXnyzgdWH9/gFS2mFnNQQYfSI3Ez0djAOMx2LOzI9qZVG28YilqRHCzo+4F
         B0d4+2EkCEYzOTK3KqvoCSk/8LKaDEX6qjloSbA+Ugym1xE59AqVoNw/3tQ8UcfaYRNZ
         w3Uhb8CmhS8iWUy2u/649dJ5QjuzMuRUVUPWc36ZsApAqMyJ1xDLOtoAKZj6cUtwCKZy
         gZ4nNLA/Em5wCmSBNdljcSTH2/Z2Q95vUvZqpMu007QX1RSyuQZq0aBhXe/5ua1qIve3
         KIhJEVe/faNHg9MaHPt048XKQB6oBg102wXJcwDCT21p0S2On1x8DFFAU/dJ79uSFJcP
         TUsA==
X-Gm-Message-State: AA+aEWY/PapgVasNk2xU26MhpxxRpzdRDn7tVksDx9Z2zQ8hbKz/zvOD
        LE6wba8Q00iJZlztq8ZyC1w=
X-Google-Smtp-Source: AFSGD/U7Go2QzRc6d1pUTKuDrzb3nuEgIGdXKlDVVVO6hAFHS0fsDnrfdq4hKjwmttBQUTOmKgstbg==
X-Received: by 2002:a62:a1a:: with SMTP id s26mr30579070pfi.31.1544137004631;
        Thu, 06 Dec 2018 14:56:44 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t29sm2199047pfa.158.2018.12.06.14.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 14:56:43 -0800 (PST)
Date:   Thu, 6 Dec 2018 14:56:41 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 1/8] Input: add `REL_WHEEL_HI_RES` and
 `REL_HWHEEL_HI_RES`
Message-ID: <20181206225641.GB34001@dtor-ws>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-2-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205004228.10714-2-peter.hutterer@who-t.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:42:21AM +1000, Peter Hutterer wrote:
> This event code represents scroll reports from high-resolution wheels and
> is modelled after the approach Windows uses. The value 120 is one detent
> (wheel click) of movement. Mice with higher-resolution scrolling can send
> fractions of 120 which must be accumulated in userspace. Userspace can either
> wait for a full 120 to accumulate or scroll by fractions of one logical scroll
> movement as the events come in. 120 was picked as magic number because it has
> a high number of integer fractions that can be used by high-resolution wheels.
> 
> For more information see
> https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn613912(v=vs.85)
> 
> These new axes obsolete REL_WHEEL and REL_HWHEEL. The legacy axes are emulated
> by the kernel but the most accurate (and most granular) data is available
> through the new axes.
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> No changes since v1
> 
>  Documentation/input/event-codes.rst    | 21 ++++++++++++++++++++-
>  include/uapi/linux/input-event-codes.h |  2 ++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index a8c0873beb95..b24b5343f5eb 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -190,7 +190,26 @@ A few EV_REL codes have special meanings:
>  * REL_WHEEL, REL_HWHEEL:
>  
>    - These codes are used for vertical and horizontal scroll wheels,
> -    respectively.
> +    respectively. The value is the number of detents moved on the wheel, the
> +    physical size of which varies by device. For high-resolution wheels
> +    this may be an approximation based on the high-resolution scroll events,
> +    see REL_WHEEL_HI_RES. These event codes are legacy codes and
> +    REL_WHEEL_HI_RES and REL_HWHEEL_HI_RES should be preferred where
> +    available.
> +
> +* REL_WHEEL_HI_RES, REL_HWHEEL_HI_RES:
> +
> +  - High-resolution scroll wheel data. The accumulated value 120 represents
> +    movement by one detent. For devices that do not provide high-resolution
> +    scrolling, the value is always a multiple of 120. For devices with
> +    high-resolution scrolling, the value may be a fraction of 120.
> +
> +    If a vertical scroll wheel supports high-resolution scrolling, this code
> +    will be emitted in addition to REL_WHEEL or REL_HWHEEL. The REL_WHEEL
> +    and REL_HWHEEL may be an approximation based on the high-resolution
> +    scroll events. There is no guarantee that the high-resolution data
> +    is a multiple of 120 at the time of an emulated REL_WHEEL or REL_HWHEEL
> +    event.
>  
>  EV_ABS
>  ------
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 3eb5a4c3d60a..265ef2028660 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -716,6 +716,8 @@
>   * the situation described above.
>   */
>  #define REL_RESERVED		0x0a
> +#define REL_WHEEL_HI_RES	0x0b
> +#define REL_HWHEEL_HI_RES	0x0c
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> -- 
> 2.19.2
> 

-- 
Dmitry
