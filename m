Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B770AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618BC20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TZ3s6Mo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618BC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIKXPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:15:49 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43144 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeIKXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:15:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so48993106oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9JvJjyF9vnR0hVMASJ3nEl55aon+CguF3nPkJgINqZ4=;
        b=TZ3s6Mo7tMigSgJO4cyNeV1aFtkt6mQT1kSvrRlIlo/k7Q+Me1mrVk5ddtutWwIAl9
         JvOV4n3LqjojXcW8mvMbv940f/th8DniAM/J28i3M/P2hWu6oTKx5ZrGlQn2qM3C6Oe+
         LSeMnW+PQF6zALRetM9Lw8jB+hm73me9g4KbgwQ5G+yRU8/TSdPxj/M4tidpMS6S75je
         OOoMM+OInY66GrQ7h4u18MXOq31cp9gJSfv3C1CRDyTX/gAv+7zM+VXx5AyqN1kdQJkI
         CBGarc8I0Wk+Qfm20uB7Hw6+cHfwpnww6SQEGfZRIpuwRQw+xtStOWYQ2+lUTSqY3QPz
         vwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9JvJjyF9vnR0hVMASJ3nEl55aon+CguF3nPkJgINqZ4=;
        b=geWlC2vaUXNPHyW4zP9T2D5ymWoUyIFLgOYjgcVSAhRDaOcKeAC0otty3P+mYX3dGD
         U16rJDnnm6TN7MdHkPAtnY5yRUfUALB7NfpKc74AxwYeSwSPKq2eRpuGOJEddwR56Y3s
         RaasQFqZicy6bj+SBtCFYNYbhpfcKu21kqPUnvAdQDdXvJkBFtmJe827iiblbkrvFRgM
         5Aa7rAQYYQX98p9usJwSA9ofnQyKCumbOZF2QSqGLNqEjIGZKxtsNE0NhUs71N8bzhDv
         b17LUZda3IIzYdb2fuUHk6CXNL5Hw3nHw0X1mWv2F+XJrWllA4fhWlkVzQfRh9U7Y/ne
         1Uww==
X-Gm-Message-State: APzg51CXTVj1+948aar7xdJfrX+N/aJ1rGxRWvWXQ/LmgLOsz2aErqsm
        0oMklCfXg4zTPbdHlfstEo9lxJJ+udpNFvUkbTSK5w==
X-Google-Smtp-Source: ANB0VdbK8ueuDhvjV7f+AXbjU1iJnDNLXiqttW2VpLsaKOadAvSx80rAFtr704xzaVl/9pjGu9eQVAghROhzxYbbwY8=
X-Received: by 2002:aca:ec0d:: with SMTP id k13-v6mr29996432oih.236.1536689719337;
 Tue, 11 Sep 2018 11:15:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 11:15:18
 -0700 (PDT)
In-Reply-To: <20180911154246.6844-3-toshi.kani@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com> <20180911154246.6844-3-toshi.kani@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Sep 2018 11:15:18 -0700
Message-ID: <CAPcyv4iEZ7q0MV7n-_eovrJw_U9S3=pkY_nYwtw1jSBS7vPqCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4, dax: set ext4_dax_aops for dax files
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 8:42 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
> Sync syscall to an existing DAX file needs to flush processor cache,
> but it does not currently.  This is because 'ext4_da_aops' is set to
> address_space_operations of existing DAX files, instead of 'ext4_dax_aops',
> since S_DAX flag is set after ext4_set_aops() in the open path.
>
>   New file
>   --------
>   lookup_open
>     ext4_create
>       __ext4_new_inode
>         ext4_set_inode_flags   // Set S_DAX flag
>       ext4_set_aops            // Set aops to ext4_dax_aops
>
>   Existing file
>   -------------
>   lookup_open
>     ext4_lookup
>       ext4_iget
>         ext4_set_aops          // Set aops to ext4_da_aops
>         ext4_set_inode_flags   // Set S_DAX flag
>
> Change ext4_iget() to call ext4_set_inode_flags() before ext4_set_aops().
>
> Fixes: 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086

Same format nit:

Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
Cc: <stable@vger.kernel.org>


> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> ---
>  fs/ext4/inode.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 775cd9b4af55..93cbbb859c40 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4998,6 +4998,8 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
>         if (ret)
>                 goto bad_inode;
>
> +       ext4_set_inode_flags(inode);
> +

Hmm, does this have unintended behavior changes?

I notice that there are some checks for flags "IS_APPEND(inode) ||
IS_IMMUTABLE(inode)" *before* the call to ext4_set_inode_flags(). I
didn't look too much deeper at whether those checks are bogus, but it
would seem safer to do something like this for a lower risk fix.

Thoughts?

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d0dd585add6a..1e9ab445c777 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4999,7 +4999,6 @@ struct inode *ext4_iget(struct super_block *sb,
unsigned long ino)
        if (S_ISREG(inode->i_mode)) {
                inode->i_op = &ext4_file_inode_operations;
                inode->i_fop = &ext4_file_operations;
-               ext4_set_aops(inode);
        } else if (S_ISDIR(inode->i_mode)) {
                inode->i_op = &ext4_dir_inode_operations;
                inode->i_fop = &ext4_dir_operations;
@@ -5042,6 +5041,12 @@ struct inode *ext4_iget(struct super_block *sb,
unsigned long ino)
        }
        brelse(iloc.bh);
        ext4_set_inode_flags(inode);
+       /*
+        * Now that we have determined whether DAX is enabled, set the
+        * proper address spaces operations
+        */
+       if (S_ISREG(inode->i_mode))
+               ext4_set_aops(inode);

        unlock_new_inode(inode);
        return inode;
