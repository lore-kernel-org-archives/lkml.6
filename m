Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133588-1524487688-2-8113083655987124950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524487687; b=mWEIIt6K0zx24WLdGrzf8N0znZwYGSrE8utUiFhOco6V/pz525
    Ce26QllXEEqbBCgY7Y5ZXq6pudHqdhs6OrsHXBA9fQWhCipk1DXYJmpVjj/Fcq9o
    A4V+8dLRKAYN42BFfzpwTtf+QgDSErFcidFiQzLB/N1/GFDtLgn4MV9UDu/xUOlL
    Dj2qacJiUFQVvRITWOi9+UFn/Kg+ELNJ0AOYeU860KEzKSEcHVEF4zvp0x2fsS2/
    SBFyuwIE1AFwNnF8QKppAxZhwSzXPuk/2c6jqOYATbzH30cz3vc3XAM8jqQNqp7N
    7oh8knOIE8NN+eUk6fIgJlfQFD3Pc8gniZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524487687; bh=T3JFjjplpZ
    AtKfCk+TjHrwGc/j6k7VtAUP6MKt/NMBg=; b=gl5AScBEiyiluvkj1n24m6IlQB
    q98uhwWgcwy1Dng7WKqrTmq4xgJUIErdF4wXBEaKtI83zDTuFHAg0YH1+FUCvofm
    sskZItpRRezK5ogMaXamki4qCZndtgTRlbGJ4YPfVzehaB55UoUIabWKEvBKoJsI
    gjCavERRHoTwopwn6ter9lTMjkeDd0EZr91Vl16/lhBXjPKu5otYVLniW/AC8kpb
    nwGboz+Ee5TdKUFSiwRp5/hoOspH3DVh6FRDMaHa/VvduXmUnDdM66gMr1HiPoi9
    mQ8EYfv52wz2JaQrvUUVl+PntgFizsZm+4tUPPpmSBBtVAhdklykm7yE7LIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnMXLVrRYbKzBIbP3KNyki9pVIBDSqzpavLDRuio8ZeNVcQOKaxe2oNhLxxMVUO22Wq6mGKoEzhuikqpZEyQe9WG8NkuD0lFm8/L9k5CmGd97O5h6kO
    LASulCg5olJ6HTpga8FfTkhNQ5oBBWbukpZi4tX5INyQb7H2yaqKgaFyp+rxNji691fBBBMFA2iHwNDNW3bdcZXGCW8/V2sTYLTXpOv476G/J6mPEE2eT/lb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8
    a=VwQbUJbxAAAA:8 a=OVYY9EAYalWlQzYOuEYA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=nlm17XC03S6CtCLSeiRr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeDWMrx convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 23 Apr 2018 08:47:53 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:16383 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754857AbeDWMrv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 08:47:51 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRWlGSWpSXmKPExsUSt3Opse7Xq3e
  jDLZ0C1o0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGU2Nn5gLtgtVT
  Fz4laWBcRFfFyMXh5DAUkaJDR/+MXUxcnKwCVhITD7xgK2LkYNDRCBDYushC5AaZoGlzBL3l/
  1hBqkRFvCW2PpzFjuILSLgI3HozT9GCDtK4te9PywgNouAqsSsry/ZQGxegQCJpoMz2CGWPWa
  W+HV9AdggTgF9icaNs8CaGQVkJb40rgaLMwuIS9x6Mh/sIAkBAYkle84zQ9iiEi8f/2OFsOUl
  tn/7zQ5h20u8vveOBeRoCaCZfY3FEGFDiVXTDrBA2OYSGz/tY4QYryOxYPcnNghbW2LZwtfME
  HcKSpyc+YRlAqP4LCRXzELSMgtJyywkLQsYWVYxWiQVZaZnlOQmZuboGhoY6BoaGuua6pqZ6y
  VW6SbppZbqJqfmlRQlAiX1EsuL9Yorc5NzUvTyUks2MQKTAAMQ7GC8eyz5EKMkB5OSKK/l+bt
  RQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4E4BJRUiwKDU9tSItMweYjmDSEhw8SiK8ESBp3uKC
  xNzizHSI1ClGRSlx3mSQhABIIqM0D64NlgIvMcpKCfMyAh0ixFOQWpSbWYIq/4pRnINRSZhXG
  2QKT2ZeCdz0V0CLmYAWd0jeAVlckoiQkmpgDN9+e40B/3n7psNakXwbyn2yFzn+/8JXGfzbI8
  j46oI23pYpszi2PtFOfOHgcLdhowzHMrkrLn2RzkHxT/sU0jUCnr3zs5ARnu9kOfmsZ9C8w6f
  PL1udmHnvG4+2UIj0rl6THz/ZPz74vPLylmtmHbIveQMkw84/6DBN0j57ZPeh7VIzlZc4K7EU
  ZyQaajEXFScCAF4I0yh8AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-239.messagelabs.com!1524487668!769655!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Topic: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Index: AQHTwo9uuL+EwiEdW0SU7JmHmFIfzqQM7/QAgACCyOCAALalgP//+gEAgAA8CHD///cOAIAAJY2w
Date: Mon, 23 Apr 2018 12:47:47 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E6D83@SW-EX-MBX01.diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180422140508.GA21446@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6B41@SW-EX-MBX01.diasemi.com>
 <20180423082528.GA20868@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6D67@SW-EX-MBX01.diasemi.com>
 <20180423112818.GA22932@kroah.com>
In-Reply-To: <20180423112818.GA22932@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 23/04/2018 10:24:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 April 2018 12:28, Greg Kroah-Hartman wrote:

> On Mon, Apr 23, 2018 at 11:06:25AM +0000, Adam Thomson wrote:
> > On 23 April 2018 09:25, Greg Kroah-Hartman wrote:
> >
> > > On Mon, Apr 23, 2018 at 07:49:38AM +0000, Adam Thomson wrote:
> > > > On 22 April 2018 21:58, Adam Thomson wrote:
> > > >
> > > > > On 22 April 2018 15:05, Greg Kroah-Hartman wrote:
> > > > >
> > > > > > On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> > > > > > > This commit adds code to handle requesting of PPS APDOs. Switching
> > > > > > > between standard PDOs and APDOs, and re-requesting an APDO to
> > > > > > > modify operating voltage/current will be triggered by an
> > > > > > > external call into TCPM.
> > > > > > >
> > > > > > > Signed-off-by: Adam Thomson
> <Adam.Thomson.Opensource@diasemi.com>
> > > > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > > > > ---
> > > > > > >  drivers/usb/typec/tcpm.c | 517
> > > > > > ++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > > >  include/linux/usb/pd.h   |   4 +-
> > > > > > >  include/linux/usb/tcpm.h |   1 +
> > > > > > >  3 files changed, 509 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > This patch adds build warnings to the tree, so I can't take it, sorry.
> > > > > > Please fix up and resend.
> > > > >
> > > > > No problem. Sorry for that. Will take a look and resolve the warnings.
> > > >
> > > > Sadly this is going to be a bit more than 'resolve the warnings' task now as Jun
> > > > Li's patch set has now made it in before me which means I need to rebase PDO
> > > > Selection because of his changes. :(
> > >
> > > Someone was going to have to do that, sorry :(
> >
> > Just as an FYI, this patch will produce warnings until the associated
> > power_supply interface patch (number 5 in the series previously sent) is
> > included as that makes use of the new API. Not sure how I can get around that
> > so I guess we have to wait on Sebastian to give the nod for the rest of the
> > power_supply patches before this can make it through.
> 
> That's not good.  There has to be a way to prevent a build warning from
> happening...

If we're ok with '__maybe_unused' then I can add that. Wasn't sure if something
like that would be acceptable for this scenario.
