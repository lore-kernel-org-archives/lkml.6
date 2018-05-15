Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3334576-1526421740-2-12660781131480784997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526421739; b=lUbHiAIdWfiFT6spVQoa5mIhebxtg5D7ur31DEd5oKbwZOBKVn
    LAjPfC72MQ42JQIAi05Fml6sIE+2rSC6oTk3do29kEJPVjW6jP47PR+bK+We4YfK
    EP74WInbUGrK7cBbvmEgHJKvZgLaLSajoNDPZx/cd1W/AmxSNg2CUNMIMV3CMvZa
    yD4lxfUvdD1VbYjpRuGCuluVokYOXKWvYrMRKxc3MnuOwykyvqL5OwK0Il1jNZSD
    rsOuERzOzTIgD0RVTNbj/IXZevumVFoRqTaFH6d4dqO0uxriVdhN20cPcFfMp8hX
    qsI2m+in5lUmbW86vm7f40xJOT4adal3Z4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=fm2; t=1526421739;
    bh=UsoYCmyeh7IejewRRChvjfZOjnFs77LMyG1WniEgyLM=; b=VkntEKfgTf4L
    mmEpSDtk5Wx7/5w3wxC8kta4wWhTc5WNm4a+/+EaGezatpmqnyKIkOUOgnRt6DiK
    9YCTql+Niz86f3SzjZKZl5w0jCIFgYPEGf+sH3cskjUkGCOYcItPT1QtPq0R9SPf
    FfGtcaCKn6t5NNTYFN54W0ljxZT0A55SY7K8QrRTFf2BSQBAnTQnMyp51iDPwirQ
    3+vr6FstN11Si1Oh+uGJwg7IHbl1DSkt9SpBOpxB9RR7c5cQ+bSVikfPHbCbV/aS
    vY4SAh+u5az6hoLtku7ZxP5RzKBYzeW/UELIB0Lu7Ot6LtjWdlWnI1fXWip+WMBr
    +uWVGN5/ug==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=i9sDhtSE x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=i9sDhtSE x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJiP/t5UzgP2mkFehmENzg5buDiid2AfJPYm2ZkHFBmLBuJ/xXOjxFYR6qBvVQn4oPhquq2O4IFlfSZYSGpeFpRkUmfnwkfxg6FTO5hY39cjQw6j0QJp
    t1jsp2xzah4WUXMF8qY/SbjgGeRSHNEHScik7CzDIyyClJUTsMGGgXAZMEnJtRW0fGBXmfBKU3fTmvlUVVPCMWSnjQmpZsJUqGNbsif1YtQ+NLqdzOVLrlgo
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=EBzs-4642dF1ywjK298A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeEOWCR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 18:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeEOWCP (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 15 May 2018 18:02:15 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Rob Herring <robh@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <5a449d93-eef0-4243-9889-bd13786edde1@linux.intel.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable <stable@vger.kernel.org>
References: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
 <20180501150236.GA15330@rob-hp-laptop>
 <5a449d93-eef0-4243-9889-bd13786edde1@linux.intel.com>
Message-ID: <152642173468.237094.11026813184254392663@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk:aspeed: Fix reset bits for PCI/VGA and PECI
Date: Tue, 15 May 2018 15:02:14 -0700
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Jae Hyun Yoo (2018-05-01 09:27:32)
> On 5/1/2018 8:02 AM, Rob Herring wrote:
> > On Thu, Apr 26, 2018 at 10:22:32AM -0700, Jae Hyun Yoo wrote:
> >> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bin=
dings/clock/aspeed-clock.h
> >> index d3558d897a4d..8d69b9134bef 100644
> >> --- a/include/dt-bindings/clock/aspeed-clock.h
> >> +++ b/include/dt-bindings/clock/aspeed-clock.h
> >> @@ -45,7 +45,7 @@
> >>   #define ASPEED_RESET_JTAG_MASTER   3
> >>   #define ASPEED_RESET_MIC           4
> >>   #define ASPEED_RESET_PWM           5
> >> -#define ASPEED_RESET_PCIVGA         6
> >> +#define ASPEED_RESET_PECI           6
> > =

> > You can't really be changing these as they represent an ABI.
> > =

> > Is there no PCIVGA reset?
> > =

> =

> This is a bug fixing. Previously, PCI/VGA used PECI reset bit so this
> patch corrects the reset bit for PCI/VGA from bit '10' to bit '8', and
> it adds PECI reset bit '10' here as it can't be combined with a clock
> gate bit.
> =


Presumably nobody is using the #define because it's wrong, so this is OK
for me. I'll apply to clk-next and yank it if Rob objects.
