Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1627020-1525310456-2-13114195204100316487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525310456; b=Vz6LyVhaile40BkDJzgAW/t1TvNYU7H4Fix/+xMa2lpEMcJoA1
    0c/cfsf5HoXylRvGs2VIzj2QSjLYUvCfN0ycCELTctesmoAv26EeUEzhIOUAdDlO
    dv+gZ0TEVb4I2Q20QQJE/rzxrqZvekwhBc/jLfmnMZaNuW/vLF9lE5eJi/iZjgXy
    kPrEtY/nPW3CvTWg0Fb+iaSyQtBNyb3kujI0k9IEtul7DFbaII7oFCwBxLhpC1np
    cVmVRpH1oddD6ZpNGbqsOWUQ6zhOOZFqgwSGc0mOTmIoKEPn34sKLiYm4/n76h7j
    OFehyg90DKTv9xRm7KZp4bqxqiEi6UTuW/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1525310456; bh=wsJXrZo/FF
    uQDYspMTPEhc2TRvo5/3pmqyijgybohDg=; b=GqJH7u0ROMRrur4eJsbo02dOUy
    lYmPb3z6GJKqGTLXiZJ7GjK9PJLOMFtIdAeYpmfvhjM78dBXG0wFU3pXgHjj9YPk
    o0Bu08TyMPtd1mVX2uKiYR7DhpyKHFz+/Eb5fwnAJtegFmDWEa4jLVKUjfwAXmhH
    VMieDg56fr1X6i26XhcwdAV6m1+QXGfIfrwFWdvOtd+snEV1N5JOFOlPZtyX8CUO
    xKqrRyi1RzFh746B/w1uY3/LQX1z5L9tSmsA7BeVteevA10Vh7HlLu3ls18om7lK
    mvmBS1ztE1zY6rY+leQ/CTm5k8DH3pRYisMwo7zbVD2fbGMk5oKp2uqlByGA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHWXCqlKgLN+i+ToYQjkYxm6MHSDQj6TyQhBxckksV4PU9lI+sqnGZSnGlun0b1rXZ2bN+2b9s0FC7jPgWsdJKa0tlF5rvMOSE+h3y6TijK8Glo0E3Zw
    ne8ZjyWD5sISH8WkYWLTWioaUuBU0RVPR1YlNu2O6KVKZajdZYsWEU5ack8wkDOEhRUX7iFKGM37T5HbHOXvih0zxxKdAZ8Os/i3mOYUmtlLlY76D4ly3PGz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=PNFaEUcPfEwZay8HG_QA:9
    a=HhdxdLxw8hOt3Hbo:21 a=KgIvFG0-mimGVMqC:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeECBUo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 21:20:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40875 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751745AbeECBUn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 21:20:43 -0400
X-UUID: 8c6d21dbf12049d89ad47965423f6149-20180503
Message-ID: <1525310436.25162.28.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] dt-bindings: add MediaTek XS-PHY binding
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>
Date: Thu, 3 May 2018 09:20:36 +0800
In-Reply-To: <CAL_Jsq+_Bq_Cm7RT0aTstLcRvdpx62U-7CXUA5hJnO-UqW6E4w@mail.gmail.com>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
         <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
         <20180501142459.GA10534@rob-hp-laptop>
         <1525244660.25162.12.camel@mhfsdcap03>
         <CAL_Jsq+_Bq_Cm7RT0aTstLcRvdpx62U-7CXUA5hJnO-UqW6E4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-02 at 07:41 -0500, Rob Herring wrote:
> On Wed, May 2, 2018 at 2:04 AM, Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > Hi Rob,
> > On Tue, 2018-05-01 at 09:24 -0500, Rob Herring wrote:
> >> On Wed, Apr 25, 2018 at 03:45:28PM +0800, Chunfeng Yun wrote:
> >> > Add a DT binding documentation of XS-PHY for MediaTek SoCs
> >> > with USB3.1 GEN2 controller
> 
> [...]
> 
> >> > +   reg = <0 0x11c43000 0 0x0200>;
> >> > +   mediatek,src-ref-clk-mhz = <26>;
> >> > +   mediatek,src-coef = <17>;
> >> > +   #address-cells = <2>;
> >> > +   #size-cells = <2>;
> >>
> >> Really need 64-bit sizes?
> > Just an example, 32-bit is also ok, but it's better to use the same
> > value as the root node
> 
> Why is it better?
> 
> It is unnecessary bloat and it is better to limit the range of child
> nodes using ranges.
I agree with you.
And here the parent and child address space is identical, and no address
translate is required, so use the same value as the root node, if the
root node uses 64-bit sizes, we will use 64-bit sizes as well,  if it
uses 32-bit sizes, we use 32-bit sizes too, in order to keep consistent.
> 
> Rob


