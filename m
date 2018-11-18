Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906A4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610B520659
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610B520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeKRRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 12:47:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:45324 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeKRRrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 12:47:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2018 23:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,247,1539673200"; 
   d="scan'208";a="280923574"
Received: from kaczmarx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.89])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2018 23:27:47 -0800
Date:   Sun, 18 Nov 2018 09:27:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v5 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
Message-ID: <20181118072745.GA5897@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-8-roberto.sassu@huawei.com>
 <20181116150352.GA3612@linux.intel.com>
 <9c534ed1-7832-7a3b-3e69-5fcc25c565cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c534ed1-7832-7a3b-3e69-5fcc25c565cc@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 04:55:36PM +0100, Roberto Sassu wrote:
> On 11/16/2018 4:03 PM, Jarkko Sakkinen wrote:
> > On Wed, Nov 14, 2018 at 04:31:08PM +0100, Roberto Sassu wrote:
> > > Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
> > > 
> > > This patch modifies the definition of tpm_pcr_extend() to allow other
> > > kernel subsystems to pass a digest for each algorithm supported by the TPM.
> > > All digests are processed by the TPM in one operation.
> > > 
> > > If a tpm_pcr_extend() caller provides a subset of the supported algorithms,
> > > the TPM driver extends the remaining PCR banks with the first digest
> > > passed as an argument to the function.
> > 
> > What is the legit use case for this?
> 
> A subset could be chosen for better performance, or when a TPM algorithm
> is not supported by the crypto subsystem.

Doesn't extending a subset a security concern?

/Jarkko
