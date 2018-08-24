Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC902159E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecI1nbk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC902159E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeHXInq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:43:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38598 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeHXInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:43:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id i7-v6so5761809lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 22:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t6LmccnPFhEch09aRSCB8Q1z6E9AbbyheDpkzJeUOE0=;
        b=ecI1nbk+33tYSbzGooK4c42EhgE93Z4mvUJIdX+aEXdleCWvznM9+lOjQoSffN8Qz6
         djdo9qK9GYqiNqW9fflksG7hJ15eyYEUzOlBvSte/CkJDVRUpARh//s2WbJpT3Dxlots
         BkGO2t02PLNJZREsy5sqgY8y3MakKn1OeOiSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t6LmccnPFhEch09aRSCB8Q1z6E9AbbyheDpkzJeUOE0=;
        b=asCmk3FVljt+NnIext3fIFVAxGz6GkSg6Rr0vHzZ5nAMrd3ktNDaIqJcc2dJUKPuVj
         I6XUPDxvdxXff1BC+M8Tu2MgjQr9VohHhy3947eOFzw3q/x/JNSjVn+qiXsSWEvlhj16
         lP68LgX4hNIs8vL2rrV5t70fWMN4Wtn9XkRuxPhZLUxwLOUglsz3RWwpOk7kI9ING2Ap
         sXXLfmkh5iWqxiHTw0oM6efRTfg84ASzCKMZA15Lc/vFm9keQB4vuXgo4CJ4r3yhxK7O
         dGjO5MvTkwutxnDwuv692uVwFYWAFWtevSgokunI2apVh1uKupgqA/7zL4jToFNMZc8k
         Gj0g==
X-Gm-Message-State: APzg51C9ZYFyU46MOPQhP2QVE8zOS5BftSzPRJyQZKP4/E9FurcgFL0M
        Rukv0QBxhJFEget8NwVGYYiQPTsvC7ffodGM65FSuqzIK7Y=
X-Google-Smtp-Source: ANB0Vdb1HRtCgvG4rlGO+B6w/gqnP7arH9iviNCtMdi+BYI8sDXhh5BCt//rhY/LIDdDo/DIm3hfa2leTArqIiteAFk=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr81097lfg.120.1535087446016;
 Thu, 23 Aug 2018 22:10:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 22:10:44
 -0700 (PDT)
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Aug 2018 10:40:44 +0530
Message-ID: <CA+G9fYtXy03iVYfMQdkG0MxR-GV7YjVOXEx8ejMF31rN_YxoXA@mail.gmail.com>
Subject: Re: [PATCH 4.17 000/324] 4.17.19-stable review
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

On 23 August 2018 at 13:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> NOTE, this is going to be the LAST 4.17.y kernel release.  Please move
> to the 4.18.y tree at this point in time if you have not already.  After
> this release, 4.17.y will be end-of-life.
>
> This is the start of the stable review cycle for the 4.17.19 release.
> There are 324 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Aug 25 07:48:40 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.19-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.19-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 0314fad8be8cd755a7b9c59f9c4441bb6b9c29e6
git describe: v4.17.18-325-g0314fad8be8c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.18-325-g0314fad8be8c


No regressions (compared to build v4.17.17)


Ran 12244 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-cve-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
