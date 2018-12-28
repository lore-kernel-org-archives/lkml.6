Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009AC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88DB20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbeL1Rek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:34:40 -0500
Received: from ms.lwn.net ([45.79.88.28]:42464 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbeL1Rej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:34:39 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 648972D9;
        Fri, 28 Dec 2018 17:34:38 +0000 (UTC)
Date:   Fri, 28 Dec 2018 10:34:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
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
Message-ID: <20181228103437.4c03c181@lwn.net>
In-Reply-To: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 09:44:44 -0800
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> Andi and I have made an update to our draft of the Spectre admin guide.
> We may be out on Christmas vacation for a while.  But we want to
> send it out for everyone to take a look.
> 
> Thanks.
> 
> Tim
> 
> From: Andi Kleen <ak@linux.intel.com>
> 
> There are no document in admin guides describing
> Spectre v1 and v2 side channels and their mitigations
> in Linux.
> 
> Create a document to describe Spectre and the mitigation
> methods used in the kernel.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  Documentation/admin-guide/spectre.rst | 502 ++++++++++++++++++++++++++++++++++
>  1 file changed, 502 insertions(+)
>  create mode 100644 Documentation/admin-guide/spectre.rst

I only saw this now, seems I wasn't copied... I'll take a deeper look, but
I have a couple of meta comments:

 - This could arguably go in the security book rather than the admin
   guide.  I don't really have a strong opinion on which is right at the
   moment, but others might.

 - Wherever it ends up, can you also please add it to the appropriate
   index.rst file so it actually gets built with the rest of the docs?

Thanks,

jon
