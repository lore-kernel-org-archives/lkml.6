Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33159ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F3B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeJRCTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:19:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60869 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeJRCTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:19:17 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gCqSY-0004WC-Uy; Wed, 17 Oct 2018 20:22:19 +0200
Date:   Wed, 17 Oct 2018 20:22:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@suse.de>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/mcelog: Remove one mce_helper definition
In-Reply-To: <20181017171034.GO22571@zn.tnic>
Message-ID: <alpine.DEB.2.21.1810172020070.1517@nanos.tec.linutronix.de>
References: <20181017170554.18841-1-bigeasy@linutronix.de> <20181017170554.18841-3-bigeasy@linutronix.de> <20181017171034.GO22571@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Borislav Petkov wrote:

> On Wed, Oct 17, 2018 at 07:05:53PM +0200, Sebastian Andrzej Siewior wrote:
> > Commit 5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog
> > driver") moved the old interface into one file including mce_helper
> > definition as static and "extern".
> > 
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: linux-edac <linux-edac@vger.kernel.org>
> > Cc: x86@kernel.org
> > Fixes:  5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
> 
> I'm not sure about the Fixes: tag - it'll trigger a flood of backporting
> for no reason AFAICT.

Not when there is no Cc: stable. If the stable folks pick up stuff
nevertheless, shrug.

The fixes tag is interesting even for stuff which does not go into stable
because you can extract it properly and look at relations between original
commit and fix.

Thanks,

	tglx
