Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F48C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0026B208E8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0026B208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeHYIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 04:25:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbeHYIZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 04:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DEC9AEA7;
        Sat, 25 Aug 2018 04:47:38 +0000 (UTC)
Date:   Sat, 25 Aug 2018 06:47:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
Message-ID: <20180825044749.GA19545@nazgul.tnic>
References: <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic>
 <20180822150033.GA14200@linux.intel.com>
 <4d6ee892-a34f-28b3-18b7-1c663eb281c6@amd.com>
 <9635ebf0-7c99-6edf-1240-8dec28036a70@redhat.com>
 <20180823152907.GA1488@linux.intel.com>
 <60acb594-abe3-912f-9702-2f34961e575d@redhat.com>
 <c565ae1c-c2f0-8a43-b1f5-404c2efe7c56@amd.com>
 <25d2cf1f-11ee-ecba-73a9-15a9553a3d96@redhat.com>
 <47b8f9dc-fb55-f14d-cb88-343810ad5763@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b8f9dc-fb55-f14d-cb88-343810ad5763@amd.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 01:47:10PM -0500, Brijesh Singh wrote:
> I am more inclined towards creating a new section with PMD aligned and
> sized. This section will contains the decrypted data. In early
> boot code we will update the mapping with C=0. If caller wants to create
> a shared variable then it can do so with:
> 
> static int foo __decrypted;

Right, and keeping the SEV-ES's GHCB in mind, you could make that
section extensible so that the GHCB's 4K page can land there too. Maybe
something like a PMD-aligned range of 4K pages which are fully defined
and which hypervisor and guest can share and can be used for all kinds of
communication in the future...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
