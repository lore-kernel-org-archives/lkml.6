Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2569430-1526997778-5-6339096725520510209
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
    1526997777; b=bYUAlILPy2uaB7s81Ly3ifq5MTQmOAvaDc5PPYuiwV58uGJe4l
    x9AbCm6lu8QyiEyTqZAVsAhkFPRHNet8HaCNiUd7wkhi9rpwm+fmGm87QbKxYs99
    OgToixxDlxI+RC++4S+4UUOVJOC0l4HTIco85aoonqJYxwg9kkX8OR5o3JVVuE8K
    P+1rkJQWz32Si+a5JLKy3Z9MtDtOO8uW+lOLBKL4kgPQx5UKzZGt+vjP4waJZq+q
    u4Qsg3GsI7keO99GxFBFUpzEw181aIzlJHtVr3DOloq+Yi/LXofghAKs3Z4P9H1S
    rc0SpNR/iEa3ArFqp7v0OBntL+zYJ+FYXLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526997777; bh=VuADeTvNqUE
    6CprMalR4M2HvMBDfQGkmVxEwIFT2ipo=; b=X+S3W6VbC9/yahWePYxmkl8Ns1n
    ZocZIy/YtEO99nTZcIob5+3iupGYQuj5fpa7Fqb97vPNV9GFwNUT3hQAkpls1WGz
    Oi/4O5LUUV2MDrZSD4gUZXvwqYESIJge+LNUzR5/vfyLwW68tg3zSJqzIg3sZctn
    d4HK6aTS5oescW41ho44O352VL7Azd+qbMYrP/16Sq3uQC3VbuYTS37pZjvRP882
    mqOjNgY68FleliRBzS0Y1zUqdRGjR9NQNu7UtfCKXalncMLZhXt32+Mp2BzDxB3E
    5xajizl+jGWuRbt46i4JNCQeiSWyon5WJGam6PFHTZimqs8QYbTcCu5WMQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SSaomS1s x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=SSaomS1s x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGSuED7zflynlaRG7TJ1RT1Z+24QBhvkWYx3OTtRtJYiNclX6xRLQ7AzZDt0NuFK63Q9VVZhxkm2su33z09mPYPg2yQVb3rEzmcA3GW/52eV+Anmv40R
    Wt3jo2p4HlxiWxHQiXcHzc0h0g+90SB+NSPZx/F53mrWr6orE53YaMKXDtr9nTQMvlIYznF8gFws5EpBiidjbDNmKoOcjZy7ieLJEUqqTBBCAUhAcQg1b1Gd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=UhOjoZm1NaWo7w_ywRQA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeEVOCy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 10:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeEVOCw (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 10:02:52 -0400
Date: Tue, 22 May 2018 16:02:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
Message-ID: <20180522140233.GB7374@kroah.com>
References: <20180521210503.823249477@linuxfoundation.org>
 <CA+G9fYsGV7P77u8z0jhGrpMDFSMo-1PBnHPWkq4z1Z7oq6vEaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsGV7P77u8z0jhGrpMDFSMo-1PBnHPWkq4z1Z7oq6vEaw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
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

Thanks for the quick turn around for testing all of these and letting me
know.

greg k-h
