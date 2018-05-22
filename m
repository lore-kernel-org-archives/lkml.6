Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2569430-1526997746-2-2849337065811415958
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
    1526997745; b=mxp3nomUNdqkCKQizMmwRfpllh4RrNxtJFfaSWQQYRN6TAURhZ
    C8stpbutI/EM8Q9xynDpvAYfFYWuyT2eDHahVoxyeZfMOuZ2kSipAi5tOBMe+SKa
    0HmhT4EftWK4kVVkJe8P4+kXvGjLHaUF2Ca9E8zTqiLpLGgO8UNCLocvue8f6p/K
    dI8KUBaG/Gxa/A35i54HMOy6SCO080EYAuIKWpnQX2BvvT5qcf+N1CNqIYjD6VtZ
    YTN2y1dFSCne72rq4aSzX8fH9dafLpg1FpCFkEYvAdCcc8EuQv8aNQze9mg8Ss68
    ElndfNFl0Qb+oZ6qWhBuUGnGx6ShWtLxAEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526997745; bh=QLYB3gr60E/
    HvFL67H/v4ovxnr6xVCQg4TLwJh/dV5E=; b=L+vQkDa7qQvoGmPjGoS3SrSgdAv
    lLhgLE4u1cb2LEtygm4uTAnXo/7xQkeY0ifdXnCqFy3kw1vtOHBA+Jefjd8aL+uk
    faCb2vAd3D/B0eb6RBx2aFFEeU74QXXNABJAiwxz0T2Yl6J7uv1CBj9OBxWd1oVO
    Cj1N2gJ81SCja+tQ73YLJNBiqSIAQMMb1/Toq+CMQlK9ewfcKLd4adxcU7JxPNuq
    0rYrwmkC2/8M7jN03ca32uUQVz6HfErSSagjvhKoUUQi80obisldpXz7Nk15Iq1w
    SUpH4iRNlWV+rZslsL7I+scZyBt1shOddM9K0qCCOiYPD3j8Bg42t7HdHzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=wGrNJuTC x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=wGrNJuTC x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKSgm6HKVdr4/HsuBTU9a8Pr0sA3A1TdUc+pB21sGQfbS5AUaEt3c8mgZIW10L4gXMKlQc+QN6+fRS7p+hwwipwy3saUNshSAjOXCzJLeB+Y4nnaxGui
    V1onLqeq/sSEhec8junGP8hAYzUv06FDQ/Ybmd2/ttEYnfdNHCwLpFtc8IPJwwaLhz58iQLuDGjEmy7gdTGOV6g35m+Go8AE28BcaBrxZj3iThvzjaPomaet
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=p2k1u3FkrfDKeSS9kPoA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeEVOCW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 10:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEVOCW (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 10:02:22 -0400
Date: Tue, 22 May 2018 16:02:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
Message-ID: <20180522140203.GA7374@kroah.com>
References: <20180521210503.823249477@linuxfoundation.org>
 <CA+G9fYsGV7P77u8z0jhGrpMDFSMo-1PBnHPWkq4z1Z7oq6vEaw@mail.gmail.com>
 <20180522125444.7zgdlx7q5rgrk52t@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180522125444.7zgdlx7q5rgrk52t@xps>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 07:54:44AM -0500, Dan Rue wrote:
> On Tue, May 22, 2018 at 04:18:31PM +0530, Naresh Kamboju wrote:
> > On 22 May 2018 at 02:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 4.16.11 release.
> > > There are 110 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Tue May 22 21:04:14 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.11-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm and x86_64.
> > 
> > NOTE:
> > kselftest rtnetlink.sh test case failed on all devices.
> > Which is not a regression which used to SKIP pass and now run and fail.
> > Bug reported to investigate,
> > https://bugs.linaro.org/show_bug.cgi?id=3834
> 
> To clarify - previously rtnetlink.sh did not run because we were missing
> the 'tc' command in our rootfs. We added it recently, and now the test
> runs and fails, likely due to a missing kernel config.

Thanks for clarifying this, it makes more sense now.

Hopefully you all can fix that kernel config one day :)

thanks,

greg k-h
