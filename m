Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA99C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4498822B70
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4498822B70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeGFVpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:45:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeGFVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:45:35 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E4FFD23;
        Fri,  6 Jul 2018 21:45:35 +0000 (UTC)
Date:   Fri, 6 Jul 2018 14:45:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        valdis.kletnieks@vt.edu
Subject: Re: [PATCH] radix-tree: avoid NULL dereference
Message-Id: <20180706144534.be6de0d9222e9755a3a09a2e@linux-foundation.org>
In-Reply-To: <20180706153640.53ot2cqm3varx7td@lakrids.cambridge.arm.com>
References: <20180706134144.48446-1-mark.rutland@arm.com>
        <20180706142540.GB20816@bombadil.infradead.org>
        <20180706143603.xrjt4wn5pkuy25sf@lakrids.cambridge.arm.com>
        <20180706153640.53ot2cqm3varx7td@lakrids.cambridge.arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 16:36:41 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> > > 
> > > Acked-by: Matthew Wilcox <willy@infradead.org>
> > 
> > Cheers!
> > 
> > I assume that Andrew will pick this up, if he's also happy with it.
> 
> I've just started fuzzing, and found this also applies with
> node_tag_set(). I'll spin a v2 with that fixed up, too.

Thanks.  Please also give some thought to whether the fix should be
backported and if so, which patch(es) it Fixes:.
