Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9718DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6158B21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6158B21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbeISA2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:28:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:58503 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbeISA2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:28:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 11:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,390,1531810800"; 
   d="scan'208";a="258334680"
Received: from kcandir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.105])
  by orsmga005.jf.intel.com with ESMTP; 18 Sep 2018 11:54:34 -0700
Date:   Tue, 18 Sep 2018 21:54:33 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tpm: retrieve digest size of unknown algorithms
 with PCR read
Message-ID: <20180918185433.GA9177@linux.intel.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
 <20180905114202.7757-4-roberto.sassu@huawei.com>
 <20180916123749.GF5040@linux.intel.com>
 <322eb81b-3f3e-e37e-5fb0-a37aad3d06d7@huawei.com>
 <20180917211622.GC6716@linux.intel.com>
 <8621eb6d-b252-4fb3-cb67-294f0aafb54c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8621eb6d-b252-4fb3-cb67-294f0aafb54c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 09:14:43AM +0200, Roberto Sassu wrote:
> On 9/17/2018 11:16 PM, Jarkko Sakkinen wrote:
> > On Mon, Sep 17, 2018 at 12:02:56PM +0200, Roberto Sassu wrote:
> > > This code has the same behavior of tpm2_get_pcr_allocation(). If some
> > > banks are not used, set the algorithm of the first unused to
> > > TPM_ALG_ERROR.
> > 
> > My point is that maybe it would sense to use zero for that in order
> > to make code a bit simpler.
> 
> Wouldn't be better to compare data with the same type? Since the alg_id
> structure member stores an algorithm, it should be fine to compare its
> value with an algorithm.
> 
> No problem to change that, but probably I should modify also
> tpm_pcr_extend().
> 
> Roberto

Please do.

/Jarkko
