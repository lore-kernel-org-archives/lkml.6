Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48D120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48D120C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeIRQch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:32:37 -0400
Received: from foss.arm.com ([217.140.101.70]:42518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbeIRQch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:32:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB7E0ED1;
        Tue, 18 Sep 2018 04:00:32 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DB473F5BD;
        Tue, 18 Sep 2018 04:00:32 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 69A9B1AE1181; Tue, 18 Sep 2018 12:00:51 +0100 (BST)
Date:   Tue, 18 Sep 2018 12:00:51 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Sasha Levin <Alexander.Levin@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.18 032/136] arm64: fix infinite stacktrace
Message-ID: <20180918110051.GB16498@arm.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
 <20180917030006.245495-32-alexander.levin@microsoft.com>
 <alpine.LRH.2.02.1809180654220.17180@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1809180654220.17180@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 06:55:34AM -0400, Mikulas Patocka wrote:
> This patch is not correct, because the stacktrace is supposed to work 
> around discontiguous interrupt stacks.
> 
> You should replace 'frame->fp <= fp' with 'frame->fp == fp'.

No, just drop the patch. It was already reverted upstream in
e87a4a92fba3. Can the AUTOSEL robot check for upstream reverts?

Will
