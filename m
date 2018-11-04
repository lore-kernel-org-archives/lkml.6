Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F40C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED082085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcUwOwu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED082085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeKDNan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:30:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42613 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbeKDNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:30:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so3839846lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PcB7Voz2rYa+HYI3t0O8ACvgPKPvaZGmcSNwwe1Y3Ww=;
        b=OcUwOwu94F9JiL1Ta6Gqr/XkcoMmJ7qh5KgGRL4SB6stFlWf4Sh1Nm/XJgzZY4Wb0H
         8rGjQFySa+azEaPEWXHYpludII4pXtdKXdfArWNZT0Ec4EN2DMDfBDwm5QPaQjJb0C8S
         YMCDabrBh1FdIYY99AUek3n2O8Vkq2mDePe2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PcB7Voz2rYa+HYI3t0O8ACvgPKPvaZGmcSNwwe1Y3Ww=;
        b=C0hHsHc0cnyAjGOleDYoHoT+cdegZ5u3aQXI2HpYXSQEZ6xaJrqRMosZIN/oXnT5Tw
         iCBmal9Ntae/naQ8rbMgOz1H8RIj5AugSVCcN9b1bOAa77+43+QX5qq2E8wurOYhHo/2
         THi3pgYv6yMHzPrKKm+HFnqNFYmpMD/lHLft6gMQBmAisy1c2toz5/Njrpl4DD3gWkWm
         QeL21Mk6AvV7ZoWOHHDtJkx3XNH1DAZNOvFHEROq6E8IIs0eRufRXXe0mTjlePhbqbs2
         /mzWe2dOi6VQ4hH3oKH2SIKXrh6MSaEpXb8dJ1a0tMAyD5Cgh7mbaSjwA1PfeWh9gZts
         AzhA==
X-Gm-Message-State: AGRZ1gI7VDS6GyEOo1qX/DTznGF/N1UdTqXWXTJPp9CjoXqGE5hajz2q
        Wzy5xCRz2bp/q8aCuY0iY05IuKENMrlBxi7Z10AIFA==
X-Google-Smtp-Source: AJdET5cAWiB1xVLNUNkrwC+/WjuD33JR1h7UdtTj4ZtCNP2H6jnoosCjqokpoSEGiIXHhPOpHssGizbzJCZbl7l3e8Y=
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr9422095lfe.152.1541305031353;
 Sat, 03 Nov 2018 21:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182902.250560510@linuxfoundation.org>
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 4 Nov 2018 09:46:59 +0530
Message-ID: <CA+G9fYttX_abh6WZf-muCkWzJkdVYU2mDa2eJLGOFRE9kUNmwA@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/150] 4.18.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 at 00:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.18.17 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Nov  4 18:28:05 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: 79190d1d2b752a03eced074e98b3aa2a03563370
git describe: v4.18.16-151-g79190d1d2b75
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.16-151-g79190d1d2b75


No regressions (compared to build v4.18.16-151-g8a21f68d3977)
