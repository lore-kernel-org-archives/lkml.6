Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E02C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79308205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79308205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbeGXNDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:03:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388280AbeGXNDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:03:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7AA7AC9C;
        Tue, 24 Jul 2018 11:57:21 +0000 (UTC)
Message-ID: <1532432981.17797.13.camel@suse.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
From:   Oliver Neukum <oneukum@suse.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yu Chen <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Tue, 24 Jul 2018 13:49:41 +0200
In-Reply-To: <20180723122227.GA30092@amd>
References: <cover.1531924968.git.yu.c.chen@intel.com>
         <20180718202235.GA4132@amd> <20180718235851.GA22170@sandybridge-desktop>
         <20180719110149.GA4679@amd> <20180719132003.GA30981@sandybridge-desktop>
         <20180720102532.GA20284@amd> <1532346156.3057.11.camel@suse.com>
         <20180723122227.GA30092@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2018-07-23 at 14:22 +0200, Pavel Machek wrote:

> > Yes. But you are objecting to encryption in kernel space at all,
> > aren't you?
> 
> I don't particulary love the idea of doing hibernation encryption in
> the kernel, correct.
> 
> But we have this weird thing called secure boot, some people seem to
> want. So we may need some crypto in the kernel -- but I'd like
> something that works with uswsusp, too. Plus, it is mandatory that
> patch explains what security guarantees they want to provide against
> what kinds of attacks...

Hi,

very well, maybe we should state clearly that the goal of these
patch set is to make Secure Boot and STD coexist. Anything else
is a nice side effect, but not the primary justification, right?

And we further agree that the model of Secure Boot requires the
encryption to be done in kernel space, don't we?
Furthermore IMHO the key must also be generated in trusted code,
hence in kernel space. Yu Chen, I really cannot see how
a symmetrical encryption with a known key can be secure.

	Regards
		Oliver

