Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E33CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE7A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K83trPq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfAaGEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:04:04 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58881 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfAaGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:04:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EE552216C5;
        Thu, 31 Jan 2019 01:04:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 31 Jan 2019 01:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=pm74jFL5WdkgPbflaRWND5Onh5JGUH4RIyse6+Dyr
        EA=; b=K83trPq/lRQ5ZAEYokXtzAHdeVPm3lHZ2XLhKPZ1Zsbfke2/k8QO7KTo7
        THpV7spAKIn45V3f0rQuImWFcFOUTIQ4jNkjgo4VJIPdyJxtp3HF8fxNEKbJjUPD
        nXpxfqnLiHQB3k3oSQ9aPSEzwmNhi/NJy07HqBqyFZRShvRauN/0hCJ3au1UIwTG
        +u9oDb+RzauvtUYLsFzC1Pu9PX18t7HbFyZsL8K2/3fj8ELnW00sTecQLydtKNms
        ZgfIPB4DtqI0PBbWWkQU3GiVR0QGHxtXUpXNQ4Ryeb+N4iyTbC1YsZphigAEFEIk
        WZpcKW281KMOD6ZxSR/xd7w0iEpBw==
X-ME-Sender: <xms:z49SXPnAFRHox4N84sy9Ju_0Lj0jhLethXXOpyVz-6IXibBu7xD2vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffg
    ggjggtgfesthejredttdefjeenucfhrhhomheprfgvkhhkrgcugfhnsggvrhhguceophgv
    nhgsvghrghesihhkihdrfhhiqeenucfkphepkeelrddvjedrfeefrddujeefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpvghnsggvrhhgsehikhhirdhfihenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:z49SXFbA4teLOv1uCMRc_Xqar5Wsjw1P5yApBhpu1OdIsMtYqudJAg>
    <xmx:z49SXJT9vg4SSoatl62M3_ELW6vevYPm54aCx1yfgFyCRdwPq8c5ug>
    <xmx:z49SXHulIQlQ2D9nJdlhFTevbUaISQr3RPyNbDpmXEydkCwsPNdyqg>
    <xmx:0o9SXFRMUqNgS-UrW9XDztpykGZ86DDkTHRiFmH2wScin1ds_k6Xug>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id DDBC0E40FF;
        Thu, 31 Jan 2019 01:03:56 -0500 (EST)
Subject: Re: [PATCH] mm: Prevent mapping slab pages to userspace
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190125173827.2658-1-willy@infradead.org>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <f1cd3105-2d36-a699-ed4c-e293d26b828d@iki.fi>
Date:   Thu, 31 Jan 2019 08:03:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125173827.2658-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2019 19.38, Matthew Wilcox wrote:
> It's never appropriate to map a page allocated by SLAB into userspace.
> A buggy device driver might try this, or an attacker might be able to
> find a way to make it happen.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Pekka Enberg <penberg@kernel.org>

A WARN_ON_ONCE() would be nice here to let those buggy drivers know that 
they will no longer work.

> ---
>   mm/memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e11ca9dd823f..ce8c90b752be 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1451,7 +1451,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>   	spinlock_t *ptl;
>   
>   	retval = -EINVAL;
> -	if (PageAnon(page))
> +	if (PageAnon(page) || PageSlab(page))
>   		goto out;
>   	retval = -ENOMEM;
>   	flush_dcache_page(page);
> 
