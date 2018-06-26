Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40430C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2774265F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2774265F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeFZH0Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:26:24 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:46246 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeFZH0X (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Tue, 26 Jun 2018 03:26:23 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Tue, 26 Jun 2018 01:26:22 -0600
Message-Id: <5B31EA9C02000078001CDD33@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Tue, 26 Jun 2018 01:26:20 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Ingo Molnar" <mingo@kernel.org>
Cc:     <mingo@elte.hu>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [PATCH] x86: modernize sync_bitops.h
References: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
 <20180626071850.GC26761@gmail.com>
In-Reply-To: <20180626071850.GC26761@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 26.06.18 at 09:18, <mingo@kernel.org> wrote:
> * Jan Beulich <JBeulich@suse.com> wrote:
> 
>> Add missing insn suffixes and use rmwcc.h just like was (more or less)
>> recently done for bitops.h as well.
>> 
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> ---
>>  arch/x86/include/asm/sync_bitops.h |   34 ++++++++++++----------------------
>>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> Have you verified that a typical x86 vmlinux (with defconfig for example) is the 
> same before/after?

It works the same, but the binary is unlikely to be the same with the switch
to condition code asm() outputs.

Jan


