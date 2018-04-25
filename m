Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-721450-1524662002-2-4692224527258429711
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
    1524662001; b=wTLdwhytRSqJlp9setCAUQcOGj4B8rXHzaZa4FrR8Qt5fbo2aY
    icKKAxsnC+BKNvMf27Aiiu1Bsj7xG/1TdP1q/nQRGOW+ZO9cUnmpGZxm+IXaD0rt
    wYRK+/FwiJE7Ey0qhpm3fP3qAdUSid5nuX/HsT6R7mh4XT/J4t1W9CZNZwmmr4VU
    3mJSEzaJ/m0/OdqCMcmB35SbIU9D56OzyhPWYKyvdYSuGeTH1Ex7ZeGgsE/aIJqt
    IWGj3mTSWR4KJXmKtg4F9ExQaXx15W7+IVRiTJEXUeLxH5xESAcu86O/229Qj/5g
    EVJB4pkVgdzNvzElEY16bJbTj6p1UQtDdYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524662001; bh=QR9Z3yE91v
    Nx77BpU/rIxqN9yl+iMfWWDSsLCI+h0tU=; b=I5ILy2gAv60I6F9lLbRsIAy5AZ
    GVHIbF72GVxfL8yROG8K47oEhhEf1IwHqMxe/ImxGZs8tkmLGkr+VNiniF6ZB9jE
    b8OPdTNNPal6IC+M/vsR/O12GofXOObwAMxlPJwk9VQ0AYsFuwTPYeQSuM2EZG9n
    vp++tX94Pr8eOEKk/eePRmNQR6E0CqeqNg+4bpH1l5lmfUs6XAK15s+QtH1JnFAB
    JodErJn37UjQacu91k+3C73jWVgM94AzBrQQqrdmsaUJ1FhKrw1m5jBPOjpqbBgu
    375b5AilQ12QTSD2JQuwYS+/iSlCIB3hI1eDMFnay/SRxNLULJrawsMlJunw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfKiIiv5FYY1WuNAYfdjjos4TuHdCr0qlQuTcQrvE5+znxKfKOJcxyk2Fk+Uer0Hww3r4+ccG2F1yExVe23BEo25F1UGRqix5W1WCTJaS9R1F1K+RBtk+
    eY/cNQfJQlQXvBU6NJDxfVptsKmCEnaUX7mtXG8QQXH8vtlP9o3YYg1xXecIoWUvCeNzsOFCsturO2XQO656GQ2jjbHsti+qXfimvfvs4TKYnrH8X8Gen0ck
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=gvl4HP8tAAAA:8 a=VwQbUJbxAAAA:8 a=Edab8mk2VOGU4iaWrVYA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=tRkgsvjveJ3YVe9fnr1q:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDYNNI convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 25 Apr 2018 09:13:08 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:31440 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751705AbeDYNNG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 09:13:06 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRWlGSWpSXmKPExsUSt3Opse79ugd
  RBt92a1k0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGet/L2QpuMNf8
  e32W+YGxh08XYxcHEICSxkl9v5uZO9i5ORgE7CQmHziARuILSIQIbF89lNmkCJmgZ3MEofWTG
  UBSQgLuEn8+rGKHaLIXWLfhYfMELabxJtPH8GaWQRUJWb/3Q5m8woESMxr3ssCse0Ao8SsQ71
  ggzgF9CX+/tkE1swoICvxpXE1mM0sIC5x68l8JhBbQkBAYsme88wQtqjEy8f/WCFseYnt336z
  Q9j2Eq/vvQOayQFk60v0NRZDhA0lVk07ABU2lzjwWAxiuo7Egt2f2CBsbYllC18zQ5wpKHFy5
  hOWCYzis5AcMQtJyywkLbOQtCxgZFnFaJlUlJmeUZKbmJmja2hgoGtoaKxrqmtoYaCXWKWbpJ
  daqpucmldSlAiU1UssL9YrrsxNzknRy0st2cQITAMMQLCDcdqhxEOMkhxMSqK805nuRwnxJeW
  nVGYkFmfEF5XmpBYfYpTh4FCS4D1b+yBKSLAoNT21Ii0zB5iQYNISHDxKIrz8wKQkxFtckJhb
  nJkOkTrFqCglzrsBpE8AJJFRmgfXBkuClxhlpYR5GYEOEeIpSC3KzSxBlX/FKM7BqCTMKw0yn
  iczrwRu+iugxUxAixMFwRaXJCKkpBoY2/qyFoqmvCxU8L5eUz0zvzF6vbBipsqT8/kzDzDKrD
  98NGPjVMF/VUWBfcoe4fKZTt/rD+tJctR4nWLVUbF9fzFnYuKZtkJL6TZPF7bDz7xn/Pud/+u
  IVVHH55SFe9zmWy4NO+GxXuliUNKEmasdvvU2G9gVSi7u7za4m1BWuXHy/ohX1zSVWIozEg21
  mIuKEwE+Yq8+fQMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-33.tower-246.messagelabs.com!1524661983!1451457!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
CC: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Hans de Goede" <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Thread-Topic: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Thread-Index: AQHT2wzl2BCYabkw6ke5dlhIIgGV1qQP4ZiAgACe54CAANsagIAAGy+Q
Date: Wed, 25 Apr 2018 13:13:02 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E71D5@SW-EX-MBX01.diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <20180424135749.GA21610@kroah.com>
 <20180424232633.s475bsccxjhm7lpy@earth.universe>
 <20180425123045.GA22950@kroah.com>
In-Reply-To: <20180425123045.GA22950@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 25/04/2018 12:06:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25 April 2018 13:31, Greg Kroah-Hartman wrote:

> On Wed, Apr 25, 2018 at 01:26:33AM +0200, Sebastian Reichel wrote:
> > Hi Greg,
> >
> > On Tue, Apr 24, 2018 at 03:57:49PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 23, 2018 at 03:10:55PM +0100, Adam Thomson wrote:
> > > > This patch set adds sink side support for the PPS feature introduced in the
> > > > USB PD 3.0 specification.
> > > >
> > > > The source PPS supply is represented using the Power Supply framework to
> provide
> > > > access and control APIs for dealing with it's operating voltage and current,
> > > > and switching between a standard PDO and PPS APDO operation. During
> standard PDO
> > > > operation the voltage and current is read-only, but for APDO PPS these are
> > > > writable as well to allow for control.
> > > >
> > > > It should be noted that the keepalive for PPS is not handled within TCPM. The
> > > > expectation is that the external user will be required to ensure re-requests
> > > > occur regularly to ensure PPS remains and the source does not hard reset.
> > >
> > > Sebastian, any objection from me taking this series through my USB tree?
> >
> > I currently have the power-supply bits in a local branch for
> > testing. I would like to have this in the power-supply
> > tree, since there is at least one pending driver which could
> > directly use the newly introduced usb_type.
> >
> > I can either provide an immutable branch with a signed tag, or
> > you can merged it and provide me an immutable branch.
> >
> > If you merge it via the USB tree patch 2-4 are
> >
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> 
> I've applied these to a testing branch in my usb tree, and if they
> survive the 0-day bot, I'll move them to a branch that you can pull from
> that will not change.
> 
> Oh, I had to add a follow-on patch to fix up a gcc warning that really
> wasn't a warning, but it saves us problems of people complaining about
> it.

Thanks Greg et al.
