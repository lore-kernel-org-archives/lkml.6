Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D76C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEC72075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEC72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeJaCca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:32:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:60224 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbeJaCca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:32:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 10:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="270051889"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2018 10:38:04 -0700
Date:   Tue, 30 Oct 2018 11:35:43 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
Message-ID: <20181030173543.GG18906@localhost.localdomain>
References: <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
 <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
 <20181030160242.GD18906@localhost.localdomain>
 <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
 <535480f3-9087-b4ae-e7c8-cfe3c2d1e2c9@kernel.dk>
 <20181030172234.GF18906@localhost.localdomain>
 <d393e6f3-bc45-e038-9a5e-e51018f0a15a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d393e6f3-bc45-e038-9a5e-e51018f0a15a@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:33:51AM -0600, Jens Axboe wrote:
> On 10/30/18 11:22 AM, Keith Busch wrote:
> > On Tue, Oct 30, 2018 at 11:09:04AM -0600, Jens Axboe wrote:
> >> Pretty trivial, below. This also keeps the queue mapping calculations
> >> more clean, as we don't have to do one after we're done allocating
> >> IRQs.
> > 
> > Yep, this addresses my concern. It less efficient than PCI since PCI
> > can usually jump straight to a valid vector count in a single iteration
> > where this only subtracts by 1. I really can't be bothered to care for
> > optimizing that, so this works for me! :) 
> 
> It definitely is less efficient than just getting the count that we
> can support, but it's at probe time so I could not really be bothered
> either.
> 
> Can I add your reviewed-by?

Yes, please.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> -- 
> Jens Axboe
