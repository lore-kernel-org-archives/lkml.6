Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB39E2083D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB39E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757033AbeFQBW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:22:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:33373 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756946AbeFQBW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:22:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5H1MCDi016000;
        Sat, 16 Jun 2018 20:22:13 -0500
Message-ID: <aff7b975390119239bfcb5bdef869bdfd28e712a.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 5/5] fsi/scom: Major overhaul
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun, 17 Jun 2018 11:22:11 +1000
In-Reply-To: <f2421fad1ea210b32a6813454832c0ed66770bf5.camel@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org>
         <20180612051911.20690-6-benh@kernel.crashing.org>
         <CACPK8Xcp4gEVOrNdcZhbDx9LU1K6d=tV0vmJ9nLut4Fjwp0Xpg@mail.gmail.com>
         <f2421fad1ea210b32a6813454832c0ed66770bf5.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 11:17 +1000, Benjamin Herrenschmidt wrote:
> 
> We have everything that cronus needs and more than pdbg needs afaik :-)
> 
> That said, cronus does a bunch of other stupid things that I'm still
> trying to figure out how to fix.
> 
> We might need to create a /dev/cfam rather than going through that
> magic sysfs "raw" file, and I wouldn't mind using a single IDA so that
> all the devices below a given FSI slace (cfam itself, sbefifo, occ,
> ...) have the same "number".

Also while we're at reworking how all this is exposed to our broken
userspace, I wouldn't mind putting all these dev entries under a
directory, if I can figure out how to do that (I haven't really looked
yet).

/dev/fsi/{cfamN,sbefifoN,occN, ...} and possibly similar by-id and by-
path that other subsystems use, so we have something more deterministic
than the "random number" crap we do now.

We can always keep hacks to do symlinks in our kernel tree until we
have converted all our userspace users.

We currently control the only userspace users of this, so now is a good
time to cleanup how we expose things. This won't always be the case.

Cheers,
Ben.

