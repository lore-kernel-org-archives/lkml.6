Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDE9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D55C206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FrpIuuhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfAIVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:54:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfAIVy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:54:59 -0500
Received: from zn.tnic (p200300EC2BEA10006802B5941DDA3DDE.dip0.t-ipconnect.de [IPv6:2003:ec:2bea:1000:6802:b594:1dda:3dde])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17ED01EC00E5;
        Wed,  9 Jan 2019 22:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547070898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YaQ9uM6sUKOubwql9UmnJ08O3bh0hx7p2t0i6e8hNM0=;
        b=FrpIuuhWCBQx4Cas2NWqTzy/5vxIwfaXgLwzY9TK0g8rxqIuE67qc6yoL/zWotU7sQMTIc
        ISmD4I0C3i30ERdnE/+Au8iJ1wIEoSKpmyHFo0GS/eHIIdYXsdP+9Ss8LOKFY8zXkiw2Gn
        ddPhX3rw1ohlr50efeHFUVaPjvcTmR8=
Date:   Wed, 9 Jan 2019 22:54:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank
 4" to more models
Message-ID: <20190109215454.GJ15665@zn.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-2-git-send-email-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546857399-2926-2-git-send-email-shirish.s@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:37:17AM +0000, S, Shirish wrote:
> The below patch added this quirk only for the first generation of family
> 15 processors, over time its noticed that its required for later
> generations too.
> 
> "575203b4747c x86, MCE, AMD: Disable error thresholding bank 4 on some
> models"
> 
> This patch extends the quirk to make it applicable till 7th Generation,

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
