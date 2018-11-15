Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204492145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204492145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeKOV7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:59:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbeKOV7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:59:53 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V0iz64xxsmG7; Thu, 15 Nov 2018 12:52:19 +0100 (CET)
Received: from zn.tnic (p200300EC2BD00900D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:900:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98E6B1EC0377;
        Thu, 15 Nov 2018 12:52:19 +0100 (CET)
Date:   Thu, 15 Nov 2018 12:52:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Message-ID: <20181115115213.GE26448@zn.tnic>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-4-david@redhat.com>
 <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
 <20181115111023.GC26448@zn.tnic>
 <4aa5d39d-a923-87de-d646-70b9cbfe62f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aa5d39d-a923-87de-d646-70b9cbfe62f0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:20:40PM +0100, David Hildenbrand wrote:
> Sorry to say, but that is the current practice without which
> makedumpfile would not be able to work at all. (exclude user pages,
> exclude page cache, exclude buddy pages). Let's not reinvent the wheel
> here. This is how dumping works forever.

Sorry, but "we've always done this in the past" doesn't make it better.

> I don't see how there should be "set of pages which do not have
> PG_offline".

It doesn't have to be a set of pages. Think a (mmconfig perhaps) region
which the kdump kernel should completely skip because poking in it in
the kdump kernel, causes all kinds of havoc like machine checks. etc.
We've had and still have one issue like that.

But let me clarify my note: I don't want to be discussing with you the
design of makedumpfile and how it should or should not work - that ship
has already sailed. Apparently there are valid reasons to do it this
way.

I was *simply* stating that it feels wrong to export mm flags like that.

But as I said already, that is mm guys' call and looking at how we're
already exporting a bunch of stuff in the vmcoreinfo - including other
mm flags - I guess one more flag doesn't matter anymore.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
