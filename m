Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17DEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE420851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DE420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeK1Kfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:35:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:20131 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeK1Kfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:35:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 15:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="102043492"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.96])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Nov 2018 15:36:17 -0800
Date:   Tue, 27 Nov 2018 15:36:17 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tpm: add support for partial reads
Message-ID: <20181127233617.GA1304@linux.intel.com>
References: <154281183700.2093.10559851516194502797.stgit@tstruk-mobl1.jf.intel.com>
 <20181121151838.GB16564@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121151838.GB16564@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 05:18:38PM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 21, 2018 at 06:50:37AM -0800, Tadeusz Struk wrote:
> > Currently to read a response from the TPM device an application needs
> > provide big enough buffer for the whole response and read it in one go.
> > The application doesn't know how big the response it beforehand so it
> > always needs to maintain a 4K buffer and read the max (4K).
> > In case if the user of the TSS library doesn't provide big enough
> > buffer the TCTI spec says that the library should set the required
> > size and return TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the
> > application could allocate a bigger buffer and call receive again.
> > To make it possible in the TSS library, this requires being able to do
> > partial reads from the driver.
> > The library would read the 10 bytes header first to get the actual size
> > of the response from the header, and then read the rest of the response.
> > 
> > This patch adds support for partial reads, i.e. the user can read the
> > response in one or multiple reads, until the whole response is consumed.
> > The user can also read only part of the response and ignore
> > the rest by issuing a new write to send a new command.
> > 
> > Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Pushed.

/Jarkko
