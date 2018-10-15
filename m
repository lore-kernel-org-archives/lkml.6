Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC05BC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2709208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2709208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOXfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:35:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:61101 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJOXfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:35:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 08:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,385,1534834800"; 
   d="scan'208";a="271484375"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2018 08:49:24 -0700
Message-ID: <c89ff15144f0c24187f82db088622d6c8aebd7d7.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] Documentation: intel_pstate: Add base_frequency
 information
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, devel@acpica.org,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>
Date:   Mon, 15 Oct 2018 08:49:24 -0700
In-Reply-To: <CAJZ5v0iXOtcNSqPU7NYwG=S_JCdoTFzLRD1qZocWMnFnVJ-oMQ@mail.gmail.com>
References: <20181012164400.3479-1-srinivas.pandruvada@linux.intel.com>
         <20181012164400.3479-4-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0iXOtcNSqPU7NYwG=S_JCdoTFzLRD1qZocWMnFnVJ-oMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 10:53 +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 12, 2018 at 6:44 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > Updated documentation to explain base_frequency attribute.
> > 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  Documentation/admin-guide/pm/intel_pstate.rst | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/pm/intel_pstate.rst
> > b/Documentation/admin-guide/pm/intel_pstate.rst
> > index 8f1d3de449b5..14a5505e073e 100644
> > --- a/Documentation/admin-guide/pm/intel_pstate.rst
> > +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> > @@ -465,6 +465,10 @@ Next, the following policy attributes have
> > special meaning if
> >         policy for the time interval between the last two
> > invocations of the
> >         driver's utilization update callback by the CPU scheduler
> > for that CPU.
> > 
> > +``base_frequency``
> > +       When present, shows the base frequency of the CPU. Any
> > frequency above
> > +       this will be in the turbo frequency range.
> > +
> 
> This isn't entirely correct, because base_frequency is not present in
> the passive mode (and it is not present for the other drivers for
> that
> matter).
That's why it said, "when present". This keeps door open to add to
other modes too in future if needed.

Thanks,
Srinivas

> 
> >  The meaning of these attributes in the `passive mode <Passive
> > Mode_>`_ is the
> >  same as for other scaling drivers.
> 
> Instead, I would say:
> 
> "One more policy attribute is present if the `HWP feature is enabled
> in the processor <Active Mode With HWP_>`_:"
> 
> here and I would add the description of the attribute below.
> 
> Thanks,
> Rafael

