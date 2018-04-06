Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2076072-1523041911-2-17751593030741250344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523041911; b=uXc+dJY/mFTauBUqLQ72kumgr0suoDMZg5vfLtpSRCFALHr/nE
    /iJuqYNBZRjhjao2men+haW93wE9TLVyMp28gq9sg4lFt/sqQm9hg6iXgT+dQ/uW
    wTAFL2sWVyAQ1058agLF/h6WrqUNxxiIwbG8INvT/2SfngqDRuS9C9HfBRR1vGIy
    xaDsAC4dNz5DpkCklk8oRN7M9Fpb74CuBVXV5IXwm10/jU+0CFFi/ZoR9nNy0+UQ
    krrMwP4jaIT6OsKG/n1R4uN8Y2ub7oAhxx1Rnx+LgGIPTA2YMvvAUcXKl7zymjv1
    OcxLXc9YiPnsdH7tDYL/NJLrjeUHwvP8srog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1523041911; bh=HbQjSZNuRGvT
    F8ibAE4AiSMtQkQUI8cMJcJuftziCho=; b=JKxVm9S0Q3YQ3fff3OmGvFgiMVV3
    J6Eyijt2NzapsBuDv6CMgIB6TtUvmUAQg7U7Y/XdyV7pR9cF208N9km8poPMDI3J
    ICckcDg4GJQa2fwHBW85fnD0Da4LtmM/9X7WUhzMmTC9wEfdVrzL4BY20G6rg8z7
    sWiYGgp8Wfn4EqWYTMvrlMt2YIfv1KJmob5osx6tIUGufB6ZQIJJIipOh4J3aFLO
    eU4FfHDrNAg7K9eh96rspXQwL2u8qBXZIbz3TNfTjNpcNIdUgREfMoMsM4CNaN0i
    8Ct+XDiZ4uFWnlEMioARGHFT+qRWBbACBZc7m3nYwymTwhgWMUhc9+L+AA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JugEqI3K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yr3gtCyB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JugEqI3K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yr3gtCyB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
X-CM-Envelope: MS4wfJ5sRZcG1QPvPwN+YdDDIrh69DQLMFNJ7FHOT1CVwCfgQGxI4GauZAF0UH33HIgWVegbWBQPQ0BCzoSMX4WJY/O7LDDtSpJ++qO6vZIRqRS//rvN7nW2
    6e89GTJLmTB+aeLLULeehzGkwkuezybvW2+4sHeA6zoc1zn5XG+tKa7U0fOlvMrarmIa88hRO7sFGCkWXY/iEbf2QfvPYTwZH8yCDKGSHH8wxBAqg4xb8DIm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=0aEd6-21V0kA:10 a=RRRRr2VPVCgA:10 a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8
    a=VwQbUJbxAAAA:8 a=KVfQRLUHT4WxoKtOI_gA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeDFTLs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 15:11:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39952 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDFTLr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 15:11:47 -0400
X-Google-Smtp-Source: AIpwx48c5V3ZRn8bvLDF9U9C8AIO5om9fLz1yGL2IPxhunJ2dUdnSq/ExT7O0q5u/2GAfoNysYcIXQ==
Date: Sat, 07 Apr 2018 00:41:38 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/93] 3.18.103-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <44CEAA8A-8B4C-47D0-A5A6-F8144EADE310@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 6 April 2018 6:52:29 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation=
=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E103 release=
=2E
>There are 93 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Apr  8 08:42:04 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E103-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h

Builds and boots on the OnePlus3T, no visible regressions=2E The merge was=
 slightly gnarly with "proc: revert /proc/<pid>/maps [stack:TID] annotation=
" conflicting due to kernel-common changes and the v4l2 series conflicting =
with CAF changes in the msm-3=2E18 tree=2E

Thanks,

Harsh Shandilya
