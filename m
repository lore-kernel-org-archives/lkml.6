Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FBC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE48320857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfBHOIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:08:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:23320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfBHOIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:08:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 06:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="145242949"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.115])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2019 06:08:35 -0800
Date:   Fri, 8 Feb 2019 16:08:34 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
Message-ID: <20190208140834.GA25255@linux.intel.com>
References: <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
 <20190208111442.GA11755@linux.intel.com>
 <06473b24-7c59-9405-bbe0-8d30b3450391@linux.ibm.com>
 <20190208130227.GA16679@linux.intel.com>
 <da69e24d-ad5c-1e7b-9f02-a435872ad635@linux.ibm.com>
 <20190208131754.GA18133@linux.intel.com>
 <20190208133355.GA18774@linux.intel.com>
 <c3da7f8d-818c-2dc6-5770-9beaf0e55152@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3da7f8d-818c-2dc6-5770-9beaf0e55152@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:02:22AM -0500, Stefan Berger wrote:
> On 2/8/19 8:33 AM, Jarkko Sakkinen wrote:
> > 
> > if (len != be32_to_cpu(header->length)) {
> > 	rc = -EFAULT;
> > 	goto out;
> > }
> > 
> > rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> > if (rc)
> > 	dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> > 
> > That unconditional call to commit space masked the bugs in the device
> > drivers. I'll provide fixes shortly.
> 
> You got it! :-)

Yes, and it should not be fixes in tpm-interface.c. Sent a patch set
for review.

Thanks for spotting this out!

/Jarkko
