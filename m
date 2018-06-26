Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ACEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4678D2652B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4678D2652B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=guninski.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeFZFzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:55:22 -0400
Received: from cannabis.dataforce.net ([195.42.160.49]:38546 "EHLO
        cannabis.dataforce.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeFZFzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:55:21 -0400
X-Greylist: delayed 1351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 01:55:20 EDT
Received: by cannabis.dataforce.net (Postfix, from userid 12794)
        id 2CD7F4A0004; Tue, 26 Jun 2018 08:32:48 +0300 (MSK)
Date:   Tue, 26 Jun 2018 08:32:46 +0300
From:   Georgi Guninski <guninski@guninski.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: s390 qemu boot failure in -next
Message-ID: <20180626053246.6kyvrj7jbuhgdkgv@sivokote.iziade.m$>
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
 <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
header: best read with a sniffer
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:27:59AM +0200, Christian Borntraeger wrote:
> -            /* Overwrite parameters in the kernel image, which are "rom" */
> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);

> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);

Why not replace strcpy() with strncpy() or snprintf()?
strcpy() may overflow.

