Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504D2C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134AA2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134AA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeKSXUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:20:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:59378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbeKSXUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:20:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 04:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="107493545"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2018 04:57:06 -0800
Date:   Mon, 19 Nov 2018 14:57:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 08/17] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
Message-ID: <20181119125704.GC8755@linux.intel.com>
References: <20181116123845.15705-1-jarkko.sakkinen@linux.intel.com>
 <20181116123845.15705-9-jarkko.sakkinen@linux.intel.com>
 <20181116161957.GG1706@sasha-vm>
 <20181118073618.GD5897@linux.intel.com>
 <20181118232157.GA1711@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118232157.GA1711@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 06:21:57PM -0500, Sasha Levin wrote:
> There's no "preferred" approach really. I try to warn about cases like
> this early because the response rates to Greg's "FAILED" email seem to
> be low - by the time they are sent out people are done with that code
> and have moved on.
> 
> In this scenario, for exmaple, this patch would not apply to any stable
> tree because it depends on a previous patch in this series that was not
> tagged for stable. My hopes are that if I warn you about this early you
> can work around this (for example, by marking that prior patch for
> stable as well) so you won't need to deal with this patch again in a few
> weeks.
> 
> There's no need to change anything about your flow if it works for you.

Ok, I see. Yeah, it is just how I organize my work. Rather solve the
patch dependency sudoku one time than two times.

When I maintain a subsystem I've thought that it is my responsibility to
always do that and not wait someone else to do it for me :-) That is the
responsibility part of the equation when you have the power to decide
what gets in.

Right now I have two failed merges in my queue that I plan to take care
of them next week.

> Thanks,
> Sasha

/Jarkko
