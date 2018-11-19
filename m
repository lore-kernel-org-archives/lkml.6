Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB09C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A7820851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A7820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeKSXMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:12:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:34675 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbeKSXMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:12:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 04:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="282337788"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by fmsmga006.fm.intel.com with ESMTP; 19 Nov 2018 04:48:24 -0800
Date:   Mon, 19 Nov 2018 14:48:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Message-ID: <20181119124822.GB8755@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-17-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA225B9@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA225B9@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:52:46PM +0000, Winkler, Tomas wrote:
> This is still NACK from my side

Last time you spoke about tboot intervention but I don't see why as even
sending a single command is not atomic in the true sense of the word
i.e. if there was a problem that would already affect the existing code
and would essentially mean that tboot itself is broken.

/Jarkko
