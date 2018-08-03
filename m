Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE01C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6572172E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkrCoGAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6572172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeHCISk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:18:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43378 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeHCISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:18:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so3973790ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8/Hd0E7th5zHUNJh21jFNkke1iZLY2kSQkzjz/DjPBE=;
        b=TkrCoGAaop//BkqNb478RJ+IyJoS99lJ0R9VLii6dWQOjEMNnLbx21o72VBs1+PqI2
         Hk/SZ8MS3Gb6byr6Qp8GaGDzJzzLXv++uyFUfu/ZiH3+hfdLoPnc/OtZMUtJjVWSkUyl
         HsXW92e/oaq9TLC81Pw+KZqZtDTikoox3o2y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8/Hd0E7th5zHUNJh21jFNkke1iZLY2kSQkzjz/DjPBE=;
        b=ayokttBToWY14UEWYUJqlHw60W/DVOFkvV5mikscvsCqQ9gI8sQitNg6UjtTBJ0+Eb
         6zRrgj07HfC2GlqHtx+UkbNohnDVp7qqAUowM1WE5f4viqokW/5qmG6sD19TVXZJoATb
         /WCULfGvu60JSBjRRU0757Hm57kwUDHSWQkCxiDVyWv2fcP3p/fW3OY4ajKKJf20VFve
         NAnBCbRKINJyjGaUZjrISHq37xpFRCAdQmUT0FlmJeJIYk2S7NVnTT978Ce8ObUOFeWZ
         l9Fuv4/oQ1jjjAYQ5K4aFL8+hWkQQ0kkFTElYmQd/neBxDSUo6YvqnD74EfSA2FvkjO0
         KGCA==
X-Gm-Message-State: AOUpUlFBh0GaVoirCniRi94nN46piezo+X7lS36eNLJ4w3Fn5yFdtvKM
        bz6+YQzx3zdHltH5tYfqHpTpHGLK2VYW4RvjM+jXWw==
X-Google-Smtp-Source: AAOMgpfS2nBYF8mJ8Dku8ELi3jUBajGAE16xwahdHkrTIM+9Z31w1fuAGOzZolUU8NKWQLUdqUGHQGBvu/dBT1Tyf9Y=
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr4122670ljj.153.1533277434505;
 Thu, 02 Aug 2018 23:23:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 23:23:53 -0700 (PDT)
In-Reply-To: <20180802194536.GA22671@kroah.com>
References: <20180801165011.700991984@linuxfoundation.org> <20180802154325.GB5137@roeck-us.net>
 <20180802182517.GA24531@roeck-us.net> <20180802190946.GA25832@roeck-us.net>
 <20180802194135.GA13901@kroah.com> <20180802194536.GA22671@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Aug 2018 11:53:53 +0530
Message-ID: <CA+G9fYs7tf497BQJKkHTJf7pmJuHkv1mUpP2oP5gzwkFo1gwdQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

> I've pushed out -rc2 releases for all of these with that patch removed.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.60-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 438a20f25869d6047a20ca359e0851b27e01c2fd
git describe: v4.14.59-246-g438a20f25869
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.59-246-g438a20f25869

No regressions (compared to build v4.14.59-247-g68285958fc2a)


Ran 14773 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
