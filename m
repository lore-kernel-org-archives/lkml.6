Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB39218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="rlq/JXb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeLSPA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:00:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39344 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbeLSPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:00:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so9556052pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=O2B8OT2BFlOTc1bYch3EgRc0i3NIlNRUFHbRXlooPok=;
        b=rlq/JXb6YaHmJjIsf1Z7UwCmfngppHySQDmke/wACbVm6e9g1bmAGytTFSplJwQf0E
         R0XkrrjeVCqLrGg1oGlpdB9Y8lNOcn7ECUbIlqg3LeWBtfwOQzulu0g9HzeGn8Fb8LCX
         ny/iwXX1AqW7j9+UT0LKGoUQIWRhe424GAvAKEuaD6MDO+kgENt+jeCjfzmb3dTZ6gIE
         Be1tbZdolkSMxyu9Zxu3/UheaDxJ3ieKNWs5BYY0muSPXj013ULpHZC8ZurBZt46k7wr
         qOuRNAZr1pGpcsN9X+8waoq4+7ZYwl3+dOqMpW8vK+55pHVM555NFd3zRP7vWG6Lbtyb
         Tj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=O2B8OT2BFlOTc1bYch3EgRc0i3NIlNRUFHbRXlooPok=;
        b=SRTUOTK8qoCK/i2Z6h6zAeMb63xuXon+zWCnQLvLgN5olafGpmODpOyjXjQx5WBhuj
         Rtx8esT0AYwgz1mLfJxEzttqeyWhzNeHIyrOlgVQ/khgnoNt4VpoJkjt3ENbzmdjI8/O
         /Wa9KrX1E6mN6Vuw/U/xUv37OZztZARjBQsPFuCTh62Or5jxlr3ZJrD7BsmV/PK9Iv+U
         UvPwp/LUZswUT+vGXxNULzLPdb4pT9P9NNJZ/suJCzNWgqIHX7nycCD/3xk+PrIoLmqc
         i7aPBW6qFccS9Vm9LfWsrTHSX+LqOzgC5tcIkmfNVONvzulH+GR/qqtXYYEqxV9lET2K
         eRwg==
X-Gm-Message-State: AA+aEWZvRFDpc5ng5AuwuSnmstk1ybQvZcLW9D8gI1R/BxCOTQxcQlVc
        yLr4a/Ok/FmmeBj0iK6s8eJ37w==
X-Google-Smtp-Source: AFSGD/V2EBdBOIZTLFmj0KJLmGC39cbcHSA8PfRAlSlMcD3xB3ykTjt5IvSHj3Gj30MHJxBIelhhTA==
X-Received: by 2002:a63:2a4a:: with SMTP id q71mr19561466pgq.374.1545231628231;
        Wed, 19 Dec 2018 07:00:28 -0800 (PST)
Received: from [192.168.0.102] ([160.202.37.112])
        by smtp.gmail.com with ESMTPSA id k14sm26714652pgs.52.2018.12.19.07.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:00:27 -0800 (PST)
Date:   Wed, 19 Dec 2018 20:31:25 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 00/44] 4.19.11-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <D3BC02ED-AFA9-4390-83A7-148406821637@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 December 2018 10:09:12 PM IST, Greg Kroah-Hartman <gregkh@linuxfounda=
tion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E11 release=
=2E
>There are 44 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Thu Dec 20 16:39:02 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E11-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E19=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
