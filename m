Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61D9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE59E20838
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391872AbfBML0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:26:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:45697 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfBML0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:26:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 03:26:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="133950012"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2019 03:26:40 -0800
Date:   Wed, 13 Feb 2019 13:26:40 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     bsz@semihalf.com
Cc:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        ard.biesheuvel@linaro.org, tweek@google.com, mingo@kernel.org,
        hdegoede@redhat.com, leif.lindholm@linaro.org, mw@semihalf.com
Subject: Re: [PATCH 4/5] efi/libstub/tpm: Retrieve TPM event log in 2.0 format
Message-ID: <20190213112640.GI7087@linux.intel.com>
References: <20190211143052.3128-1-bsz@semihalf.com>
 <20190211143052.3128-5-bsz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211143052.3128-5-bsz@semihalf.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:30:51PM +0100, bsz@semihalf.com wrote:
> From: Bartosz Szczepanek <bsz@semihalf.com>
> 
> Currently, the only way to get TPM 2.0 event log from firmware is to use
> device tree. Introduce efi_retrieve_tpm2_eventlog_2 function to enable
> retrieving it from EFI structures.
> 
> Include lib/tpm.c into EFI stub to calculate event sizes using helper
> function.
> 
> Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>

Collides with Matthew's changes. I want to land those change first
because they are almost production ready.

Maybe you should consider reviewing those changes to make sure that
they make sense to you so that you can build these on top of after
these have landed.

There is not rush as I already made my v5.1 PR. These will be released
earliest in v5.2.

/Jarkko
