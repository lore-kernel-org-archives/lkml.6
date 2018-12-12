Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A42C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C3520851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C3520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeLLSZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:25:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:64249 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbeLLSZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:25:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 10:25:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="127337049"
Received: from hekner-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.170])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2018 10:25:09 -0800
Date:   Wed, 12 Dec 2018 20:25:08 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
Message-ID: <20181212182508.GG6333@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-8-roberto.sassu@huawei.com>
 <20181205001417.GF1233@linux.intel.com>
 <63ac9e36-34ac-6a1d-553d-dac5cab98d43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ac9e36-34ac-6a1d-553d-dac5cab98d43@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 07:09:48PM +0100, Roberto Sassu wrote:
> 
> 
> On 12/5/2018 1:14 AM, Jarkko Sakkinen wrote:
> > On Tue, Dec 04, 2018 at 09:21:38AM +0100, Roberto Sassu wrote:
> > > The new tpm_bank_list structure has been preferred to the tpm_digest
> > > structure, to let the caller specify the size of the digest (which may be
> > > unknown to the TPM driver).
> > 
> > Why is that? Didn't previous commit query these?
> > 
> > > +struct tpm_bank_list {
> > > +	u16 alg_id;
> > > +	u16 extend_size;
> > > +	const u8 *extend_array;
> > > +};
> > 
> > Naming is not good here. If this only for extending shouldn't that
> > be in the structs name?
> 
> tpm_extend_input?

I think something like this would be appropriate:

struct tpm_extend_digest {
	u16 alg_id;
	u16 size;
	u8 *data;
};

/Jarkko
