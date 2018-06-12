Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91E1AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D97D208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="K4H30i7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D97D208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932833AbeFLSUp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:20:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33682 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeFLSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:20:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so11858602pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :autocrypt:subject:to:cc:from:message-id;
        bh=LXI9OHWSS00T5QxXO2V0eXibiFQlQhpbNQrwrMd6Pn4=;
        b=K4H30i7MaQ1od9hOyZUHMmb+YA60S2XFdrKnX7KrVrqfrcel2h/ZsHGE+x08jxWCI9
         BXlz/7ufWdYU+iZ13HlN8/OupmEPupFn3VWYegiHxGT53N3C8+gc8nESzLihvCiXJaq4
         p68xQY9uHmcBY4gxWmL/d/EpL6hQXUSicewt/DM94k5ceIK5cU6SOP7aU0rsoaJR6jT3
         AqVSU4GLn44IKXT5RDMH797DqU49OSkAKrW505s1cZ9bzVAIqmqivPVNPilUZCIfCV0k
         m7oqYNoRaSWIbVBl2glCmRIgKxLNP0KPrBzZH2fin2YshD51mDTCbuZ0pLu9azUhagX/
         yKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=LXI9OHWSS00T5QxXO2V0eXibiFQlQhpbNQrwrMd6Pn4=;
        b=bEpUTpU/vnDhVk4l+CqwOvYASo66l7vzAWe6wezEfP9o+RU7WARRt0WJKHTJfwiSUA
         VqMQHVlj5hqZHG0DMikpk7uReucAbZoc7zRczRv+S7XJiTtgbTBkdIOGKaZ1OTxw/N9T
         j0KSA7W+nWj7a5kXmMlehkgaUx0O54mGtqKZAWuMyFXwRNVlC3b3pUptxglMGWjBHL7G
         7s/dk8bNu7GR4nsi9nlmbNGKfsO37dqRAMLSkoJMZY2GLLApLzahxh/IGQLG7VMDQmkM
         P3lWisA3wOvMKhm1AfXalC2oLfQ2u53xgAyRy3AMg3qYObHaqCfNXoHzokzbIzLml4Mm
         xHTA==
X-Gm-Message-State: APt69E3wu4yLH9QLBzc9pYYJ5XrKBtnL6cQF2CS9FMLVZYgeVIxBjpWx
        0ieh/FL3gOZ6pK+7fj9Tnt/DH6Dx
X-Google-Smtp-Source: ADUXVKILIzmf5b9X89TIgeNh39DiLaZ1ILLqBQ3skP2LWyMn7iu9VV62jycA8lKd/9p48k2PVFQsUQ==
X-Received: by 2002:a62:701:: with SMTP id b1-v6mr1544107pfd.252.1528827642171;
        Tue, 12 Jun 2018 11:20:42 -0700 (PDT)
Received: from [192.168.0.101] ([160.202.38.131])
        by smtp.gmail.com with ESMTPSA id m7-v6sm816203pgr.5.2018.06.12.11.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 11:20:41 -0700 (PDT)
Date:   Tue, 12 Jun 2018 23:50:36 +0530
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=harsh@prjkt.io; keydata=mQINBForuUUBEADNrWLYhW8qjO6GmfU32cqU
 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
 GOzuzn9qgWR/VAqd9BA=
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <F70C0113-57F2-411F-AD90-BD7F1A871137@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 10:21:57 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation=
=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E113 release=
=2E
>There are 21 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Thu Jun 14 16:48:15 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E113-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Merged, compiled and flashed on the OnePlus 3T, no immediate regressions n=
oticed=2E Thanks for the update!

--=20
Harsh Shandilya, PRJKT Development LLC
