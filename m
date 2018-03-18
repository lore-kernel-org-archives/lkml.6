Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521369016-2-1149299576792946664
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
    t=1521369016; b=U9h7MP+zXl90RlN5ivo8NnuepjMcIBBYczjNfRSF4T8o0Rz
    VyWQaCNDJpIr5V2uKW557gytSt+ppUOKnHYYkObyVT0DONUUzwxKk2DexqWWj3tE
    acIal5Ryk3opXbf92NcCQ6wM8Cd1awsHFkVQXYmPpZFXWG+SUyxa4cFQzT5UmkB1
    2W43VKES5j+XZgiXkelAPEk8c9ltGdOjkiaL9nW8rmdk6L29TOhj0T7He8zURoUh
    KOS+WuRl1n3DnzAYnGwAmIrGyGBgDc4be4/99nDU08gprjNQEUtz2tVYzwS4RhnJ
    wFFJbW2jSPJP592xggrUQ8YfOt1TXSWVhu/zZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521369016; bh=ABFFOXh
    If9JKl9B9km9LgKXdcLyc8K0loTjIsJeXobM=; b=F9ze3txl1IKdpR7rg2FHhut
    ckwjoVJOOD13cvKocJPj36WlClaHrPHw/ILwAgJ3wxs2cDy8df31dajyjsbI4v+J
    oFtmjkMzpj9rQafDcvmQVOqeaSc1SKUN8yDkosD1TNh2eH/JerPME4Lq4NqsCXz2
    ognUMztQWQUHbVAVfJmjYbXdnd1MMRGlf7Ac1VeNci5EEafOVbyVgt0Ep9j8NsOn
    6RZyiMuJKoeQGs/CSZjks4v3ZfnLSBtWEDPTWPHnbKZ+kDuGoTft9eWabr9GdADm
    3KrNnzK1Z7JDum8IHumLZ2CIq9nFGMgsvOconHP+TbfeGTrvsZKnhz8Fc1VaCgg=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeCRKaN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:30:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeCRKaM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:30:12 -0400
Date: Sun, 18 Mar 2018 11:30:11 +0100
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
Subject: Re: [PATCH 4.4 00/63] 4.4.122-stable review
Message-ID: <20180318103011.GG32470@kroah.com>
References: <20180316152259.964532775@linuxfoundation.org>
 <CA+G9fYvnq9wEat-96JAshHpn4Pvf+7CZZi8Z47Y5afQSiK6rfg@mail.gmail.com>
 <CA+G9fYth=+85LuL6cQQ9TtD+E2tVz9NoqVLt5amea7C=1CpbfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYth=+85LuL6cQQ9TtD+E2tVz9NoqVLt5amea7C=1CpbfQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 03:51:14PM +0530, Naresh Kamboju wrote:
> On 17 March 2018 at 15:41, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > On 16 March 2018 at 20:52, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> This is the start of the stable review cycle for the 4.4.122 release.
> >> There are 63 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.122-rc1.gz
> >> or in the git tree and branch at:
> >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> > Results from Linaro’s test farm.
> > No regressions on arm64 and arm.
> No regressions on arm64, arm, qemu_x86_64 and x86_64.

Thanks for testing and letting me know.

greg k-h
