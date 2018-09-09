Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0BC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A992520865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5KrAIS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A992520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeIIJkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 05:40:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32843 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeIIJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 05:40:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so14970677lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 21:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vP6yczaq0ryb2ZlvjNMN6PTeosUXb9ibt/Bky5uzjls=;
        b=T5KrAIS7m9eePiiWxcVQCLtH0soTiaUPUAW5nqKZZx9Idf8UgGb+OLvxgNgZpEEMx7
         SJsrSiiuPEnFqfuh14REGajiIg8BsIYqcGEiJyirlIieWDhpkJlgPz2P6y75wjz9/QRv
         JFwEfcPb7sU7MPLND69qXyNqufjFaSWyo1a8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vP6yczaq0ryb2ZlvjNMN6PTeosUXb9ibt/Bky5uzjls=;
        b=AOWbIozmrCtW9zgFm4eaV4QG5KOSkkQWLDYVw2r06/2rK6k8Addhu5D9+//xr5t4jH
         aTrIqoLpyro2FFSZUfPUCCE+ZPlQrFxP1qKKhtskcdTrY1pyqeEaFNXZ5lVGXhgW8peP
         GDQUneV4fN8En7OUs4/V02z2l4oappx+5VDO+jSwyxLyiXj9BPRemGLfBPKUwENQ137r
         6W/TpGB75oxggKUSvGn1UTXey5PvMCmC0kRdQt+dBsFVO00CuhKHqOzhDSL7/tpKbSHW
         zUcTsk+Vu4ce/B2xZsM0cKbTt9n1PWVMmji9AVXnq+ee4u+FOgSnqG8vbSkhL9kRQz0G
         ptQw==
X-Gm-Message-State: APzg51DUAKLqkLPJFvOrtp/AK02FQrHfRgz1AuH/77txqK4Ce1KCqg3D
        ENe8BL+e6dKlkkVbpSEDcoihRCy1r5ctOVccyMGSPdt1
X-Google-Smtp-Source: ANB0VdYnfJt5b9nQXwQeLdc2Y6R0akVNyhHSAXwZtwBOlCNLQ7Nhepf9iJpmIjAYtXL+OTdR7HCoG8WEjys8j8PS97c=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr8803778lfg.120.1536468747761;
 Sat, 08 Sep 2018 21:52:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 21:52:27 -0700 (PDT)
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 9 Sep 2018 10:22:27 +0530
Message-ID: <CA+G9fYsuVwSd2V=Na9YJT68nGHsA4f9qbPUZOFbn9OecBNM9qw@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/47] 4.4.155-stable review
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

On 8 September 2018 at 02:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.155 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Sep  9 21:08:44 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.155-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Jann Horn <jannh@google.com>
>     userns: move user access out of the mutex

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64 and i386.
LTP containers tests

Test cases: userns02/03/06/07 failed on all devices.

LTP: user_namespace2 1 TBROK : safe_macros.c:452: userns02.c:95:
write(6,0x7ffc133113d0,18446744073709551615) failed: errno=3DEFAULT(14):
Bad address

Other bug from kernel selftests,
mount_run_tests.sh bugs needs to be investigated.

selftests: mount_run_tests.sh [FAIL]
write to /proc/self/uid_map failed: Bad address


Summary
------------------------------------------------------------------------

kernel: 4.4.155-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 892befb7e4dca0c09750b1fa1a0ce632691730a7
git describe: v4.4.153-129-g892befb7e4dc
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.153-129-g892befb7e4dc

Regressions (compared to build v4.4.153-81-gc9eed05cd5dd)
------------------------------------------------------------------------

i386:
juno-r2 - arm64:
qemu_arm:
qemu_i386:
qemu_x86_64:
x15 - arm:
x86_64:
  kselftest:
    * mount_run_tests.sh

    * test src: https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.18.tar=
.xz
  ltp-containers-tests:
    * runltp_containers
    * userns02
    * userns03
    * userns06
    * userns07


    * test src: git://github.com/linux-test-project/ltp.git

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
