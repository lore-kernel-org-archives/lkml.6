Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECC22086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECC22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeIJU3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:29:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728043AbeIJU3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:29:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4ACEACFB;
        Mon, 10 Sep 2018 15:34:54 +0000 (UTC)
Date:   Mon, 10 Sep 2018 17:34:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 4/5] x86/kvm: use __decrypted attribute in shared
 variables
Message-ID: <20180910153452.GA20286@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-5-git-send-email-brijesh.singh@amd.com>
 <20180910120416.GD21815@zn.tnic>
 <1536585310.11460.34.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536585310.11460.34.camel@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:15:10AM -0700, Sean Christopherson wrote:
> Heh, that was the original formatting until I asked him to change it:
> https://lkml.org/lkml/2018/8/29/809.  Checkpatch throws an error if
> there's a newline after 'Commit'.  Though looking at this again, there
> shouldn't be a colon after 'Commit' and there should be quotes inside
> the parentheses, e.g. this satisfies checkpatch:

Yeah, we don't take checkpatch too seriously - only when it makes sense
to a human brain. Roughly speaking. In this case, the logic should be,
the commit which is the culprit should be visible immediately.

Although after the Fixes: tag thing got introduced, that argument is not
as important anymore, I'd say.

As to the formatting, I think adding this to your git config helps in
that regard:

[alias]
	...
        one = show -s --pretty='format:%h (\"%s\")'

so that you can do:

$ git one 368a540e0232
368a540e0232 ("x86/kvmclock: Remove memblock dependency")

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
