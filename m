Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-371457-1526678949-2-689446145561413468
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
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
    1526678949; b=gJUc2UPJC9Cv54ONPdSQfipKA8DnsVNd4J2QppciZ9xSgvsI3R
    2MKz1AMIu4Cmux9d5YNtjAb+am+/0B2ypqqVjXZkooc7lB7e5dL6QKO3YqiA4v5/
    qtECmPjMmGtjvtXkwTXhV043QxWPQDgv4wQcJgsr5WqEM4lBx7UMnheJBeL9OIxg
    YjVNYys8u//Rd2XvFX0es6FdHUHssMmwEcJHUj8YT2uhJxJfBYNeQRUtJhNPlKOq
    +YQ5Q0gZ1TJwbJRfM1H0xQfQr/nobQ9UQCFvxkiKpq9JJCgYi7A+HZ9VB8zs/alr
    B+9ZLdbLR96h7/Mw6QAH+oHa/tLCOUHVDJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526678949; bh=aKoSTq170vf2TLbSUqYrI93btuF4JH
    sxIUhD7pc9O2c=; b=bOOQj72Rg6gX6IpScAck3lznASWjVqTqTvRTJKgU+FPwyZ
    hfhoKIAsECyL3MQ7wp4N6gvS9sQbZUm0O2/dRsMm6AMZuLWTkHJ8+ZAq6NCq0o7U
    HTv2gG9KwCrS6eXeYTXqQiE44cELGqnDYvGdf14FA0fwpUAbeyQyHx6wYF+wfMhX
    zdKi52ncnU6j3sWIquVOMarEamTZ5PiKbU+3xwxv6U+yGAm57+8IoJpSTHXoxTiW
    gigE+vifRQW1+bDvkgi9HMz0+HnX9ICne0/Zpoy0FybLnuT8MUP2etz2PSwD9n8d
    MZD7LI4cZODKj6POdrsYX8u0qMwfz3QhTnuxlnGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNNxqEtOpv/QFCTV7/YBBJVOjl0g1WrpwmJbSUaPgieFz5K0qNYABubrbHsmUn6PRvvi/J+UEI8okryot5fdUU5mWJLY8myQmajHvmT4eH6RSGu3/IA0
    oiYocdEoitO5HsfxBwEXDReRiRs3QisVks5HRt8PKlB2FaXBiOgS4W6+8bP+7r7azO+QcsZvB6jmUnIQRMYTGJp6DLUBAYvTgHReu61Tqg8fAQa/ZnXaMD7u
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=SbiFeICAywIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=faAW8OCUbW3BSYwANREA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeERV3D (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 17:29:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:28679 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeERV3C (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 18 May 2018 17:29:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,416,1520924400";
   d="scan'208";a="56553199"
Date: Sat, 19 May 2018 00:28:57 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:"
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9360/9370
Message-ID: <20180518212857.GA21732@kuha.fi.intel.com>
References: <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
 <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
 <20180517085930.GD11469@kuha.fi.intel.com>
 <40707f34-e0a6-3114-36a3-6603bdcd8d82@molgen.mpg.de>
 <20180518104000.GA13595@kuha.fi.intel.com>
 <20180518150823.GA14756@kuha.fi.intel.com>
 <20180518151543.GA6501@kroah.com>
 <CAJZ5v0hbpgvvmvCvxEVGed8VcOXoO1TTEXK9zsXxCGP4wLqrZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hbpgvvmvCvxEVGed8VcOXoO1TTEXK9zsXxCGP4wLqrZA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 10:04:02PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 18, 2018 at 5:15 PM, Greg Kroah-Hartman
> > Given that Windows works with this same set of ACPI tables, perhaps the
> > requirement isn't that this memory location be uncached?
> >
> > We shouldn't have to fix up ACPI tables just for Linux, we've been down
> > that path before :(
> 
> Yes, pretty much.

That's not what I'm suggesting. AFAIK these Dell laptops are the only
ones with this problem, so if we accept this, I fear it means we have
to start maintaining DMI quirk table in the driver, and then:

if (dell)
        ioremap_cache()
else
        ioremap_nocache()

I was really hoping we could avoid that. Or is there something else we
can do in the driver?

I have no idea how the windows driver works, so I will double check
and test this next week, but our driver has really worked fine so far.


Thanks,

-- 
heikki
