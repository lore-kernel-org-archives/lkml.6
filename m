Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7CB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfARO0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:26:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:64202 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbfARO0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:26:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 06:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="311539442"
Received: from unknown (HELO localhost) ([10.249.254.249])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jan 2019 06:26:02 -0800
Date:   Fri, 18 Jan 2019 16:25:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190118142559.GA4080@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I get this on a Geminilake NUC after rebasing my maintainer trees:

tpm tpm0: A TPM error (-1) occurred attempting the self test

I checked the latest commit ID from drivers/char/tpm to make sure
that I did not put anything broken to my last PR [1]. It works
without issues.

In addition [2] gives me an empty diff.

Something outside of the TPM driver must have happened that breaks
the driver. Any ideas?

[1] commit 9488585b21bef0df1217e510c7134905d1d376a7
[2] git diff 9488585b21bef0df1217e510c7134905d1d376a7 master drivers/char/tpm/

/Jarkko
