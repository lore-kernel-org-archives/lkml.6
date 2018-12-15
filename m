Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EAAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C61206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/pcQYwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeLOCGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 21:06:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46696 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeLOCGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 21:06:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so3464536pgp.13;
        Fri, 14 Dec 2018 18:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eR4FMrkemc7vPkL3Z4KSaMsreAs/iMd/ZUm8ZvRGnBk=;
        b=b/pcQYwoT90yGwW7gxupYgNPjJI+WvFAiUhBuGKaERAePmfoqGCwe6k2ou1BzoLUpw
         uFRmPrDligpxa3I4UOXJrSWfNC+kjWtNL3hxOdyA44mWbe7mDuUK3uPDnxWOfXUX0cXM
         pHTB3gCgE7/SreQkqk2bcc4+N0JUCq06ug6CSK2MeaczPU5JtHGz2whbk7HMNNHgqhXV
         0w5jmkk/12O44gWgfnYrzWlqr/mvm30hUwcDbylpobFwW0mrm5YwikWULgPLor/FX8Y2
         Se4bqMFa/s3CNNuj0kCoIiqmI7VYo5EtGXrPDj4zrujymoNoL54cwbh5LmPDgEMQnNwh
         iNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eR4FMrkemc7vPkL3Z4KSaMsreAs/iMd/ZUm8ZvRGnBk=;
        b=PMaq+Hxv/rBL7mSYybz07K1O6WrIv7CM4eum1XapgbkXNzLqhj0dDti79IpxPXIvpk
         q0r4WvhHzLBw7KxBlZoBtwAVwRezuZ79LxKTE0vd+s3aSO9bqhl3keZ3KzGzKj5g/Evb
         FvFGaEKNm8aS1xr6j0ExgUiLV9M3Ky3R7DqAk8NvAvRdscjAailN+cKdvRu51r8I2hM9
         evVNT2Pw0pl7Io5t1XfLaKMMPIXJQRpx1bJjVBurA8TD5RVb7VqrOyhi9E4T9Ru9Fc3g
         H63jatF5Z8Ynq/v2vpeqgpQnoaXyw2yg2pIkGOCiFgf4ugPSzc0usLPzQYmFF43BYAfQ
         xncw==
X-Gm-Message-State: AA+aEWYgSKgfLZvUfnmK9OXRfXh/UAaK4JU/56DC9q83oWMx7ocgITt4
        t/8Kq5G7o2qHBKzWUlvuV0J6ZKBZ
X-Google-Smtp-Source: AFSGD/XGSVyf435TlmSD0rbeNjtG5PpEQsosGPXDdQLo/kWUQHW9Tt/Iqz8Y6hiw1Czqs4+dYnji/A==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr5052961pfm.253.1544839573934;
        Fri, 14 Dec 2018 18:06:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s21sm9643095pfk.133.2018.12.14.18.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 18:06:12 -0800 (PST)
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181214115747.053633987@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <74dfaa4d-24e0-d894-29b1-d17e1d022869@roeck-us.net>
Date:   Fri, 14 Dec 2018 18:06:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 3:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 337 pass: 337 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
