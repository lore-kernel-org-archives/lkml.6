Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07853C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B258E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B258E2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHQXo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:44:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeHQXo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:44:28 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7414CC74;
        Fri, 17 Aug 2018 20:39:37 +0000 (UTC)
Date:   Fri, 17 Aug 2018 13:39:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/compiler.h: don't use bool
Message-Id: <20180817133935.b93ce7534656e587d4c8d3e6@linux-foundation.org>
In-Reply-To: <20180817101036.20969-1-linux@rasmusvillemoes.dk>
References: <20180817101036.20969-1-linux@rasmusvillemoes.dk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 12:10:35 +0200 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Appararently, it's possible to have a non-trivial TU include a few headers,
> including linux/build_bug.h, without ending up with linux/types.h. So
> the 0day bot sent me

What's a "TU"?

> 
> config: um-x86_64_defconfig (attached as .config)
> 
> >> include/linux/compiler.h:316:3: error: unknown type name 'bool'; did you mean '_Bool'?
>       bool __cond = !(condition);    \
> 
> for something I'm working on.
> 
> Rather than contributing to the #include madness and including
> linux/types.h from compiler.h, just use int.
