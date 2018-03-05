Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1265376-1520245697-2-4012788760083261585
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520245696; b=reR0YVlb/r25W5A0KvoAdWilslqXlRv48+iWX27NyKL6KIk
    zkObJY0X6wc05qZdBMjEJfWt27kjfccHjt4QQIIrgkirRGA1J8sbXfn3VgdWOQT0
    WZV/UqD4ipyVVO14Ob5ISH7oMQvH1GgHiEScwN99wLCek2tvmMYfBo8YivWMI+a9
    SXoztBnQxoT9sfk+GTfgEhFSz3rJPmJNVUNJRJoZ53mAvNQQaAWBFC+myneX3nEo
    LtFo0U5I89vRKIazwGyjlVqmQdP1MMyOE621xQZhSZSQShXIHrEISQLJ/vG1zLVP
    gw51FqmeN4OmrUA0+9Fk+pFFxRuzXR+G8jasS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520245696; bh=O+Z2JcVv9flPxrPmrWMQMXGpFj
    hM8Q8HWLAS7bp1ZsE=; b=B0mdU3O82RKlQgf/joHG4sLo3S1dGcBtzcgr7rMSsK
    5E/wVjXY5eO4g1fz7BuuWwvw9YVw6g36k0GnedLxrnz4OMGvmpWjpLcybtg2zIc3
    kbKHYRmYCiSNr6CgK1S28OaflRyElPOv7btugc5DspCuJzIyaXFYMrBHhj36eNYq
    qknyHbyZjnLiKeTHyaZLImKUjO4sSf3wWP2lVEVKxQirTonOwU8iZuDuuYs4z4qW
    1watPew0ezU1u/wvx/lWIA/VQiDLNm7eSk0Iax4zhiivWToyu5AyP4zy3rk1//MJ
    cfG08f+2UyiZR4cxWrI+OfffgW9dAUSE64czr8cmNZWg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934013AbeCEK2D (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:28:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:2857 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeCEK17 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Mar 2018 05:27:59 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="35544022"
Date: Mon, 5 Mar 2018 12:27:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
Message-ID: <20180305102753.GC10598@kuha.fi.intel.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
 <20180302131315.GA10598@kuha.fi.intel.com>
 <8434f820-5016-1e5a-c3cb-5d7789dd69c1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8434f820-5016-1e5a-c3cb-5d7789dd69c1@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 09:18:10AM +0100, Andrzej Hajda wrote:
> On 02.03.2018 14:13, Heikki Krogerus wrote:
> > Hi,
> >
> > On Tue, Feb 27, 2018 at 08:11:29AM +0100, Andrzej Hajda wrote:
> >> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
> >> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
> >> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
> >> +
> >> +ccic: s2mm005@33 {
> >> +	...
> >> +	usb_con: connector {
> >> +		compatible = "usb-c-connector";
> >> +		label = "USB-C";
> > Is this child node really necessary? There will never be more then
> > one connector per CC line.
> 
> But there can be more connectors/cc-lines per IC, for example EZ-PD CCG5[1].

OK, in that case the child node is of course needed.

> [1]:
> http://www.cypress.com/products/ez-pd-ccg5-two-port-usb-type-c-and-power-delivery
> 
> >
> > We should prefer device_graph* functions over of_graph* and
> I guess you mean fwnode_graph* functions.

Yes.

> > acpi_graph* functions in the drivers so we don't have to handle the
> > same thing multiple times with separate APIs. Is it still possible if
> > there is that connector child node?
> 
> Bindings proposed here are OF bindings, I suppose the most important is
> to follow OF specification and guidelines and these bindings tries to
> follow it.
> It looks like it should not be a problem for fwnode framework to handle
> such bindings, but it is just my guess. I have not seen any fwnode*
> specification I am not sure what is the real purpose of this framework,
> but it seems to be just in-kernel abstraction for different firmware
> standards (OF, ACPI), so even if it lacks at the moment some
> functionality it should not be a barrier for OF bindings.

Sure thing.


Thanks,

-- 
heikki
