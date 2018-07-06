Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D6CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2990D22ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2990D22ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeGFV6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:58:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeGFV5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:57:55 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0ED7ADB1;
        Fri,  6 Jul 2018 21:57:55 +0000 (UTC)
Date:   Fri, 6 Jul 2018 14:57:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] bitops: Introduce BITS_PER_TYPE
Message-Id: <20180706145753.b186b0b22d9c55744b77f385@linux-foundation.org>
In-Reply-To: <20180706094458.14116-1-chris@chris-wilson.co.uk>
References: <20180706094458.14116-1-chris@chris-wilson.co.uk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 10:44:58 +0100 Chris Wilson <chris@chris-wilson.co.uk> wrote:

> net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
> number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the
> macro to bitops.h, alongside BITS_PER_BYTE, for wider usage.

A bit of grepping shows that there's quite a lot of code which does
sizeof(blah)*BITS_PER_BYTE.  Fun newbie project.
