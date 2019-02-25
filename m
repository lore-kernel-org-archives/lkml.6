Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91680C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEEB21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfBYNdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:33:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:37478 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfBYNdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:33:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 05:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="136106726"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Feb 2019 05:33:36 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 058FA300309; Mon, 25 Feb 2019 05:33:36 -0800 (PST)
Date:   Mon, 25 Feb 2019 05:33:35 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190225133335.GM16922@tassilo.jf.intel.com>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
 <20190225125615.GI19795@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225125615.GI19795@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:56:15PM +0100, Jiri Olsa wrote:
> On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:
> 
> SNIP
> 
> > +static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
> > +{
> > +	struct res_sample *r;
> > +	int j;
> > +
> > +	if (!he->res_samples) {
> > +		he->res_samples = calloc(sizeof(struct res_sample),
> > +					symbol_conf.res_sample);
> > +		if (!he->res_samples)
> > +			return;
> > +	}
> > +	if (he->num_res < symbol_conf.res_sample) {
> > +		j = he->num_res++;
> > +	} else {
> > +		j = random_max(++he->num_res + 1);
> 
> will he->num_res keep raising all the time?

Yes, but the display code limits it to symbol_conf.res_samples

That was intentional so that we can keep track of the total
number of samples. Plan was to eventually display it somewhere
so that the users know how many of the samples are covered
(currently it is not though) 

-Andi
