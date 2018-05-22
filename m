Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2627688-1526998960-2-13185888427901668489
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
    1526998960; b=ONQezoy2STyWQL7hSN/uEioLRIeFFYlknXacKO579XkRMCY8yE
    D2HT+Y/ZRMJr93JOMQKxyWRkMqIEbrnAqSufpulm6RDGH5l6ztUY7DCYlcdFAVm8
    GBCW52KxicrutS1zJ3FenEGJoWt9oCnx0oSfjZ6jIazJfmQNkvhs2pRE4I5095Ye
    dENX10JCS5U8Yh86s0XrOMA+Eo9J7uE8dYc94+sYxqU5AteF88qaCHv8iLDe9xR6
    kgMaRFVidXZp7rVoUek14eLex5VMTMvVm82NWACvY3ibB588RU1qyNwSXYDkZcNo
    HlvSw8cPoL24CbhDyNE6IO9R3ysBGYVexIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526998960; bh=Z62+C7wiLC+
    tMpjkFhRfCczK3MLzFcsau5TFsNjX0mY=; b=XbZ6hmypdXT4KR2ph8eGg0tJ0wA
    bRcoK315JbuxIjSrraZgSz/2EYBpDPwXHeWXEOKzGaNzlcKoIsGDylKVxTgskBMv
    CNgmB93nQ4PKgSyuZSVv5aB21J71jRZ1nOAVHpsD6M7XBbWT3CRPCSqNjhzqzu95
    56fDO6AHtv0UuJiTkizGESSQ+LnQ3zmrPxZbLq12FyszGQGRcY8Nznzes1rPwgrP
    WO5lRr3Zf1Tf85m8d99DYqpMFc1EQwSATurY1DHW70VGEo0nrZzvS2Gf7FdRW29b
    jSzOGzsczlMnUPqtYHH5Uh7Sejxhh9YzafBOush9j1+WZJabh2SzppSXL1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=DvByowKC x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=pbd6QjFK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=DvByowKC x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=pbd6QjFK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJvi+PbN4AAgJtrgQlmQb4RkJ8jwyuNu41qdiSOGu15eJWhJ9IGJ9M9eIcdSwIPTftMz/sQRrQzEYxQYDyuvY0xB6SqJEzLZ9g/K0pyOeACLP4QYM+N2
    SBRxd+RTdQLox2cfeGk+buR1o1YA6C05iy6xzEsNpMemGCbcmx4JOdQmQ1hgAqJU8EX2dGZdPp9yxJDakrh1kKggU9aI9hTkm99yAQYmnH7mro7m/cRNdChG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=lwIAlZot-N1xkc84GMUA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeEVOWi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 10:22:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54740 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVOWh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 10:22:37 -0400
X-Google-Smtp-Source: AB8JxZr+XmMqTkJHePclYIOtIeT09GqMJj2YBFyG5Ul16thmKjJWSGlWmr/l25pBF0HFGXsmHZwNLg==
Date: Tue, 22 May 2018 09:22:35 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
Message-ID: <20180522142235.s4cl5bh62z24oc6f@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
 <20180522125444.7zgdlx7q5rgrk52t@xps>
 <20180522140203.GA7374@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180522140203.GA7374@kroah.com>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 04:02:03PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 22, 2018 at 07:54:44AM -0500, Dan Rue wrote:
> > On Tue, May 22, 2018 at 04:18:31PM +0530, Naresh Kamboju wrote:
> > > On 22 May 2018 at 02:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > This is the start of the stable review cycle for the 4.16.11 release.
> > > > There are 110 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Tue May 22 21:04:14 UTC 2018.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.11-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > Results from Linaro’s test farm.
> > > No regressions on arm64, arm and x86_64.
> > > 
> > > NOTE:
> > > kselftest rtnetlink.sh test case failed on all devices.
> > > Which is not a regression which used to SKIP pass and now run and fail.
> > > Bug reported to investigate,
> > > https://bugs.linaro.org/show_bug.cgi?id=3834
> > 
> > To clarify - previously rtnetlink.sh did not run because we were missing
> > the 'tc' command in our rootfs. We added it recently, and now the test
> > runs and fails, likely due to a missing kernel config.
> 
> Thanks for clarifying this, it makes more sense now.
> 
> Hopefully you all can fix that kernel config one day :)

We use the kernel config fragments that are included in kselftests..
 
Dan
