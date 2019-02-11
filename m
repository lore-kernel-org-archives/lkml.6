Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC64C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7873721B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbfBKP1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:27:10 -0500
Received: from ms.lwn.net ([45.79.88.28]:46130 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfBKP1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:27:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E98502F3;
        Mon, 11 Feb 2019 15:27:06 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:27:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, Linux MM <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH] Documentation: fix vm/slub.rst warning
Message-ID: <20190211082705.0ff3d86b@lwn.net>
In-Reply-To: <1e992162-c4ac-fe4e-f1b0-d8a16a51d5e7@infradead.org>
References: <1e992162-c4ac-fe4e-f1b0-d8a16a51d5e7@infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 22:34:11 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix markup warning by quoting the '*' character with a backslash.
> 
> Documentation/vm/slub.rst:71: WARNING: Inline emphasis start-string without end-string.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> ---
>  Documentation/vm/slub.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-50-rc6.orig/Documentation/vm/slub.rst
> +++ lnx-50-rc6/Documentation/vm/slub.rst
> @@ -68,7 +68,7 @@ end of the slab name, in order to cover
>  example, here's how you can poison the dentry cache as well as all kmalloc
>  slabs:
>  
> -	slub_debug=P,kmalloc-*,dentry
> +	slub_debug=P,kmalloc-\*,dentry
>  
>  Red zoning and tracking may realign the slab.  We can just apply sanity checks
>  to the dentry cache with::

The better fix here is to make that a literal block ("slabs::").  Happily
for all of us, Tobin already did that in 11ede50059d0.

Thanks,

jon
