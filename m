Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A86C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23C92084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbeLTA6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:58:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:49965 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbeLTA6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:58:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 16:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,374,1539673200"; 
   d="scan'208";a="119714389"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 19 Dec 2018 16:58:41 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C06F7301325; Wed, 19 Dec 2018 16:58:41 -0800 (PST)
Date:   Wed, 19 Dec 2018 16:58:41 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH] x86/speculation: Don't inherit TIF_SSBD on execve()
Message-ID: <20181220005841.GW25620@tassilo.jf.intel.com>
References: <1545246590-12704-1-git-send-email-longman@redhat.com>
 <20181219193822.GU25620@tassilo.jf.intel.com>
 <f2cd45e2-e390-a6f6-f4fb-1d316be0f54c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2cd45e2-e390-a6f6-f4fb-1d316be0f54c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You can always force disable SSB. In that case, all the child processes
> will have SSBD on.

Okay that sounds reasonable, given the below. Thanks.

-Andi

> 
> >
> > Do you have a real use case where this behavior is a problem?
> >
> > -Andi
> 
> Yes, we have an enterprise application partner that found that their
> application slow down up to 10-20% depending on how their application
> was set up. With the slow setup, the application was spawned by Java
> processes causing the SSBD bit to stay on when the application was running.
