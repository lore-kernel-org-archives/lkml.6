Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E03C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FCF2654C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FCF2654C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeFZGcg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:32:36 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:57809 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeFZGcf (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Tue, 26 Jun 2018 02:32:35 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Tue, 26 Jun 2018 00:32:34 -0600
Message-Id: <5B31DDFF02000078001CDC03@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Tue, 26 Jun 2018 00:32:31 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     <mingo@elte.hu>, <rdunlap@infradead.org>, <tglx@linutronix.de>,
        <hpa@zytor.com>
Cc:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
 <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
In-Reply-To: <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 25.06.18 at 18:33, <rdunlap@infradead.org> wrote:
> On 06/25/2018 03:25 AM, Jan Beulich wrote:
>> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms - use
>> 32-bit ones instead.
> 
> Hmph.  Is that considered a bug (errata)?

No.

> URL/references?

Intel's Optimization Reference Manual says so (in rev 040 this is in section
16.2.2.5 "Zeroing Idioms" as a subsection of the Goldmont/Silvermont
descriptions).

> Are these changes really only zeroing the lower 32 bits of the register?
> and that's all that the code cares about?

No - like all operations targeting a 32-bit register, the result is zero
extended to the entire 64-bit destination register.

Jan


