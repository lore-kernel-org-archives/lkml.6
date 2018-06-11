Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 89A90C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38654208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNAmSeRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38654208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeFKRQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:16:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38971 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753873AbeFKRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:16:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id w12-v6so10069577pgc.6;
        Mon, 11 Jun 2018 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHmISXAIUWGGjpyGKmLxGR8oVJogmcWpFkWFH00ff10=;
        b=aNAmSeRmELlBHkopM3ouxifnKyr7EhAWKYQMJqXkubToivb1el6SNyP0Wk0dOXLTek
         e5iRAqrwHmDHZ/Tj4OOA0Y9dnoM4HhM65LMtFl6ehOnqP+3ULE3mi7PDnfhVzmDGXNj0
         miKOR8pIsJ13muhljTCybE6r192qNCH9FRXI5Ws58eRno7bq9GKIGszVyN2p1WzFjuZf
         RA6/lcRuiFqT47+amfmS8pjM27K4ADY+E3zhmd5Lf5X0B3PNiqOUcZo15yk8IbkC2F99
         QTjWWHLM8aIaIqCZRBNbbgU7N/s8IK6+0l8/oJ5GXc1vKbhkW+a0xQLsLwUGNQrHtwYz
         P78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHmISXAIUWGGjpyGKmLxGR8oVJogmcWpFkWFH00ff10=;
        b=rmRtQgFXe6w2dW4p9KzEh5Y6YkVJNfC13Kyd/3uAcpx08rIpqNyVozdIAkF1jmkC6I
         +OVqnuTdmDGRFn/tHc+gi0pmhV6VN3Il0XvAPtR+o9UbIT1l4CH+7LP5vRMLgoGQSLOl
         GBW8sQ8A/p7KfMjksb6rT+8qnsjwV585hTTSSUeR2HPrXmzpk4qxnANYFQw0x1uuiuuQ
         DtGh4EZvcm8VAm9JiyJ6R5kpQ5fcbYfjR4zHDv8FvsJaqVgIByTzOxQLffStbFHQ9wRJ
         VD3OicQPUxDYyrzezZBZCvAu20dUja9fiXCJRPbXCFXQadJrd6XsdrnkKsR3e1T5Ng42
         +gKg==
X-Gm-Message-State: APt69E3xe5bf5OpcNCovtQ5j9FZ5KiyWzfXlU5U25UMwu7chaKcWMNXo
        OeMAXnIrgO0S8WnBOpFyaLU=
X-Google-Smtp-Source: ADUXVKIAKWifwfYK3eU4rDcE44pAkwIDWlTduC4PrIQnL8hYJ1IQnMnbYGXxm65pHFg/9oMDAGJwrA==
X-Received: by 2002:a63:ad08:: with SMTP id g8-v6mr77712pgf.74.1528737379722;
        Mon, 11 Jun 2018 10:16:19 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id n72-v6sm25138958pfj.68.2018.06.11.10.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:16:18 -0700 (PDT)
Date:   Mon, 11 Jun 2018 10:16:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] input: move MT_TOOL_* to input-event-codes.h
Message-ID: <20180611171616.GB251078@dtor-ws>
References: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
 <20180607075448.5706-2-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607075448.5706-2-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Jun 07, 2018 at 09:54:36AM +0200, Benjamin Tissoires wrote:
> This is evdev API and should be in this file.

This is a weak argument. include/uapi/linux/input.h is exclusively evdev
API as well. input-event-codes.h is simply evdev API that is usable in
device tree files, and I do not think that at this time we need to
expose tool types to device tree...

Thanks.

> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> new in v2
> ---
>  include/uapi/linux/input-event-codes.h | 8 ++++++++
>  include/uapi/linux/input.h             | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 6cba8a21ea19..e8841cdb1ebd 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -848,4 +848,12 @@
>  #define SND_MAX			0x07
>  #define SND_CNT			(SND_MAX+1)
>  
> +/*
> + * MT_TOOL types
> + */
> +#define MT_TOOL_FINGER		0
> +#define MT_TOOL_PEN		1
> +#define MT_TOOL_PALM		2
> +#define MT_TOOL_MAX		2
> +
>  #endif
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 7288a7c573cc..cc55c140dfef 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -267,14 +267,6 @@ struct input_mask {
>  #define BUS_CEC			0x1E
>  #define BUS_INTEL_ISHTP		0x1F
>  
> -/*
> - * MT_TOOL types
> - */
> -#define MT_TOOL_FINGER		0
> -#define MT_TOOL_PEN		1
> -#define MT_TOOL_PALM		2
> -#define MT_TOOL_MAX		2
> -
>  /*
>   * Values describing the status of a force-feedback effect
>   */
> -- 
> 2.14.3
> 

-- 
Dmitry
