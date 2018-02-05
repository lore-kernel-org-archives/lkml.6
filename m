Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3744797-1517874919-2-14243769990659626662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517874919; b=VEBU8t7lub+nHb3Wxm9WCumFkOtgvht+7Aqe1vL4kHgdt4k
    rrf80z3SksuqD+52gXjlUts41ZPFd2ls8Kxls9wUqKZXyoD6USsc5t+MtFrjYGJG
    u9ROWDX7uYRsd6v+Fjbyqv2N2vUu1tMVTVLt+VWLIA2Imxl0zBNwhLjnPHLgTXkO
    ilI4F21zF9tQmPnZw8wDVpQFVLmBxy9yIPVPurX2hmqfOXd0SVqQCiNdlITkkKvf
    DPA/a1pr87d4GVYezk3AX69ZiPIrHk0DXXNYFTJs942AuHXultmeg4NzAPJIfhKZ
    knczzPSMwQCmDINjMb6f+wlhn4N7e5a2d3EXVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517874919; bh=4gIfcDb
    Vl9GM7vL6Z0mtBBpK7belAAACnJvYwcuR7ko=; b=SXayw5zRdJKCT1j7uHqnCMv
    jHXJXptb5pFIBsnH7fb3t3ZKxgO0ujNVmJk6b6qKfNfaz9hQWhcGyBz5HiIp3YdJ
    NeEWSWQ0yRQUqYKOwFGcFU42s9kS8hZBpvpN2hixju5QVFXRC46MQTm4mIgsPH68
    05Cn65G25FRlL/2empXHo032HMNiimCnKY0fmgTneTGhVjO338ltUOIQRYNO6CQ3
    6vI7fz9zV11TZzRilqC2SihjzonmFwRFWdaSEcp+0F4zhKAs+snLhcni0UWCwu4O
    fsepfntW4wuohFyjKvZ9JWs7oWqRAVGQshWVnDBXuMN5xQQDNtAIEozxLOEhnBQ=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=BaqwsRha x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SAmvfGw/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=BaqwsRha x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SAmvfGw/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeBEXzS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 18:55:18 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43755 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeBEXzR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 18:55:17 -0500
X-Google-Smtp-Source: AH8x227N12OBUZ6deoz7xbhJkNtgslqk+Tr1rt0bBLjq7hjEgGzVdGAVQ3p0PXJ6ZmqCH5hNEpFdAA==
Date: Mon, 5 Feb 2018 15:55:14 -0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/64] 4.14.18-stable review
Message-ID: <20180205235514.b3ckk4ijsimwt3so@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180205182138.571333346@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 10:22:19AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.18 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:21:22 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.18-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.18-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 161cd48d7ece18d8e7256f58ea7b48a417e7eade
git describe: v4.14.17-65-g161cd48d7ece
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.17-65-g161cd48d7ece


No regressions (compared to build v4.14.17)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 46, skip: 16,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 984, skip: 121,
* ltp-timers-tests - pass: 12,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 46, skip: 16,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 987, skip: 121,
* ltp-timers-tests - pass: 12,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 43, skip: 18,
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1038, skip: 66,
* ltp-timers-tests - pass: 12,

x86_64
* boot - pass: 20,
* kselftest - pass: 56, skip: 18, fail: 1
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 1,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1016, skip: 116,
* ltp-timers-tests - pass: 12,


--
Linaro QA (beta)
https://qa-reports.linaro.org
