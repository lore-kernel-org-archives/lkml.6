Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F04ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BC820843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USH94u42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BC820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJUTRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 15:17:06 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40148 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeJUTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 15:17:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id l79-v6so14904735ywc.7;
        Sun, 21 Oct 2018 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGJdcefxbjY6UCyLLMXwAOjBqWIum9TnIF2W9kVmh4k=;
        b=USH94u421HHRoiuxSHz9qEKGJsrTuNaK8133CQFLLtxhUI0TS7nFuIQUBF5r9w0J4a
         JsImj3HlNDV4xo08c0IAR9+w18J1M3Gj2pj5NzHnqV9xxzs2z0IBqjcg918SRJXamrEp
         /L92P6tVzRfRgyNdK5hDcJ1rtGkkas1JLk+8ZZz90C+MbM1njPhLo8lyrIdU1ZQC6viJ
         cqMAV2cU4uZfgd3clC415EQAp86WP9v0DnVDMv/GIUa4lPqhc5tMxP56qxkRWEYbfrqw
         d0SC4Xu7dOZch9SHxcZlybAjrndQQv7+Ki3xY9N7sSlHj+RyvM+qOAvu9QaWDKye8n86
         kx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGJdcefxbjY6UCyLLMXwAOjBqWIum9TnIF2W9kVmh4k=;
        b=k7Re7RDxsaqUpAOmLnsil32LQzMaTkRWcQ7PqwaduX6Sjpv+3tfq7ui8SgoQG/hq/d
         XFHMei0Z9HXc9Jf6IjvvOO35Me3nAMXqXFzC+/QafycFet9BgRIkVpDMzz5vxCv5gSgV
         Gtw24lFQySqnvTViHZ0999TQnxnbTU5f2lbIOJR+A1GzlBK0i716ALtqi3M8Bg5UIrSD
         Z/n3u1Finw8UpnDXALTWYURdEnVLRHCrmuJZCd0Kve3OBal1MYppX0PAwVZ44piPJw4x
         x8XUzyVTcC4Qo3KvgDPAfJ5xYR4y5nJC09xxYG3KynycU62IZO8cwL85owozGrNpgDCf
         GUyQ==
X-Gm-Message-State: ABuFfogc9kEWp7Sn4RBFglDTWBTP34nqdBrWu37qX2rf2GuON+h0gYfj
        8zVTxxvi7XcoOx9Kx8ZKBzsSvWmQb4ZvN7cVGAo=
X-Google-Smtp-Source: ACcGV620sEjV6Je3vK6lrrtjVT78Org1A2VVQ3p+MiQP1SvZMaMbixE/RTVuFSdpS5xF1KapeCr6mxzMZRcu2LpPxwc=
X-Received: by 2002:a81:ac1f:: with SMTP id k31-v6mr7257346ywh.248.1540119789660;
 Sun, 21 Oct 2018 04:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181020220957.GA7267@pathfinder> <20181020222637.GA3477@bombadil.infradead.org>
 <CAOQ4uxhO_-B12280jT5RHX3oMjoSTHG73=PyDDVfURs-ey-EkA@mail.gmail.com> <20181021095710.GA3482@pathfinder>
In-Reply-To: <20181021095710.GA3482@pathfinder>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 21 Oct 2018 14:02:57 +0300
Message-ID: <CAOQ4uxg2Vb4fKUcN1nHUtYuapBmUNFNiMZYJaPsjKf5z4EAEuA@mail.gmail.com>
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type function
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>, David.Laight@aculab.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 12:57 PM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> On Sun, Oct 21, 2018 at 08:30:35AM +0300, Amir Goldstein wrote:
> > On Sun, Oct 21, 2018 at 1:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sat, Oct 20, 2018 at 11:09:57PM +0100, Phillip Potter wrote:
> > > > Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
> > > > header and replace with simple assignment. For each case, S_IFx >> 12
> > > > is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
> > > > us the correct file type. It is expected that for *nix compatibility
> > > > reasons, the relation between S_IFx and DT_x will not change. For
> > > > cases where the mode is invalid, upper layer validation catches this
> > > > anyway, so this improves readability and arguably performance by
> > > > assigning (mode & S_IFMT) >> 12 directly without any jump table
> > > > or conditional logic.
> > >
> > > Shouldn't we also do this for other filesystems?  A quick scan suggests
> > > someone should at least look at xfs, ubifs, squashfs, romfs, ocfs2,
> > > nilfs2, hfsplus, f2fs, ext4, ext2, exofs, coda, cifs & btrfs.
> > >
> >
> > I've tried to do that 2 years ago, not even for readability, but to
> > fix a lurking
> > bug in conversion table implementation that was copy&pasted from ext2 to
> > many other fs:
> > https://marc.info/?l=linux-fsdevel&m=148217829301701&w=2
> > https://marc.info/?l=linux-fsdevel&w=2&r=1&s=amir73il+file+type+conversion&q=b
> >
> > The push back from ext4/xfs maintainers was that while all fs use common
> > values to encode d_type in on disk format, those on-disk format values
> > are private to the fs.
> >
> > Eventually, the fix that got merged (only to xfs) did the opposite, it converted
> > the conversion table lookup to a switch statement:
> > https://marc.info/?l=linux-fsdevel&m=148243866204444&w=2
> >
> > Some fs maintainers were happy about the initial version, but I did not
> > pursue pushing that cleanup:
> > https://marc.info/?l=linux-fsdevel&m=148243866204444&w=2
> >
> > Phillip, you are welcome to re-spin those patches if you like.
> > Note that the generic conversion helpers do not rely on upper layer
> > to catch invalid mode values.
> >
> > Cheers,
> > Amir.
>
> I only changed this code in the first place because of the comment in the code -
> I was looking for things to do basically, and this caught my eye because I play
> with FreeBSD now and then which of course uses UFS. I didn't consider any use
> to the other filesystems - by re-spin do you just mean fix up and make sure
> the kernel still builds etc?
>

Yes. If you are looking for a cleanup task, you can
apply relevant patches from my series, starting with:
https://patchwork.kernel.org/patch/9481237/
(Leave the xfs patch [11/11] out)

But besides verifying that patches still apply and build,
you will need to address the concerns of fs maintainers.
Take for example the btrfs patch:
https://patchwork.kernel.org/patch/9480725/

It says:
+ *
+ * Values 0..7 should match common file type values in file_type.h.
  */
 #define BTRFS_FT_UNKNOWN 0
 #define BTRFS_FT_REG_FILE 1

But that is not enough.
When converting code to use the generic defines FT_*, instead of
filesystem defined we need to leave in the code build time assertions
that will catch an attempt to change fs contancts in the future, e.g.:

static inline u8 btrfs_inode_type(struct inode *inode)
 {
- return btrfs_type_by_mode[(inode->i_mode & S_IFMT) >> S_SHIFT];
+ BUILD_BUG_ON(BTRFS_FT_UNKNOWN != FT_UNKNOWN);
+ BUILD_BUG_ON(BTRFS_FT_REG_FILE != FT_REG_FILE);
...
+ return fs_umode_to_ftype(inode->i_mode);
 }

Same should be done for all relevant filesystems.
Then you need to hope that fs maintainers will like this cleanup and
want to take the patches ;-)

Cheers,
Amir.
