Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE48AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B143720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B143720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeGWQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:13:02 -0400
Received: from ozlabs.org ([203.11.71.1]:51745 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbeGWQNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:13:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Z4h828kfz9s4s; Tue, 24 Jul 2018 01:11:19 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fdf743c5c51d5b45db4dada39109549d2e49eb62
In-Reply-To: <20180717042430.15395-1-david@gibson.dropbear.id.au>
To:     David Gibson <david@gibson.dropbear.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/hugetlbpage: Rmove unhelpful HUGEPD_*_SHIFT macros
Message-Id: <41Z4h828kfz9s4s@ozlabs.org>
Date:   Tue, 24 Jul 2018 01:11:19 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 04:24:30 UTC, David Gibson wrote:
> The HUGEPD_*_SHIFT macros are always defined to be PGDIR_SHIFT and
> PUD_SHIFT, and have to have those values to work properly.  They once used
> to have different values, but that was really only because they were used
> to mean different things in different contexts.
> 
> 6fa50483 "powerpc/mm/hugetlb: initialize the pagetable cache correctly for
> hugetlb" removed that double meaning, but left the now useless constants.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fdf743c5c51d5b45db4dada3910954

cheers
