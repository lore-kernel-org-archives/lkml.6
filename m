Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFB52151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFB52151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeHXWxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:53:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeHXWxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:53:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D247F76;
        Fri, 24 Aug 2018 19:17:52 +0000 (UTC)
Date:   Fri, 24 Aug 2018 21:17:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Roland Dreier <roland@purestorage.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bp@alien8.de,
        brgerst@gmail.com, davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
Message-ID: <20180824191749.GA15489@kroah.com>
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:08:28AM -0700, Roland Dreier wrote:
> > See
> > <https://lore.kernel.org/lkml/1512686629.18523.217.camel@codethink.co.uk/T/#u>.
> 
> Thanks!  I'm not using SGI UV and I'm not using kexec, so I guess I
> sidestepped most of those issues.  Greg, I think we need to unrevert
> the cpa->pfn change (otherwise the L1TF fix probably gets pretty
> messy) and I guess pull in the other patches that Ben mentions.

Ok, so what patch should be reverted?  I'm seeing other reports of
problems all around this same area, but I can't figure out exactly what
to do.

Guenter, any ideas?

thanks,

greg k-h
