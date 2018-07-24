Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C621BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B13A205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B13A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbeGXMyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:54:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:60246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388275AbeGXMyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:54:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AAB5AED3;
        Tue, 24 Jul 2018 11:48:36 +0000 (UTC)
Message-ID: <1532432457.17797.8.camel@suse.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
From:   Oliver Neukum <oneukum@suse.com>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Kookoo Gu <kookoo.gu@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rui Zhang <rui.zhang@intel.com>, Theodore Ts o <tytso@mit.edu>,
        Joey Lee <JLee@suse.com>, Pavel Machek <pavel@ucw.cz>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Tue, 24 Jul 2018 13:40:57 +0200
In-Reply-To: <20180723162302.GA4503@sandybridge-desktop>
References: <cover.1531924968.git.yu.c.chen@intel.com>
         <20180718202235.GA4132@amd> <20180718235851.GA22170@sandybridge-desktop>
         <20180719110149.GA4679@amd> <20180719132003.GA30981@sandybridge-desktop>
         <20180720102532.GA20284@amd> <1532346156.3057.11.camel@suse.com>
         <20180723162302.GA4503@sandybridge-desktop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2018-07-24 at 00:23 +0800, Yu Chen wrote:
> Hi,
> On Mon, Jul 23, 2018 at 01:42:36PM +0200, Oliver Neukum wrote:
> > On Fr, 2018-07-20 at 12:25 +0200, Pavel Machek wrote:

> > > So your goal is to make hibernation compatible with kernel
> > > lockdown? Do your patches provide sufficient security that hibernation
> > > can be enabled with kernel lockdown?
> > 
> > OK, maybe I am dense, but if the key comes from user space, will that
> > be enough?
> > 
> 
> Good point, we once tried to generate key in kernel, but people
> suggest to generate key in userspace and provide it to the
> kernel, which is what ecryptfs do currently, so it seems this
> should also be safe for encryption in kernel.
> https://www.spinics.net/lists/linux-crypto/msg33145.html
> Thus Chun-Yi's signature can use EFI key and both the key from
> user space.

It seems to me that your initial reasoning was correct and the key
should be generated in kernel space.

	Regards
		Oliver

