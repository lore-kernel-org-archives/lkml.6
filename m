Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35032C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA74C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hZTs+WDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA74C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeIKW7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:59:46 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44433 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeIKW7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:59:46 -0400
Received: by mail-oi0-f66.google.com with SMTP id l82-v6so48915742oih.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zpbR4x/mj0fwbzLHsBkJtWNApIh0JB2XSHny7nLhpsM=;
        b=hZTs+WDlQf6OwFfIqkrUUpw2moOvpyBQ26FFkv46MkmEN6RCQB5cp8URxNB8PkIaQ9
         WdfCVWVSsXdmEnet+GyOtP3N5zo/uwTt2pD+4Rph0WSp7bfAfSkLJn+pCkqAYgM2dU/A
         xDOSLXOlcV97Nnh1q+DISjLLxJOyhFy4oNillHUE1o2Vpp1R3AS8pKc+I9pVxaVvdsFl
         Kd27fB4PHcl6mBdftpzyPAVbQ42GCHxqc7QaNUPES9Lut6mJqWNCvMB3Cwo3y8hFKWF5
         KMVenqd2AehAlKZLNmQNuwcfLEiOXyopjB7FGl+O5kkWYx3OYgaHu84Lka5yJvbmYSsF
         Nkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zpbR4x/mj0fwbzLHsBkJtWNApIh0JB2XSHny7nLhpsM=;
        b=Jr/wvaal27oFu2PXPzAX82yYjUNDtPr8ISET8QXhhhnBHt4gqOPXtO4jq3XjB42bNX
         L9SkvrGV7tCtiYuRIpLTSjwnYLDTGhSjfFxUo2PG+kYOdk+mS6eYsuH7x6Ka0t7xCsYx
         Iqp+10geRowxgDQNngtPqta7PCaLOoNRKmoXkEq/kP+/YkOzxRn7Bzso3iSrC0n1GcSQ
         T8pzeSmpZhviHMVzsCTegWYe9yQzY+iNsSd7573hPuCyC6L7ZuHSdxTsX/ee4d64qz+e
         +3t5Y9p9NHnGwxB3UTpocWkMPqR71lmF+UUP599nvRbx5KdYcIczLIbebVvy1UBvWZm+
         rlxQ==
X-Gm-Message-State: APzg51ChT7GaU1JSdpHezp8ix7oWA/Ulrpb9NTP7+1I7axxBmhExAshO
        23Z0xOotQ3lkWyBltWlYvGQcXDgxJYgL1BUPKTMUGQ==
X-Google-Smtp-Source: ANB0VdZpQC+r5H2pt1jDhCo4sQGuSrOCc0xqUtCcwQX1ozV2Q2/tJZcSviZ4GfAeY4TcxR7bua6D0s59mykYVcGUvDA=
X-Received: by 2002:aca:4507:: with SMTP id s7-v6mr26990094oia.200.1536688759824;
 Tue, 11 Sep 2018 10:59:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 10:59:19
 -0700 (PDT)
In-Reply-To: <20180911154246.6844-2-toshi.kani@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com> <20180911154246.6844-2-toshi.kani@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Sep 2018 10:59:19 -0700
Message-ID: <CAPcyv4j0zF+OjqPywkmZLgGiSjNdH_9SwpXjS=92bqT9OXZ_MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
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
> Ext4 mount path calls ext4_iget() to obtain the journal inode.  This
> inode does not support DAX, and 'ext4_da_aops' needs to be set.  It
> currently works for the DAX mount case because ext4_iget() always set
> 'ext4_da_aops' to any regular files.
>
>   ext4_fill_super
>     ext4_load_journal
>       ext4_get_journal_inode
>         ext4_iget
>
> In preparation to fix ext4_iget() to set 'ext4_dax_aops' for DAX files,
> update ext4_should_use_dax() to return false for the journal inode.
>
> Fixes: 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086

Just a minor format recommendation:

Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
Cc: <stable@vger.kernel.org>

> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> ---
>  fs/ext4/ext4_jbd2.h |    8 ++++++++
>  fs/ext4/inode.c     |    2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 15b6dd733780..9847dc980a0d 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -437,6 +437,14 @@ static inline int ext4_should_writeback_data(struct inode *inode)
>         return ext4_inode_journal_mode(inode) & EXT4_INODE_WRITEBACK_DATA_MODE;
>  }
>
> +static inline int ext4_is_journal_inode(struct inode *inode)
> +{
> +       struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +       unsigned int journal_inum = le32_to_cpu(sbi->s_es->s_journal_inum);
> +
> +       return journal_inum && (journal_inum == inode->i_ino);
> +}
> +
>  /*
>   * This function controls whether or not we should try to go down the
>   * dioread_nolock code paths, which makes it safe to avoid taking
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d0dd585add6a..775cd9b4af55 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4686,6 +4686,8 @@ static bool ext4_should_use_dax(struct inode *inode)
>                 return false;
>         if (ext4_should_journal_data(inode))
>                 return false;
> +       if (ext4_is_journal_inode(inode))
> +               return false;

This looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
