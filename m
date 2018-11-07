Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673DDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FF420817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FF420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeKGWFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:05:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:34533 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeKGWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:05:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 04:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="106039861"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2018 04:35:20 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 07 Nov 2018 14:35:19 +0200
Date:   Wed, 7 Nov 2018 14:35:19 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Message-ID: <20181107123519.GH13048@kuha.fi.intel.com>
References: <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com>
 <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
 <20181106144037.GD13048@kuha.fi.intel.com>
 <20181106145537.GB10650@smile.fi.intel.com>
 <20181106150503.GE13048@kuha.fi.intel.com>
 <20181106155347.GC10650@smile.fi.intel.com>
 <CAL_JsqLdEciRtssX+x8TRmPX6QzZtNyMX9MrT9=J0DhhewFMZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLdEciRtssX+x8TRmPX6QzZtNyMX9MrT9=J0DhhewFMZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:13:30PM -0600, Rob Herring wrote:
> On Tue, Nov 6, 2018 at 9:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Nov 06, 2018 at 05:05:03PM +0200, Heikki Krogerus wrote:
> >
> > > Maybe it would be best to just read the "name" device property in
> > > fwnode_name() and not have of_fwnode_name at all.
> >
> > If it's a mandatory property or somehow its presence is guaranteed, it would work.
> 
> It is currently, but after removing the name ptr, my current plan is
> to remove the 'name' property too for FDT. On real OpenFirmware, it is
> a real property so it will remain for sure in some cases.

OK. I think we'll use the full_name after all.

thanks,

-- 
heikki
