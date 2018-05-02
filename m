Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-683833-1525264942-2-2361518380777668256
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525264942; b=NT7Zr57SXPWpWN/yfJMgjqgenUO89PqLDea8CuuFhw8khdQJVZ
    prdbAoGhj6rzgPEWwZMs9iiHwDMoF5BaDKYmdbUlNJC/0xaICKyICcMNVb4NBEqY
    hME4a0Ij689rx3NXmpN4sLN3bfuLJU862/K8VK6oyjdxf9/+4njiBA6nG9D5qOsC
    Ht6eBVg8z/Vxe3PmRi0kHcKZ4wD8pflKkveCGMVxGlrQgpMKUUm2dyMNYV0O3FWv
    EQ15+2S6BcJH3U1JhlorGLO1YXCogyF6rmCzqBaltHrS9nuVOnBGkPCTYHx/QI0r
    rZ6VWVePnsoDhrCki/bvPk9xNoBIzE1cH0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525264942; bh=Owh0op+7igJXNpn5CJAi+Ajm8S9GJADzLoMWrR8zJc
    4=; b=l3xmQ+6GbhGu2E62TKnKXpEJSn9nbTiUDtCEFu4UNE5U56l7Ql8CKYTbSU
    oPVDMDVaDDDeQzpCKVRgD3NrSq5rpr/MpyX2ECaUquGKXYWoM7EWUGOK6f/Kcqy2
    pE6bZyIaX7LwtKLUVKrDvWqsG0xRwINBYws9nVlSo/QEaSm4IH9tdzkhVVuEKNPp
    cYGfiYlagrxXBMKPuK6mQ/dXkWnZCWUlWINVY5Jcz/A11fGT1n3O6gLiZz+fhcT+
    X43t/aFDwYlb40Y5DKmOX2flpaXeYCVTLbqhRqoBhIA5+iI/Wo8RcDjthL6HkAX4
    yySyMozpBaWpRSaABQUYW2Rffgaw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=0cIZ/k7a x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=0cIZ/k7a x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPzNm4JH6453QgduzNyQBageuwtSHhcw5Xvbg5R4QWIGmAO7CqtABdHf01ZJmh2V0sJkBRYjFkb+92YFbyTtSz0HZeBy8LGznInswdi0meBoRmwGhHF+
    R5o/zq4TPSVGteTfyyBdr2EJu5q684SukxclcWLMNRyBXonKg9JnBf14ISNhQ1d0WbTVUgEVpxhRFldxjozaWztrQGpYHRPs+glLni23m3NNgX3hpCV0x9tU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=YsAUHQR33577Veb54HkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbeEBMmG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 08:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBMmF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 2 May 2018 08:42:05 -0400
X-Google-Smtp-Source: AB8JxZopf63eO4f0KbJkmlFavVq+jCX803vuCYFk14AY1838Zj2lvZ4yAWf6W+Qo/COyF8JAMhXFagrd1BqHHbG1xDI=
MIME-Version: 1.0
In-Reply-To: <1525244660.25162.12.camel@mhfsdcap03>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
 <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
 <20180501142459.GA10534@rob-hp-laptop> <1525244660.25162.12.camel@mhfsdcap03>
From: Rob Herring <robh@kernel.org>
Date: Wed, 2 May 2018 07:41:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+_Bq_Cm7RT0aTstLcRvdpx62U-7CXUA5hJnO-UqW6E4w@mail.gmail.com>
Message-ID: <CAL_Jsq+_Bq_Cm7RT0aTstLcRvdpx62U-7CXUA5hJnO-UqW6E4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: add MediaTek XS-PHY binding
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 2:04 AM, Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> Hi Rob,
> On Tue, 2018-05-01 at 09:24 -0500, Rob Herring wrote:
>> On Wed, Apr 25, 2018 at 03:45:28PM +0800, Chunfeng Yun wrote:
>> > Add a DT binding documentation of XS-PHY for MediaTek SoCs
>> > with USB3.1 GEN2 controller

[...]

>> > +   reg = <0 0x11c43000 0 0x0200>;
>> > +   mediatek,src-ref-clk-mhz = <26>;
>> > +   mediatek,src-coef = <17>;
>> > +   #address-cells = <2>;
>> > +   #size-cells = <2>;
>>
>> Really need 64-bit sizes?
> Just an example, 32-bit is also ok, but it's better to use the same
> value as the root node

Why is it better?

It is unnecessary bloat and it is better to limit the range of child
nodes using ranges.

Rob
