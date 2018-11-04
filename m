Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AED1C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354272085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMS44o1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354272085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeKDNh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:37:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbeKDNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:37:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so5090599ljd.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y2zGV+LLbBlFb5wGTnc2cK4n9xwJNiAuiM6PDgHJxfU=;
        b=BMS44o1CfeiusjDOjB4zdl/xSyxkSAIWpyf0Q0MH+NNbOr4P98Fo3QeTcuPA398fb/
         wNVanmJtMMUFS5qIId3vUK34xoDsCA01NAy+FJT5cSRZIv0QedrWSTgX268GZ8kQzxS8
         EwjJphMKANvM+8Cyq5C1HDwqIqfmrdB2P3Kho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y2zGV+LLbBlFb5wGTnc2cK4n9xwJNiAuiM6PDgHJxfU=;
        b=lt7harqyFH3fgNa7Z3HL4JejX2U5tLMyEojunrQjS7KsktOfSdiL9FXvkZcbSp6SKH
         uXpkxS5+C0al2Tb+e0mbjEbyoKRSMgD88q1lyZpPcePCRZp0r74w+UyeQbolJqBE8geL
         +E16VJ/K8m6MED9XteqZX2dVtlrzom9svewVOqgu/NclrW3Ml5ngXHwpJoD14abq53Y9
         zGyWjFJlNdPThK7X3erHqZQ90eN37IVTbL8Wo8KZKxXJhBSRrXsD1GU+SA7lYXBh7ddC
         Do6kzbTPK0veM2saMo48e7E2tsmoWBCXmd3OxQ0KKFRrsUyK8VCkMfLQrQ+965VAPYAx
         QkGg==
X-Gm-Message-State: AGRZ1gJLF4xoEA1I7OaaDWiqYrsg6rzEWQybsEoGDb1szChjFuRBY8OL
        KhiCS1u+iw/uWntasYrTFfMlKzgzF/cIYRBNDTnJiA==
X-Google-Smtp-Source: AJdET5cfLmh5Se+yJfY3fTr3gd4gHwASp5p9N6kM660YAYd2Bki6jXBuolv7+MLxsZFgh+saYrGp0hMqHSi2MkfjGh0=
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr777329lje.88.1541305464230;
 Sat, 03 Nov 2018 21:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182839.725385066@linuxfoundation.org>
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 4 Nov 2018 09:54:12 +0530
Message-ID: <CA+G9fYuTFgPor-OZBb2j8PNLOZX4JN_W26zJi6U4JkNmXcC5HA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/24] 4.19.1-stable review
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

On Sat, 3 Nov 2018 at 00:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.1 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Nov  4 18:28:10 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

NOTE: kernel selftest version updated to 4.19

Summary
------------------------------------------------------------------------

kernel: 4.19.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 6eebea1ddae93f3931387c0672ff2d130a4888ce
git describe: v4.19-25-g6eebea1ddae9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19-25-g6eebea1ddae9

No regressions (compared to build v4.19-25-ga3c575473f6c) and mainline.
