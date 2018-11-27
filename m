Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E549C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeK1Kke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:40:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:65071 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeK1Kke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:40:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 15:41:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="94620352"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.96])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2018 15:41:01 -0800
Date:   Tue, 27 Nov 2018 15:41:01 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
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
Message-ID: <20181127234101.GA3150@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 02:47:33PM +0200, Jarkko Sakkinen wrote:
> [was Detach TPM space code out of the tpm_transmit() flow but the scope
>  expanded a bit.]
> 
> Make the changes necessary to detach TPM space code and TPM activation
> code out of the tpm_transmit() flow because of both of these can cause
> nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> to maintain, and thus, it is better to just fix things now before this
> turns into a bigger mess.

I will take care to address the feedback from Tomas and Jason but won't
yet try to push this into v4.21. It is a patch set, which is better to
lie in linux-next before landing to a release. Probably will push the
patches soon after my v4.21 PR to linux-next. Then they will get maximum
time of exposure.

/Jarkko
