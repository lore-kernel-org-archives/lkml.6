Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE26C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3242B2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfAVArR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:47:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:51129 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAVArR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:47:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 16:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,504,1539673200"; 
   d="scan'208";a="116368833"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.37])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jan 2019 16:47:15 -0800
Date:   Tue, 22 Jan 2019 08:46:47 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
Message-ID: <20190122004647.GA6575@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190122002615.GB5855@richard>
 <CAPcyv4jXS-doCdyTrcV3DL63N-q4m1H2=Msgm1z88HnF8bcEig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jXS-doCdyTrcV3DL63N-q4m1H2=Msgm1z88HnF8bcEig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:29:08PM -0800, Dan Williams wrote:
>On Mon, Jan 21, 2019 at 4:26 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>[..]
>> >@@ -706,6 +711,22 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>> >               sig = DAX_SIG;
>> >       else
>> >               sig = PFN_SIG;
>> >+
>> >+      /*
>> >+       * Check for an existing 'pfn' superblock before writing a new
>> >+       * one. The intended flow is that on the first probe of an
>> >+       * nd_{pfn,dax} device the superblock is calculated and written
>> >+       * to the namespace. In this case nd_pfn_validate() returns
>> >+       * -ENODEV because no valid superblock exists currently.
>>
>> As you replied in following mail:
>>
>> 3/ If present, nd_pfn_validate() returns 0 and nd_dax_probe()
>> registers the dax0.1 device (this is a libnvdimm 'personality device).
>>
>> So at this point, nd_pfn_validate() return 0 or -ENODEV?
>
>In this case 0, because the configuration was successfully validated.
>
>-ENODEV, is only returned for the initial case where we want the
>kernel to write the configuration.
>
>All other error codes are an actual failure and the probe procedure stops.

To be honest, this maybe crystal clear for you. But I still feel a little
confused. Especially on differentiating those cases. How many cases we have? 

And what's your first probe mean? This the nd_btt/pfn/dax_probe()? or the
linux driver probe?

-- 
Wei Yang
Help you, Help me
