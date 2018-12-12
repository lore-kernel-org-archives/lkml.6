Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046622084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046622084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeLLSQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:16:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:36289 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbeLLSQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:16:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 10:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="303291248"
Received: from hekner-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.170])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2018 10:16:27 -0800
Date:   Wed, 12 Dec 2018 20:16:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 5/7] tpm: retrieve digest size of unknown algorithms
 with PCR read
Message-ID: <20181212181625.GE6333@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-6-roberto.sassu@huawei.com>
 <20181204235354.GD1233@linux.intel.com>
 <ac404fdd-b673-eb49-d6e7-4fc6de561ce1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac404fdd-b673-eb49-d6e7-4fc6de561ce1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 07:00:13PM +0100, Roberto Sassu wrote:
> On 12/5/2018 12:53 AM, Jarkko Sakkinen wrote:
> > On Tue, Dec 04, 2018 at 09:21:36AM +0100, Roberto Sassu wrote:
> > > +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> > > +		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
> > > +
> > > +		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
> > > +			continue;
> > > +
> > > +		bank->digest_size = hash_digest_size[crypto_algo];
> > > +		bank->crypto_id = crypto_algo;
> > > +		return 0;
> > > +	}
> > > +
> > > +	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
> > > +}
> > 
> > This is a part that I don't get. Coud you just always call
> > tpm2_pcr_read() instead of this complexity
> 
> First, we avoid operations that may increase the boot time. Second, the
> loop is necessary to obtain the crypto subsystem identifier from a TPM
> algorithm identifier.

I think here would be a comment in place and it would be fine.

/Jarkko
