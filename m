Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ADBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811E22147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM9CqZe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfBSR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:27:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45060 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfBSR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:27:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so10741787pls.12;
        Tue, 19 Feb 2019 09:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e2FK53xA3VySXk0Hsx7JNLtAQYFsETCjUh6NPViQhA0=;
        b=kM9CqZe1cIoXQvx5/9lwYmG6R2ORVbqS5qoRzA+GfeEOr8V+4apPGVcWazHsLJAUW3
         phyM0YVlmVGmSh+x6DARohMAX2gqt+pFQ2W3359suwOfgT6B60gGZn/z9qOBEvWYKt42
         WxX9i6MTP0Cd4+/tBwAS8MG5pvKc57/YpY5+gWoYQ9xD8WXH4il/Q3G00EBzN4mnHTiN
         nYk0jsIYpf0S+HcQxDKnAfRnX0s1jou3zJPzakt1PA4HtEaJv+oZ2OwDKngJNqyY1g6Y
         om13Aig2SWvq4ifLDAmnRGufOpWEZSA3KA7slt+Ej7xRhD6XttUfIthFpDpr7x8bVFrI
         ugJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e2FK53xA3VySXk0Hsx7JNLtAQYFsETCjUh6NPViQhA0=;
        b=nGXej929zKJDSasMTk3YE2oKEFTfXIqk0GVT+TzYI/zk0ec/3Ay/+tIYQGrOuh+TGT
         ej1nbBuUnR1LTx90VZt/CN4lJpfDdOKYHSL/AiV8GN635y60zYEvJlffH4U53diQpkIp
         CFxJcZCVMHCpAtd39ktNgFOpdwC+nzE1cnMHsioOgkvgjke1/0+OKTgk8WfISLI8XOvT
         56zaaF1Xs3KBpGChd/0I1lkhNDIXJr2IuuugDg55ff6nSswXgC3IO0kYjN3qHlGtTcMm
         hfbMLBGBe1fpEyTXtj0N6k8AGhDdaJbiSrMLf6FrY9h3PHXEsZMep/7cokLvPxg0/2yN
         WI3w==
X-Gm-Message-State: AHQUAua+s8r00eQLYLSfQG2HdXPTEqzhkoA2i8gfc4sAEnmb/KUUCxXS
        1vGlDdNT+tUSLmOM4+nIgPMVQ/eP
X-Google-Smtp-Source: AHgI3IZ9qMqJgwPKK1QFSHYbfiebjQF7kpkvx9OmcE1AODWJWL49zbgGtIpzBqrvZEGLx+S2BoLFNQ==
X-Received: by 2002:a17:902:29c9:: with SMTP id h67mr32168504plb.111.1550597274842;
        Tue, 19 Feb 2019 09:27:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6sm33832113pgm.90.2019.02.19.09.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 09:27:54 -0800 (PST)
Subject: Re: [PATCH 4.19 00/85] 4.19.24-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190218133459.758004711@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <96f0b70e-7433-6a8b-7598-ad4fd677369b@roeck-us.net>
Date:   Tue, 19 Feb 2019 09:27:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 5:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.24 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:30 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
