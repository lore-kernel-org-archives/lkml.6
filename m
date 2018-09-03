Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622FD20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622FD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeICTXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:23:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57690 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:23:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B284D80D;
        Mon,  3 Sep 2018 08:02:33 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A44F33F557;
        Mon,  3 Sep 2018 08:02:32 -0700 (PDT)
Date:   Mon, 3 Sep 2018 16:02:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v3] kmemleak: add module param to print warnings to dmesg
Message-ID: <20180903150229.zwyc7nrjpacnwag3@armageddon.cambridge.arm.com>
References: <20180903144046.21023-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903144046.21023-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:40:46PM +0200, Vincent Whitchurch wrote:
> Currently, kmemleak only prints the number of suspected leaks to dmesg
> but requires the user to read a debugfs file to get the actual stack
> traces of the objects' allocation points.  Add a module option to print
> the full object information to dmesg too.  It can be enabled with
> kmemleak.verbose=1 on the kernel command line, or "echo 1 >
> /sys/module/kmemleak/parameters/verbose":
> 
> This allows easier integration of kmemleak into test systems:  We have
> automated test infrastructure to test our Linux systems.  With this
> option, running our tests with kmemleak is as simple as enabling
> kmemleak and passing this command line option; the test infrastructure
> knows how to save kernel logs, which will now include kmemleak reports.
> Without this option, the test infrastructure needs to be specifically
> taught to read out the kmemleak debugfs file.  Removing this need for
> special handling makes kmemleak more similar to other kernel debug
> options (slab debugging, debug objects, etc).
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v3: Expand use case description.  Replace config option with module parameter.
> 
>  mm/kmemleak.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
