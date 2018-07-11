Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA08C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4C220BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEDAQHKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4C220BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbeGKLV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:21:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43876 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbeGKLV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:21:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id r13-v6so19072724ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t/DcttdXXefndzUqPeXUbgo7ygp1s0Botd/yylewrL4=;
        b=ZEDAQHKiTb+ivsMFub9cgQgFECpyJulSf8OZgZy299WRjif1he6O+JFtz2RwfJcpas
         CGkP2JDHyexKzDkiZ+yONiN8Ty2gX41eb7DIsfIbKE0JEMn1DQxeP/hcFSxwBQv6OPFz
         pi24u6A1AUam9zaOpaIZnMtXObYFQhXP4byU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/DcttdXXefndzUqPeXUbgo7ygp1s0Botd/yylewrL4=;
        b=KcsB3WVQ0ggdChRMlTmU6ONAgnr+sTTkXkjJSifgr/xa33j47RadbYpIXu7DLShV+f
         y4YHFaV6PlFInvJn70yziQ9e8jPWhUuUtc3b8t/JcTPqilmlUQ7lXxLuCfA2zAUe1FSh
         asXgIIs0lZKyBw3BYGdSEBiFWv7A6go8RQvz/ry123zUXqf/1ebkZRn8eEEspsu2Ctc9
         mH8DnR6bTUBXvcx9ChV1i185ZPCTEbDZ6+icoA67+IS5t6+cR/9QDvTO3etIFL9NKnrE
         X77U1yJAOCzTqmlmWP/N5Yp7d4KmM8isheaIA0/5G/6KOerQ0Ma3hCKfnSf3dVRgNoKD
         04XQ==
X-Gm-Message-State: APt69E0hnOMezARiSPnm6fLxycJKLe2V3WUvtpZwJXBjmrEzer12S2cf
        d/OT44lSoD/fVxdKbQTGGLfakOtJrf/2LQ/tLlXxfQ==
X-Google-Smtp-Source: AAOMgpcrRcnPEhxDJecBQNusrHmqVp0fBZakvxy3IwuQnHljz6116tnWmEIwofehLN4Kt/lKaz44xPLPsCAZon0VCpc=
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr16810467ljj.80.1531307856268;
 Wed, 11 Jul 2018 04:17:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 04:17:35
 -0700 (PDT)
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Jul 2018 16:47:35 +0530
Message-ID: <CA+G9fYuXPJ3v9ua3UiN9ydF=WoxBj7qE2mcxaHZVyooMYk51MA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/52] 4.9.112-stable review
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

On 10 July 2018 at 23:54, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.9.112 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jul 12 18:24:30 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.112-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.112-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 74d7eea2e72c5481ba8b578cfa663c117ab7f23b
git describe: v4.9.111-53-g74d7eea2e72c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.111-53-g74d7eea2e72c


No regressions (compared to build v4.9.111-52-g0d73d5427339)


Ran 16283 total tests in the following environments and test suites.

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
