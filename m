Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8620C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9DE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYxEcq7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9DE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbeGXKSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:18:42 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34164 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeGXKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:18:42 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so1275206ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Myk3ZsuyfUQNIndGeIVSHuFFOeov84KG9Di98BnSPts=;
        b=jYxEcq7DcfBtw0Qnt0nDLjc86RQwxWQs1NVVW6mxLcjYzlQ99Huz6uxiZMPDEgSi1W
         FMwNUCj6zLPs/Zoi6ScgVlljuwA7dPbPl9d/mjcUIxZU4cSXaptN6decaLfhJI57szGe
         fBh1ibLIXbwcrqUoOTdg3ogNwDCqF1BC1EhGmcTwCEHgrXDsdshaQ9+crDLuouKkgrDq
         UUhwAZXhM/lkZWyd3f99ynFN59AwP5GiMG27D0dWheEGfHmJwmkqWnaARwYehmOp4rSY
         1dy+pj+L4KSePMfVF1nPJGXz6+Ob9yxhVAZpiWuWYoHYjmJtuBuJ9WrSQdEI1kmgjmA5
         Si1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Myk3ZsuyfUQNIndGeIVSHuFFOeov84KG9Di98BnSPts=;
        b=VHyFRMrxNyll1ctEZCHtGIKwXg/+eYjNg0nxh0uJflVGjrsxejBsDjr7ydIvrCfVJ2
         josTC4y3qBdO4IYgXXvtSe2/ZI8hcmZslRog32fqHZ5HqIr+37Mxfv/l7t5ku0aUeIYw
         jFbr5bZ9knRhajqDRyssu4TjvrrVBFVk4B7ZEMlqz4rNaIzIqB37pvuQF5gtB4eheL7B
         sdbVe8gV8ztCalBqs8YayMhF4WMCqw2pti2CQCGKECqxS1m2tS8sIKFIJSWM992cDL3Q
         plg2KcfeQ/sxj3ADjX5tonnwODYyP9VLFZ7uOgy9DZL7eUHWoW5W/jsFhGcJ7TQASKmz
         KWNw==
X-Gm-Message-State: AOUpUlGxtNiHyWvh1LfgFExpIIKQT39x4Dt55dXxkJAQ3WmPo014uPpd
        EDj6YBVdx+sZkycAIzddU1l3JQ==
X-Google-Smtp-Source: AAOMgpcA1Nc5vanaNMxNaybtB113ietQxe9Dj+CDtcf7lxEcxKS8+ibb5PPvL6NfiDF5i7ZwQ+Oy6w==
X-Received: by 2002:a81:a742:: with SMTP id e63-v6mr8757540ywh.388.1532423592182;
        Tue, 24 Jul 2018 02:13:12 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k9-v6sm15775409ywh.33.2018.07.24.02.13.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 02:13:11 -0700 (PDT)
Date:   Tue, 24 Jul 2018 02:12:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
In-Reply-To: <20180723225454.GC18236@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.1807240121590.1105@eggly.anvils>
References: <000000000000d624c605705e9010@google.com> <20180709143610.GD2662@bombadil.infradead.org> <alpine.LSU.2.11.1807221856350.5536@eggly.anvils> <20180723140150.GA31843@bombadil.infradead.org> <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
 <20180723203628.GA18236@bombadil.infradead.org> <alpine.LSU.2.11.1807231531240.2545@eggly.anvils> <20180723225454.GC18236@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> On Mon, Jul 23, 2018 at 03:42:22PM -0700, Hugh Dickins wrote:
> > On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> > > I figured out a fix and pushed it to the 'ida' branch in
> > > git://git.infradead.org/users/willy/linux-dax.git
> > 
> > Great, thanks a lot for sorting that out so quickly. But I've cloned
> > the tree and don't see today's patch, so assume you've folded the fix
> > into an existing commit? If possible, please append the diff of today's
> > fix to this thread so that we can try it out. Or if that's difficult,
> > please at least tell which files were modified, then I can probably
> > work it out from the diff of those files against mmotm.
> 
> Sure!  It's just this:
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 32a9c2a6a9e9..383c410997eb 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -660,6 +660,8 @@ void xas_create_range(struct xa_state *xas)
>  	unsigned char sibs = xas->xa_sibs;
>  
>  	xas->xa_index |= ((sibs + 1) << shift) - 1;
> +	if (!xas_top(xas->xa_node) && xas->xa_node->shift == xas->xa_shift)
> +		xas->xa_offset |= sibs;
>  	xas->xa_shift = 0;
>  	xas->xa_sibs = 0;

Yes, that's a big improvement, the huge "cp" is now fine, thank you.

I've updated my xfstests tree, and tried that on mmotm with this patch.
The few failures are exactly the same as on 4.18-rc6, whether mounting
tmpfs as huge or not. But four of the tests, generic/{340,345,346,354}
crash (oops) on 4.18-rc5-mm1 + your patch above, but pass on 4.18-rc6.

That was simply with non-huge tmpfs: I just patched them out and didn't
try for whether they crash with huge tmpfs too: probably they do, but
that won't be very interesting until the non-huge crashes are fixed.

I paid no attention to where the crashes were, I was just pressing on
to skip the problem tests to get as full a run as possible, with that
list of what's problematic and needs further investigation.

To test non-huge tmpfs (as root), I wrap xfstests' check script as
follows (you'll want to mkdir or substitute somewhere else for /xft):

export FSTYP=tmpfs
export DISABLE_UDF_TEST=1
export TEST_DEV=tmpfs1:
export TEST_DIR=/xft
export SCRATCH_DEV=tmpfs2:
export SCRATCH_MNT=/mnt
mount -t $FSTYP -o size=1088M $TEST_DEV $TEST_DIR || exit $?
./check "$@" # typically "-g auto"
umount /xft /mnt 2>/dev/null

But don't bother with "-g auto" for the moment: I have workarounds in
for a few of them, generic/{027,213,449}, which we need not get into
right now (without them, two of those tests can take close to forever).

To test huge tmpfs (as root), I wrap xfstests' check script as:

export FSTYP=tmpfs
export DISABLE_UDF_TEST=1
export TEST_DEV=tmpfs1:
export TEST_DIR=/xft
export SCRATCH_DEV=tmpfs2:
export SCRATCH_MNT=/mnt
export TMPFS_MOUNT_OPTIONS="-o size=1088M,huge=always"
mount -t $FSTYP $TMPFS_MOUNT_OPTIONS $TEST_DEV $TEST_DIR || exit $?
./check "$@" # typically "-g auto"
umount /xft /mnt 2>/dev/null

Hugh
