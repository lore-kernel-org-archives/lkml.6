Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB0C4646F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2127B217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB+0tB7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2127B217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHEDSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 23:18:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41042 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 23:18:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so2484019ply.8;
        Sat, 04 Aug 2018 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3JTjV+XqT4IV4y5YSovo8gJDSc27VvxcOn5e7IJyZJA=;
        b=DB+0tB7zMfzs38f2jLXzkHUDioKgy0yCRWVkSQD0w/RFS2O6tYHxw+nGJktuY+Xf+8
         BAtQA1jtW6M02uaMI4qW3CPHdSIue+I1jfMwz469n5PrT4YLVVAZDi2l+Y/t1Edox50x
         Q3jQhW2+1dQJMQBtXR+LglvQ3zKqMI9U0KcUfxw/jvXHrq0P2oaeR9NVRlHNOeDo26ec
         minbLkXsw3o48mWnRA67BSXhNH1Jj7C1jmT0m5+F7R9m3d17xvu/vYkVFNYtPIKF3eM4
         qR44uxZom57MVK5lTN2gzkosMNgrI8K173QfQkj0ZHB+H3TGP4ei6x2kzvkDwEX18Y67
         n2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JTjV+XqT4IV4y5YSovo8gJDSc27VvxcOn5e7IJyZJA=;
        b=PnvqUZ4ZuUnyYFKioHPczKuuOP/zLuD/Sdd7/PciRog4ZKVIrFtgfT6BzozzhGJY1w
         Kxdcd0PSByrF8uoSH1RJuOJ+DJ9G/5QWebyEwaV8xLYEQ5wNUkbVukxeni1lhW7fbjEd
         f6TqDdKwZFagaJjWtLao4ziQVPjXNtxSPYFe7zgO+ih9+X/+j7/KRhVG7ceABQ501dMk
         LynRTv1V1j7MPQspAgWCSoUltM/UDjlqGmv3rUzZM1jVecW1LFjaS8rn8RU/OiwkwW4V
         1BXonTXrAhKWPQ6QRzDp52+Ybmv2ubOQqgJOS+RDFeGEdtW5Yfk5UedllBCl22OXQyXy
         iDTg==
X-Gm-Message-State: AOUpUlFDQx0MglcBi5hN2Zt2gFS4S5SsE+vjIFhPf/cLTOxlp/pR1x9P
        2SSnRZZjhxFu2bdxszXzzpo79S61
X-Google-Smtp-Source: AAOMgpf0KpB4CBZkVsGxwGp6bp7AztTSAlCkHydC5IIwpxGLrjxjvxQz4cba66t7ngigLBm1kIMLCA==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12-v6mr8757567plo.4.1533431762270;
        Sat, 04 Aug 2018 18:16:02 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h18-v6sm4793268pfa.173.2018.08.04.18.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 18:16:01 -0700 (PDT)
Subject: Re: [PATCH 4/4] watchdog: hpwdt: Update version number.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-5-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <056cf690-6a25-c921-5bb1-217ea1c9536c@roeck-us.net>
Date:   Sat, 4 Aug 2018 18:16:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-5-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> Bump version number to reflect recent bug fixes.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

As usual, my recommendation is to drop version numbers. The version number is
reflected by the Linux kernel version and SHA. Yet, I understand that people
feel quite strong about having version numbers in drivers, so,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Just don't expect anyone outside hpe to keep it up to date.

Guenter

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index f098371..27091f3 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -26,7 +26,7 @@
>   #include <linux/watchdog.h>
>   #include <asm/nmi.h>
>   
> -#define HPWDT_VERSION			"2.0.0"
> +#define HPWDT_VERSION			"2.0.1"
>   #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
>   #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>   #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> 

