Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C3320657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547471184;
	bh=PNSV2S9St9Dx9NZv4nOezUpI5b3WN94UrwmZZY0998o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y9kpsRT0M3WfPqYl/Sr4W3rPzav3/bjPcf+oQlFC7j7myxbFs2g1wgz5ma13IWsbY
	 gv9JHitpYZltSPu5PgAfUOp6q6OfYRgd84ZAANYQ30tZUiKqvZoKE4PfEIqYB5oGQ6
	 gJzDlHVP3fOKc1rSo3d5yHZlJoesSP5gTkSTxztI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfANNGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:06:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:38958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfANNGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:06:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 899DFAD6B;
        Mon, 14 Jan 2019 13:06:20 +0000 (UTC)
Date:   Mon, 14 Jan 2019 14:06:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
In-Reply-To: <20190114130153.GC21544@amd>
Message-ID: <nycvar.YFH.7.76.1901141403550.6626@cbobk.fhfr.pm>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com> <20181228103437.4c03c181@lwn.net> <aed62eaa-93b4-8dc5-1920-6a5547e349c8@linux.intel.com> <20190113231001.GB18710@amd> <nycvar.YFH.7.76.1901140012110.6626@cbobk.fhfr.pm>
 <20190114120157.GB21544@amd> <nycvar.YFH.7.76.1901141305220.6626@cbobk.fhfr.pm> <20190114130153.GC21544@amd>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Pavel Machek wrote:

> Frankly I'd not call it Meltdown, as it works only on data in the cache, 
> so the defense is completely different. Seems more like a l1tf
> :-).

Meltdown on x86 also seems to work only for data in L1D, but the pipeline 
could be constructed in a way that data are actually fetched into L1D 
before speculation gives up, which is not the case on ppc (speculation 
aborts on L2->L1 propagation IIRC). That's why flushing L1D on ppc is 
sufficient, but on x86 it's not.

-- 
Jiri Kosina
SUSE Labs

