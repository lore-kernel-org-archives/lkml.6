Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081717-1527020322-2-8409104707958422027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527020321; b=EjjCwC8kPHHdaUe0ZrAzpe/04J45uivT2Zs4CfL3PtRZy4CE9c
    fhWpLJtWP6xKxmASAlrXaFWJ7FcwKr9GBMnwi4UJHuOGi26pTwS+pt3Wr3nDsDzD
    V/cQ2rLZwY5v8QpGN94/MVZ3SxqSPph03DtI8C6+9lt8Iui85z/ZIEPvAQjr7w7I
    XGIi/bN9PoLzu2fwHvMU1j6pfuTzFGUHQ7wAbQnczZPtk7dLvsAPkuGILEkERYd3
    O1X5bVub7ywwH3KD9iJF3oMOihaUN+hB4cMe6tFgrPWBgsBDPEct7BIqIZTGpddF
    NJtmHGUK7lxC4RdToT9w/uiU5091mSExyCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527020321; bh=ZW0Openov1WsEW2y/Xxe5F0dAl9a5a
    OTan13zjXzZUA=; b=WrnFbmiU+U0ONFB20YBWEBmwjuAP69OsLlww2a1jV+aYq+
    hH02lzI2xLj/z3M3YkInDQuSIORBzgAai3nBkbtOQWS1ADiaLUnD6cC+wbaVlg3L
    TD7VftVYBf2ieB8x5YSj5qwfI+0tHgPfU39y9QGrP/e+9yl9khfukYMUNs7VG5Kp
    fLJdBEOAMVLf5AAdjDgRRwc0Hq+YHDSqiBoISYqUzIiJoIjeu7pzc2Fqb7BSxlDd
    bReKEhqwNGKNEG8BJfl/2BNhnzdF6u/8SGkANe1037NUBu4aSoa/96/jO2/oph/W
    jSyNO+vuLyoaMyWVzcBZTJx9NMiD6uz5Lpl+R9pg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=RElb3uT5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=RElb3uT5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGsMJKTMaKn6ZBsuuNC4oxwxuHw64LUdXeaJw+i6L2jgkAI9BJOn1dJhCEPj0NW2vYqzH0Lzrh0CzCfGS9me8N4aMsrwcVlnANi0wnsb8zkBOYO3V52q
    FgIE+n+Zt1I6vUAYMeAEhU/QRVcaUiMUu7uT8OL5A4WOUhT/FBTpVTjMnTqgnVJ5FztdQ7A2eqkcOAaO9+eZRbPaobKT7wUh1UbhWdfo/jIdxAI2G6nY+69V
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=9MCFatSrEyx-oVUv0vwA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeEVUSj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:18:39 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:42209 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeEVUSh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 16:18:37 -0400
X-Google-Smtp-Source: AB8JxZqfPQM63j0lC9i4Khw+AWOafc5HqH7n5sFyx/NZ4QLfLiqv30zv0ZEeJpNPx8dVb4Xall4nMg==
Date: Tue, 22 May 2018 15:18:35 -0500
From: Rob Herring <robh@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, mark.rutland@arm.com,
        jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, araza@nvidia.com,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
Message-ID: <20180522201835.GA24611@rob-hp-laptop>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-3-mperttunen@nvidia.com>
 <3ddaafbd-d8cb-3cca-be4e-8c5c53fd9734@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddaafbd-d8cb-3cca-be4e-8c5c53fd9734@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 04:15:09PM +0100, Jon Hunter wrote:
> 
> On 08/05/18 12:43, Mikko Perttunen wrote:
> > Add bindings for the Tegra Combined UART device used to talk to the
> > UART console on Tegra194 systems.
> > 
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > new file mode 100644
> > index 000000000000..86763bc5d74f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > @@ -0,0 +1,35 @@
> > +NVIDIA Tegra Combined UART (TCU)
> > +
> > +The TCU is a system for sharing a hardware UART instance among multiple
> > +systems withing the Tegra SoC. It is implemented through a mailbox-
> > +based protocol where each "virtual UART" has a pair of mailboxes, one
> > +for transmitting and one for receiving, that is used to communicate
> > +with the hardware implementing the TCU.
> > +
> > +Required properties:
> > +- name : Should be tcu
> > +- compatible
> > +    Array of strings
> > +    One of:
> > +    - "nvidia,tegra194-tcu"
> 
> Nit. We should say what device the above compatibility is applicable for ...
> 
>     - "nvidia,tegra194-tcu": for Tegra194

Yeah, everyone seems to do that, but I find it to be redundant.

Rob
