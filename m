Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C546C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ECE2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ECE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeLLO7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:59:04 -0500
Received: from muru.com ([72.249.23.125]:57710 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeLLO7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:59:03 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B0B57809F;
        Wed, 12 Dec 2018 14:59:06 +0000 (UTC)
Date:   Wed, 12 Dec 2018 06:59:00 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: Regression in next-20181211 with fsverity changes
Message-ID: <20181212145900.GD6707@atomide.com>
References: <20181211191220.GW6707@atomide.com>
 <3171217.2PqYythArb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3171217.2PqYythArb@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Chandan Rajendra <chandan@linux.vnet.ibm.com> [181212 04:16]:
> On Wednesday, December 12, 2018 12:42:20 AM IST Tony Lindgren wrote:
> > Hi,
> > 
> > Looks like commit 4de97efb578a ("fsverity: Move verity status check
> > to fsverity_file_open") causes a boot regression for me with root
> > on ext4 SDIO card, see below.
> > 
> 
> fsverity_file_open() used to incorrectly return -EOPNOTSUPP for non-fsverity
> files on kernels built without fsverity support. This bug has been fixed in
> the V4 patchset <https://marc.info/?l=linux-ext4&m=154458767124953&w=2>.

Yes thanks for the update.

Regards,

Tony
