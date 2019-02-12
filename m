Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BC6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1780820855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9tQ4QFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfBLQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:40:38 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42139 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbfBLQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:40:38 -0500
Received: by mail-pl1-f169.google.com with SMTP id s1so1551255plp.9;
        Tue, 12 Feb 2019 08:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UjREQ/jY188zRonI6LPf9frGFqIjMmai5JWehOc538I=;
        b=A9tQ4QFsJSQ2ZDvM2y6OomZz88qw5Xt6NJZ/b59EiRzfjw16CDta8ok0xlHXJZx7ZA
         BUN3GZPno3+jze10oeQrOzvFCWUh1idW1R/zCIij0bvmXejLrnW18yZBC6ObYJGgyFv9
         ERtuly0tMqxd/AekRMgx4WHFfCsaKFn2gcDMEZeZKljwOGWOznVc1WiUmExe0YvWQ6yl
         FeNI/HNSyo3gFJrcPCGIM2Upkty2/oaBAk18pajoVx8hOnYQ41kdE4sAJ8EOvVZZubVo
         mea6mNKcWZnZFDeoNRwvwhaCMS7oP8Rz5V6DTxtHP1yeVbYKaPUIOf/Xpt2mnlqPKWxD
         l1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UjREQ/jY188zRonI6LPf9frGFqIjMmai5JWehOc538I=;
        b=dltTGh87vZj4ixztS1YBJaS1ro7HhbjDGDeZa3JqRht3mgMgLX48MjPxgPVOR7KNRH
         Cd0+s6cTZNKE5Y9aQXnZPhAuen8vdxhXeLDLex1uro8ao2r8QBIU3GlFacnan4HzdTNv
         5+QhxgECJ5eLklkexH16DSGagwy1ZKYt97DzKh/qAx+iPh2r94w5f3bGfbqaT0Liul7w
         mTxntvkqXFQi5DDKKBIVb4nxvxrcIm0znoOdAhx4VQS4VKoRdEomqqIKN26zewYsHH7K
         japqCbK18ZpAbrPqio80F1p7ZOJdUT3za92NEnoDx48wDGze5/XhK33aTjYHKN+IzZzj
         NRKg==
X-Gm-Message-State: AHQUAuY8SQXgt3xJvlsOQCVFmJArg7lGsNMDBwr3E4PFr9nvDV1djLPh
        JUB+zCNZonqZp6M8yzPFNWhP/vsT
X-Google-Smtp-Source: AHgI3IYBt+AZONUgi+mgqiUYw7w/Xt860mlJVNLfqU9rXO7LQSUWifnv4YfXM3vA8OrG0Txpn72YGg==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr4875967plq.84.1549989637040;
        Tue, 12 Feb 2019 08:40:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 24sm18626884pfr.75.2019.02.12.08.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:40:36 -0800 (PST)
Subject: Re: [PATCH 4.14 000/205] 4.14.99-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190211141827.214852402@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3ffc8475-2d84-e55f-d7cc-0bc968b601e6@roeck-us.net>
Date:   Tue, 12 Feb 2019 08:40:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 6:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.99 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 13 14:17:19 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
