Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3ABC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC4A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC4A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeIKSyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726985AbeIKSyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 088A6AF64;
        Tue, 11 Sep 2018 13:55:22 +0000 (UTC)
Date:   Tue, 11 Sep 2018 15:55:19 +0200
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
Message-ID: <20180911135519.GI11418@zn.tnic>
References: <1536586152.11460.40.camel@intel.com>
 <097eb5f5-2cd9-8b08-32c5-d90c8e0cbb6d@amd.com>
 <1536593297.11460.72.camel@intel.com>
 <11618b8b-4d1f-9307-35f0-3c0f0fc856ca@amd.com>
 <20180910164851.GC20286@zn.tnic>
 <3b8b4c9c-b0f6-1e08-3d26-0e146cd7189e@redhat.com>
 <20180911100142.GA11418@zn.tnic>
 <554c6fb5-0de4-5415-9970-0d09325d718b@redhat.com>
 <20180911102504.GC11418@zn.tnic>
 <cacb6865-e4ad-80c9-7482-23e480a61b0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cacb6865-e4ad-80c9-7482-23e480a61b0f@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:07:06PM +0200, Paolo Bonzini wrote:
> If the host TSCs are unsynchronized then yes, that's what happens.  And
> you can do live migration from synchronized to unsynchronized.

Which brings us back to my original question: why would we *ever* want
to support unsynchronized TSCs in a guest? Such machines are a real
abomination for baremetal - it doesn't make *any* sense to me to have
that in guests too, if it can be helped...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
