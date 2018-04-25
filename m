Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1044611-1524678819-2-3804711770674244983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524678818; b=KTvnQK3UiH/IiyePNJFe9EX/c9nYppB4fhIrekfXp6vDawEzw8
    u6P880RaFVaXz7yOD9She+JMGtvW+CfWE6XChl1mRn8sVVxCdokb2g472Whyicxo
    KFaO3rPdtWKp619gTk0qwvik2Fyfkh+UaC/pvuocXlf3KsU2zCyDpMau8H1yUo3N
    jgmsQp1iVfCzR00GsIgwyAukhSP9CX7fg+7CGpAuEdvXxsWQXVzdHslDGR/Uqr93
    6C3HFRB0pptJUy+7hqQ9foHkFsJfkaG29+sCBa/8VkpQK0R5ezDDGc38BRUf5O54
    237BB3dzd6FbgPY/fh7B/FpUuS391JHopOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524678818;
    bh=IinZQ4RYNO6Kzaq/qXGbjScYGJlg0CF7RsdIsFs/2Wg=; b=Fb8JGqN6dsgm
    3LCjPU2qLUrpJQwuu4jF7DiooACkEZkD+Ung3EiZHg8nYyVT0RGPQ22oa0KC1T7y
    ypk2+g6yA7Q9r/OjnDVbCHq+Whq2gqvpq8iA7M/Hzj41d83ASF3cBk8hLNq+5vlQ
    pux+SXfVMham7GAoDOOby70euypstd1Rg4g7Nqb3qaT+uBBIfxVlycarVQGS6IAb
    DYw+TRvi5e5tdHLGERJ2HnP5dZJ2P8DyFPLBJjTKEdLtBciCDmOVKmEfGU79KsSX
    TOqRFMPkEF093G5h0XD3OyLyFfoae+I28nPsyPPSMKeDtoe2rZhsxB3DoJry/PbJ
    BD1WFO+oyA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=d/pjdpt2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=hansenpartnership.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hansenpartnership.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=d/pjdpt2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=hansenpartnership.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hansenpartnership.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC9aj2lSumMoxNBYt59iMM0780rMcVmD8AxwSHWQZKrF0QwEz5XVWT0jRFWmHx8s/4/4rnmEFF+FeFo2EuIAIc7zhsJeDtS+SBCS4XTsKbOYgUAoWm7Y
    zUkyt1gHY62WXUMN8WH8YLD6akeUq9OBbQk4zYzLV9WeagaPqM2VHIcnksTN++Rxpko4Jz5zUOThM7uMLyk5Yxb+VLHBK7usZbCTZGQwdv4KxvbgCiu4KyJu
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=wWTLrero8pnTmabqmoMA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755910AbeDYRxf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 13:53:35 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42020 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755899AbeDYRxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 13:53:35 -0400
Message-ID: <1524678812.4100.9.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/3] v4.16 tpmdd backports
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Date: Wed, 25 Apr 2018 10:53:32 -0700
In-Reply-To: <20180425110600.GA1996@kroah.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
         <20180425110600.GA1996@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-25 at 13:06 +0200, Greg KH wrote:
> On Wed, Apr 25, 2018 at 01:44:20PM +0300, Jarkko Sakkinen wrote:
> > "tpm: add retry logic" caused merge conflicts so I picked couple of
> > other fixes in order to get it apply cleanly.
> 
> Are these only needed in 4.16.y?  Nothing earlier?

The retry one (tpm: add retry logic) could go back as far as you can,
but the bug it causes is rarely seen: mostly it's a failure of the
kernel trusted keys due to a tpm retry being interpreted as a fatal
error.  The number of users we have for kernel trusted keys seems to be
pretty small ...

I'd say if the backport works as is, go for it, but if we get a patch
apply failure, it's probably not worth trying to work out how to modify
the patch again until someone actually complains about the problem.

James
