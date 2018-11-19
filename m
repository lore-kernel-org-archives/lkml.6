Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A38C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EE720831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EE720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeKTCUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:20:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:49118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbeKTCUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:20:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 07:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="275195815"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2018 07:56:11 -0800
Date:   Mon, 19 Nov 2018 17:56:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Removed nested TPM operations
Message-ID: <20181119155610.GC13298@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <1393743e-7c54-4a83-ba2a-779a3a8a31e3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393743e-7c54-4a83-ba2a-779a3a8a31e3@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:23:03AM -0500, Stefan Berger wrote:
> On 11/18/18 7:47 AM, Jarkko Sakkinen wrote:
> > [was Detach TPM space code out of the tpm_transmit() flow but the scope
> >   expanded a bit.]
> > 
> > Make the changes necessary to detach TPM space code and TPM activation
> > code out of the tpm_transmit() flow because of both of these can cause
> > nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> > to maintain, and thus, it is better to just fix things now before this
> > turns into a bigger mess.
> 
> Tested this series with the vtpm proxy test cases:
> 
> 
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Awesome, thank you! I'll add your tags to the next revision.

/Jarkko
