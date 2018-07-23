Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A2AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D4920779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D4920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbeGWQNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:13:01 -0400
Received: from ozlabs.org ([203.11.71.1]:43291 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbeGWQNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:13:00 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Z4h573nxz9s7c; Tue, 24 Jul 2018 01:11:17 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8c8c10b90d88bfaad41ea34df17bf6f18d00f09d
In-Reply-To: <4302f36bd615c179c92f2007a0f3a1215ba96c55.1531439662.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: fix handling of early NULL pointer dereference
Message-Id: <41Z4h573nxz9s7c@ozlabs.org>
Date:   Tue, 24 Jul 2018 01:11:17 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 13:10:47 UTC, Christophe Leroy wrote:
> NULL pointers are pointers to user memory space. So user pagetable
> has to be set in order to avoid random behaviour in case of NULL
> pointer dereference, otherwise we may encounter random memory
> access hence Machine Check Exception from TLB Miss handlers.
> 
> Set user pagetable as early as possible in order to properly
> catch early kernel NULL pointer dereference.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c8c10b90d88bfaad41ea34df17bf6

cheers
