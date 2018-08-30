Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7370C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5E42082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5E42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeH3N0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:26:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727780AbeH3N0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:26:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A55B5AEFC;
        Thu, 30 Aug 2018 09:25:34 +0000 (UTC)
Date:   Thu, 30 Aug 2018 11:26:06 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 2/3] x86/mm: add .data..decrypted section to hold
 shared variables
Message-ID: <20180830092606.GC18459@nazgul.tnic>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
 <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
 <20180829150314.GA32493@linux.intel.com>
 <0de361d4-1d1e-0584-f9d4-41bf5936e2be@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0de361d4-1d1e-0584-f9d4-41bf5936e2be@amd.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dropping stable@

On Wed, Aug 29, 2018 at 10:33:24AM -0500, Brijesh Singh wrote:
> During the initial SEV/SME patch review cycle we had some discussion about
> using decrypted vs unencrypted. At that time the consensus was
> that a memory range mapped with C=0 should be referred as 'decrypted'.

Yes, the idea was to avoid having "unencrypted" *and* "decrypted" to
mean pretty much the same thing for ease of understanding just by
looking at the name.

Also whether the data was initially unencrypted or was decrypted is
immaterial - you only need to know how to access it.

> Having said so, I do see your point and I am not oppose to calling it
> 'unencrypted' if others agrees to it.

No, please don't. Let's stick with "decrypted" for everything.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
