Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1313496-1527142145-2-4058835226274305882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527142145; b=GuQpgsHEgGUJqTep+JKsS6iDdk02gjyOQAcpMD6h0qTSeepM5D
    wRIYfP9jYWNZEh1VAvYI+AyLdPekTMwKHek/WAw0hCzVr1v0LDxLqEE9jKUCPw3d
    02tcxksYFKSkmjO7R3kFCTOrFapQ9VTih78x+/nAHw7jYhcL53tfQXdYUjbDXosx
    y0TRgLbgy2BuQqlmwIyF/Ni/AS/869J0GAxbVtwc9B7d0uETRD1WfoPm8iBmXuEH
    hnibbMm5aGcqdruyjxp85LefCQded0iZUSpaK5Pz0bG9xvt5ChIcm3JPlop+jLHG
    KLk8d/92lvuE2YvDFBTYVDf8E2s/3+z5zN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527142145; bh=5C06f7ndEpXjLQkluvqgbjOp7eztN7
    +HvwOtZhresjQ=; b=O5CipxLDkvxhvmLTRgD/cbDEeTQcjw4KRxAeZ7i4pLEApl
    ap7YBf2ihy6V13RoqUbQxd79NJgdhGCagWKamrEujYinnO8KfQqsFxrHULMDCGM3
    rx0qxOkZqhV3diCVmRMLqa16TjjWi5mTiS6mz42/pf0z76XpkCgf0hbRA1wFXjBs
    dQD90+SgbFhym3NLghK1ZK+mwFa2fQoAVS1qZfora/5GzfQz9+EV8CSdz/z3bfMP
    A4a43+Ssv9nQipRp8az6CsP3b2avaC7vDkpV/Vii3T3oIy/i+pkk6zSOKydEUOAX
    in/eIoXhNQb6gPtsJWUo2DHUS3G7GwOi1Qqmu16Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNfkhaFWymdpYfShoSEp98zz6QdBforeLpFeBKfoT6VtvcohbW1HKaZVU/LTrYre6pqROxaB3EJIA5611gxdgdfuKlhs9bew0aSilaCZzVQpkDkGFjDZ
    fTE0Kx6LGOx5mX/Nm4lL3ctEWwf+Ys1JLZRfOf6wJgTqIKXZGS3kjHhrOIp27XrF2XGJUn5oHQGfnAHbDWT7NzeqqkocOawOngPdW/nNyPlzEPJ6Ca0TSW9W
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=swf3fw8LVao0taxj4wcA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964823AbeEXGI6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 02:08:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:58957 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935526AbeEXGI4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 24 May 2018 02:08:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="58044533"
Date: Thu, 24 May 2018 09:08:52 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: roles: intel_xhci: Always allow user control
Message-ID: <20180524060852.GB29600@kuha.fi.intel.com>
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
 <20180523143758.66348-2-heikki.krogerus@linux.intel.com>
 <bb07759b-44c7-33bb-fff8-18910667d4a0@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb07759b-44c7-33bb-fff8-18910667d4a0@cogentembedded.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 07:10:58PM +0300, Sergei Shtylyov wrote:
> On 05/23/2018 05:37 PM, Heikki Krogerus wrote:
> 
> > Trying to determine the USB port type with this mux is very
> > difficult. To simplify the situation, always allowing user
> 
>    s/allowing/allow/? Else the statement doesn't parse for me. :-)

Thanks, I'll fix that, and the other patch too.


Cheers,

-- 
heikki
