Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3547052-1523486326-2-17653892642271072050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523486326; b=mlw0mzoXj0e5kUOJ0c5Fa4WTTG5MC6scB4SNxsIOwqBf1GY+6Q
    3jNDl8Xaj+tBdt3SbW1l6FWqHw3k3qts5reTh2HoXZAhRMCh6C/HLgvQY4C60p2e
    Dxbw/gV0J1ixtmcIfuaDW98nB6nEo1cwuzj3nTksVd8yVYQDpEOJKilkcRr2lS6X
    l/x9ZAYxEp/6pTuSB6O/swGDyLQTYYNFDvJcKAh3iY4WaoaY1in4+hmw1oYH709R
    EoRJ8SiV13LUxZ0ds/q95HQ1c3QMPk/DsNi8+cmom4FBGZwCmsNgwNtkDz8qCYtO
    Dp5yFXo5j8nb1ySwPNLaRMx3QCl2wqQqEDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523486326; bh=i3m7kR+y4FGe3OFPz/Ofv+MLINI+uTmdOaks92BF1G
    s=; b=ZWe5vG4m9ztgif5n91iD9sIxc1LxFIyizrnnnffcADbXkAug0IfM0DpRLI
    Tq4r+vfPca9l1jyRylGYjJgWybSqvBRz7jotSaRECWFtH/8iOXRB5jeWq4Tjit1v
    z0PPixwQKcWtp7KjuaRM1OaElBPViky6yXYjhiTvw0TFPU6mWDGSB3CSf/51umjD
    lCpXWueopKRICMYrSExsU5yexCB0YWo9PuXripD1qZnwQOzIjDzIteUawNbs4CxK
    oS/ih6qyTql4MwCh/RNLRQrifyklQj+xPYP6qBUFNKcYoKoFTE2mTt+si/kbk277
    BcdeYiKXYfSIOdXD6XuSqPL9ihvg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SwBbVOEb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DCmx99Ad x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EhVA0flg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SwBbVOEb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DCmx99Ad x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EhVA0flg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC8az+qiLatefkS/1FolTCvYKttAW1XgS3lt5H7MD/slA8Dzg2y0ulXcgzR9Nc6XQb0MRlqNJeNflLVjXXOibIDiFposbJU5eHb3XwamjmLEcJHVTEiE
    /hvGpqsF7fNCpBeCxaHjwXN3fo4M106jcPHPWeFWZhKrK2U0x+cwpGuH+PAqrBl75owV6V40US/lnVSDXX2gP+rJTfie75I+dhLybNjV0FiCvbzQ1PN7KiEY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=M9FBDDqkXOsw-5tzMJkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeDKWia (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 18:38:30 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:46596 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDKWi3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 18:38:29 -0400
X-Google-Smtp-Source: AIpwx48YkAe1elq3QLhlT8ymIeK6VrVurn6Nu9bJgJzMT6qoPA3LdJBoAM7/ph13dEPas7MWdEsHQcVn/6m+IdTymz8=
MIME-Version: 1.0
In-Reply-To: <8z0aRQyD-6Krqntk8UD9WQjK5JSqEai2Pt5oeFU2EplgxoWiHlX5nlJXwCDHQ1WcS1oIprXimgz7UvwHCWDB9Z3dYFrEmZmtkEJSqaYMel8=@protonmail.ch>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
 <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com> <8z0aRQyD-6Krqntk8UD9WQjK5JSqEai2Pt5oeFU2EplgxoWiHlX5nlJXwCDHQ1WcS1oIprXimgz7UvwHCWDB9Z3dYFrEmZmtkEJSqaYMel8=@protonmail.ch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 15:38:27 -0700
X-Google-Sender-Auth: JQXxiiP2qAutJeg4_ebmDw_hnq8
Message-ID: <CA+55aFzvnf=4OeBy5vQQ6HQoCsgCkAJw1LhSBOTkDWm3ck1pZA@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: David Howells <dhowells@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 2:05 PM, Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
>>
>> If that /dev/mem access prevention was just instead done as an even
>> stricter mode of the existing CONFIG_STRICT_DEVMEM, it could just be
>> enabled unconditionally.
>
> CONFIG_DEVMEM=n

It's actually CONFIG_DEVMEM, CONFIG_DEVKMEM and CONFIG_DEVPORT, it's
just not obvious from the patch.

But the important part is this part:

>> So I would seriously ask that the distros that have been using these
>> patches look at which parts of lockdown they could make unconditional
>> (because it doesn't break machines), and which ones need that escape
>> clause.

.. because I get the feeling that not a lot of people have actually
been testing this, because "turn off secure boot" is such a universal
thing when people boot Linux.

So it's really the whole claim that distributions have been running
for this for the last five years that I wonder about, and how often
people end up being told: "just disable secure boot":.

But if people really don't need DEVMEM/DEVKMEM/DEVPORT, maybe we
should just disable them in the default configs, and consider them
legacy.

I'm just surprised. I suspect a lot of people end up actually using
devmem as a fallback for dmidecode etc. Maybe those people don't boot
with EFI secure mode, but if so that just shows that this whole
"hardening" is just security theater.

              Linus
