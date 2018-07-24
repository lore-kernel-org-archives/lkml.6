Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF34C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1B420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1B420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbeGXOB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:01:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:51870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388322AbeGXOB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:01:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A107FAD94;
        Tue, 24 Jul 2018 12:55:33 +0000 (UTC)
Message-ID: <1532436474.17797.20.camel@suse.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
From:   Oliver Neukum <oneukum@suse.com>
To:     Pavel Machek <pavel@ucw.cz>, Yu Chen <yu.c.chen@intel.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Tue, 24 Jul 2018 14:47:54 +0200
In-Reply-To: <20180724120133.GD26036@amd>
References: <cover.1531924968.git.yu.c.chen@intel.com>
         <20180718202235.GA4132@amd> <20180718235851.GA22170@sandybridge-desktop>
         <20180719110149.GA4679@amd> <20180719132003.GA30981@sandybridge-desktop>
         <20180720102532.GA20284@amd> <1532346156.3057.11.camel@suse.com>
         <20180723162302.GA4503@sandybridge-desktop> <20180724120133.GD26036@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2018-07-24 at 14:01 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > >        "There have some functions be locked-down because
> > > > >        there have no appropriate mechanisms to check the
> > > > >        integrity of writing data."
> > > > >        https://patchwork.kernel.org/patch/10476751/
> > > > 
> > > > So your goal is to make hibernation compatible with kernel
> > > > lockdown? Do your patches provide sufficient security that hibernation
> > > > can be enabled with kernel lockdown?
> > > 
> > > OK, maybe I am dense, but if the key comes from user space, will that
> > > be enough?
> > > 
> > 
> > Good point, we once tried to generate key in kernel, but people
> > suggest to generate key in userspace and provide it to the
> > kernel, which is what ecryptfs do currently, so it seems this
> > should also be safe for encryption in kernel.
> 
> Safe against what kind of attack? Please describe what kind of
> security you are trying to provide.

Unsigned code must not take over the priviledge level of signed code.
Hence:

1. Unsigned code must not allowed to read sensitive parts of signed
code's memory space

2. Unsigned code must not be able to alter the memory space of
signed code -> snapshots that are changed must not be able to be
resumed

> I don't think generating key in userspace is good enough for providing
> guarantees for secure-boot.

Why?

	Regards
		Oliver

