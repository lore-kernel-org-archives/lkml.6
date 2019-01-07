Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EADC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D89F2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfAGWK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:10:27 -0500
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:37838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbfAGWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:10:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9A62318021E99;
        Mon,  7 Jan 2019 22:10:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fruit85_3621416afa1f
X-Filterd-Recvd-Size: 2707
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Jan 2019 22:10:23 +0000 (UTC)
Message-ID: <8ec3603317f477fe9923b87499a33da7a2cf81ff.camel@perches.com>
Subject: Re: [PATCH v3] coding-style: Clarify the expectations around bool
From:   Joe Perches <joe@perches.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Date:   Mon, 07 Jan 2019 14:10:22 -0800
In-Reply-To: <20190107211117.GA24142@ziepe.ca>
References: <20190107211117.GA24142@ziepe.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 14:11 -0700, Jason Gunthorpe wrote:
> There has been some confusion since checkpatch started warning about bool
> use in structures, and people have been avoiding using it.
> 
> Many people feel there is still a legitimate place for bool in structures,
> so provide some guidance on bool usage derived from the entire thread that
> spawned the checkpatch warning.

Thanks Jason.

It'd be nice to combine this with some better
checkpatch warning or even a removal of that
misleading warning from checkpatch altogether.

With a couple minor nits below and and Ack if
you want one:

Acked-by: Joe Perches <joe@perches.com>

> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
[]
> @@ -921,7 +921,37 @@ result.  Typical examples would be functions that return pointers; they use
>  NULL or the ERR_PTR mechanism to report failure.
>  
>  
> -17) Don't re-invent the kernel macros
> +17) Using bool
> +--------------
> +
> +The Linux kernel uses the C99 standard for the bool type. bool values can only

Maybe

The Linux kernel bool type is the C99 _Bool type.

> +evaluate to 0 or 1, and implicit or explicit conversion to bool automatically
> +converts the value to true or false. When using bool types the !! construction
> +is not needed, which eliminates a class of bugs.
> +
> +When working with bool values the true and false labels should be used instead

true and false are not labels but #defines


