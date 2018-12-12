Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8070AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1320851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC1320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeLLRxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:53:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:54363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbeLLRxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:53:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 09:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="118251585"
Received: from hekner-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.170])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2018 09:53:19 -0800
Date:   Wed, 12 Dec 2018 19:53:17 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm-dev: Require response to be read only if there
 actually is a response
Message-ID: <20181212175317.GA6333@linux.intel.com>
References: <20181206175801.23048-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206175801.23048-1-Alexander.Steffen@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 06:58:01PM +0100, Alexander Steffen wrote:
> If the tpm_transmit call in tpm_common_write fails for any reason, there is
> no response that could be read. Therefore, do not require the application
> to issue a read call before sending further commands. This restores the
> behavior from before support for partial reads was introduced.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
> Feel free to merge this into Tadeusz' original commit.

Thank you, good catch.

My PR is a bit late becuse just came from Oregon back to Finland so
I'll follow your advice and squash this. Thanks again.

/Jarkko
