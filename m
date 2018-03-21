Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4050712-1521638550-2-1148305946155894488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521638550; b=irAyC1eGqVqAp6T1D0WZYKeEQV8RZdyf948tGH/1mVFl1Kh
    pfTiXGxCIOQ3soGl+dlFir7CjauwtwB/03kHwAUnHZBJ6BKXg8KNHwNo8aOjNb8L
    FlyBwkiumQvUA2K2pale6W3YGv0dknF9JCZxIAV2ru18l1koQRnbfldo5DwYlTWj
    CJRJmBGLk9gqgIp2cFZuhlev4RDG/5dn+eXZ/R4xnInIWVaZ19rschp0+AvYsbn0
    1iznSyXOJvFYB8eLQWpD4pwPEwWYBrYyeB8GmmhDCjEn7D3Qr6dy8IA6SMLTQJo2
    +MujAMvffWy4l3zZJSfNqgINkcJILMNJT2IQB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521638550; bh=FogPuKJ
    o01ujIn4hlN2L3QacKcruNwbyZku5j6ZN/QY=; b=Q1j1MPgkDZHrhX41SfN2xr6
    OhCS91c7p0Y57uELt0oubwGmDiGs3aEM70NbAOg9asnt+hbId8TGh5rP64U3y/JV
    680Rmi0QsDr8lr7u1IogmT/JLxq2PG7LpxT3adubSM68I+ICjyiTGesiJ7hobPzy
    20dEFK1LgvZKVSQciLy7rC/joTDQVT5f3X35JMg8Znju9v9WX/xuYk9Mj7c7VtHd
    bBumwTgb5xvIXemfYD2wms8cCwdMgCvwiq9vMqOSKNWm2/wqSkb1kcFxasDAmcJz
    g6/HxVE2VlKUXbnBV/bc12GiIDD08fz9Bp/32mZHlxLMVB3YyufYk2UYPM+X5hA=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeCUNWI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 09:22:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeCUNWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 09:22:07 -0400
Date: Wed, 21 Mar 2018 14:22:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180321132205.GA27514@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180320075012.GB10034@kroah.com>
 <CA+G9fYsGwYQ1pEdp3vec6823GNcMpRqQzv7Zdt+CbBJAYMNU+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsGwYQ1pEdp3vec6823GNcMpRqQzv7Zdt+CbBJAYMNU+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 10:52:45PM +0530, Naresh Kamboju wrote:
> On 20 March 2018 at 13:20, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 4.4.123 release.
> >> There are 134 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
> >> or in the git tree and branch at:
> >>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> >> and the diffstat can be found below.
> >
> > -rc2 is out to fix a build error that was in -rc1:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc2.gz
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Thanks for testing and letting me know.

greg k-h
