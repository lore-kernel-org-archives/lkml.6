Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8795C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E64B222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391765AbfBMLSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:18:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:35857 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfBMLSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:18:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 03:18:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="133948410"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2019 03:18:07 -0800
Date:   Wed, 13 Feb 2019 13:18:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     bsz@semihalf.com, matthewgarrett@google.com
Cc:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        ard.biesheuvel@linaro.org, tweek@google.com, mingo@kernel.org,
        hdegoede@redhat.com, leif.lindholm@linaro.org, mw@semihalf.com
Subject: Re: [PATCH 1/5] tpm: Copy calc_tpm2_event_size() to TPM library
Message-ID: <20190213111806.GF7087@linux.intel.com>
References: <20190211143052.3128-1-bsz@semihalf.com>
 <20190211143052.3128-2-bsz@semihalf.com>
 <20190213111443.GE7087@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213111443.GE7087@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:14:43PM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 11, 2019 at 03:30:48PM +0100, bsz@semihalf.com wrote:
> > From: Bartosz Szczepanek <bsz@semihalf.com>
> > 
> > Function to calculate event size in TPM 2.0 log will also be needed in EFI
> > stub. Separate it to library to make it accessible out of TPM character
> > driver.
> > 
> > It will be removed from tpm2.c in subsequent commit.
> > 
> > Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
> 
> Collides with Matthew's patch set, which has priority over this because
> it was sent earlier.
> 
> Matthew, what you think of this? Maybe could replace 1/4 with this in
> your patch set? Somehow feels a bit cleaner approach.

 This commit is in any case broken. It leaves two versions of the
 function hanging to the code base.

 /Jarkko
