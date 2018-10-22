Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C4ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FCA20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FCA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeJVRzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:55:48 -0400
Received: from ozlabs.org ([203.11.71.1]:49057 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbeJVRzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:55:48 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42drzZ1HRvz9sDF; Mon, 22 Oct 2018 20:38:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3ff38e1874863827374b02b4f31c73faa3744e1c
In-Reply-To: <23d27ae15a7b0389fc26f2265f969c6c69f44009.1539433567.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/book3s64: fix dump_linuxpagetables "present" flag
Message-Id: <42drzZ1HRvz9sDF@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:38:01 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 06:37:41 UTC, Christophe Leroy wrote:
> Since commit bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to
> mark pte temporarily invalid."), _PAGE_PRESENT doesn't mean exactly
> that a page is present. A page is also considered preset when
> _PAGE_INVALID is set.
> 
> This patch changes the meaning of "present" and adds a status "valid"
> associated to the _PAGE_PRESENT flag.
> 
> Fixes: bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to mark pte temporarily invalid.")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3ff38e1874863827374b02b4f31c73

cheers
