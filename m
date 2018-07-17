Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3216521470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LT7TjrwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3216521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeGQIg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:36:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34976 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbeGQIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:36:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so201084ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4KlAviCIKMwLb/bh6wpzHvro8QlT7ZZ75qCHpsKYSmM=;
        b=LT7TjrwKI403J+DoL3PvoJWdXHTTDof+qwwS5l5u3XuqNwEhg+Moo+bMHYfvFiwWXN
         Bl2dAr7rQadIGeZQ6SeH8YFcSUIeqGKgzjPpFWwbNX/VdwOlAZL+Nyb9Ub6UjI8U1myM
         KkdToyqnNnDD23xRsEDmwgMKB49Qn0jg22TBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4KlAviCIKMwLb/bh6wpzHvro8QlT7ZZ75qCHpsKYSmM=;
        b=R5Zl/u/gOdl2ZQVZZqMBbZLcr6o6zB3i/Ru0244Vn1hqyK6uRJVGlvX5vXxRGOwRe0
         kCZJ+fHlVM3/qCZYq2kY8zK59cx4v0CRh3cavgk9AjPKijKa7WaTsCMMfKQz5n4OfgQB
         xvAJGxtxuZsZ4vILWQrk2R5AyhwUDoRa93hfsAb4PEIdCavrkgxFJJAmb59E62qaHPg3
         ABWkB7yHxTE/wNjLnv61GHz2VnGu1Y9fe+Yf7f/S7mLcyCaNvS2cHfMqP2E2Fc4M3Y8d
         OgUbd/FTlJMXDsbPlp+9ppv6W3ckKQ2LnYDYrY73+uB43Bx4yQD6GvW+Xr3u/7fpOZri
         8u1g==
X-Gm-Message-State: AOUpUlF3vbtyb3TtSVYjTY6T8AWUYbcudvu+uE5dnBO1MZBJK5b9nfJ+
        R9Nk+xw/0MiQKW79tnyUBegq2Fv3ZzRua8BPspTygQ==
X-Google-Smtp-Source: AAOMgpfRhwZi1brK3qND8e2wpdA19z5M/iE7F73mUV7K1jUwDGSIXh1+yLRZhtyU+d/QVjJHGOoQB7qY6oPG8z6+DRM=
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr579526ljd.67.1531814734770;
 Tue, 17 Jul 2018 01:05:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 01:05:33
 -0700 (PDT)
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Jul 2018 13:35:33 +0530
Message-ID: <CA+G9fYu_0GG7JAg8aEa6QTju9cBuwutPyOXNqEehOumQGFsLTw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/32] 4.9.113-stable review
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

On 16 July 2018 at 13:06, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.9.113 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.113-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

> Linus Torvalds <torvalds@linux-foundation.org>
>    Fix up non-directory creation in SGID directories

( For the record, sharing the report again on 4.9 )

Results from Linaro=E2=80=99s test farm.
Regressions detected.

LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
 - creat08
 - open10

Reported this bug internally on upstream Linux mainline week back.
Now this bug happening on 4.17, 4.14, 4.9 and 4.4

creat08 and open10 failed with this error,
TFAIL  : testdir.B.3132/setgid: Incorrect modes, setgid bit should be set
