Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C530BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD020862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDD020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbeKFSJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:09:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:7144 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFSJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:09:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 00:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="105652286"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2018 00:45:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 Nov 2018 10:45:42 +0200
Date:   Tue, 6 Nov 2018 10:45:42 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Message-ID: <20181106084542.GA13048@kuha.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:50:02PM -0600, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Instead of always being forced to read the "name" property
> > in fwnode_name() with of_nodes, implementing the fwnode
> > operation meant for getting the node name.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/property.c | 6 ++++++
> 
> Please Cc the DT list for DT changes.

OK.

> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index f46828e3b082..ac7b0b6c2d4d 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -823,6 +823,11 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> >         of_node_put(to_of_node(fwnode));
> >  }
> >
> > +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> > +{
> > +       return to_of_node(fwnode)->name;
> 
> I'm trying to get rid of the DT name ptr, so please don't add one. You
> can use of_node_full_name() here instead if "<name>@<unit-address>"
> instead of <name> is fine. Otherwise, you've got to allocate your own
> storage and use "%pOFn" printf specifier.

OK, I'll use of_node_full_name().

thanks,

-- 
heikki
