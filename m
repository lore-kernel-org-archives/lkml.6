Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8DBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44AD20855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Ot1JRQLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfBACes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:34:48 -0500
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:60078 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726968AbfBACer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548988486;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=GQG+fGJgX62Yh7Aovoer22fTd1EYeth0253wwis/ybU=;
        b=Ot1JRQLY1t5HLkohdl+kAWmNK2IJb1fnTVJJwtPo77WILVS7MeO26vryyDIWopuv
        JN/k1cC4dmt4I1nY1lGRh4QzcmBgDczc1JHqzYIlTNBs3I93kuq6q4pg9Uba8ilsKrf
        ArcCOLEgNXHDqgbb7s/QFEgxHtNokZbXYLFwPa+A=
Date:   Fri, 1 Feb 2019 02:34:46 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
In-Reply-To: <20190201004242.7659-1-tobin@kernel.org>
Message-ID: <01000168a6e8944d-b8e72739-2611-4649-a8d2-304b98529b7d-000000@email.amazonses.com>
References: <20190201004242.7659-1-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.01-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Tobin C. Harding wrote:

> Currently when displaying /proc/slabinfo if any cache names are too long
> then the output columns are not aligned.  We could do something fancy to
> get the maximum length of any cache name in the system or we could just
> increase the hardcoded width.  Currently it is 17 characters.  Monitors
> are wide these days so lets just increase it to 30 characters.

Hmm.. I wonder if there are any tools that depend on the field width here?

