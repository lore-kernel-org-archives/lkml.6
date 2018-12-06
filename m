Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7130820850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GvTaENsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7130820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLFSGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:06:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39778 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLFSGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:06:10 -0500
Received: from zn.tnic (p200300EC2BCE8F00FC176F88AC425FE9.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:8f00:fc17:6f88:ac42:5fe9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0D0C1EC04DF;
        Thu,  6 Dec 2018 19:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544119569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sgxX7qOiwpthTwIR7mh7W6yCw4yrP+yNggi7kHFKdU0=;
        b=GvTaENsb3Xpazttulvcz97DrDHK+nRIbxnABcmQ2TknlGKM0Pkqb2A43dIC/yyGI+PYSad
        uuSjX13WxxYVQkhk+q/sO9GTX9dykvKdsY+Yu+7DgehOMsv4UOipLxDOnoJRTtgNmI9hsi
        TN4zd9xy4aKaNyAEGACJNctqBGQD4Os=
Date:   Thu, 6 Dec 2018 19:05:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Streamline MCE subsystem's naming
Message-ID: <20181206180552.GB3986@zn.tnic>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205163037.GC109259@gmail.com>
 <20181205170006.GK29510@zn.tnic>
 <20181205180158.GA64770@gmail.com>
 <20181205190355.GP29510@zn.tnic>
 <20181206162703.GA119163@gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7D47B665@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D47B665@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:36:03PM +0000, Luck, Tony wrote:
> > So the real question is, is there a signifcant class of MCE events that 
> > are not tied to the reporting channel which is per CPU (-ish ...) MCA 
> > banks?
> 
> Perhaps QPI/UPI interconnect errors?

Whatever, this is pure bikeshedding what we're doing right now. All the
errors are reported through the CPU's MCA banks and the argument whether
an error class which is maybe not really tied to the CPU, should dictate
which path to put the files in, does not make any sense to me.

The only argument which makes sense IMO is whether the path should be
short. :-)

And both

arch/x86/cpu/mce/
arch/x86/mce/

are short enough to me.

Now, the real question is, how do we want to place the rest of the
files/folders so that we can get rid of deeper directory structures.

If we say, we don't want to have .../cpu/... and put everything in
arch/x86/ then this answers the above question too.

IMO, of course.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
