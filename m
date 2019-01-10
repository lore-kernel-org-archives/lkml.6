Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF93206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QJS/X9Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfAJQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:02:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50252 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfAJQCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:02:45 -0500
Received: from zn.tnic (p200300EC2BC5CF00BC5292658C5BA6FB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:bc52:9265:8c5b:a6fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 602BF1EC03DB;
        Thu, 10 Jan 2019 17:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547136164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2vcG7i6Ra4Tqh1nuYhiELkX1bqSneyTELQ7Fd4tGmvQ=;
        b=QJS/X9RuQVR7cjxx9fm3/Ucucl9MprGrkFVludUB5L2kSjzg19GIddSdUnOByPh2AhSKm+
        5WjSqOdIDCG2S8EFg4nHFqUYZ3HNorDmgYFrYGBl6ZW3XAnwJ0dq6z5IOnv3o+p0rq42Ps
        NiGBtwvh7l88JUehFweYdVnodEsbPJI=
Date:   Thu, 10 Jan 2019 17:02:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Message-ID: <20190110160240.GE17621@zn.tnic>
References: <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
 <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
 <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
 <98ed83c0-3077-848b-9de4-add70e9b417a@amd.com>
 <9bca3e26-1dfc-6e86-cf28-90cadd983ff4@molgen.mpg.de>
 <20190109211104.GG15665@zn.tnic>
 <9bbcbaa7-b164-fcef-0588-7c5f25aa2440@molgen.mpg.de>
 <79744a6a-91c9-9318-3155-c1942cccf5f2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79744a6a-91c9-9318-3155-c1942cccf5f2@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:53:11PM +0000, Lendacky, Thomas wrote:
> Checking the original log file again, it showed the mitigation message
> for IBPB that is just after the above switch statement, so this print
> output is expected. What about applying this patch on top of the patch
> from Boris:

Ha! See the mail I just sent - it has yours + more! :-)

With this funky bug, you never know...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
