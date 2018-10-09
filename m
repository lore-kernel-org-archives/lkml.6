Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD07ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBFC204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBFC204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJJAxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:53:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbeJJAxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:53:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 129B4AD4E;
        Tue,  9 Oct 2018 17:35:27 +0000 (UTC)
Date:   Tue, 9 Oct 2018 19:35:26 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lijiang@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        thomas.lendacky@amd.com, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>, brijesh.singh@amd.com,
        dyoung@redhat.com, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
Message-ID: <20181009173526.GD17073@zn.tnic>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805812916.1157.177580438135143788.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180928164108.GE21895@zn.tnic>
 <CAErSpo7fO-bNCzxRXtREfs82OKjd0h3Yu8y+Ova7bhe3NyMd=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAErSpo7fO-bNCzxRXtREfs82OKjd0h3Yu8y+Ova7bhe3NyMd=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:30:33PM -0500, Bjorn Helgaas wrote:
> Sorry, I don't know what happened here because I didn't see these
> comments until today.  I suspect what happened was that my Gmail
> filter auto-filed them in my linux-kernel folder, which I don't read.
> On my @google.com account, I have another filter that pull out things
> addressed directly to me, which I *do* read.  But this thread didn't
> cc that account until the tip-bot message, which *did* cc my @google
> account because that's how I signed off the patches.  Sigh.

No worries, it all should be taken care of now! :-)

> Anyway, it looks like this stuff is on its way; let me know
> (bhelgaas@google.com) if I should do anything else.  I would address
> your comments above, but since this seems to be applied and I saw a
> cleanup patch from you, I assume you already took care of them.

Yeah, I think I've covered them all but if you see something out of the
ordinary, let me know so that I can fix it.

Thanks!

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
