Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB8DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0034A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0034A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbeGXOPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:15:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388364AbeGXOPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:15:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB8ECB035;
        Tue, 24 Jul 2018 13:08:39 +0000 (UTC)
Message-ID: <1532437261.17797.22.camel@suse.com>
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
Date:   Tue, 24 Jul 2018 15:01:01 +0200
In-Reply-To: <20180724130110.GA29006@amd>
References: <cover.1531924968.git.yu.c.chen@intel.com>
         <20180718202235.GA4132@amd> <20180718235851.GA22170@sandybridge-desktop>
         <20180719110149.GA4679@amd> <20180719132003.GA30981@sandybridge-desktop>
         <20180720102532.GA20284@amd> <1532346156.3057.11.camel@suse.com>
         <20180723162302.GA4503@sandybridge-desktop> <20180724120133.GD26036@amd>
         <1532436474.17797.20.camel@suse.com> <20180724130110.GA29006@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2018-07-24 at 15:03 +0200, Pavel Machek wrote:
> On Tue 2018-07-24 14:47:54, Oliver Neukum wrote:
> > On Di, 2018-07-24 at 14:01 +0200, Pavel Machek wrote:

Hi,

> > > Safe against what kind of attack? Please describe what kind of
> > > security you are trying to provide.
> > 
> > Unsigned code must not take over the priviledge level of signed code.
> > Hence:
> > 
> > 1. Unsigned code must not allowed to read sensitive parts of signed
> > code's memory space
> > 
> > 2. Unsigned code must not be able to alter the memory space of
> > signed code -> snapshots that are changed must not be able to be
> > resumed
> 
> Ok.
> 
> > > I don't think generating key in userspace is good enough for providing
> > > guarantees for secure-boot.
> > 
> > Why?
> 
> Because then, userpace has both key (now) and encrypted image (after
> reboot), so it can decrypt, modify, re-encrypt...?

Right. I was dense. But if the key is generated in kernel space,
the method works, doesn't it?

	Regards
		Oliver

