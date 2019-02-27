Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B1C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B9820661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfB0ODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:03:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:27794 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbfB0ODG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:03:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 06:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="278280438"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.169])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2019 06:03:01 -0800
Date:   Wed, 27 Feb 2019 16:02:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V4 2/4] tpm: Reserve the TPM final events table
Message-ID: <20190227140259.GA17106@linux.intel.com>
References: <20190222202606.160816-1-matthewgarrett@google.com>
 <20190222202606.160816-3-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222202606.160816-3-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:26:04PM -0800, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@google.com>
> 
> UEFI systems provide a boot services protocol for obtaining the TPM
> event log, but this is unusable after ExitBootServices() is called.
> Unfortunately ExitBootServices() itself triggers additional TPM events
> that then can't be obtained using this protocol. The platform provides a
> mechanism for the OS to obtain these events by recording them to a
> separate UEFI configuration table which the OS can then map.
> 
> Unfortunately this table isn't self describing in terms of providing its
> length, so we need to parse the events inside it to figure out how long
> it is. Since the table isn't mapped at this point, we need to extend the
> length calculation function to be able to map the event as it goes
> along.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Getting:

Applying: tpm: Reserve the TPM final events table
error: sha1 information is lacking or useless (drivers/firmware/efi/efi.c).
error: could not build fake ancestor

My tree:

git://git.infradead.org/users/jjs/linux-tpmdd.git

My guess is that your patches are based a later 5.0-rcX. Unfortunately I
cannot update my master at this point because my 5.1 PR was taken to
security tree and rebasing would change the commit IDs of 5.1 content
because security/next-general does not yet contain those patches.

/Jarkko
