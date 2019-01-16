Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A124C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B90205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gCxLFuFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbfAPP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:26:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391324AbfAPP0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:26:52 -0500
Received: from zn.tnic (p200300EC2BC98A0051F7D431547F2E6D.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:51f7:d431:547f:2e6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5F3A1EC0573;
        Wed, 16 Jan 2019 16:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547652410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MYYorcIRUcXhg1zAafpo1eOtw408X5CfmY13stII8+Q=;
        b=gCxLFuFqWz0trqQ21LV/F7ght8cSmlScT2sefI5iYplL+iZGaYVGZDOQJ9Y94NvXnXRIao
        kH+jQbeX85ruvz1QI2TabdQrEHpea32Q1FJ5LD9QCzY5VnNDbjXeYRL9E1vNU8ohLFBRSB
        Jboa9eC0msbLk43J+E9+wNzqp+qrQmo=
Date:   Wed, 16 Jan 2019 16:26:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Message-ID: <20190116152643.GH15409@zn.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
 <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
 <20190114103312.GG2773@zn.tnic>
 <2ad4bb63-2b70-3652-3261-009cdbfc15a9@amd.com>
 <20190114153256.GM2773@zn.tnic>
 <4f8b532b-8613-feb5-7474-4bb0462cf1c7@amd.com>
 <20190115172659.GE6596@zn.tnic>
 <8bed39c8-df48-dbb9-3674-dfbc4aea2967@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bed39c8-df48-dbb9-3674-dfbc4aea2967@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:14:29PM +0000, S wrote:
> Done. Hope the mailer is fine now, i have added --from while sending the 
> new patchset and also got it reviewed from folks here.

No, it isn't. And the problem is not git. The problem is your normal emails
you're sending. Look at what you just sent:

https://lore.kernel.org/lkml/8bed39c8-df48-dbb9-3674-dfbc4aea2967@amd.com/raw

and especially your From: field:

From:   S@vger.kernel.org

Is that your email address?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
