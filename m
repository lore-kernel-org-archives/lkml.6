Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB2023F02
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="M/f/SYGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB2023F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbeGCQDL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:03:11 -0400
Received: from imap.thunk.org ([74.207.234.97]:55720 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932531AbeGCQDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=67EkCDeCIu8vdCQpMmlrWhbgLO299ISlUWCPs5Uq580=; b=M/f/SYGS9lBV7WzsGGgIaXu8vU
        VsZV4NqbOB76dSI171H8drzaZRHgKAkUZ4q40NI8fCF5w5f/07zYKja65y5TIxvpUGz/teYeuRBdB
        048RJ2RAuH4sGnbAWy7iqz0W2tS9Ri5lWCgs4FNQmKODQ5wE6DVc43mDjabc8ZHtD+bU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1faNlf-0003sr-IE; Tue, 03 Jul 2018 16:03:04 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 931F77A01EE; Tue,  3 Jul 2018 12:03:01 -0400 (EDT)
Date:   Tue, 3 Jul 2018 12:03:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRDSF0g?=
 =?utf-8?Q?ext4=3A_e2fsprogs=3A_fix_inode_bitma?= =?utf-8?Q?p?= num not
 integer,incompatible for ancient android devices
Message-ID: <20180703160301.GB4384@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
References: <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
 <20180630130429.GA26529@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41D5F@dggemm511-mbx.china.huawei.com>
 <20180702121654.GA15131@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41DC4@dggemm511-mbx.china.huawei.com>
 <20180703103557.GA27426@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41F40@dggemm511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDC91B229D965C458E3615E98C48ADDD0EC41F40@dggemm511-mbx.china.huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:15:21AM +0000, Gaoming (ming, consumer BG) wrote:
> 
> You misunderstand my question.  Why was the choice of a blocksize of
> 1024 made?
> 
> -----some one choose, not me . I guess they want get more inodes in 20M filesystem.

That can't be the explanation.

I just checked the sources for make_ext4fs; the blocksize was
hard-coded, as was the number of inodes.  So in order to use a
block_size of 1024 bytes, someone must have hacked the sources
directly and modified compute_block_size().  And in fact, it would
have been *easier* to simply hack compute_inodes() which is just a few
lines below in make_ext4fs.c:

static u32 compute_block_size()
{
	return 4096;
}

static u32 compute_inodes()
{
	return DIV_ROUND_UP(info.len, info.block_size) / 4;
}


This also means commit 06c35f935a7a which fixed make_ext4fs.c wasn't
buggy; it was a valid fix given the complete-non-adjustability of the
blocksize in make_ext4fs.  Yes, it's not a great fix, since it was
fragile --- but that's hardly the smallest problem in make_ext4fs,
there was plenty of other super-fragile bits in make_ext4fs.  There's
a *reason* I was pushing hard to make make_ext4fs go away.

That being said, given the block size of make_ext4fs was hard-coded to
4096, it makes it clear that the change to make it create a blocksize
of 1024 must have beeen a Huawei-local change, and it was never sent
back to the the common AOSP tree.  (If it had, I would have gotten an
e-mail, and I would have explained to whoever had made this
Huawei-local hack why it was such a incredibly bad idea.)


In any case, what I would recommend at this point if you need to
support Huawei devices that do this, is that you keep your e2fsprogs
as a Huawei-specific e2fsprogs repo.

> How long has Huawei been using a 1024 byte blocksize?  And why?  And
> for how many devices?  Essentially, I'm trying to figure out if this
> was a Huawei-specific mistake.
> ----- I cannot answer this question.

Well, actually, it should be very easy for you to detremine the answer
this question --- it should just be a matter of checking git source
control history and see which product trees has the change to
platforms/system/extras/ext4_utils/make_ext4fs.c --- and you must have
platform-specific source trees in order to be compliant with the GNU
Public License (GPL).

Even if you didn't, it would just be a matter using dumpe2fs or
debugfs (they aren't built by default in e2fsprogs by the AOSP build
trees, but they should be buildable) to those Huawei devices that you
still support, and then run either dumpe2fs or debugfs via adb shell
and see what block size is reported.

Even if you aren't allowed to answer this question publically, I'd
strongly recommend you figure it out, so you know when your local
change to e2fsprogs can be dropped.  I'd further recommend that you
make sure all new Huawei devices use a block size of 4096, preferably
using mke2fs and e2fsdroid, as is currently done in AOSP.  Failing
that, at least please use the stock make_ext4fs which doesn't have the
Huawei-specific hack to support 1024 byte block sizes, or have that
Huawei-specific hack reverted.

Regards,

						- Ted
