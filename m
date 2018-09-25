Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0959620645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0959620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbeIYUgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:36:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:64113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeIYUgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:36:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="75791661"
Received: from thomasvo-mobl2.ger.corp.intel.com ([10.252.53.212])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2018 07:28:13 -0700
Message-ID: <54bbc3719576bf3365aea5992fe49cbc6b02e3b6.camel@linux.intel.com>
Subject: Re: [PATCH v4 20/21] tpm1: reimplement tpm1_continue_selftest()
 using tpm_buf
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Sep 2018 17:28:13 +0300
In-Reply-To: <ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-21-tomas.winkler@intel.com>
         <5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
         <ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 17:25 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-09-25 at 15:53 +0530, Nayna Jain wrote:
> > > +
> > > +	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
> > 
> > I think this needs to buf.data instead of &buf.data
> > 
> > Thanks & Regards,
> >       - Nayna
> 
> You are absolutely right. Thank you.

Had to backtrack what I was doing wrong last time because the commit
has my tested-by and noticed that I did not have this one applied. I
tested this now by doing the change that you suggested and seems to
work.

/Jarkko
