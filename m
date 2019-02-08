Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A2C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AB32086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfBHQXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:23:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:41202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfBHQXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:23:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 08:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="317419552"
Received: from shivamur-mobl1.gar.corp.intel.com (HELO localhost) ([10.249.254.162])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2019 08:23:18 -0800
Date:   Fri, 8 Feb 2019 18:23:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v2 0/2] tpm: Unify send() callbacks
Message-ID: <20190208162316.GA25496@linux.intel.com>
References: <20190208160328.18715-1-jarkko.sakkinen@linux.intel.com>
 <b0469b08-18fd-847b-0f0b-6223c732b346@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0469b08-18fd-847b-0f0b-6223c732b346@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:14:42AM -0500, Stefan Berger wrote:
> On 2/8/19 11:03 AM, Jarkko Sakkinen wrote:
> > A portion of send() callbacks have returned length, in many cases just
> > returning back what was given as an argument, and tpm_crb has returned 0 on
> > success. This patch set fixes and unifies the behaviour.
> > 
> > v2:
> > The drivers tpm_nsc and tpm_infineon were forgotten. For this version I
> > checked both with find and command and from Kconfig that everything that is
> > supposed to be a driver directly interfacing with the TPM core, is included
> > (e.g. discluding tpm_tis_spi).
> 
> 
> :-( st33zp24/i2c.c ends up calling i2c_master_send, which returns number of
> bytes written:
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/i2c.h#L108

And i2c.c is not a TPM driver so does it matter?

Then st33zp24_send() is the callback interfacing with the TPM core.

/Jarkko
