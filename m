Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-784116-1523001470-2-1237140717290702970
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
    1523001470; b=hpU9W5iTIFTILrGaZGqk1JecxJN+dmj472cH88nrIm8R5b5hnr
    nphrBYn1fPNvkWwKxVZ3/YPq/RzUWZziTwwwvlDfMNUYiaw8cX0MAUTyCYxLQcXi
    pjntZY4NMfU6GXUpufrqDFt10panJALTZ/KSXauYPtc2d8/tzbbPBMEJhCrLDY0V
    V1M6CE56nqsOZ2u1kzKdrhi8vkCIzkP9NqWhUkC1Y7YHWUW2KYI8t8UX0sve4LRX
    J0B9kcCAEV4LNbGwz4Z7l5fP5BqZWIw30OwlVYWxzJSvcs0Zhj2QgOr+B6CPVskZ
    HINT8KMkCoXYqk6IkgL2fEJt9kRT+zIdORaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523001470; bh=YjBp9tqn+L3w9mWsM0NkvsNQ8z7j2B
    +Jwox38I26KRI=; b=T1O6c7q72w03/hzlgnyvmHdWgTalBRaYRsrqBfnW6DBFlq
    eznZUkdjiGli90Qg8/h9csTp8zCOhfVmz91LGdpyjfwCCnaE0FyAVfkc7Fy/fkMK
    WEVm0q5JIY7XEAvT5Hw4x6VIeb6n+Spuoe4iBuzBYN/gDyDsMaIWwxDQyqmWJuf9
    KKt+8zLM8q9N7bJwsJBHR3JjHndMQpjOZDpe6Btj4o0waBdl5t94ds3+DEJ4z83C
    EHWZZ7b/jnAWumtVc2QgmITC8N+7HdbajvlXIQOGcOv6Eb0ENwZ5RFvB/qZXNRmR
    NNY/fLBAOKwVEHwCSAqS+iEQJ+i7FAvjdN14PK4w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfB6G0Jy+yigQKERMmyNlN1++MBzTlbQ8jZcHmUcCOe3oBjh4XlLez3YZag8k6T4ZLtYy0vpFOSys+YmcrlRT8VPS/7ciqZkBqpw7+LPSpQBefJSLUt1n
    NsfmV98cKP8qgAPHVmMbn5pVAxbEyz6LsqNPNGcfj4bOso59Jnq/Z5dPlyBjFQ8aaRjbjDCySuFsAf6s8+Sl09h9TVn1nt9NIHOe+0EZpDZ1juPyUCzkjOc6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dhXjJaTu3RinuNEX5XAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeDFH5g (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 03:57:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeDFH5f (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 6 Apr 2018 03:57:35 -0400
Date: Fri, 6 Apr 2018 09:57:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-doc <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org
Subject: Re: make xmldocs failed with error after 4.17 merge period
Message-ID: <20180406075734.GA16728@kroah.com>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
 <20180406075109.GA21589@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406075109.GA21589@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 10:51:09AM +0300, Heikki Krogerus wrote:
> On Fri, Apr 06, 2018 at 12:38:42PM +0900, Masanari Iida wrote:
> > After merge following patch during 4.17 merger period,
> > make xmldocs start to fail with error.
> > 
> >  [bdecb33af34f79cbfbb656661210f77c8b8b5b5f]
> > usb: typec: API for controlling USB Type-C Multiplexers
> > 
> > Error messages.
> > reST markup error:
> > /home/iida/Repo/linux-2.6/Documentation/driver-api/usb/typec.rst:215:
> > (SEVERE/4) Unexpected section title or transition.
> > 
> > ------------------------
> > Documentation/Makefile:93: recipe for target 'xmldocs' failed
> > make[1]: *** [xmldocs] Error 1
> > Makefile:1527: recipe for target 'xmldocs' failed
> > make: *** [xmldocs] Error 2
> > 
> > $
> > 
> > An ascii graphic in typec.rst cause the error.
> 
> Thanks for the report. I'm going to propose that we fix this by
> marking the ascii art as comment:
> 
> diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
> index feb31946490b..972c11bf4141 100644
> --- a/Documentation/driver-api/usb/typec.rst
> +++ b/Documentation/driver-api/usb/typec.rst
> @@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.
> 
>  Illustration of the muxes behind a connector that supports an alternate mode:
> 
> -                     ------------------------
> +..                   ------------------------
>                       |       Connector      |
>                       ------------------------
>                              |         |
> 
> I hope that works.

Try it and see!  :)
