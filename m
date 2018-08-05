Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A44CC4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED780217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3ohDay9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED780217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeHEDK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 23:10:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37466 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 23:10:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so4145152pll.4;
        Sat, 04 Aug 2018 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cCrj3sFseUYA2F0Jc3TZaqcI53uRFXYOA5GhyJE3Ck=;
        b=I3ohDay9JAAv8uZ3wHRQA/he2ZGwDKBa7KQzWoHgIcfwh6jT4fTy941iutRUW2yboF
         yo043CYe3Maqrh7WxNy5MxymvwbF12SP/A/928FY2BUmGMgTHfNU7772xK0xa9OiA0SC
         2xGjbUiKbJOjZCLZ92QfQhipbrClV9QW513CYk/ItGRk1MwKcWUb7gK9tbM/9pYOimPr
         k0hAj6ZDAKju+83FxYIqNN06eNardcmp9RVmKtca3g4IRbcJrIEUWdS1/A6N5wCDOiI9
         XKCK7qMQHXdXiefwuo5lU3ksEHmR1f4H+mUeOSG6KRwGy6CQTVtxKDx/PpZ21LHqPCcQ
         yrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cCrj3sFseUYA2F0Jc3TZaqcI53uRFXYOA5GhyJE3Ck=;
        b=erHhODOj35Oh6NfOnDisDCz5FenjtYUEQrqPzgvcQ4FRsn/YtvdrfujOc3a9ZImXdw
         RhStjy29lpCvWwouXBddqSmzlfcNd13Vjya0w3Mbd7a/AEYrVqfap5eWNJqJ2PhVP6GN
         vtOGb3xt47XKMY75Rdr81tpx7TX+hemXZD+y/nst54nn+dvrzI2FnmwOjYhrZlLlg4eW
         ldxd6WaEpIfWxW2OqNLCJ8Ild+2gRrS+K4py01+5hxdEaoftgXWxspdjFYU4nekRk2pw
         UxoFhTbE+hWXgF5GIn5J/eVgyL/kmPjdtEDsri+kSYuunMGPopX/qH/lB+1rbLz5g4UL
         KaGQ==
X-Gm-Message-State: AOUpUlH+ti7MfZCxpK8vvECRIiCdIko1uQNVfiF+avt0lL3HINwrY9TD
        H/D0LTEhLheoPNRmhlVi7UiKnDG7
X-Google-Smtp-Source: AAOMgpdQUJAOSVAFvdrWCXQPizEVyq392CM+4mZkijSOAcY56kiUG50InrGRr3ThR1MsdzUZAhrdNg==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19-v6mr8779554pls.238.1533431299573;
        Sat, 04 Aug 2018 18:08:19 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v3-v6sm16311951pgb.54.2018.08.04.18.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 18:08:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] watchdog: hpwdt: Initialize pretimeout from module
 parameter.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1635a9b2-6b2a-fd57-13ea-d99494dbfdec@roeck-us.net>
Date:   Sat, 4 Aug 2018 18:08:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> When the pretimeout is specified as a module parameter, the
> value should be reflected in hpwdt_dev.pretimeout.  The default
> (on) case is correct.  But, when disabling pretimeout, the value
> should be set to zero in hpwdt_dev.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9dc62a4..369022d 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -313,6 +313,11 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
>   		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
>   
> +#ifdef CONFIG_HPWDT_NMI_DECODING
> +	if (!pretimeout)
> +		hpwdt_dev.pretimeout = 0;
> +#endif
> +

Seems to me that
	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
would accomplish the same without ifdef. Also, that would make
the conditional initialization in hpwdt_dev unnecessary,
saving us some more ifdefs.

Guenter
