Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B81C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D92E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D92E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeIKPA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:00:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbeIKPA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:00:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8586BB037;
        Tue, 11 Sep 2018 10:01:50 +0000 (UTC)
Date:   Tue, 11 Sep 2018 12:01:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
Message-ID: <20180911100142.GA11418@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
 <20180910122727.GE21815@zn.tnic>
 <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
 <1536586152.11460.40.camel@intel.com>
 <097eb5f5-2cd9-8b08-32c5-d90c8e0cbb6d@amd.com>
 <1536593297.11460.72.camel@intel.com>
 <11618b8b-4d1f-9307-35f0-3c0f0fc856ca@amd.com>
 <20180910164851.GC20286@zn.tnic>
 <3b8b4c9c-b0f6-1e08-3d26-0e146cd7189e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b8b4c9c-b0f6-1e08-3d26-0e146cd7189e@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:26:21AM +0200, Paolo Bonzini wrote:
> Usually the kvmclock structs are all the same, but there is support for
> old machines with inconsistent TSCs (across different sockets typically).

Would that be a problem, though? Sounds like an "improvement" to me. :-)

I mean, if we keep using the same TSC across all vCPUs, the guest will
actually see a single TSC and thus have stable and synchronized TSCs.
Unlike the host.

I.e., the guest will be better than the host! :-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
