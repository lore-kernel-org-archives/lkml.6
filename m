Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E54C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB551214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvJE97hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB551214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJJLkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:40:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34301 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJJLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:40:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id y10-v6so2926116lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GFF7tt01ZngrgQvq5y4xnJd3bIjkL1a+W+xEvV8dALU=;
        b=dvJE97hYPrmjtYuIVnf4nfhkGSzrG6to57UUCxgsJtY3txa4nbCXkpzbpLC09LUHWv
         ZX47NCQE5UrNgFLpaioQOUPzGLt9m98ImX3mBBj3kJc22KABGByp0FfFyfdAFnJyYb9N
         jFVlg4hZNZ0Fk2v4t+5NCh1M+6xUCElh/mGuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GFF7tt01ZngrgQvq5y4xnJd3bIjkL1a+W+xEvV8dALU=;
        b=Lkiphgr3iBiTcEGaWxI2R3CYXqVAwcRA/OpWZugsRKm3V4G4IiWkYPRS+OgL+49ajX
         wZy/LZQe6N+OC2lO7ZjlvRSBRK/x1YKDjhssn2N5aKCqc0tiAlRCpWDc8U9cxsPNPTPq
         7FEWjEag1dK8fE3O7vOUYakqPQJFrUnXDsgOeg8/v6ITq/ZcBM0rtm+dmFxuUOu5dcIZ
         rMfvpj2WasLLVaD5VPzM1Z/FSpoD9YEfdyohPCGLnYfSHYZhAtKgVlURA5auWjl0KPCD
         zFNernCb2PSNXfbFBNGAjTBLP+9CKVMDZ8tykCQDWzeRWIcikWFneF9cm6W1sKNlqy+E
         byUQ==
X-Gm-Message-State: ABuFfojOGhSqr/CTkBMYf146cMx02pUoxxgKePheF1jHEQACFFzxgh7I
        1pfh++P85z3I3j01oJa2rQZXPsPtOl+pI8koMoqVmw==
X-Google-Smtp-Source: ACcGV60kFM1cv1XO8v2IYJosdU19i7KoJYK5SvFcuj7hrbWIId5cCv3jI7N+wTyKXNT97BTokJz/HM9Mu0dnJCa4x5k=
X-Received: by 2002:a19:735d:: with SMTP id o90-v6mr17829265lfc.45.1539145239866;
 Tue, 09 Oct 2018 21:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181008175530.864641368@linuxfoundation.org>
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Oct 2018 09:50:28 +0530
Message-ID: <CA+G9fYvmP+6r-Dt86SJbHJpmJmpOso2h7G5Binbe=knanQjXyw@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/113] 4.4.160-stable review
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

On Tue, 9 Oct 2018 at 00:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.160 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Oct 10 17:55:13 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.160-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.160-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: b5eb3855f86e32f79c8034c539bdaafa45832e8b
git describe: v4.4.159-114-gb5eb3855f86e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.159-114-gb5eb3855f86e


No regressions (compared to build v4.4.159-114-g20e5d5bcb76b)


No fixes (compared to build v4.4.159-114-g20e5d5bcb76b)
