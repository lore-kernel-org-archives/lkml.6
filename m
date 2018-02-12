Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935593AbeBLNiV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:38:21 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33135 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933114AbeBLNiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:38:19 -0500
X-Google-Smtp-Source: AH8x2258HRG0uCd+WIkDen3WZewdJj0uo+7Ip8oCEzrkP50/sjtbBIqf4MPzPCsLl3/PwkfG/qYkvQ==
Subject: Re: ext4 iomap SEEK broken [was: [GIT PULL] ext4 updates for 4.15]
From: Jiri Slaby <jslaby@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20171113031502.f6mctmlmgk5psh77@thunk.org>
 <7ae851b1-92a8-779a-a066-1c7e34867465@suse.cz>
 <45062110-e80c-f1e8-3710-743c1ae4d232@suse.cz>
 <6db646d9-9ec0-ddda-d480-357cf3c70a09@suse.cz>
Message-ID: <de55a671-408e-df3e-30ae-c4608eb7d4c3@suse.cz>
Date: Mon, 12 Feb 2018 14:38:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6db646d9-9ec0-ddda-d480-357cf3c70a09@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018, 02:34 PM, Jiri Slaby wrote:
> @@ -3523,7 +3523,7 @@ static int ext4_iomap_begin(struct inode *inode,
> loff_t offset, loff_t length,
>                 iomap->flags |= IOMAP_F_DIRTY;
>         iomap->bdev = inode->i_sb->s_bdev;
>         iomap->dax_dev = sbi->s_daxdev;
> -       iomap->offset = first_block << blkbits;
> +       iomap->offset = (u64)first_block << blkbits;
>         iomap->length = (u64)map.m_len << blkbits;
> 
>         if (ret == 0) {
> 
> sounds about right?

Or even simpler:
-       iomap->offset = first_block << blkbits;
+       iomap->offset = offset;

>> regards,-- 
js
suse labs
