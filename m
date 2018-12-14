Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D77C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DBA2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DBA2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeLNH7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:59:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:52359 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeLNH7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:59:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 23:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="scan'208";a="118296825"
Received: from hekner-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.170])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2018 23:58:57 -0800
Date:   Fri, 14 Dec 2018 09:58:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
Message-ID: <20181214075852.GB1721@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-8-roberto.sassu@huawei.com>
 <20181205001417.GF1233@linux.intel.com>
 <9d6e47d9-3b88-86f6-1b60-6652dfe8dc00@huawei.com>
 <20181212182734.GH6333@linux.intel.com>
 <ae012b83-af66-6dfe-6131-e08507c3372e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae012b83-af66-6dfe-6131-e08507c3372e@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:57:17AM +0100, Roberto Sassu wrote:
> > 1. The function does not fail if alg_id is not found. This will go
> >     silent.
> 
> It is intentional. If alg_id is not found, the PCR is extended with the
> first digest passed by the caller of tpm_pcr_extend(). If no digest was
> provided, the PCR is extended with 0s. This is done to prevent that
> PCRs in unused banks are extended later with fake measurements.
> 
> 
> > 2. The function does not fail if there is a mismatch with the digest
> >     sizes.
> 
> The data passed by the caller of tpm_pcr_extend() is copied to
> dummy_hash, which has the maximum length. Then, tpm2_pcr_extend() takes
> from dummy_hash as many bytes as needed, depending on the current
> algorithm.

I would suggest to document these corner cases to the function long
description to make it easy and obvious to understand.

/Jarkko
