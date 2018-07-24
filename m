Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5425DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185B320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185B320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeGXJK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:10:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbeGXJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:10:59 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A58BABA0;
        Tue, 24 Jul 2018 08:05:44 +0000 (UTC)
Date:   Tue, 24 Jul 2018 10:05:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the fsi tree
Message-ID: <20180724080541.GA29845@kroah.com>
References: <20180724160356.7f5a018d@canb.auug.org.au>
 <e3a66e2364db2e5439ca8e08cb0def3195d303a4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a66e2364db2e5439ca8e08cb0def3195d303a4.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 04:39:19PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-24 at 16:03 +1000, Stephen Rothwell wrote:
> > Hi Benjamin,
> > 
> > After merging the fsi tree, today's linux-next build (x86_64 allmodconfig)
> > produced this warning:
> 
> Ah thanks. It's a pair of missing "z" qualifiers in those dev_dbg.
> 
> This normally won't show as this driver can only be enabled on 32-bit
> ARM, but COMPILE_TEST will allow you to build it on x86_64 thus
> triggering the warning.
> 
> I've pushed a fix in the fsi tree.
> 
> Greg, do you want a new signed tag with the fix or that can wait
> for my next pull request ? I have a last bunch of chardev conversions
> and object lifetime fixes being reviewed that I was thinking of sending
> later this week.

Later this week is fine.

thanks,

greg k-h
