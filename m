Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5318C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC2820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="zvkx4QPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC2820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeK0Ers (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:47:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40476 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeK0Ers (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:47:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so1652763plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=LL5KV36bqh0RYU6Va23d3d9Iu7UeUPcdZro9Vm6/a2c=;
        b=zvkx4QPTjJjiBEWOGSIVAm+A/NYkKQu3ouarsrgSun5iDmAZKLmCYl3EpYY7aYucsD
         +sn4bNF+Hu1bGNTf9VKQ9Qj0uMQATtEqMWwGU1pA0I67xgU2Dfd8BOtTk+50U/wBEGOf
         Gr2Lj1B0F3Vaee5Hf85/AHB5hmfIdORlzrUBNn39MykEsd03xyWeRJVZkZ2xv9/QbqaL
         TEk4qyU7qJXig/DuLm53weZq2LlWvxHwrvZdoQbvxsJiE/SMQnx1lPczGbO6gLQGniSJ
         MhU/GVYFGHF4IgPhdujEVOTbcXpG6H9s4R+HF58aITXt5hk3UM6/qW2d7ffi8+a7E4D+
         uPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=LL5KV36bqh0RYU6Va23d3d9Iu7UeUPcdZro9Vm6/a2c=;
        b=pb5j9wH/7NwezQ2nvvFZ0A5Qf4udyLnWWX2jvMjP5jIzoS4+msVCg0NyY4SFxTg8cN
         3pfFaP/fYcj8JzYT0yAiG4OiyDCLIu/v0Nq2yQUsDyICR+hWyv3ywCUPexti/CrHEA7Z
         XCm5UQPV3aaCfpRwUghJ8Ek5UnftKpDvodvvpjFDBS9kA3GkArTnX7mizcW1yGn8vdNl
         ikexgjAz9ajDohlkjI8AAqWgi1OBTp3T7JDjdBX8PMQNw+ClbRs1HZqspx7bGmEFBir5
         H5MUZy9rO0ywvXL91N0QKYrNc/sRGsGUPjhl6BKwlnmQGUD9VFVytNqP7Uc4BUxVlgnb
         z1Ig==
X-Gm-Message-State: AA+aEWZvnxi/OHVm1xXXnjBT7eufC9Y8jU134sv00NHK1xbUidjWX20p
        DBTg/DDemvVBAedKXs1hNkA3gg==
X-Google-Smtp-Source: AFSGD/U+YrVzp/SOW6Ru/k8WBfvvsTz8oJ+3c65Pfcz186WajDqBOjprKWZ4iseJowrx4mFtN7qjAA==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr28820081plb.169.1543254777738;
        Mon, 26 Nov 2018 09:52:57 -0800 (PST)
Received: from [192.168.0.100] ([160.202.37.134])
        by smtp.gmail.com with ESMTPSA id f32sm1108333pgf.80.2018.11.26.09.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:52:56 -0800 (PST)
Date:   Mon, 26 Nov 2018 23:23:31 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/24] 3.18.127-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <72581FF2-2956-4867-A4DC-2E5923FD557C@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 November 2018 4:20:54 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E127 release=
=2E
>There are 24 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Wed Nov 28 10:50:13 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E127-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the OnePlus 3T, no immediate regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
