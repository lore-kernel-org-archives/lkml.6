Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB467C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C05320855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+yHY8v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfBLQly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:41:54 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:46340 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfBLQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:41:53 -0500
Received: by mail-pl1-f170.google.com with SMTP id o6so1538390pls.13;
        Tue, 12 Feb 2019 08:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XT1vo98U1bBmOQI02QPbBxujhVYJfWj/nj1+uhmfFiE=;
        b=p+yHY8v9EZCS+tV4QiDVxsbwhuFNu8AcmDeEdrCOyEMSMsT4KiXvhOU7hh3cV/Z/oS
         EWrJ4QXgsggnYgKz3V0ZUEbxNWmDUT0kI5S4wmz4mtZT3OBjxYGdu8DlzgCKqgWd6ZuK
         MlKPLcuW6fw0iJSQoDh01FA0y/Zj2s3L9tOJkSphHpwgPP26FMzFXZDuEOY4Ce29+aKz
         6cmcmIAbYaDARQrdhBwpgXYpmm2v7hrGyWmEBv/haFnwxHuY20O95nuZLdjmlLmMYae0
         EvzVwp+Z8bjkOVRhoganKlHhwHrA2ak+k0b/8/t+AzpmUpc+ptQelwOLIDqpTZXGFxth
         E/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XT1vo98U1bBmOQI02QPbBxujhVYJfWj/nj1+uhmfFiE=;
        b=tMutX9Nps+InDdLuq9Ax584QUmPZ/N9d0kaxO8q2BsBvE9KlVuFKjdU/1P/1HrdVmY
         seIgFPpagYjJLZjF9LkJz2gBo/oePyi6GnJgHQh3vZ6SAfCztlhwRuUFBKxSGyFtfFAj
         ZxQ+P+7+WAupdGQUMQ/4Jx6mucjtcleGRhkNkYKlV5NETk/adWSYYKIxY3KGWhaetkI9
         OETTnUOgS2/+jeQwB7z+snrUcn7IrvEzQAP94GqiyMc0VFZMMV3rBFUGeQ7lEMtAtNvx
         /usexeF3Qdu5sl5mV9kxX3KKNKhqjQrNAC1ka6VVRHpm44kiE0D/OrM/IOfOn7htd7Q1
         UUzQ==
X-Gm-Message-State: AHQUAuawAiNpUW2KJ8KqSR9nPGYIUjzd9I7VtEi6JsQj9rij7iUdgwsQ
        ap6OViiSOh0MeFEH+ON40FCegSpN
X-Google-Smtp-Source: AHgI3Ia0XXUL4FY1+FS54EeLjSVQBAp+V7r0sAzvB7VTZTtnvnq09yho3nRLOmYNwKaTKrr0IJtbKQ==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr4837031plr.135.1549989712985;
        Tue, 12 Feb 2019 08:41:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm21915007pfg.144.2019.02.12.08.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:41:52 -0800 (PST)
Subject: Re: [PATCH 4.20 000/352] 4.20.8-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190211141846.543045703@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6ed3a3b3-1bed-96ba-d773-167059fa27f2@roeck-us.net>
Date:   Tue, 12 Feb 2019 08:41:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 6:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.8 release.
> There are 352 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 13 14:17:03 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
