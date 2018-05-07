Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeEGLQ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:16:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEGLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:16:57 -0400
Date: Mon, 7 May 2018 04:16:44 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] vfs: dedupe: rationalize args
Message-ID: <20180507111644.GB18116@bombadil.infradead.org>
References: <20180507082108.28186-1-mszeredi@redhat.com>
 <20180507082108.28186-3-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507082108.28186-3-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:21:07AM +0200, Miklos Szeredi wrote:
> @@ -1738,7 +1738,7 @@ struct file_operations {
>  			loff_t, size_t, unsigned int);
>  	int (*clone_file_range)(struct file *, loff_t, struct file *, loff_t,
>  			u64);
> -	s64 (*dedupe_file_range)(struct file *, u64, u64, struct file *,
> +	s64 (*dedupe_file_range)(struct file *, loff_t, struct file *, loff_t,
>  			u64);

Please name the parameters here ...

+	loff_t (*dedupe_file_range)(struct file *src, loff_t src_off,
+			struct file *dst, loff_t dst_off, loff_t len);
