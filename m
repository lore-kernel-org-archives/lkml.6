Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67208C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F52F24728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F52F24728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933711AbeGCQcP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:32:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:31614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:32:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 09:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="68360855"
Received: from cdikicix-mobl.ger.corp.intel.com ([10.249.254.69])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2018 09:32:08 -0700
Message-ID: <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
Subject: Re: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
 a tpm_chip
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 03 Jul 2018 19:32:07 +0300
In-Reply-To: <1530550839.3709.46.camel@linux.vnet.ibm.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
         <1530550839.3709.46.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 13:00 -0400, Mimi Zohar wrote:
> On Mon, 2018-07-02 at 11:24 -0400, Stefan Berger wrote:
> > Rather than accessing the TPM functions by passing a NULL pointer for
> > the tpm_chip, which causes a lookup for a suitable chip every time, get a
> > hold of a tpm_chip and access the TPM functions using it. Also get rid of
> > the ima_used_chip variable and use the new ima_tpm_chip variable instead
> > for determining whether to call TPM functions.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Jarkko, would you mind staging this patch with the rest of the patch
> set?

Yes, sure, I can do that. Any additional tag?

/Jarkko
