Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44666C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6B22172F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyyYjUZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6B22172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeHCIVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:21:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39307 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeHCIVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:21:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id a134-v6so3272667lfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=avyRWBRD8k2w8gpsNvZbc4Y4XzYPg1F2uBBIEqwqw0Q=;
        b=dyyYjUZTw9hRh/d5pGdiNQHWXLhbe3P8nh3e00gh0JM9clVbQjUWOLV1ea6yCL5yQq
         ZZP0F4fhY6Jlg/3ChEzeKhP75XHit+mpdQ2QADH6g3DTB86/nw0IA8P51GylTCug52Hm
         i2bVe6MGCbRJAI4Aro0aSJ2uoxSfxxG0uoIz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=avyRWBRD8k2w8gpsNvZbc4Y4XzYPg1F2uBBIEqwqw0Q=;
        b=UdNLu3DrLPFLwtO8SlqDKlJKnwY2RwYUINNKCF+5Pk4zkUhFY9TDrUWINxiqFwS1Ri
         Fi+nxZrGEHafu/Ts4lPjSszbBa2ywfSJoJdveVJIBxWDiZknG73L/wHWfLxVAO4g4jsL
         OD8DUJLCIXJKsQJB9H/2TpzeFgAKV6wfmA4vJFrmQEf884L47zjJ3Y9zVXgIbpzR1mKd
         9oBU+BQGoQ1/HsUGY9BiJOU9nOh79mRuLg6HXnovYvfTEZ+wP7ellMwFaem1lk5QEqHc
         IWsrTuxBaDP5h/HQUNgLH5IMqz3r2tnhLtkOazBWoeMgmJ7xYQSDN8oY8mFP11CLkDQ0
         hH8w==
X-Gm-Message-State: AOUpUlFtZmu06K7JpSn77ovY4uVul25pFUg0ZKb/THuFYKwIbemIjjc7
        209BMpVfp35uyvKTRekJwflWMj/w00dA8g9W3gksHg==
X-Google-Smtp-Source: AAOMgpdsiLLPikrz98TWasCtY/S3sjpi9ilKU+/VWX81dYgabX2SJvIdLnDbigNx0Tb9JfiGEXn37dlOlJ4oiu89XeU=
X-Received: by 2002:a19:9345:: with SMTP id v66-v6mr3873684lfd.89.1533277593858;
 Thu, 02 Aug 2018 23:26:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 23:26:33 -0700 (PDT)
In-Reply-To: <20180802070348.GA24944@kroah.com>
References: <20180801165028.930831994@linuxfoundation.org> <CA+G9fYtXfNtufXr=_w4Rdq-WaYXb52yeY7x58k5oMJcHP28r7Q@mail.gmail.com>
 <20180802070348.GA24944@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Aug 2018 11:56:33 +0530
Message-ID: <CA+G9fYt8xMB1SeOovjqKaT_pG2GdV-2MPei1-zBfJz83ZfrVVQ@mail.gmail.com>
Subject: Re: [PATCH 4.17 000/336] 4.17.12-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 August 2018 at 12:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Aug 02, 2018 at 12:27:24PM +0530, Naresh Kamboju wrote:
>> On 1 August 2018 at 22:15, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > This is the start of the stable review cycle for the 4.17.12 release.
>> > There are 336 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, pleas=
e
>> > let me know.
>> >
>> > Responses should be made by Fri Aug  3 16:49:21 UTC 2018.
>> > Anything received after that time might be too late.
>> >
>> > The whole patch series can be found in one patch at:
>> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/pat=
ch-4.17.12-rc1.gz
>> > or in the git tree and branch at:
>> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-sta=
ble-rc.git linux-4.17.y
>> > and the diffstat can be found below.
>> >
>> > thanks,
>> >
>> > greg k-h
>>
>> Results from Linaro=E2=80=99s test farm.
>> No regressions on arm64, arm and x86_64.
>
> Wonderful, thanks for testing all three of these and letting me know.

4.17.12-rc2 report,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.12-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 0158527d783942a4a7dd3c7b3e04f94eccd01e0e
git describe: v4.17.11-336-g0158527d7839
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.11-336-g0158527d7839


No regressions (compared to build v4.17.11-337-ga7e0b37ac7bf)


Ran 15348 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-nptl-tests
* prep-inline
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
