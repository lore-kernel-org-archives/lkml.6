Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C418AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883A021873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eq0ENAhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeLSKhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:37:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeLSKhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:37:35 -0500
Received: from zn.tnic (p200300EC2BD1DB008D03BCFA6A977107.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:db00:8d03:bcfa:6a97:7107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21BE11EC0A98;
        Wed, 19 Dec 2018 11:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545215853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MFlZ6ujPSCs1GwHGBcXgFh+wiU43Xt9oucxOUcLB8HM=;
        b=eq0ENAhH64PxKWJea26QhS0GuPhqdWE+0/6Ic4JWr/RDLI7455LbKSn78O6IygqJSUnMi1
        A30hfOuz3nRSIH0BdKWJ3wJc0dyt9zO2ZutM5QwTQimDXIR6x800Dg/zZRu8UtXB0P4dRx
        tFJ0rR5fcW8UntJr8PHQQGAPwBP+ypA=
Date:   Wed, 19 Dec 2018 11:37:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 1/9] jump_label: Add for_each_label_entry helper
Message-ID: <20181219103733.GB18479@zn.tnic>
References: <cover.1545149539.git.bristot@redhat.com>
 <c1b514e312238c0fe4e22500d1d41c0f565cae28.1545149539.git.bristot@redhat.com>
 <20181218211923.GM7485@zn.tnic>
 <21a12942-2813-9b8a-9051-582070b5eda5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21a12942-2813-9b8a-9051-582070b5eda5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 08:38:03AM +0100, Daniel Bristot de Oliveira wrote:
> It is also used in the patch 9. But I can remove it, no problem.

Oh, that's a function with the same name but in the
HAVE_JUMP_LABEL_BATCH #else branch. Oh well, whatever people prefer.

In my case, I always end up looking at the macro definition anyway. But
this is just me.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
