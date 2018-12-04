Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95077C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D8E206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D8E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeLDXk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:40:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:16804 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeLDXk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:40:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 15:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="127132461"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.183])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2018 15:40:25 -0800
Date:   Tue, 4 Dec 2018 15:40:24 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 4/7] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
Message-ID: <20181204234024.GC1233@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-5-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204082138.24600-5-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 09:21:35AM +0100, Roberto Sassu wrote:
> Currently the TPM driver allows other kernel subsystems to read only the
> SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> tpm2_pcr_read() to pass a tpm_digest structure, which contains the desired
> hash algorithm. Also, since commit 125a22105410 ("tpm: React correctly to
> RC_TESTING from TPM 2.0 self tests") removed the call to tpm2_pcr_read(),
> the new parameter is expected to be always not NULL.
> 
> Due to the API change, IMA functions have been modified.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Mimi, Nayna, can you help with testing this (because of the IMA change)?

/Jarkko
