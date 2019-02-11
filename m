Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1C8C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B719B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBKBCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:02:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:41472 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfBKBCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:02:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1B0LjHR014682;
        Sun, 10 Feb 2019 18:21:46 -0600
Message-ID: <749f719a0881531cad2071a7011dc5e894812d3d.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 03/16] powerpc/32: move LOAD_MSR_KERNEL() into
 head_32.h and use it
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Feb 2019 11:21:44 +1100
In-Reply-To: <1946d8ed86a92a9a6827ec260d0d9c99e0d88184.1549630193.git.christophe.leroy@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
         <1946d8ed86a92a9a6827ec260d0d9c99e0d88184.1549630193.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 12:52 +0000, Christophe Leroy wrote:
>  /*
> + * MSR_KERNEL is > 0x8000 on 4xx/Book-E since it include MSR_CE.
> + */
> +.macro __LOAD_MSR_KERNEL r, x
> +.if \x >= 0x8000
> +       lis \r, (\x)@h
> +       ori \r, \r, (\x)@l
> +.else
> +       li \r, (\x)
> +.endif
> +.endm
> +#define LOAD_MSR_KERNEL(r, x) __LOAD_MSR_KERNEL r, x
> +

You changed the limit from >= 0x10000 to >= 0x8000 without a
corresponding explanation as to why...

Ben.

