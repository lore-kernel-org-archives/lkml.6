Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E770C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93FF2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93FF2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJPWhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:37:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:8924 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeJPWhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:37:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 07:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="99673630"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 16 Oct 2018 07:46:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Oct 2018 17:46:22 +0300
Date:   Tue, 16 Oct 2018 17:46:22 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Message-ID: <20181016144622.GG24771@kuha.fi.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <CAHp75VcWu_6jco6k5to1x1QNG8Ad893J81TPpTbJkLcqw=RR=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcWu_6jco6k5to1x1QNG8Ad893J81TPpTbJkLcqw=RR=g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:35:50PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 12, 2018 at 2:41 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi guys,
> >
> > To continue the discussion started by Dmitry [1], this is my proposal
> > that I mentioned in my last mail. In short, the idea is that instead
> > of trying to extend the support for the currently used struct
> > property_set, I'm proposing that we introduce a completely new,
> > independent type of fwnode, and replace the struct property_set with
> > it. I'm calling the type "software node" here.
> >
> > The reason for a complete separation of the software nodes from the
> > generic property handling code is the need to be able to create the
> > nodes independently from the devices that they are bind to.
> >
> > The way this works is that every node that is created will have a
> > kobject registered. That will take care the ref counting for us, and
> > also allow us to for example display the properties in sysfs.
> >
> > There are a few more details in patch 3/5 about the software nodes in
> > the commit message.
> >
> > [1] https://lkml.org/lkml/2018/9/17/1067
> 
> In private discussion I brought a concern that we exposed properties
> as a part of ABI, but at the same time we have not strict rules which
> might lead to ambiguous reading, e.g. there is no type exported and
> thus no possibility to tell what kind of property it is.
> 
> Examples:
> 1. 0x1 and 0x1 ??? are they of the same type?
> 2. 0x1 ??? is it an array or single value?
> 3. 0x12345678 ??? is it string or hex?
> 4. 25 ??? is it hex or decimal?
> 
> Until these will not be solved, better to not to expose properties to userspace.

I agree. I'll drop that part from my final version.


Thanks Andy,

-- 
heikki
