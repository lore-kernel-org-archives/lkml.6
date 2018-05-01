Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3060808-1525175748-2-7824450814959362118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525175748; b=mhAH4nhd3ybiEHgD/lfXPbzFg8x3amBxIoN4sTE6UEPKS6oOAW
    YZDp2HZ6gy1qPcEjMKlTYdS5k0qwz/NHnDFt/s9Pd4AzxSkJApSQgs7EB51T8Qov
    1tcK6mCPzD8dCdGyE+XowToFIYaG3pVuEuLmai1sJCLh54EXFzen7BYSch2SfL97
    Sf8jm28IPtRGF6JS2G1u9c1wX+s3JXWXmZX20ZZvcrxYNGqQGf7vXJ1yMdAPgmJA
    YD/oAS47fEPcqfaQO1s0G0zR4vovvJhjNmr8WV2daVESnUUjdUqMoEm8d43OQvwg
    P1xgIcPez9egzQ0WzxdoSVBODWex2JpwkCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525175748; bh=DDvHUZRZBpJ
    +6YhXje6Ex3C4gjiYxGCQg13X3iaQ30I=; b=LM2UVmlKrjM6k7JDR6DZgHIpZlp
    KKcs35SqKqkFuseBlhn4VOU93zw0qgg6IXCBjxS9q3f3foScxI/dVKVt6G/0cDmc
    PF9o1/cZ6DnOMeCloZTs73YtKs9drTSe7ZNIDw8zk/f4HHBLIpTlhfjl5jf3Sdk5
    6yBMKxvqwC6c2jeLZDhoNdrOJXieVIgK1S4d/9zcszGk00ZHZDn+fbPABfhMpXgL
    MBsfmhmeXF9Vt8bVlR+MW6WDcnQD6hbGV+2/G82ewjSXyna4RQB9SLABK5UYp3zP
    N3TzUywTruMJ8w7/5XuYMT1zsYh0t3uXHir1OkzPPyponalrVoZtQJRGJDQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfBjJX6xDqGB6M1+Z/Cyh/qFfEW5Omy08vWauF6dQuLpmo0RnsjQ1K6/5wYcFMcjSzpSqbVGuTs15txZRbXQDbBbDyEiwgSBQqO1b7m8/eaShNQBzuFVj
    cg4XN7fU1RbupY6+kNDCMXKwg3s2OsfEEJgg13kWKEH6KaX0Eazlb0BT9SoMVa1q6GGSThCXldK7aEZz/Y3ai9eGwpU7R4Dl4ukHLUzfvxLFKsRO+21Mi/22
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=tu9t46T5kkYImYKWLEkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeEALzo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 07:55:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:31266 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeEALzn (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 1 May 2018 07:55:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="52241279"
Date: Tue, 1 May 2018 14:55:38 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH 0/3] v4.16 tpmdd backports
Message-ID: <20180501115538.GE20978@linux.intel.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
 <20180425110600.GA1996@kroah.com>
 <1524678812.4100.9.camel@HansenPartnership.com>
 <20180426174924.GD28091@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426174924.GD28091@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 07:49:24PM +0200, Greg KH wrote:
> On Wed, Apr 25, 2018 at 10:53:32AM -0700, James Bottomley wrote:
> > On Wed, 2018-04-25 at 13:06 +0200, Greg KH wrote:
> > > On Wed, Apr 25, 2018 at 01:44:20PM +0300, Jarkko Sakkinen wrote:
> > > > "tpm: add retry logic" caused merge conflicts so I picked couple of
> > > > other fixes in order to get it apply cleanly.
> > > 
> > > Are these only needed in 4.16.y?  Nothing earlier?
> > 
> > The retry one (tpm: add retry logic) could go back as far as you can,
> > but the bug it causes is rarely seen: mostly it's a failure of the
> > kernel trusted keys due to a tpm retry being interpreted as a fatal
> > error.  The number of users we have for kernel trusted keys seems to be
> > pretty small ...
> > 
> > I'd say if the backport works as is, go for it, but if we get a patch
> > apply failure, it's probably not worth trying to work out how to modify
> > the patch again until someone actually complains about the problem.
> 
> They seem to all work for 4.14.y and 4.16.y, so now queued up, thanks.
> 
> greg k-h

+1 what James said. Thank you.

/Jarkko
