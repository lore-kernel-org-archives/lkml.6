Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B01C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41FF213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41FF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJIAtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:49:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJIAtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:49:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80C183002E2A;
        Mon,  8 Oct 2018 17:36:17 +0000 (UTC)
Received: from treble (ovpn-121-208.rdu2.redhat.com [10.10.121.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE23967E7A;
        Mon,  8 Oct 2018 17:36:16 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:36:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unwind_init() takes 100 ms
Message-ID: <20181008173614.bchqq6unw65bc57x@treble>
References: <81a1ff79-b303-c384-f926-c9618afac8f0@molgen.mpg.de>
 <20181008173417.crlfndi3p5pevnx3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181008173417.crlfndi3p5pevnx3@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 08 Oct 2018 17:36:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 12:34:17PM -0500, Josh Poimboeuf wrote:
> > 4.  Would a command line parameter be reasonable `disable_unwind`, so people
> > could decrease their boot time with distribution kernels, and easily turn it
> > back on, when they need a stacktrace without having to rebuild the Linux
> > kernel?
> 
> I think a boot cmdline option to disable ORC would be ok.  However,
> disabling ORC would need to fall back to the "guess" unwinder.
> Otherwise it would make debugging impossible.  That shouldn't be too
> hard, but it would require restructuring the code a bit.

But I should also clarify that this option wouldn't be worth it.
Sorting at build time is the way to go.

-- 
Josh
