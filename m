Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A47C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0071F20896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VOOS182b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfANPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:33:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfANPdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:33:04 -0500
Received: from zn.tnic (p200300EC2BC4CA0069059D8206A41D25.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:6905:9d82:6a4:1d25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55EBA1EC0586;
        Mon, 14 Jan 2019 16:33:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547479982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EEHAyED4L4wcZBkmVPjqfJ8N393VCeyec4F4ue77MSQ=;
        b=VOOS182bfE5ncduGPgvx0KiIPUmsdbhh4xa98D4I5eNzpFVFE7pyEYQ93VPV1V1cuyzHKj
        /HmRslxKrhkr3Cq9ZT6Mul71fHwZuCeD4niZkgc0at+cMtACfVGIRQq5CtMqwThkaa3S2g
        +pgHguGCg6lYQeLe8FY1YGpDUaffE1s=
Date:   Mon, 14 Jan 2019 16:32:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Message-ID: <20190114153256.GM2773@zn.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
 <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
 <20190114103312.GG2773@zn.tnic>
 <2ad4bb63-2b70-3652-3261-009cdbfc15a9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ad4bb63-2b70-3652-3261-009cdbfc15a9@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:26:50PM +0000, S wrote:
> I will get back with a thorough confirmation from the hw folks.
> 
> Since Yazen is on vacation, i will consult with him too once he is back.
> 
> Thanks for all the comments, i shall implement the same in case there 
> would be another re-spin.

Ok, thx.

> > Btw, fix your mailer: It has an empty from:
> >
> > From: S
> >
> > which, when I do "reply-to-all" here, generates an empty To: too.

Btw, your mailer is still broken. What I see here is:

From: S
To: Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	...


Please talk to your colleagues how to fix that. Adding some of them to
CC.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
