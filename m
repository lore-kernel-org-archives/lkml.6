Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3620115-1526026679-2-8320575921937744081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526026679; b=huRfQq8mAkWQhIIDn9oveGAWbY8P6/kFBNM5eN5iC/WcLzgMqF
    7PKNJshetzpokX/ZkF9kETFL5ldvj0J+O6oXvNfOLM1sCX5Nz7PrR6XTmAGUttz0
    UBBtO4uFhvo5jx6Daq4aQCOD7ZW3XHnCkONWXlqgLqqXn2duClnaqPueuQnsWfLc
    G6Lu+3pJNPcNHvfztVmCgoYGefHOf5P4zU0cI95BgBomNA/jhUPw9lI6pEFc1nlX
    Syu9MqZeyir+QIOyZmR2Pkl54WOLC+x6VVRyvztXwLdsOJ0O6KydVp3v3oud2SL5
    seZgaf3rIuiCpicENyuz3soj9VqhkN6thKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526026679; bh=J3FlJ
    HqqT7kEFZbd+FxpQE7T6kDGsHROLgaev62T85E=; b=mhfp/qcZ2OcKNxHhLuWrC
    FhPUCIR9JzsdoOP++QyPsq9jujCJVT3quqo3Sq1vlzPIlzbIahKEvivYtd8Rb4ZE
    PUNPkRFj+GuzZpdFcOgtuC86DHYDZ9zpIvLi1yPrgsSJmuL2xNrfN/NWf1WuST1K
    bm31eQLIheQqjEXWp+HO2pmoUMzv6HV5fUqpHu9vmdgwj251PbcGWy1ZLVDrHbpA
    md09AHSslBpmUARMgyhSS/jhrWHIQybOI4firXFE+V5iP6vxTeNHsX7nMVqNonP2
    oj0S5/3CrJLdEp5Qne+yFrQXN3dR029GDITvpvU7G1IMmTMvMblDknVZcK56TruO
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=android.com header.i=@android.com header.b=GmjyhW0d
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=azT8azwq;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=android.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=android.com header.i=@android.com header.b=GmjyhW0d
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=azT8azwq;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=android.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFyrTd+OqMAzyrsKyYgqNnvqES2G2l1ILmnF6kbo+KK/6xlaQwzNXkMHxCkPOxW3f/LcVCQsF07N2j0pZBoxfdDkg/i878eDPA69BIs5VpzV2cZw+Dme
    8sWvv20tTRxsRmvFGGPA/SMnwaI6StYsylAbGrdkjU5RaytdoKYTapZ7zxmw8ZKngyvpeWz74y6DQ2U5fcc2SjT3FtJ4oiVsPH3oRdylpf9tT3mC2hNLfl1C
    Gh7+po7v+AqzIZOekAqOQA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8
    a=vcVTJ-pIv0VSPsM6CrgA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZq9caIFqkPeXvtIZ6lwtDjkysUTRCQZO0Bl/+xJxXEeUzsD9929MfzdrnZ0YYiDTAeFfq04pn4FaksLvPg5hNg=
MIME-Version: 1.0
In-Reply-To: <20180511080801.GC3258@kroah.com>
References: <20180504195728.72932-1-maco@android.com>
 <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
 <20180511080801.GC3258@kroah.com>
From: Martijn Coenen <maco@android.com>
Date: Fri, 11 May 2018 10:17:52 +0200
Message-ID: <CAB0TPYFvriXj_nKY8YMEM4aNDX36WU_AF5f3qzK7r51h+kibHA@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
To: Greg KH <gregkh@linuxfoundation.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Amit Pundir <amit.pundir@linaro.org>,
 "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Martijn Coenen <maco@google.com>, John Stultz <john.stultz@linaro.org>,
 kbuild-all@01.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 10:08 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> I think using !CONFIG_M68K is a good start.  We can blacklist any other
> arch that doesn't support this, and that list should be small as I doubt
> any new ones will be added without this support.

Thanks, I will send a v2.

>
> thanks,
>
> greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
