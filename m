Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-878918-1523003452-2-17109933960356494230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523003452; b=OismCbI86z58emsuszzcnkVGtSu3xG7md6hHXnaBw3k40OO+Zu
    mrP+N3XGoLtX+QCjxwyTa9GNP0NwCtT51sUh2RylTK0WR1BzBZGGIVIMku0gvINi
    5Nli56tHp0ky5Mi4mhuLAYYLbg3PNhmji+TBA6QRR+2effFQp5sGd9RftToQ3tm5
    BCF1fPQRebxob/h4n8qs3ZwhNeU+hoS2+Fpac6G0w40a6HW5MpHNx5XR1iXXZIgC
    3tRk7djvowweIrGcLznMsechitamoXQyPIQNeoOC4eK7RtDqgcPq54ZhhSAUH1wk
    CkwBSHVEhqBR37qp9To7jgg0upvI+1eod1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523003452; bh=PYBzR9/TUGARxYnQfO6PRDaq/UCH9B
    H9I9xScKxme+I=; b=gmNhSVugavrHLu9XT4LIPrxmcdMp22BpyJ5NEY+/ucgMjQ
    /Hj4LkAxdBi9aKbL6qCRajXiN1DIyVSt3fOiU74uXzLvtMzxa+0DOqkquqggs8Ob
    Hnw3tQZOvoDaCppueXkdmxt4Tg56QsmzB/RPXCuGcQ/haNV9WJnubF6ypLmITFgG
    GRVflKeW6ERuy8WZZu3XFC54dbnT6qMNIe9fj7Nls2xCueeAVwjuSFuOg3bKHq7m
    UGKrsZRyrfkvWlImXxbruL8IlFHONdGeoP0semheR5oG/fLu9HtPIhhsCK9AIxCC
    ZIb6KJyxNKzI/opC58MQ7AI/4mFXaFsFcqF928eg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHbvlvxyu42A/B13yD7Y9vQk8JGMsPzd9VIryKdyBQQEcV+YNg/O3CIlkgmsNaAdtThy8F7EJuju3lwc9ubpeLwxbKtoY/Ue7X93NbtHImICVkyYnn1H
    /di7KLkQSGggpY6wxovsUzMaW6rlmyphX6UQ8F2QA4cJ9m0YbebwFcFz6Jl4G388aJhv3oiNxsgetxYSeMFMEXPSjG8awtQuYUoDceeY/RMxMjQzQXhyBnCa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=GiJKl23CWzlfLmA0l5gA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeDFIaN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 04:30:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeDFIaM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 6 Apr 2018 04:30:12 -0400
Date: Fri, 6 Apr 2018 10:30:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-doc <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org
Subject: Re: make xmldocs failed with error after 4.17 merge period
Message-ID: <20180406083010.GA20174@kroah.com>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
 <20180406075109.GA21589@kuha.fi.intel.com>
 <20180406075734.GA16728@kroah.com>
 <20180406081555.GB21589@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406081555.GB21589@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 11:15:55AM +0300, Heikki Krogerus wrote:
> On Fri, Apr 06, 2018 at 09:57:34AM +0200, Greg KH wrote:
> > On Fri, Apr 06, 2018 at 10:51:09AM +0300, Heikki Krogerus wrote:
> > > On Fri, Apr 06, 2018 at 12:38:42PM +0900, Masanari Iida wrote:
> > > > After merge following patch during 4.17 merger period,
> > > > make xmldocs start to fail with error.
> > > > 
> > > >  [bdecb33af34f79cbfbb656661210f77c8b8b5b5f]
> > > > usb: typec: API for controlling USB Type-C Multiplexers
> > > > 
> > > > Error messages.
> > > > reST markup error:
> > > > /home/iida/Repo/linux-2.6/Documentation/driver-api/usb/typec.rst:215:
> > > > (SEVERE/4) Unexpected section title or transition.
> > > > 
> > > > ------------------------
> > > > Documentation/Makefile:93: recipe for target 'xmldocs' failed
> > > > make[1]: *** [xmldocs] Error 1
> > > > Makefile:1527: recipe for target 'xmldocs' failed
> > > > make: *** [xmldocs] Error 2
> > > > 
> > > > $
> > > > 
> > > > An ascii graphic in typec.rst cause the error.
> > > 
> > > Thanks for the report. I'm going to propose that we fix this by
> > > marking the ascii art as comment:
> > > 
> > > diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
> > > index feb31946490b..972c11bf4141 100644
> > > --- a/Documentation/driver-api/usb/typec.rst
> > > +++ b/Documentation/driver-api/usb/typec.rst
> > > @@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.
> > > 
> > >  Illustration of the muxes behind a connector that supports an alternate mode:
> > > 
> > > -                     ------------------------
> > > +..                   ------------------------
> > >                       |       Connector      |
> > >                       ------------------------
> > >                              |         |
> > > 
> > > I hope that works.
> > 
> > Try it and see!  :)
> 
> It will fix this issue. I was just wondering if use of ascii art is
> acceptable in general with the .rst files? But then again, why
> wouldn't it be.

There are ways to do this, look at how the v4l2 and I think the drm
subsystems handle ascii art such that "real" drawings end up being
produced.

thanks,

greg k-h
