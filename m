Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3069381-1519657376-2-5989902900771878703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519657375; b=BQ6Go9R7fS+vEoYmF2ZY0Kosjst1rtSoRC/sz4NggZO41lZ
    JlZSzVMXMi5P8ldhbLpW6UFFR+3akCbEQxnS5ijbo6r+TZMZ3XXqjeG3xguGeVDt
    ixrMe9D0BFy9SF90LWYocYCTU2/FRlV9h5wWCxjuwkNNsWi4OvkNzXZ02dVL134M
    lhAXUcMEVyYFCtJJYAxWKdCaKPHsepsYZTwnCBEOpEyXPtvM+7AprdqNcpeGqvtb
    IJO2p3WTJfP5GZpudSH+H1N41VR51Qw3LLO1GSMrxE9mU5AL+Jg9gXKxph6ilXUV
    YTOT2xZXw/VB9RXYrE0NM7hbkrTQ22YgDf0/Fcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519657375; bh=mDTFLdT6MrcVBWysE/6fQk0x7k27kGnEZv1K54Jc/iI=; b=d
    j3LPvaam78K9en4rnMagTZZxcLrwYojuGCtoNdlUHx3sW8LHcYP4CeUV0SIOI8Av
    dAEiQuZbXkYhVrfonlGD+iuHMYShZOZ1g0nmw2f1MdWdpt+Pvh95q0/VaSzfSTDL
    7mELn5UwVNizHpbHwMtGXnnILZkT8+d36wwV+3eD0TEk4vfEbkMdwcnUv7r+dl+V
    3e19Ee58BWxJ6oynGj4vpjJb/V8zJgfWIkVULt7oH5BJez1AxZYnw/jqiyKyHHlU
    ZU91qIo1yYOw0E+4vziDSpI2r4JJfRtItBiciuC/B34y4d1MRLZ+04pb90g8A5Up
    R9wFCznyl+NqT7kGnGJCA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeBZPCt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 10:02:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:59797 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753387AbeBZPCt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 10:02:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="207059834"
Message-ID: <1519657365.10722.187.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
        ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date: Mon, 26 Feb 2018 17:02:45 +0200
In-Reply-To: <22270a6a-44fb-d2ad-d6d3-3d301bdde26e@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
         <1519407117.10722.124.camel@linux.intel.com>
         <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
         <1519638828.10722.153.camel@linux.intel.com>
         <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
         <1519644517.10722.179.camel@linux.intel.com>
         <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
         <1519647669.10722.184.camel@linux.intel.com>
         <1519648063.10722.185.camel@linux.intel.com>
         <22270a6a-44fb-d2ad-d6d3-3d301bdde26e@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-26 at 13:15 +0000, John Garry wrote:
> On 26/02/2018 12:27, Andy Shevchenko wrote:
> > On Mon, 2018-02-26 at 14:21 +0200, Andy Shevchenko wrote:
> > > On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:
> > 
> > 
> > > >    Device (LPC0.CON0) {
> > > >      Name (_HID, "HISI1031")
> > > >      // Name (_CID, "PNP0501") // cannot support PNP
> > 
> > 
> > One more question. What is the problem with this CID? Do you have a
> > race
> > condition in enumeration?
> > 
> 
> Hi Andy,
> 
> Not sure if race condition exactly. I tried enabling this CID and a
> pnp 
> device is created in pnpacpi_add_device_handler(), while we have
> already 
> marked the corresponding acpi_device to skip enumeration in ACPI scan 
> handler (by flagging it as a serial bus slave).

Is that code already in upstream?

If no, please, Cc next version to me and possible Mika.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
