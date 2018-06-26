Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F465C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20B266B1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F20B266B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeFZIVu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:21:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:46179 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932722AbeFZIVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:21:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 01:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="211207894"
Received: from jsakkine-mobl1.tm.intel.com (HELO jyrjanai-mobl2.ger.corp.intel.com) ([10.237.50.56])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2018 01:21:27 -0700
Message-ID: <cfa499cd0a663517d17ede0206ad98a2b0d350e9.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/5] Have IMA find and use a tpm_chip until system
 shutdown
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org
Date:   Tue, 26 Jun 2018 11:21:26 +0300
In-Reply-To: <165d1f1ba8219da81390b064aaf6787ee263fe12.camel@linux.intel.com>
References: <20180625104312.2213278-1-stefanb@linux.vnet.ibm.com>
         <7233579b5bf09fbea65e8132fb31fc9f6af59bad.camel@linux.intel.com>
         <165d1f1ba8219da81390b064aaf6787ee263fe12.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 11:20 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-06-26 at 11:19 +0300, Jarkko Sakkinen wrote:
> > On Mon, 2018-06-25 at 06:43 -0400, Stefan Berger wrote:
> > > This series of patches converts IMA's usage of the tpm_chip to find a TPM
> > > chip initially and use it until the machine is shut down. To do this we
> > > need
> > > to introduce a kref for the tpm_chip that IMA and all other users of a
> > > tpm_chip hold onto until they don't need the TPM chip anymore.
> > > 
> > >     Stefan
> > > 
> > > v3->v4:
> > >   - followed Jason's suggestions
> > 
> > "Jason's suggestions" means nothing.
> 
> Please fix the change log for the next version.

You should probably resend this version as also linu-security-module
is missing. NAK because of that.

/Jarkko
