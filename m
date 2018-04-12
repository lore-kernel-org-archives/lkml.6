Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1450961-1523552104-2-16459135155528357984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523552104; b=i59gTjGr0vTHebjKev86XEiHE4QhmJV4/joNyAqr8uiuge86WJ
    S4zs3cmldOnEy2rxMGrqCdMkMk50vVZ94K9mftpkOOZg9u+tFhOmYqlVZ7CHgc+9
    2eIHd6HfDNgBhktQbXPzCNX2ScxcDSOud7ZAReq4zF7X9tKdMrIaWiWZYD8o2qzg
    kyAszGlu5NjdWXPyk4DMfd6nSGd0v7IW29k61p8RIvFTAxW8DE2AOcmzZUXF0YJd
    FlJQ+6WJFZhVkAOUdybkRaTtnkX65C/ELeFn7RE06dVmjjLa5GTvKY6wSxIP4bCf
    BkmJL20kIwR9AUeXo0yfiFhyHQZIAHOHJQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523552104; bh=h0n8NGcRo7i
    2Wy9O49nI51+8oHf3oAFtQT66g+A3jTA=; b=UB8ZJo/5dscp0+r1/XTXlkdyuH8
    a0fOGZINcumcqJeEr4H1OXbCIu5KRh9IoRExVuAnQGkWdx8IyUR2Q0mlyNgdvNJz
    QgyG/F5RdJ1u/+Rr/VQNWP6cRH6pBNKC9VNM6hpyYigZDUyLKHheNtJcKaRbhX8L
    tDGM8m8xY1VcQeBlOqzS7W/BanfCfNIYtO4rzXbGlfoupIStyl51aVs2bcOlPD1e
    x3mR1chHnyNct5fzQPZc95HZlAeAxbL7UT8AWHuRwGKFrpwGy3RwsbR3N4DkJXcS
    vEl+JuaMZnUFkoHcC2JuArZBZoiRVEzjKI7HcgsDeLmrT5Av+MT6fZYO/sg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFNz+LvO3G030Jrld0yTliXSB3v51TrR6g5IT9jugt82Vw8jmsqKhiFSm/TSO9eabueK6/PnW6MsYL1O6dYYYFmz8SD46z1pVOBD/vheoSNFoMfp8rzO
    7EMyYrUwAPNoh2QHWA6i8bZ93bgsG+Ed31iWEiTg8DIYjbJ7do2wH9mQcPV/KbSnhB1FxbmdisSwrQxbnMfCb/W78T0hR8RKs1jOISOdCM/0nKjDVftetz5m
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=vSoj_SWoPg4A:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=UhOjoZm1NaWo7w_ywRQA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeDLQyu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 12:54:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbeDLQys (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 12:54:48 -0400
Date: Thu, 12 Apr 2018 18:54:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 000/310] 4.9.94-stable review
Message-ID: <20180412165435.GC23951@kroah.com>
References: <20180411183622.305902791@linuxfoundation.org>
 <CA+G9fYvMYm=LYC8F1PxLNm4BG64GxB67fP7u51V=aJ+7QLUX=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvMYm=LYC8F1PxLNm4BG64GxB67fP7u51V=aJ+7QLUX=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 06:30:32PM +0530, Naresh Kamboju wrote:
> On 12 April 2018 at 00:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.9.94 release.
> > There are 310 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri Apr 13 18:35:00 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.94-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Thanks for testing these two and letting me know.

greg k-h
