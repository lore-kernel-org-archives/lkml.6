Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941935-1524139425-2-14177563692457178480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524139425; b=ZGiwuWqlGgefeY05/8bpFq/7SHyR4yX+qjBxri8rTapSVwuIIY
    Z+KwbQQh2dGuFLpmG/pjFCw7N+jr5Zb7bfE93QHjthf5w1lA+qxxXrCJhbPmE73U
    2J4jSIjP/7+OxuJO3u2iew3rRi7JaB4+HeGSbj86o7z5+1cG6reORNfQU6fIK/re
    ktxGXJskVcIXZWqXI9aJkzMm180NAl2HTokUV2M2fTiaNwqEPsrl3Ujoph8wq9yC
    CIk1KTDK/X/M67JUxEzR0Einy6w292QlFPypmtq5jhzUr1XbHTbc5YSTNOUV2vq8
    NPpDclJONzOlRcQFRCXIQqXwKeK/8gDLVULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524139425; bh=pq5bUYOwJNck3J5NGJpGI8T527k5RVfil/o4JwL0w/
    o=; b=g8o4TLJVUf5MRDf52xigSuNcwkBL21D3g8QiOxRIJOIeU0ldfo9jW/tUdl
    p7O+ar+32nTrB8Uikkc2WjFp0kMJHJgx215gKRFk7kjJoMv3shwkfbGw/UKKPfnQ
    pQmMYLwZXo61fUvajZhIYBK7zrQii+HaT77tEUiIM7OFCKNhfoyIJD2rZSxB+/qX
    cpj/1vCnZg2Tb6rhDaa09nqrQX3nKP0MtLNf4Ygz/WKBBFmf8pl5lcFNQDnbIzrP
    Pvp2IsU0M1BQUMTreYyrn9V16CCV7e+BzMJX/ngj9RojnkaN0iDBdxKuN6nTsesA
    S/4g/ysL0lGcAf0nH4GsxTg7pCNw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GD4xsgTF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZRx8asvU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GD4xsgTF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZRx8asvU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVJqt9HInpf1wd+E0t4OXywXQSG9ULfvPaNUx0tbBOdttJ6K7We5GzwNYnTwDpaaJlIqCFzd9caCh1kG1eETASclqyhpYgU6V0qhRv2K/1PzvYm8mdi
    G5SQiWV8Xh+FpiICej09XdpySMn64Mrbd4er6N5+Apz52zVMBI7SuIIx9z7N8BaDGUy3DninWOFP1FUM5j6O9KnB9YKTIKud+qjqgNePYrMnCxd4yO9AWclo
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=BK_riLhbfcJTKT0X-Q0A:9 a=QEXdDO2ut3YA:10
    a=l1He_3m2cmAA:10 a=x8gzFH9gYPwA:10 a=Oj-tNtZlA1e06AYgeCfH:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeDSMDd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:03:33 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35311 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeDSMDb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 08:03:31 -0400
X-Google-Smtp-Source: AB8JxZoa8xOvryUc/7j/z3+PwCAGq+GaVvPhOusNWMXs+WKHqo0KqdEM6434yiSjeBR/A6VRnx3uj9Y1bUbsumrAHwk=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXNHaBVMqrQOfBuN+Ro4SC40B9OxCs9HsNM_c4fxcJT0g@mail.gmail.com>
References: <CAK8P3a0-n-Qabdr+5hwjq8wa9nZHtFwcE32WsW8ZTbKjtpiBUQ@mail.gmail.com>
 <CAK8P3a3vS1AWHGMmGchQOrkV40GESNuJHQfZF-YDtOwZ1Z18Dw@mail.gmail.com> <CAMuHMdXNHaBVMqrQOfBuN+Ro4SC40B9OxCs9HsNM_c4fxcJT0g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 14:03:30 +0200
X-Google-Sender-Auth: Fr-ja6HwQD2Ehh8iANlf9L3Qj1M
Message-ID: <CAK8P3a0bMxupCGnrzOomACmgdkfoE8BYmyx_UX1OLeBmdNx7+A@mail.gmail.com>
Subject: Re: [tip GIT PULL v2] y2038: timekeeping syscall changes
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 1:59 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Arnd,
>
> On Thu, Apr 19, 2018 at 1:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Apr 19, 2018 at 1:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>>>
>>>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git+ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
>>> tags/y2038-timekeeping
>>
>> That one is still messed up. I changed my .gitconfig to have a
>> different "insteadof"
>> section, but for some reason that failed. Obviously the URL I meant is
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
>> tags/y2038-timekeeping
>>
>> I've never figured out how to configure this correctly and try to
>> manually edit the
>> pull request, but forget to do that half of the time.
>
> I use:
>
> [remote "foo"]
>         url = git://git.kernel.org/pub/scm/linux/kernel/git/user/foo.git
>         pushurl = gitolite.kernel.org:/pub/scm/linux/kernel/git/user/foo.git

Thanks! I've figured something out now using 'insteadOf' and
'pushInsteadOf' config options to the same effect. I had a
separate pushurl in the past but that broke when I added
an insteadOf substitution without adding pushInsteadOf.

       Arnd
