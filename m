Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3288027-1519664044-2-12211491426282679779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519664044; b=TkXqT1z0qRZE1kjawjFEqGMCegKtnAFE4O30uSzKVG4Ng3O
    LSfjptpz7S6IwdlV+oGFXIPXy2JBcZ/o5zUbQ0QX33UHTN+Zo0rlkttf06ouq5xq
    v+kz2QY/uxU3yA76dL2U2JasEshROvDmYlY+X8k/FlJ5snCc9ITSENF/VU8GzbhR
    RF85R7H+r0i+gfC+NSLXlFxrlB3IMoWTPAsVg+0jGq9A0K2exMJW111qI+aIrUKd
    Ke4m0zD7INhATr7kQZ1rIpeeGeZYtEnnbBUGVIn1xfHKbErB+SunPhhYnLF8cusc
    ddf/4idc/1DhHrIOXf0emNM6JkZle1GrEiAnjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519664044; bh=XSg7LuFoO/nDGWQMRIa1Uh51KSyjSF5vv6Aoet
    zdT08=; b=NJ8wC3iJQj95VVvduJ8uyZBwt7rJYkOjZi+JiHvcZhxZxLFPGKbR7Q
    2pEIrybU/3zgH9H9oT7WHmd+kwjx3bGp060BvHJswZDCADoXJsI5i5com05xljiX
    TUo0ax3IPcyjKgsmAniMzHuzB9IekVRykKoCiSAFTYMezgOnNTAG0I4R2JERUF1j
    aJ7/NGG1i2LzVO9NDG19mqdAmdHEV/9F/g8X4+HYOLeo1Z9aGpN9AmBZP/C+Sje4
    HeFPkrnckY1Uct5eXPONC82OgBWatkjyntqAMTp2bFRjlzkY5x/hCbmujXAwAfxU
    G2OZrSKZuG4+YW0cE2h0+a2/q0cMGO8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nEWeisMN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hvC5HvMv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nEWeisMN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hvC5HvMv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeBZQxu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 11:53:50 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:46236 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeBZQxt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 11:53:49 -0500
X-Google-Smtp-Source: AG47ELsLFWEF+5qYesarConEv9mGA+L/cV0kWFBSknZ3sNKnhSaewzb7KccDyncZusHp4aTqVPrxw6OAxzGAlzG8aWI=
MIME-Version: 1.0
In-Reply-To: <1519658060.31245.4.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-3-Evgeniy.Didin@synopsys.com> <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
 <1519658060.31245.4.camel@synopsys.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 18:53:48 +0200
Message-ID: <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation for
 32-bit systems
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 5:14 PM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> On Mon, 2018-02-26 at 16:39 +0200, Andy Shevchenko wrote:
>> On Mon, Feb 26, 2018 at 4:34 PM, Evgeniy Didin
>> <Evgeniy.Didin@synopsys.com> wrote:
>> > In commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
>> > have been made changes which can cause multiply overflow for 32-bit systems.
>> > The value of cto_ms is lower the drto_ms, but nevertheless overflow can occur.
>> > Lets cast this multiply to u64 type which prevents overflow.
>> > -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
>> > +
>> > +       cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
>>
>> IIRC, someone commented on this or similar, i.e.
>>
>> DIV_ROUND_UP_ULL() ?
> Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
> because overflow happens on multiply and DIV_ROUND_UP_ULL helps
> with sum overflow.

Did you try to compile your code for 32-bit target?

-- 
With Best Regards,
Andy Shevchenko
