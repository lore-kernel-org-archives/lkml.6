Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E0C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0464A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WPDFF9eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfBYERV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:17:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45303 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfBYERV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:17:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id v139so4511123qkb.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 20:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KwhHjjj9HR5HZqEHnHUp5jSlrDPl0JyzCsowCQXd15Q=;
        b=WPDFF9eASZjddbTEaqyCSEP11uJIVKJf9h09VZjWfdQMs5JYYYbDw5Ney/ynaP6Tpx
         96l1P3LM5PGEZjgYtJ+o7O7l/V694qWwSyrYWTFfyUf7xI89mOtjwX5z89XFKaymZICv
         rD/SHUyfjfG3uPQ/deHzxI2YnA3s1OxrB65cw5YYLXgAZ0rDUl9N8/N3I17nVNu5GqC5
         4opjuuWRV766MYzHJQf2/3qYVEpDQZCpWO3rgu+FMOEoeQUhJe3jZrvPBHNz4WaaupYX
         ddBYaP2jkVZzDduH8LQOft2Ml88pZ69wRfG5OR+VeDtYwudqG64nETNOkGzmG1C5F34V
         BsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KwhHjjj9HR5HZqEHnHUp5jSlrDPl0JyzCsowCQXd15Q=;
        b=VcqlyusD1E4Bkzk8In+wkhiDzqXVHAFW3SHvujuBFGDMIyjCp2ss51H7vbDh55RQM0
         +VsJfE1sUtt9zjo3/nrgZ+QYgnr3in6PQV3INDMrE0oE4/5XaBC4nBAVeT6nxuIDJEcr
         qlTZGT9YGrkRG3NKtkdk+cjro5ePf3ThO9JrFJ5UMHodbgH4mnVtjyZh4TfWoHMsu5np
         tHGiTn4mb8zwSi0yMitjfYpuPXxJqD1ukXWAfiNpTiYjfQhatcV9ACFsUNvDotHOkyTN
         5JKZKKtBG4z3ofL0p3UsehfPZ06Zwr/aR3CDGGigqC2U6n5rxn/+QeUcJj0pFmzPEjGy
         Jhsw==
X-Gm-Message-State: AHQUAuYLp6n4jwxG+3hk7/c3RGdNZHNwZBIDSVgoGtxMKA+G+0uNtMNV
        DLE4zF0OS80lE+gU2y3aL5xWLWGaHdztjZ0lPkbVjg==
X-Google-Smtp-Source: AHgI3IbcKxI4CGVSrxiHoayHHHl/y/CsAI+Ki3aG3mSUUidxV/RmZXpO+4LYDNP/wKyPWq4WIbc0Qake+xjLKMSpgEA=
X-Received: by 2002:a37:74a:: with SMTP id 71mr11608388qkh.47.1551068240569;
 Sun, 24 Feb 2019 20:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20190221192712.E5CD895C343F@us180.sjc.aristanetworks.com>
In-Reply-To: <20190221192712.E5CD895C343F@us180.sjc.aristanetworks.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Sun, 24 Feb 2019 20:17:10 -0800
Message-ID: <CA+HUmGi=M=86kJTDc0DrBY-CbtGKP+qAzmGEO+KPkdi9fLm+OQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix inconsistent page index
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Francesco Ruggeri <fruggeri@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:27 AM Francesco Ruggeri <fruggeri@arista.com> wrote:
>
> __find_get_block_slow() and grow_buffers() use different methods to compute
> a page index for a given block: __find_get_block_slow() computes it from
> bd_inode->i_blkbits, while grow_buffers() computes it from the block size
> argument.
> The two can get out of sync, for example if bd_inode->i_blkbits is modified
> while a isofs_fill_super() (in mount) is between sb_min_blocksize() and
> sb_read/__bread_gfp/__getblk_gfp/__getblk_slow.
> The script below can reproduce such a scenario, resulting in an infinite
> loop in __getblk_slow(), as grow_buffers() allocates a page but
> __find_get_block() keeps looking for a different one.
> This patch changes __find_get_block_slow() to also use the block size.
> It implicitly relies on size being a power of 2 in the 256..PAGE_SIZE
> range.
>

Any comments?

Thanks,
Francesco Ruggeri
