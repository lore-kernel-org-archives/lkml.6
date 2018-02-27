Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199880-1519728553-2-2319947702397868517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519728552; b=e7ebYrlqDoV0SzVqsWwPiLRfkjYrYVMsX53BWyU/iiat0VE
    T5wNCGRaw+TCOHESjMC4w+JKHeU4459Wj6z+r1Y5+5CVObjKG6DfG5oBNNRF7f+7
    F434YuXW9t+E3hgM9uJynPaZENQxgK29ta774mSHvdmFXeNN+nK6IYMKpIQdcyPI
    v2Gk8BhxWUvw5lrHBbGyCl4ji5S8DH6ewPRY0KrOAbCAIm7NTKjHrKpqXpKlowqq
    1dvOTS/I874YOmVlxhPcK0fd6CLqTuZcoTR6qGyhqqaxHQYdYNa1Cnro+UsPx0YF
    if+/W93zZjcMSsZgxffH4uNjI2HFeACo+JD2lNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519728552; bh=SEZroCjx4gLFC2H7GeiyX9cKgBe2jHJsK9W3LY
    mHY8k=; b=ixzKiHg50OIweXOVJuJZ66VK1CLJ7ShixG8OMPT2BRdEWlDdN0nRb9
    KPrxJKAPj//eIvgL6er9VHUzFyRCCaCOqxBlkO9QIlfhMIlpQqyoe9fEH1mct6qD
    D1699PlAeg8vohAsGIdwoPIsONytnk9OzspGXa5wARcG26KSbcsmVFUjKZV9a13q
    U6FDG2G9bV5ziXOc2kArOZr4v5/HFaZqM2hfxG0vc9Bg662o//X4bCwAPY24extN
    NhCnjTCjLspmRcXQzPoe6EX7UreJ73JmogB5/zwwXo9fo6MhuIdq1sXzW+nQU3D0
    9b8goJnArmzzTljA6JAPLOcNx1xUtYBg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cKf+9zo4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m9yKqmcP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cKf+9zo4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m9yKqmcP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeB0KtJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 05:49:09 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45643 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeB0KtI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 05:49:08 -0500
X-Google-Smtp-Source: AG47ELsHDl/zyY9g8LUt+XJwrp/txkuvVRjyWvqRFDU2brY/91x0bxiP7z9PLtmfmwqsoWIj1YVv9IFsTIOk6uN5V5E=
MIME-Version: 1.0
In-Reply-To: <20180227115243.7ca84b3b@xhacker.debian>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-3-Evgeniy.Didin@synopsys.com> <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
 <1519658060.31245.4.camel@synopsys.com> <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
 <1519665265.31245.6.camel@synopsys.com> <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
 <1519676841.2997.7.camel@synopsys.com> <20180227115243.7ca84b3b@xhacker.debian>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 12:49:06 +0200
Message-ID: <CAHp75Vfb6HQvx531bDi_j1wG=-vae73o+hcOyCGfOeQKEUpYeg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation for
 32-bit systems
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 5:52 AM, Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Mon, 26 Feb 2018 20:27:22 +0000 Alexey Brodkin wrote:
>> On Mon, 2018-02-26 at 20:30 +0200, Andy Shevchenko wrote:
>> > On Mon, Feb 26, 2018 at 7:14 PM, Evgeniy Didin
>> > <Evgeniy.Didin@synopsys.com> wrote:
>> > > On Mon, 2018-02-26 at 18:53 +0200, Andy Shevchenko wrote:
>> > > > On Mon, Feb 26, 2018 at 5:14 PM, Evgeniy Didin

>> > > > > > IIRC, someone commented on this or similar, i.e.
>> > > > > > DIV_ROUND_UP_ULL() ?

^^^^^^^^^^^^

>> So maybe we need to add export of __udivdi3() for other arches, what do you think?

> Per my understanding, Linux kernel prefer to make use of do_div or implementations
> in <linux/math64.h> for 64bit divide

To everyone in this thread. See just above. That's solution which will work.
Other than that, drop COMPILE_TEST from the Kconfig and put a comment
that driver will not compile on architectures w/o division library.

-- 
With Best Regards,
Andy Shevchenko
