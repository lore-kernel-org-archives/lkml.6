Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83650C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517A82064D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517A82064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeLDXx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:53:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:16960 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLDXxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:53:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 15:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="299356540"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.183])
  by fmsmga006.fm.intel.com with ESMTP; 04 Dec 2018 15:53:54 -0800
Date:   Tue, 4 Dec 2018 15:53:54 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 5/7] tpm: retrieve digest size of unknown algorithms
 with PCR read
Message-ID: <20181204235354.GD1233@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-6-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204082138.24600-6-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 09:21:36AM +0100, Roberto Sassu wrote:
> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
> +
> +		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
> +			continue;
> +
> +		bank->digest_size = hash_digest_size[crypto_algo];
> +		bank->crypto_id = crypto_algo;
> +		return 0;
> +	}
> +
> +	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
> +}

This is a part that I don't get. Coud you just always call
tpm2_pcr_read() instead of this complexity

/Jarkko
