Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19D92186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeLTPlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:41:52 -0500
Received: from ms.lwn.net ([45.79.88.28]:53502 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeLTPlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:41:51 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5A0D0182;
        Thu, 20 Dec 2018 15:41:51 +0000 (UTC)
Date:   Thu, 20 Dec 2018 08:41:50 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-doc@vger.kernel.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: fix wrong name of struct in documentation
Message-ID: <20181220084150.3075f8d7@lwn.net>
In-Reply-To: <20181207191158.18769-1-helen.koike@collabora.com>
References: <20181207191158.18769-1-helen.koike@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 17:11:58 -0200
Helen Koike <helen.koike@collabora.com> wrote:

> The name of the struct is configfs_bin_attribute instead of
> configfs_attribute
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> 
>  Documentation/filesystems/configfs/configfs.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/configfs/configfs.txt b/Documentation/filesystems/configfs/configfs.txt
> index 3828e85345ae..16e606c11f40 100644
> --- a/Documentation/filesystems/configfs/configfs.txt
> +++ b/Documentation/filesystems/configfs/configfs.txt
> @@ -216,7 +216,7 @@ be called whenever userspace asks for a write(2) on the attribute.
>  
>  [struct configfs_bin_attribute]
>  
> -	struct configfs_attribute {
> +	struct configfs_bin_attribute {
>  		struct configfs_attribute	cb_attr;
>  		void				*cb_private;
>  		size_t				cb_max_size;

The document is clearly wrong, and this patch makes it better, so I've
applied it - thanks!

That said, the structure appears to have grown some fields that are not
reflected in the document; I suspect that there's much more in there that
is somewhat fictional at this point.  Hopefully somebody someday can help
to fix it up.

Thanks,

jon
