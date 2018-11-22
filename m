Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E900EC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50DD20892
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="diYQAdNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50DD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392755AbeKWGpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:45:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKWGpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3iMUh2dkWeYr3Wxskhu4eNYKLzoeaX8kLN4jP9KbV3Y=; b=diYQAdNo0/Z1OVDUdcJUj5cyr
        kFIDSxC0oD+zPTGgG2cpefx6eEjJueDDF8bO7wAL31DT08IZKtnQSXTeBQiE0S26khoHh8+iLeUU0
        tnhLlAdFPNmETrYCM7lM0c5OOdYuv+NqNC4Wp8cj2oNY0b4R+gUZyxL+zgytlZbX13RKtQs0u5R2O
        tx6TRpwrOeoaT/hJ5gguBahHSBlwQryWsQtuOdOgeW4njwKYevV4rKDrju0cESv4JTKHDMw8OvUF8
        6ONLalQU7wN46hsiNcn+98H1iKB+zSYY9sKiM1ySrQXZ2lTOKdOB+w48QC7WnabPA9ITd+Rzk+7WJ
        e2mXwOvkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPvCy-0007Hx-D4; Thu, 22 Nov 2018 20:04:16 +0000
Date:   Thu, 22 Nov 2018 12:04:16 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/17] prmem: documentation
Message-ID: <20181122200416.GS3065@bombadil.infradead.org>
References: <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
 <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
 <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
 <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
 <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
 <3BB9DE07-E0AE-43E2-99F1-E4AA774CD462@amacapital.net>
 <5e10c8e4-aa71-1eea-b1ce-50d7d0a60e8c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e10c8e4-aa71-1eea-b1ce-50d7d0a60e8c@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:27:02PM +0200, Igor Stoppa wrote:
> I have studied the code involved with Nadav's patchset.
> I am perplexed about these sentences you wrote.
> 
> More to the point (to the best of my understanding):
> 
> poking_init()
> -------------
>   1. it gets one random poking address and ensures to have at least 2
>      consecutive PTEs from the same PMD
>   2. it then proceeds to map/unmap an address from the first of the 2
>      consecutive PTEs, so that, later on, there will be no need to
>      allocate pages, which might fail, if poking from atomic context.
>   3. at this point, the page tables are populated, for the address that
>      was obtained at point 1, and this is ok, because the address is fixed
> 
> write_rare
> ----------
>   4. it can happen on any available core / thread at any time, therefore
>      each of them needs a different address

No?  Each CPU has its own CR3 (eg each CPU might be running a different
user task).  If you have _one_ address for each allocation, it may or
may not be mapped on other CPUs at the same time -- you simply don't care.

The writable address can even be a simple formula to calculate from
the read-only address, you don't have to allocate an address in the
writable mapping space.

