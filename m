Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219526-1523120859-3-8932563993206648489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523120858; b=XxokLo249oq/RFSFchxicj14yJdqlL+wiku1oPLW8AdhNhwuJ9
    Fnm26nG0JK3g2SKsy9f6i90OoVQ37TSdxroxrrgAYI6ur6CpJaigFDOEgTTg/gPz
    cNUc5xck4npdQD+Hu6ryFjtIZnMDynjRt/1AjrUruwi+HNWDOneuXLVukZsOFocJ
    8+fCcnCAWwpkAFx5dPwTyedWuQ1sM71eRPFFzPvE2dTCJpCr25zJiep33j6Fiawt
    cNtl8Snr1QnHSyUq+roIN9oxp24xdJjhZfkHeCQDcskHMsoXL2Efaiv1ssK/IOly
    xXA8lVsUfjmipusnb+qwwAYXeFFBar7pOmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523120858;
    bh=ZrO3+WBHTf1DN+lj7ULzIMaKA+PmOWt0+4iDGeFO6dI=; b=ttadINnFZ0be
    3fsydf/YPr2Hg4J0M/zXoxQzlvmBErmdOeUF5IL42K4Blu+6DMRRqBwF5HH6ZjnH
    TLwiJP3lGx6slIzLDvWcd7a6izx+pLGyuwwF3/jE36d39s/8DRbMzeSRs3L1D0z6
    rYW+JmOexC9efakGaHahR4kThmU4mdYJCsZkMu02qlSdcoaYybGhs2S23cotRrD0
    QEetSJjMtITSzghofUIJwU8gjcFyBewjHqpZz65X+HwwPyov1qS0l6t02IfJ+VYY
    iZ9XO96shmY865TgTiizykFnQpnD5PIyTPB2rRedkBc3Oqy0WXrfyc7EjeS4Fxdx
    Y8PHryWRNg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=NH6AlUwc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PB/r8VbP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=NH6AlUwc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PB/r8VbP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBfm3szEm0a9O8F2zFUYhroijINaxQWGDBerSoqiM8CG3n0kR9mBycAzCvkVCE0BFS5CMBnsxNV3QkACXbfOtQ8jLziG9+hsyCypS1bXeOwnVMUkP6CI
    wPAFAczhUAajzT3+1siby35f6JufmJ7mJR4/dHZvuEeloGMctTOgW1uIJA0c5deYYDWHo43TwFT95FEIaRw1I1BAutOzvYwVIk5t4wEbFXFWa8iqpT8ianRv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=wslChEY2J8gA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=awofrA4z_IkSCh5LJgkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeDGRHg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 13:07:36 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34756 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeDGRHg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Apr 2018 13:07:36 -0400
X-Google-Smtp-Source: AIpwx4+BLD7qrmahpU8XjZFYVKA0C4ISaX30m7GBosnyYgnuqEF1hjK9SX8zWl55EJAHX7q92umljnrJRJSYq5UXTs0=
MIME-Version: 1.0
In-Reply-To: <20180407122815.GA2399@kroah.com>
References: <20180406084340.999820380@linuxfoundation.org> <CA+G9fYsbMhN_h8d7QGpEXwG9RZRg0otP9DZHfO8CtQo2tv4Vag@mail.gmail.com>
 <20180407122815.GA2399@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 7 Apr 2018 22:37:33 +0530
Message-ID: <CA+G9fYvim=o4cc0PtM1UMKznThkX0C7RqVr370GiK8J7Bb9ceg@mail.gmail.com>
Subject: Re: [PATCH 4.16 00/31] 4.16.1-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> Results from Linaro=E2=80=99s test farm.
>> No regressions on arm64, arm and x86_64.
>>
>> Summary
>> ------------------------------------------------------------------------
>>
>> kernel: 4.16.1-rc1
>> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git
>> git branch: linux-4.16.y
>> git commit: 30380aa579224caf6a737160802151f466fe3953
>> git describe: v4.16-32-g30380aa57922
>> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe=
/build/v4.16-32-g30380aa57922
>>
>> No regressions (compared to build )
>
> Compared to what build?  :)

There is no previous build to compare.
stable-rc 4.16 is the new build in our system.
This build results will act as base line for coming up 4.16 builds.

- Naresh
