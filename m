Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A64EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E767E20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="G03PCklD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E767E20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbeGJUT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:19:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34657 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbeGJUT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:19:59 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so8092340plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:disposition-notification-to:return-receipt-to:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=47/UT1f9JlDoAXfC1uDYq/fahvbXuh7lS8ez8J07O3g=;
        b=G03PCklDZ2dtJKSYA3T1Ob/3ATGnHZyH/KmMW4gEZM5/FByP/wbL6xJXdaowJxb+i7
         W53ckb5I7lwzNqXwgrdllKSr7u3QDjD6+cnzNpjRIOBc5qCf96QxQDzkO0XuHUZb0KWP
         O5IbZDzjzDMHqSZZzZ79HVHf4TkQO+9r6zwgF4pxvCL5kAl8dkbqm97/6e/vzQIDb9/1
         ZfrUk1JFYHhTxRYW4J87Y+yrPGpJ39quJyT6fxodHIzFi7qLl4HGYpLHp0laDmpNtbm+
         2Fv6k16INmUliIRbgO9QJiUQETGedWz7ObBhgCzvLvIWglIJGoRbwAu/7WE4KBKp2sNe
         T47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:disposition-notification-to
         :return-receipt-to:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=47/UT1f9JlDoAXfC1uDYq/fahvbXuh7lS8ez8J07O3g=;
        b=kbtbpB9zODzSEv/3oYz0rq1KtBWJ/KLxSbF5JbfjuISV+KX7pTSPXrKU5bB4Dppa7f
         nJ7Wbe94lpcI49o94345nXrMkadPwiEyCcLN/DfxN7eKlKo733I2BgBv69DKUBvW5uyO
         pIoVTL6uDwlw8fRxVU22BVWcAWN4NvOtBEwPqm46sfyDzcFkWQ+exYMxlwznu/dWGpTr
         HHI51uEgbKh9Jk2vp5GRj8CW6P65n/5JOWDoehVmHywWDsxlFAag/EtMezYfO3/lHipF
         d0/GkoBcI3yVUXQJwTNO9BGRcZR3vNIHvQyP8cN5lr+Y2jnm7cXSDj/jnjp1TJvG725P
         bETg==
X-Gm-Message-State: APt69E38bwqRxODQ65xHXNvZp6zzFgE5bA2+KgB+30i43JQPOzL9fQ0P
        wMiYBU8o4+e26sp+NqsovR20Wg==
X-Google-Smtp-Source: AAOMgpeLpMpHp+fOZjs27vTLFnOlsanX+OPsAM42R6S6sWmUavtnJ4AAT9Keav4t2saK28uZv51vIQ==
X-Received: by 2002:a17:902:a505:: with SMTP id s5-v6mr26340823plq.66.1531253959877;
        Tue, 10 Jul 2018 13:19:19 -0700 (PDT)
Received: from [192.168.0.104] ([103.87.58.142])
        by smtp.gmail.com with ESMTPSA id d22-v6sm7020759pfk.69.2018.07.10.13.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 13:19:19 -0700 (PDT)
Date:   Wed, 11 Jul 2018 01:49:14 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
References: <20180710182308.877332304@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/23] 3.18.115-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh 'Shandilya <harsh@prjkt.io>
Message-ID: <677BE89C-6507-40BA-8D52-AEF01F7EC689@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 July 2018 11:54:33 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation=
=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E115 release=
=2E
>There are 23 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Thu Jul 12 18:22:59 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E115-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h

 Builds with -Werror and boots fine on the OnePlus3T, no immediate regress=
ions noticed=2E Thanks for the update!

--=20
Harsh Shandilya, PRJKT Development LLC
