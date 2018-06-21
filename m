Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66327C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232E42178B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232E42178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeFURPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:15:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:59336 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754089AbeFURPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:15:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 10:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="51189872"
Received: from lmrad-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.46])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2018 10:15:17 -0700
Date:   Thu, 21 Jun 2018 20:15:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621171518.GI11859@linux.intel.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> Implement tpm_chip_find() for other subsystems to find a TPM chip and
> get a reference to that chip. Once done with using the chip, the reference
> is released using tpm_chip_put().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

You should sort this out in a way that we don't end up with duplicate
functions.

/Jarkko
