Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D63C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9992064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9992064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH3Dmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:42:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeH3Dmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:42:50 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6670E25A;
        Wed, 29 Aug 2018 23:43:31 +0000 (UTC)
Date:   Wed, 29 Aug 2018 16:43:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] proc: readdir /proc/*/task
Message-Id: <20180829164330.435fb1d1c78e9d066e5eb862@linux-foundation.org>
In-Reply-To: <20180828193502.GB4847@avx2>
References: <20180827231503.26899-1-adobriyan@gmail.com>
        <20180827231503.26899-11-adobriyan@gmail.com>
        <20180828123622.GA2087@darwi-kernel>
        <20180828130440.GA6464@darwi-kernel>
        <20180828193502.GB4847@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 22:35:02 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > Are we really in a super hot path to justify all that?
> 
> /proc is very slow, try profiling just about anything involving /proc.

So how much does this patchset help?  Some timing measurements would
really help things along, if they show goodness.

