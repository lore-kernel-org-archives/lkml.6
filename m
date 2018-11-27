Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50CCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9FE20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9FE20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbeK1C0E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:26:04 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:48840 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbeK1C0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:26:04 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 21:26:03 EST
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id E2002149B5; Tue, 27 Nov 2018 15:20:24 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix insert_pfn() return value
References: <20181127144351.9137-1-mans@mansr.com>
        <20181127150852.GA10377@bombadil.infradead.org>
Date:   Tue, 27 Nov 2018 15:20:24 +0000
In-Reply-To: <20181127150852.GA10377@bombadil.infradead.org> (Matthew Wilcox's
        message of "Tue, 27 Nov 2018 07:08:52 -0800")
Message-ID: <yw1x8t1elf7r.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Nov 27, 2018 at 02:43:51PM +0000, Mans Rullgard wrote:
>> Commit 9b5a8e00d479 ("mm: convert insert_pfn() to vm_fault_t") accidentally
>> made insert_pfn() always return an error.  Fix this.
>
> Umm.  VM_FAULT_NOPAGE is not an error.  It's saying "I inserted the PFN,
> there's no struct page for the core VM to do anything with".  Which is
> the correct response from a device driver which has called insert_pfn().
>
> Could you explain a bit more what led you to think there's a problem here?

Apparently some (not in mainline) driver code had been hastily converted
to the vm_fault_t codes, and that is where the error is.  Sorry for the
noise.  Please disregard this.

(The quickest way to get the correct answer is still to send a bad
patch.)

> Also, rather rude of you not to cc the patch author when you claim to
> be fixing a bug in their patch.

Sorry about that.  Blame the get-maintainers script.

-- 
Måns Rullgård
