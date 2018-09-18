Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D283ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE09820858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE09820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=newtech.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeIRMen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:34:43 -0400
Received: from imap.newtech.fi ([83.150.94.195]:34920 "EHLO mail.newtech.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbeIRMen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:34:43 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 08:34:42 EDT
Received: from eseries.newtech.fi (eseries.newtech.fi [194.110.87.243])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by mail.newtech.fi (Postfix) with ESMTPSA id D2CA06677F;
        Tue, 18 Sep 2018 09:54:47 +0300 (EEST)
From:   Dag Nygren <dag@newtech.fi>
To:     xen-devel@lists.xenproject.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgross@suse.com, "Dr . Greg Wettstein" <greg@enjellic.com>,
        dunlapg@umich.edu, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jgg@ziepe.ca,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH v2] tpm: Restore functionality to xen vtpm driver.
Date:   Tue, 18 Sep 2018 09:54:47 +0300
Message-ID: <6898808.CzJHl40L0f@eseries.newtech.fi>
Organization: Oy Espoon Newtech Ab
In-Reply-To: <5d63093d-620d-80d5-1138-0332a210d61f@oracle.com>
References: <20180913212551.2435-1-boris.ostrovsky@oracle.com> <20180917211900.GD6716@linux.intel.com> <5d63093d-620d-80d5-1138-0332a210d61f@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On tisdag 18 september 2018 kl. 01:25:29 EEST Boris Ostrovsky wrote:
> On 9/17/18 5:19 PM, Jarkko Sakkinen wrote:

> > Just to understand this bug better why did not the wrong version
> > cause any undefined behavior? Sounds like a fatal bug. Does this
> > cause crashes?
> 
> AFAIK, no, no crashes. I haven't tested this myself (and I believe
> relatively few people use this functionality, which explains why this
> has not been fixed for so long) but I don't think it will necessarily
> crash. It's just that the frontend driver will be reading from wrong
> location, causing TPM not to function properly.

I bumped my head into this last week and spent most of the
week trying to figure out why the vtpm did not respond.
Finally found the email from the guy that dirscovered and fixed
it. Did the fix and rescompiled. Now it seems to be working
fine. The patch is surprisingly 2 years old!!
I will be very pleased to see it go in to the
official kernel!

But no crash. Just a timeout when trying to communicate with
the vtpm-engine.

Best
Dag



