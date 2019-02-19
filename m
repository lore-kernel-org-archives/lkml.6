Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B6FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4C62147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4BU+f2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfBSR10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:27:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46152 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfBSR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:27:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so10520720pfh.13;
        Tue, 19 Feb 2019 09:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PVXNMsjGVhMRb06EfzSmfjnXNO9xabKd7VwoeCz1C+E=;
        b=C4BU+f2q7R1pQGoBGkYkOv4SAcXrhFCQoEX8b7ShVFKgMbhcqAJwK7xfNd4eNPXd17
         wv9NzR8whkEAJSFQ4ty1Alm/Qm4FwTVMDe4wEQSUW7jAgEoGKkQqFiJbWaXhip39raiJ
         Wz8vEu6lLmEiV8jME/ERXLLg821tx5UPvkal/T4SOkL8F71JSVCFUQRPedq6w2v5n2bc
         /vD6EGPxGnHimNbB1GfLq5lpq7KoEis3Nxnl9dgRt3BoXT9lmsZVU71GEoTRnNoSUMkF
         IvCxUBVnI3NZrXKHcRCLQfsBHJozLUJAMOCKnFfcvVMyPa/6Ve1kuTz5vdYB2EPrp2Vh
         30cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PVXNMsjGVhMRb06EfzSmfjnXNO9xabKd7VwoeCz1C+E=;
        b=qMZkoypABosBKmokAXvdNQKFJa+wVht+YodarzxbG73lGeE+wSbkUuyC2bdBk9C5J8
         pw+AwDDziiu1T48irQu2XG9k0SrTybrJHVpkzQTh8B9N9L4kScNIrg5yf5Acp8uPqkal
         Y0EgHdn8Smgd8cmUeW6AiJL03MMP7q8DrhMvFdpC0NSgCaMgHpa7+evfrEwYBUtEtDPw
         vJGMrzT6vEqp7fjQ7ic5og6hLBtAxOMXIxm8DzFhkEIvO6Wb1t9amDZVXBUsJLACdYA+
         Ce75odIO17JEx5tIuoQF+IQXTIongwUGK4hhUuUZnHsRzz4zNNEzIWqgPEbKQb7HXcn8
         rF2A==
X-Gm-Message-State: AHQUAubCX//LsLJLSvU/APXDr88CynT8qjx6kXzuuFlOOfBtfwu7rj7y
        qyeAFm20DC92nCjSe9ilBV2k8pl5
X-Google-Smtp-Source: AHgI3IZbxNM3hLwiMT9wKRxHdgsrU4nBWB1B04Vvr12HeRjP9LsnI8m5fPkUbI8zZj4RooasOkFYjQ==
X-Received: by 2002:a62:168e:: with SMTP id 136mr30718319pfw.116.1550597245528;
        Tue, 19 Feb 2019 09:27:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u127sm22318615pfu.165.2019.02.19.09.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 09:27:24 -0800 (PST)
Subject: Re: [PATCH 4.14 00/62] 4.14.102-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190218133505.801423074@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ec8926fd-1f6a-fde4-83fc-2300e234d7c2@roeck-us.net>
Date:   Tue, 19 Feb 2019 09:27:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 5:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.102 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:36 UTC 2019.
> Anything received after that time might be too late.
> 


Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
