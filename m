Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BE5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310BC20645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310BC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJCSuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:50:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:11329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeJCSuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:50:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 05:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="75847297"
Received: from hoffmann-mobl.ger.corp.intel.com (HELO localhost) ([10.249.38.250])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2018 05:02:15 -0700
Date:   Wed, 3 Oct 2018 15:02:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
Message-ID: <20181003120215.GB7969@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-7-tomas.winkler@intel.com>
 <20181002004248.GC23753@linux.intel.com>
 <7e42b9c4-2299-a62d-ac79-0e147cb60573@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e42b9c4-2299-a62d-ac79-0e147cb60573@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:58:00PM +0530, Nayna Jain wrote:
> 
> 
> On 10/02/2018 06:12 AM, Jarkko Sakkinen wrote:
> > On Sat, Sep 29, 2018 at 01:30:20AM +0300, Tomas Winkler wrote:
> > > Move tpm1_pcr_extend to tpm1-cmd.c and remove
> > > unused pcrextend_header structure and
> > > EXTEND_PCR_RESULT_SIZE and EXTEND_PCR_RESULT_BODY_SIZE
> > > defines.
> > > 
> > > Fixes warning:
> > > drivers/char/tpm/tpm-interface.c:609:38: warning: ‘pcrextend_header’ defined but not used [-Wunused-const-variable=]
> > >   static const struct tpm_input_header pcrextend_header = {
> > >                                        ^~~~~~~~~~~~~~~~
> > > 
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Would need help with this from someone with a working IMA setup
> > on testing.
> 
> 
> My test system is down for now.. I think it will be up later in this week. I
> can test it then.

Thank you.

/Jarkko
