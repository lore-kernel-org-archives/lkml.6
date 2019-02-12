Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7465FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E2B20855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o22z2Bd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfBLQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:41:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42954 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfBLQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:41:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so1540091pfi.9;
        Tue, 12 Feb 2019 08:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aHcTRDb4J0UyIxsGRzeGCloccJzp07ahFZtcWgY5oFs=;
        b=o22z2Bd3OvDRX+k80Z3OiPJ5jEQE5sWIEMIKdITdXXt1F7QZFIGbFneJlojp4FYISC
         /qHJfTbwl15eJ+N0LJrGP95LoY+PjUkrhADFKKUAEncS66qrfMV8FqsLzJLOoHOVxvIz
         8H1GLrqKOWOVEMeXMU2FJW5yChi65IZMu4LwoLb18eVbhnDkboaWcOrWU2V+tBxHQwY/
         kLxlM6cNfl3P7e37bMmKq6eMibwXULrY21bpY38RjiBIRPyca8z666vg8K6bFZDLVKlV
         fpjjJFI+LEE7a9So5n8aGoe7imLVxeMrfeizJkjKgR25lDiRTlP72Ies9TZf52GAy6f6
         xImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aHcTRDb4J0UyIxsGRzeGCloccJzp07ahFZtcWgY5oFs=;
        b=AwinH6Fw1aFG0oBTxm1DmHAZx2Yw/CFicbwm5Cm0GAkacRjVvFzHyvUmxaOfI6BLek
         RIc/8+L3G9oKXCYHVY1imWjJb6jOKjF1l6H9SDKwqTZRxjJGSexIjOvCyaq8xOTEZJvH
         zky+uKvMXoiH1KrzKGddbSznmC458SovVkdEn6kH8HCqPweN49eRT3kkNASOIfYD/yk5
         he1LsID+XV4tMF3AnAp6+sm7GN/dQvN0Ai20RMOWHt2Af/LBza5//PrORgQ0gwx0tzw6
         eZwl8ETuxo0qBmFtWGUC4fZejX9ttnLAOvoQtWsj+dRIzY+ykgPfqlpt0ulFVh1foRxd
         4grg==
X-Gm-Message-State: AHQUAuYWxpt57ZM82WdDvLOj5hPEDaw/NrBUTcwcHkk0niyuN+34fUq1
        al83+eu+xirzdlca8HvfwZxs4Ql0
X-Google-Smtp-Source: AHgI3IZB6CAe/coJJ12mALtI8RAGL6/xpjCez8iWJzkEsGaiMpZTbvY5cuMyrUz2jHkVm0bI0o1tVQ==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr4352531pgt.155.1549989671016;
        Tue, 12 Feb 2019 08:41:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g87sm25150820pfe.43.2019.02.12.08.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:41:10 -0800 (PST)
Subject: Re: [PATCH 4.19 000/313] 4.19.21-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190211141852.749630980@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b337d6cd-b321-38f8-83a0-bf5d41927743@roeck-us.net>
Date:   Tue, 12 Feb 2019 08:41:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 6:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.21 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 13 14:17:25 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
