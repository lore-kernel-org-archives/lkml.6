Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674E9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E429204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TK7Sp2ZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E429204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeI1XGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:06:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeI1XGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xgwjnTvayf+L6F/C4e9YJ+e1F+TcO0YCZ5iolqEmcAA=; b=TK7Sp2ZQlHi9fhOjS5ytrFUBw
        KNuFNwWIF+pRl06KeBoPEZhtqCEMEKH3G3rZ9Ej1pLQpIUwT068tGOrzqfwtYqL7yF+qOuqGIheMU
        Ry8iYjmpysneJP9e9Q9JuC8ee5sae5uIJwrI0NBsO94uziD0KfijQMzQb0QUo509CaIMgtb36l9Nb
        mOxvTQmH1XLgogVmeOhZoIkXX0As5pu5zK9WWPiQxUd2LJM5EnTTHjyzYNh7nStQeR3n2nVgY9WcC
        +nvYVAYm6ocEc+bKPlMtwtK+3f9aw6gl+g+k5iKOUWBJc96JAnCfplm2Nv9PFVXjxJXckqCl5mrwy
        6PCSTeSSQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5vq9-0002UY-20; Fri, 28 Sep 2018 16:42:05 +0000
Date:   Fri, 28 Sep 2018 09:42:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] fuse: allow caching readdir
Message-ID: <20180928164204.GA20414@bombadil.infradead.org>
References: <20180928154234.19270-1-mszeredi@redhat.com>
 <20180928154234.19270-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928154234.19270-5-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 05:42:29PM +0200, Miklos Szeredi wrote:
> @@ -103,6 +103,21 @@ struct fuse_inode {
>  	/** List of writepage requestst (pending or sent) */
>  	struct list_head writepages;
>  
> +	/** readdir cache */
> +	struct {
> +		/** true if fully cached */
> +		bool cached;

umm, you're using kernel-doc markers without formatting this comment as
kernel-doc.  See Documentation/doc-guide/kernel-doc.rst but I believe
you should be writing this as:

		/** @rdc.cached: true if fully cached */

or just use /* */ if you don't want kernel-doc.
