Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1272C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9435020645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbeLQMPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:15:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:3761 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbeLQMPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:15:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 04:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="130601358"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 17 Dec 2018 04:15:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Dec 2018 14:15:18 +0200
Date:   Mon, 17 Dec 2018 14:15:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/3] of/property: Add of_fwnode_name()
Message-ID: <20181217121518.GB14121@kuha.fi.intel.com>
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
 <20181211131451.52832-4-heikki.krogerus@linux.intel.com>
 <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
 <CAL_JsqLn3dbt-8Hjoja5AJip7FxLoWLAh0Cuk1eqE3Z8RiaO1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLn3dbt-8Hjoja5AJip7FxLoWLAh0Cuk1eqE3Z8RiaO1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:46:02AM -0600, Rob Herring wrote:
> On Fri, Dec 14, 2018 at 3:36 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Dec 11, 2018 at 2:15 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > This implements get_name fwnode op for DT.
> > >
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > Rob, any objections here?
> 
> Yes, what I said in v5.

I did address your comment in v5? The helper no longer tries to read
"name" property if the callback fails.

> At one point this series had a user which was finding a matching node
> by name. Now there is no user, so I can't really say whether this API
> makes sense or not.

That is a fair point. I choose to not to convert
fwnode_get_named_child_node() to use this helper because it would mean
we would have to allocate the buffer there, and I don't know if it's
worth it.

Let's forget about this for now. I was planning to use this helper for
matching a requested remote-endpoint (graph) device, but I'm not sure
if the node name is usable there.

I'll resend these as part of a real user for the API, if I ever have
one.


thanks,

-- 
heikki
