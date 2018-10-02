Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4F82064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="laXdewcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4F82064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJBPNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:13:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36808 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeJBPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:13:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so1147088wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7wdiTWCVAzgYBoRGLBTvE3F5jIePHK5Te2cSzVql9zY=;
        b=laXdewcmJ+RyqzumSN4yHw/aiTlhCXIKFZnLPxo4y7LOhZdGHRlH5UoxlH1mGVZl9r
         DgQGD82kM8oVhic8hxTnDrENSgZhNRuMUf1hP0A7TN8ZjjrPUV/PNdh9jzjoJ5Ak1+er
         Br0t/d2vb6GADpXR2EK05q4X4Vp13zI7/V0W+QA/OKBWYlQ5erog7zSzyY/yVcyz9lST
         cPOegAFqWmOhOZ80QECJhPY4xW1sa1OXJDLK1VH1bLjYtFLd0ChjneMAyEaolGR+H0ck
         SbTUXPxLLo0/UVE8dWa9B/4bgNyh/eVAW7Yqv4LGD/5pvAkGho0Ik6toRZvhhQgZRQqy
         7urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7wdiTWCVAzgYBoRGLBTvE3F5jIePHK5Te2cSzVql9zY=;
        b=L4MWleudUy/tzrEm0D+fLhy1XPHEB5PfzPNuHCMseyBb0agxJ2re9UOuUaaoZkG3+q
         LDW83xANHkxvbqmuRw/8t2d3yLZrO/W6WMbbnQlY1xK7aBih1gYALrknHwHVFWlUMXwv
         esCsuAQLL7zp/t6dZyz2YYZIf/aG7iLoOowsdr8MKgYGCW+lGrjG+kvGFuNqZiNvKBwj
         Ha+Im19qh1FA809S0Af0tG3XVhXk9bv0TWegcEGTpSdP4pDXAIsEVE36I746xeZFiMcb
         jhqgUWEeT2mGe3gsUakfj4b4Q0A+6MWVki2Zgxzgs4fLU5toHBctbttHwC1tgu94Tv+k
         kWNA==
X-Gm-Message-State: ABuFfohLmTnEEkJrt7D9yPg9J/ATN4g+a1CzRIoH4DBjPObubU5CwHY+
        dbNjLBe4R8faSEa/bnHkt9g5LrX51iA=
X-Google-Smtp-Source: ACcGV633PRpn/QKpcri0tT3thy9mpgNqp+ykadyoqSjFjgzqDR/pFXihq3uTjt1D6qhSM0Md+B9wog==
X-Received: by 2002:adf:aa90:: with SMTP id h16-v6mr9253834wrc.216.1538469062682;
        Tue, 02 Oct 2018 01:31:02 -0700 (PDT)
Received: from pathfinder (host-78-148-28-244.as13285.net. [78.148.28.244])
        by smtp.gmail.com with ESMTPSA id e142-v6sm2737514wmf.20.2018.10.02.01.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:31:01 -0700 (PDT)
Date:   Tue, 2 Oct 2018 09:31:00 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dushistov@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ufs: Convert ufs_set_de_type to use lookup table
Message-ID: <20181002083100.GB4263@pathfinder>
References: <20181001153310.GA13006@pathfinder>
 <20181002022814.GN32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002022814.GN32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:28:14AM +0100, Al Viro wrote:
> On Mon, Oct 01, 2018 at 04:33:10PM +0100, Phillip Potter wrote:
> > Modify ufs_set_de_type function in fs/ufs/util.h to use a lookup
> > table rather than a switch statement, as per the TODO comment.
> 
> Brittle, that...   Something like fs/ext2/dir.c approach (that is,
> #define S_SHIFT 12
> static unsigned char ext2_type_by_mode[S_IFMT >> S_SHIFT] = {
>         [S_IFREG >> S_SHIFT]    = EXT2_FT_REG_FILE,
>         [S_IFDIR >> S_SHIFT]    = EXT2_FT_DIR,
>         [S_IFCHR >> S_SHIFT]    = EXT2_FT_CHRDEV,
>         [S_IFBLK >> S_SHIFT]    = EXT2_FT_BLKDEV,
>         [S_IFIFO >> S_SHIFT]    = EXT2_FT_FIFO,
>         [S_IFSOCK >> S_SHIFT]   = EXT2_FT_SOCK,
>         [S_IFLNK >> S_SHIFT]    = EXT2_FT_SYMLINK,
> };
> in there) would be saner, IMO.  Note that DT_UNKNOWN is zero, so the
> array elements lacking an explicit initializer will end up with that.
> 
> What's more, the values are ->i_mode >> 12 or 0, depending upon the
> value being valid.  And since the upper layers do validate the type,
> I'd consider simply using (inode->i_mode & S_IFMT) >> 12 there.
> Unlike ext2, ufs stores straight bits 12..15 there (ext2 uses an
> enum with sequential values instead; e.g. regular files are encoded
> as 1 there, not 8 as on ufs)...

Dear Al,

Thank you for taking time to offer your feedback, I really appreciate
it. I will rework this patch this evening and resubmit.

Regards,
Phil
