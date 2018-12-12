Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135A0C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D649A20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D649A20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeLLOXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:23:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeLLOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:23:46 -0500
Received: from [67.139.178.66] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gX5QJ-0004DS-R9; Wed, 12 Dec 2018 15:23:40 +0100
Date:   Wed, 12 Dec 2018 06:23:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
In-Reply-To: <38aca18b-4312-5e03-fdd9-86e47c332e44@amd.com>
Message-ID: <alpine.DEB.2.21.1812120621130.30793@nanos.tec.linutronix.de>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net> <20181212000518.GX27375@zn.tnic> <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de> <38aca18b-4312-5e03-fdd9-86e47c332e44@amd.com>
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

On Wed, 12 Dec 2018, Lendacky, Thomas wrote:
> On 12/11/2018 09:37 PM, Thomas Gleixner wrote:
> > On Wed, 12 Dec 2018, Borislav Petkov wrote:
> >> I still don't like that separate stibp_always_on variable when we can do
> >> all the querying just by using mode and X86_FEATURE_AMD_STIBP_ALWAYS_ON.
> > 
> > Hmmm. I've not seen the V1 of this (it's not in my inbox) but the v1->v2
> > changes contain:
> 
> That's strange, you were on the cc: list. Anyway, here's a link to the
> first version: https://lkml.org/lkml/2018/12/11/1248

Must have been my sleep deprived brain. Found it now :) Sorry for not
paying attention back then.

> >>> - Removed explicit SPECTRE_V2_USER_STRICT_PREFERRED mode
> > 
> > Now I really have to ask why?
> > 
> > Neither the extra variable nor the cpu feature check are pretty. An
> > explicit mode is way better in terms of code clarity and you get the proper
> > printout via spectre_v2_user_strings.
> > 
> > Hmm?
> 
> That is what the first version did. See if that's in-line with what
> you're thinking.

Yes, though I'm not too fond about the preferred wording, but can't come up
with anything better.

Thanks,

	tglx
