Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4EF208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="Ax+6qfW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4EF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeK0UxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:53:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35633 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeK0UxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:53:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so5069867plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=gXT2B2LaMuioSkQAboulu/6sveOX5FRn0pOVgtsp0XU=;
        b=Ax+6qfW3gXhb/FIhdQOFtPTHOQZS/qZYlAlPgdAljZzw63JvmSOOmwtZ9kLdEke1GD
         7JTlJY3CEfjm9qFm0moyWKy3dBUy3WlboU8Slg8WA0CrQ/8/FiZOxIM9j8VG3GAb6PL8
         NNOb1HPF6RXAPE6sQnHx2Inh6/EMooDdnvHhwYUQquIp3i9w0aDCgPePvkscBsn/Q3Z8
         PUMsP29t3fV5qOOnCk4lfDgH1FfedCGkZsV4CwYNSfkrvJjnYmbPHmrWc/ETDjABqgkk
         jXgdruOwWjz84WRrzhsV/l3harBezFnO7HiqvyCTDBA6effOhBIHbJZlLxt91ECEXLI3
         Mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=gXT2B2LaMuioSkQAboulu/6sveOX5FRn0pOVgtsp0XU=;
        b=n30yeG8lj1SoQSIGxEZVSZEU94sGQtR/G011/x95gvkcSVD7d9+tc0FU199mkr3Bo3
         OoY8dmaTWO7CCwDLFNOG3I9SOzR08a5u4NVg7LULcK7Ps5WTT6PrZalq0HOj07ICfHEP
         QgoE4Ymk6n3SikTIl/Hpp+yj1LBPtz4y+CCK17Ucq4mQZlLtZnod1yTBSpKeG0HcQSic
         0aHk0vEZUY4KtwEKQTPrCRY7bRbSYJoAVcg3fEcKAR4YbuAN19fSyrBgBdl2ijL0gNP0
         q6U+LKU0chkYPqa6htrrjrET94upzpAavKV66mmn+nS91Qk9bO14NJ1Vhx8UZoJy7kAJ
         KvfA==
X-Gm-Message-State: AA+aEWavTAXLuo7LbZCinPnbxpOjzOqEiollf6Y3P0wa+qwyqOpEZuB1
        0XPzgE0fiSxOWQaWhQCaLMcAIg==
X-Google-Smtp-Source: AFSGD/XAmYx3+G/57V4/kPJ7LbiR7LmmE6dhW8ZIs2ZCdwIyeQxvV4IQLYC1m53N8tdMcsYg7hThGQ==
X-Received: by 2002:a17:902:bf03:: with SMTP id bi3mr30192143plb.83.1543312553397;
        Tue, 27 Nov 2018 01:55:53 -0800 (PST)
Received: from [192.168.0.100] ([160.202.37.134])
        by smtp.gmail.com with ESMTPSA id s9sm4152247pgl.88.2018.11.27.01.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:55:52 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:26:32 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.4 00/70] 4.4.165-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <9E1ED636-20E6-4FE9-8C96-915CA0599E9B@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 November 2018 4:20:15 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E4=2E165 release=
=2E
>There are 70 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Wed Nov 28 10:50:16 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E4=2E165-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E4=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
A rather painful merge into the Pixel 2 tree but I'm glad to report I have=
 noticed no regressions over the past couple hours of testing=2E
--=20
Harsh Shandilya
PRJKT Development LLC
