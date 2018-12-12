Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC5C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC37F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fZMeqYlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC37F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeLLUjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:39:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40088 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbeLLUjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:39:07 -0500
Received: from zn.tnic (p200300EC2BCDD800543C0EB17EF60A9B.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:d800:543c:eb1:7ef6:a9b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C49221EC096B;
        Wed, 12 Dec 2018 21:39:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544647145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N8/nML7J9YWCZEPLBvyw7ybzW2xCelTfc1p83+z5wH8=;
        b=fZMeqYlvI7wOvbLRtEV7JbpZXkX9TJNL3ApioocLpZ5ruMhu0vP5brLntavoXUIJE9qamE
        P4U96MLaOkWdlFN4C3TG9Z7+AvXmX+EPRHnYUKTVRAL6Pf/5fijaxf97UAx9t6FjIOqBSw
        BqZfMFkFQXP3ZIyxGqJpebH4Vxi2eJs=
Date:   Wed, 12 Dec 2018 21:39:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Maran Wilson <maran.wilson@oracle.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        bp@suse.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        mchehab@kernel.org, mingo@redhat.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com
Subject: Re: [PATCH v9 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Message-ID: <20181212203901.GI6653@zn.tnic>
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
 <20181211131825.GD27375@zn.tnic>
 <5fc083d4-1dbd-f2f9-3059-0e3e8dda9b25@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fc083d4-1dbd-f2f9-3059-0e3e8dda9b25@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:29:21AM -0800, Maran Wilson wrote:
> Is your question about what options you need to provide to Qemu? Or is your
> question about the SW implementation choices?
> 
> Assuming the former...

Yeah, that's what I wanted to know. But looking at it, I'm booting
bzImage here just as quickly and as flexible so I don't see the
advantage of this new method for my use case here of booting kernels
in qemu.

But maybe there's a good use case where firmware is slow and one doesn't
really wanna noodle through it or when one does start a gazillion VMs
per second or whatever...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
