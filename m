Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64928C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2687D20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ggd2fqhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfBEM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:26:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49400 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbfBEM0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:26:48 -0500
Received: from zn.tnic (p200300EC2BCB6B00551F5C4602011D50.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:551f:5c46:201:1d50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2883E1EC0943;
        Tue,  5 Feb 2019 13:26:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549369607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GilOkvYlGQsVC3azc/3Vq1mBlw+AdqkuhbfOq97SNlI=;
        b=Ggd2fqhfGijikN6tan4F30a+cGv34BgwGyT86GYDFH0tRf2q+Fg2CvxLjSkDO6dOCOyPpO
        UiYqJFnzaN5G3wyTvdC7FrX57sm4uBNwQ+IMpp18cRgJp0i/Ncx9fll7ao2FnfHtSoKN6J
        x0YtOIYQdxoqw7BV4Rm8dxGI4QtU/f4=
Date:   Tue, 5 Feb 2019 13:26:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V7 1/5] x86/cpufeature: Add facility to check for min
 microcode revisions
Message-ID: <20190205122641.GM21801@zn.tnic>
References: <1549319013-4522-1-git-send-email-kan.liang@linux.intel.com>
 <20190205114616.GQ17528@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205114616.GQ17528@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:46:16PM +0100, Peter Zijlstra wrote:
> So Boris asked me to remove the tail comments (done), but what about I
> do: % s/\<x86\>/&_family/g, on the rest of this too? I know we have
> cpuinfo_x86::x86 history, but at some point we should rename that too.

My argument was to keep them the same as cpuinfo_x86's members so that
there's no confusion.

But renaming the family member to x86_family makes sense to me. We
should do it some flag day.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
