Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C6BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654302086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="rSx1ZxR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654302086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeK0VxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:53:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34869 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbeK0VxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:53:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so5141757plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=mD7glOThETrmBU6a8d3Bp7Guh0KL0g5TbVxqyhHozcM=;
        b=rSx1ZxR5ht9RxyyVF4Svup0hKXyWEIyNxHUhFUOjrYfYUhW6XfADiNxqqMcZhEi1xz
         xtFAPQJQpJfKgERxxcT8jp7ST6bVQKh7ou5HSJFgHbBzy5OpbGjhJ01pB8P+8YLAWtp4
         B4erMXHouhUm4w7HrEE87fpIwJUAigD+CnuGUMRVs+S0spkvALQRjUt7XWjyWZQ/JFDP
         CDWToxn96Ero7QMJsSDIRWEaFAhwCvjaTTe3yScMsUouolI3hTjVh2nFOhkgMk7HLVvY
         aa1zkbKLx2TOI9Tlieye6qOzS9VHzFZWlILIIT7ACSjKukj9XaeV8FXeZPjdF4rOZ0El
         /eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=mD7glOThETrmBU6a8d3Bp7Guh0KL0g5TbVxqyhHozcM=;
        b=ZTiVSvGyrfXKVHushfCY7ORw9xBQEseDX140Nd+4B+rR2GIXeJG/GSY13+1m2MwsJF
         sl7R52ngTS3WCCk3SvTW/zUD4lNHprhgiqClxetHJr31cueCOs6HkhDHbG++5DHWlEqW
         qr7KxfJWFxvVFO/g2mO+Uja5U28p1X9MYRzdZZgqEX/OT7+YRvP+QZvgUSQofvlX+ROO
         H5UUx7nMz9wFaU6Z1eUIXGpXs/rD31HPXM+yxJPvSNIwYUnBPZ9/Rl/pMoKPUH7DDMMU
         WvBVkKmOKz+cT9kj0SnHvbTXLL1JXI63OCnUCu0Wga5E6ahySC8qBGWgs5+zuw/s0lmL
         mo6w==
X-Gm-Message-State: AA+aEWZFmpEATVw2HN2kVDTxrVgWP0xWcEP82nYWmZRkiY/miNuNJG0p
        zBoITcO8fJ4DLYQ68bbGk53kbA==
X-Google-Smtp-Source: AFSGD/Xg+W5CiF2D3TACCtLLwHygrf9IpV3EE/BsKFN/D4yh5z1s6iB7VUGWPusRCKLheRsWB/frew==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr30656104pla.272.1543316146025;
        Tue, 27 Nov 2018 02:55:46 -0800 (PST)
Received: from [192.168.0.100] ([160.202.37.134])
        by smtp.gmail.com with ESMTPSA id s84sm8285025pfi.15.2018.11.27.02.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:55:45 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:26:25 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 000/118] 4.19.5-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <30DE875D-2776-4A48-9635-538EB63AE4E4@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 November 2018 4:19:54 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E5 release=
=2E
>There are 118 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Wed Nov 28 10:50:22 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E5-rc1=2Egz
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
