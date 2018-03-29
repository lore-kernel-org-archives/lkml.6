Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1884642-1522361196-2-11469093992681693219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522361195; b=MmHU3QBSob0oji4q1PbmdOVWJZ2SrdFXmzhSa1UUbMHpCvI64O
    uMAYoxVozCJVOeohQsMmnLCBw9dqWydLAbIRu7Qvi0snHNJv1Izlm0unwEs+K3ob
    LuNa+FPhTeQGGRKIv9PzBVsdb5Z8CnH0rOX/AGbY/VYN9kY7fucPw20kMxlgSOT5
    XkGAVnBXkWNFOduphM5nrzpHbI1+wFXw6NfKAJdfAnrPIYGMO8seOEXZY+0EcYBV
    OvbR4iK0tlaCDX+C1atRRgx2HKNxMbESkwfyQqszbaVR5NvmBQ+6N/QiRUGvF+WB
    Z4yHhtRsKq6F6Md5ul2biR2l52tLKUDIu9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522361195; bh=mAQefUdPXraS04Ju/VIvXlW8QcGdTu
    df+euAMyplBGg=; b=n7/uQDeRuOV2ijjg7wLKhyzg+xn/xzgRpBnraU+KiPICCD
    UtojcCYgjbF9PkF2Ohx/4VjRsWQcsfwkD3Lmars/w/Ep90/TpAfMV+6iFQUDigJM
    eC71CVi3I4w0uz0MoOVTGkt0p42DBV0Ja+kPBshaUDIM9tu85VGYs8pjWpDA35zl
    r3G49pW35LpLitd7uWH4J7BwhoQ84MQG8zIebL25N4dljzKYnNMW1XIsoqzf02lv
    WUqefU5dG2GDrBpEzwMx3dEbvfPdojIgxaHRTBRbvXcXMiB1HCyPTTM7tdYZ04Tz
    2p+gc7FxgBzelJQSPqE1xNZNIDm5UiBb8ziD0MlQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MPdq8GBx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cahSplF1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MPdq8GBx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cahSplF1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKPrQVP7+odc0Y9TNdb2mt47uGie6qEE+h9tndP/C2O7VjJOWzWB/XMpQYaSd63Pso+D831WkPM45D2lyqIufyXogkDi/+C6ZCwhGlzMgxOOPCVXDd/A
    cXrlWCta2ID98Ay66QZ3uKBkpGJqSlYAo3jslJVBm55mtQVgEIskW69SkdueQyo6yn8I09kM5GfMnNjHi+Xgmq3I2quNky1VgGjKIQWSHVlZlMP0Mkf56hTV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=J1gerpJq6k4A:10
    a=v2DPQv5-lfwA:10 a=U0zfkUukAAAA:8 a=VwQbUJbxAAAA:8 a=IojNT2NR04zwuxZg3fsA:9
    a=CjuIK1q_8ugA:10 a=rdti5zajfK0A:10 a=rXRU1dkEVDZ1dOovDhQH:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeC2WGc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 18:06:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33704 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeC2WGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 18:06:31 -0400
X-Google-Smtp-Source: AIpwx49aSvIhbmUnlNR1C1ykrumO9PE9gHNLFYxs1VyyD7ZVAZ1WcrMaeMISHpi1K58Fa6vQaMSrEQ==
Date: Thu, 29 Mar 2018 15:06:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "kernelci.org bot" <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/20] 4.4.126-stable review
Message-ID: <20180329220628.GB5526@roeck-us.net>
References: <20180329175741.886181131@linuxfoundation.org>
 <5abd622f.cb98df0a.3c8b9.f18b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5abd622f.cb98df0a.3c8b9.f18b@mx.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:01:19PM -0700, kernelci.org bot wrote:
> stable-rc/linux-4.4.y boot: 105 boots: 1 failed, 92 passed with 10 offline, 2 untried/unknown (v4.4.125-21-g290572f02954)
> 
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.4.y/kernel/v4.4.125-21-g290572f02954/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.125-21-g290572f02954/
> 
> Tree: stable-rc
> Branch: linux-4.4.y
> Git Describe: v4.4.125-21-g290572f02954
> Git Commit: 290572f02954767c84991efa816fbfb56c7da9df
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 53 unique boards, 20 SoC families, 16 builds out of 177
> 
> Boot Regressions Detected:
> 
> arm:
> 
>     at91_dt_defconfig:
>         at91sam9261ek:
>             lab-free-electrons: failing since 6 days (last pass: v4.4.123 - first fail: v4.4.123-97-g3054df73e9af)

>From the boot log, this may suffer from the regression I have been talking
about. The boot log repeats

13:42:46.064162  genirq: Flags mismatch irq 16. 00040080 (ttyS0) vs. 00040080 (pmc)
13:42:46.071500  atmel_usart fffff200.serial: atmel_startup - Can't get irq

forever.

Guenter

> 
> Boot Failure Detected:
> 
> arm:
> 
>     at91_dt_defconfig
>         at91sam9261ek: 1 failed lab
> 
> Offline Platforms:
> 
> arm:
> 
>     sunxi_defconfig:
>         sun5i-r8-chip: 1 offline lab
>         sun7i-a20-cubietruck: 1 offline lab
> 
>     multi_v7_defconfig:
>         exynos5410-odroidxu: 1 offline lab
>         sun5i-r8-chip: 1 offline lab
>         sun7i-a20-cubietruck: 1 offline lab
>         tegra20-iris-512: 1 offline lab
>         tegra30-beaver: 1 offline lab
> 
>     exynos_defconfig:
>         exynos5410-odroidxu: 1 offline lab
> 
>     tegra_defconfig:
>         tegra20-iris-512: 1 offline lab
>         tegra30-beaver: 1 offline lab
> 
> ---
> For more info write to <info@kernelci.org>
