Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226FC214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226FC214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbeKUXhD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:37:03 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:48429 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeKUXhD (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Wed, 21 Nov 2018 18:37:03 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 21 Nov 2018 06:02:45 -0700
Message-Id: <5BF5577202000078001FE7AC@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 21 Nov 2018 06:02:42 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "David Laight" <David.Laight@ACULAB.COM>
Cc:     <mingo@elte.hu>, <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <hpa@zytor.com>
Subject: RE: [PATCH v2] x86: modernize sync_bitops.h
References: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
 <5B30C2C302000000000FA99B@prv1-mh.provo.novell.com>
 <5B30C2C302000078001FE5A0@prv1-mh.provo.novell.com>
 <5BF52F4D02000078001FE5C1@prv1-mh.provo.novell.com>
 <92f590595593498eaa1f91a17875126f@AcuMS.aculab.com>
In-Reply-To: <92f590595593498eaa1f91a17875126f@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 21.11.18 at 12:55, <David.Laight@ACULAB.COM> wrote:
> From: Jan Beulich
>> Sent: 21 November 2018 10:11
>> 
>> Add missing insn suffixes and use rmwcc.h just like was (more or less)
>> recently done for bitops.h as well.
> 
> Why? bts (etc) on memory don't really have an 'operand size'.

Of course they do - depending on operand size they operate on
2-, 4-, or 8-byte quantities. When the second operand is a
register, the suffix is redundant (but doesn't hurt), but when
the second operand is an immediate, the assembler (in AT&T
syntax) has no way of knowing what operand size you mean.

Jan


