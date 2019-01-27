Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8BC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A0120C01
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfA0Uqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:46:51 -0500
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:53742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbfA0Uqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:46:51 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0433B100E86C2;
        Sun, 27 Jan 2019 20:46:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dad92_140dc6d67e45
X-Filterd-Recvd-Size: 1562
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Jan 2019 20:46:48 +0000 (UTC)
Message-ID: <6e166e2d25a56212c06c1334fd9bfb09d14beff0.camel@perches.com>
Subject: Re: [PATCH v2 1/1] int_sqrt() adjustments
From:   Joe Perches <joe@perches.com>
To:     Florian La Roche <florian.laroche@googlemail.com>,
        linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian La Roche <Florian.LaRoche@gmail.com>
Date:   Sun, 27 Jan 2019 12:46:47 -0800
In-Reply-To: <20190127203239.973-1-Florian.LaRoche@gmail.com>
References: <20190127203239.973-1-Florian.LaRoche@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-01-27 at 21:32 +0100, Florian La Roche wrote:
> Add __attribute_const__ and use normal ints for the right param of "<<".
[]
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
[]
> @@ -513,10 +513,10 @@ extern int __kernel_text_address(unsigned long addr);
>  extern int kernel_text_address(unsigned long addr);
>  extern int func_ptr_is_kernel_text(void *ptr);
>  
> -unsigned long int_sqrt(unsigned long);
> +__attribute_const__ unsigned long int_sqrt(unsigned long);

This might as well return u32 to be consistent with int_sqrt64


