Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465131-1524502695-2-11762404480804750683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524502694; b=NttUvb9ndaItfp3a1bsoasJU5JKQtRLgGFcqey0UadtKaADNGw
    TolxELy76RczdHurNAxJUMlBlDO/8QQ88EHgXME5j0+BDf7Ysalgjz/6GEa3w/X7
    SBjrFZHE2fgD2juzOzDcvYf1WbVCLdTmpJhhqDwSw6leS+zHawloWEJLrw89+Krd
    mf+BdFJ1oM+S9didy7sLdbp51sqMiIrj90xFD7XQIsmaZ4MCKrOCoFvtbH+9vj1h
    xhaHux03sB7meaGB9Xqtd18xRrdM70JLohjexYfkK+91j4TNJF41epJjUbbI7PPh
    G2KgvgH6NFy5n+QSjbCsJ4qcSMo9VAMKrtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524502694; bh=nu6tOiuWBjecU95DasPo3JNyfUKc3X
    YyD13/mL5tKDY=; b=CrebOPnCvaWzFwCfaWKHT8j2LIpy2gmBBxrKyMSFhRt1jH
    rxHPCOWPKcszDZzeJS9JupdVoQeOpZCPzt+u4bC9Ec8haYk+eRk0FAouyqgUXzOo
    j15UWvQtzZr24SAK62570gBAPZHhWAgK/H76rOIc6fqUQLWnAmwt0+6ma7r9dacr
    z8zll3Exj196ggBgwp9I5ZIXU33x1uWcNTdKmjajis32HAYIBjrhXMuxGJdnNrCn
    gZa+6UWBGrb5sPmlYCyE63c8s0I/x6S0eJ7WQydLGiLKTGWaX+bvD/kBBHWCkRrL
    pXZ7nM+6Yt/gbS5INN1oxg9mFfwOfXlJ8FEwYSpw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfJY+whs1zkxSqkG7deDy0hOD5g/8EG3Td6hbCaO/x+D2O87SnC+ZSrLMOfI8Ggb8ygXmi1RyxGnWsgkvCqWx7kgmudbpAlUwj5WR9vLlSMEoimBqsGIX
    /96KiIwQrkrXIa9W1JHv3wHVlmNhd5sAnEEvQYLsIkWi0DZG5UjDALcH73iHIDUGdnqZyge3Y5Woj9w8PNjMifTCTSZkrFFvCh3xjbJUJ9xE7P1V20+VF7aN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=RMlRvZAwo0AA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=NXjAMjVqi3p_7X4nQyUA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeDWQ6B (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 12:58:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeDWQ55 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 12:57:57 -0400
Date: Mon, 23 Apr 2018 18:57:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180423165750.GA27986@kroah.com>
References: <20180422135210.432103639@linuxfoundation.org>
 <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:23:49PM +0530, Naresh Kamboju wrote:
> On 22 April 2018 at 19:22, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.9.96 release.
> > There are 95 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Regression detected on arm64 devices Hikey and Juno.
> 
> Here is the list of bad commit patches to be reverted.
> git bisect found first bad commit as "3"
> but reverting 3 patch failed.
> so i have to revert all four patches and boot test and the boot PASS on hikey.
> 
> 1)
> Theodore Ts'o <tytso@mit.edu>
>     random: add new ioctl RNDRESEEDCRNG
> 2)
> Theodore Ts'o <tytso@mit.edu>
>     random: crng_reseed() should lock the crng instance that it is modifying
> 3)
> Theodore Ts'o <tytso@mit.edu>
>     random: set up the NUMA crng instances after the CRNG is fully initialized

This is the one I need to revert anyway.

Let me see if I can just drop that one and do a -rc3.  Give me a few
hours...

greg k-h
