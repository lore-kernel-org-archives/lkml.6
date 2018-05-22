Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2473873-1526993702-2-17816443428139302073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526993701; b=kV8P9jCs6EQosgIhJCXgzc93xwb/dyVcYMkiErl4mK+J1BiVta
    FXVj5zmBNTsIvpA7g+pKejWBCmxRlK0kqjamdXwWnWNYTgXezs9B+eOVoMQr+RxV
    R4U+NBiZvB/fSwe0qhOwerqTCBD46X929okNkmHYufEplzr5M4OBYztbaHvaHXAC
    XwlkHgopwlAgXZXlCUO2wUzKrwaG5OVH3XbR2JoubmH3u0VKSu1tGp/u8AHhzSLj
    zDjzbmV8FW3XMtEdSwaRlab0km+pcINThdi6jK3nB42dAj88zRpFG2jPbwos0PUt
    G05eEfWNy56Sd5sBPNRD3k/+nIsiD4ELwYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526993701; bh=YYOwgqDsKKD
    Y9zVuycsZ7lR+zjKbXX6ijQb5RNT9z5s=; b=fDTbYDm7LzDgZWoYTS+5PicP0lK
    peHUZSDTxYR2Ge4VM64oGpuMasknprHVgo1JIT1HPP3D+Rz8XwEUlvpLFzCn4rdT
    dlGHjMLbkiPS4g33f1hn0U3XM0eaQp2f+vDbwsBcJDjEV07JHOejXAopzvAkBHAu
    kkF0LoSBuz6hiwS2Ke6Pwjd4GxZEcwMC3yviFHFHWShJwsJw10RMQnnMrr/6Wqir
    V6awtmvPRv3sCwYdRABfcGfvfEpp6KV+kFJM7Urplm35cldPknflcDRsGUz1uH8I
    NJvbCNgGeTcqzGdZOwHZCDMaysA6N1iBZfA21BieNYUFQqDwjcdIyAwIifg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=PhrIza/A x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Tf0Ygv0L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=PhrIza/A x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Tf0Ygv0L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGRlC0jWLjAsrs3hup2Ek3IRg1aFChAjdu2XFxbJhC3MBT2udleTEZPo9F7YuJqJEynMzrHSgaNniMletE3ZlSi9C28vUxZFgZtayzjXb5jx605ROTH0
    5UPV3mUg4TbZx/OtIKp8Ovdbb5obBVuXRpfzXu5e7FBMwxQZOCvUN/n1RXkuB2NI/eFvU4uRzIWqEH1zj+s/CYOhisJ34zw4Ltv06QauEKEMoX1GK9n9X2qV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=UhOjoZm1NaWo7w_ywRQA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEVMyr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 08:54:47 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39789 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVMyq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 08:54:46 -0400
X-Google-Smtp-Source: AB8JxZoa/7kbAqPvNYk/q+xGM7lKdKjNkNJBn2k/o0imkh2r6AfioOKWAOQTUbjoaQjo3h65STxT0g==
Date: Tue, 22 May 2018 07:54:44 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
Message-ID: <20180522125444.7zgdlx7q5rgrk52t@xps>
Mail-Followup-To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20180521210503.823249477@linuxfoundation.org>
 <CA+G9fYsGV7P77u8z0jhGrpMDFSMo-1PBnHPWkq4z1Z7oq6vEaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsGV7P77u8z0jhGrpMDFSMo-1PBnHPWkq4z1Z7oq6vEaw@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 04:18:31PM +0530, Naresh Kamboju wrote:
> On 22 May 2018 at 02:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.16.11 release.
> > There are 110 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue May 22 21:04:14 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.11-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> NOTE:
> kselftest rtnetlink.sh test case failed on all devices.
> Which is not a regression which used to SKIP pass and now run and fail.
> Bug reported to investigate,
> https://bugs.linaro.org/show_bug.cgi?id=3834

To clarify - previously rtnetlink.sh did not run because we were missing
the 'tc' command in our rootfs. We added it recently, and now the test
runs and fails, likely due to a missing kernel config.

Dan

-- 
Linaro Linux Kernel Functional Testing (LKFT)
https://lkft.linaro.org/
