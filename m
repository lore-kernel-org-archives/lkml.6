Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9B7C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9678D27F20
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="yErTUchF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9678D27F20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755448AbeF2O0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:26:20 -0400
Received: from imap.thunk.org ([74.207.234.97]:40426 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753109AbeF2O0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TCneEr6+gR/PgixD5c1cMOPEzP90p05zHnHEzQuJiSY=; b=yErTUchFKpd27PCAViYP8YFJtD
        OOUy4nKrzzTMTAG662lpitSc8J+qlmOQ8NOcCMttuKt1plQixXcGv8TxBjY6OcJYMGKBx7ij/s+oR
        CJcoq6Yzyl6io+gAUBGLk6RwF7E4bLbNOb8BM72LEMRVp4y88+3V0ljZ1Gdis1VtBQOU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fYuLl-0006dZ-R1; Fri, 29 Jun 2018 14:26:13 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B39587A4481; Fri, 29 Jun 2018 10:26:12 -0400 (EDT)
Date:   Fri, 29 Jun 2018 10:26:12 -0400
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
 =?utf-8?B?5aSNOiBbUEFUQ0hdIGV4dDQ6IGUyZnNwcm9nczogZml4IGlub2RlIGJpdG1h?=
 =?utf-8?Q?p?= num not integer,incompatible for ancient android devices
Message-ID: <20180629142612.GE1231@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
 <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:06:03AM +0000, Gaoming (ming, consumer BG) wrote:
> We use usual inode size, it is 256 bytes.
> 
> Yes, this commit is in my repository.
> But there is a bug in this patch.
> 
> Let me show you,
> Here is the bug: " return ALIGN(inodes, (info.block_size / info.inode_size));"
> 
> In my reproduce,
> info.block_size = 1024, (it is legal)
> info.inode_size =256,

But why are you using a block size of 1024?  It's legal, but in
general, it's a bad idea (often will hurt performance, will impose
additional scalability limitations, etc.)....  It's certainly not
the default.

A block size of 1024 is also incompatible with file-based encryption
(FBE), which is required for a number of Android features.  Support
for FBE is strongly required, and it wouldn't surprise me if it
becomes an mandatory requirement at some point in the future.

How long have you been using a block size of 1024, and why?

> But in real scenario, we should align by 8,( 8 bit per bytes in inode map).

Yes, and that's why mke2fs does.  make_ext4fs was an Android specific
abomination, that I've been pushing hard for Android to rid itself of.
This is not the only thing it's gotten wrong in the past, and I've had
to help Android developers deal with data corrupting bugs caused by
the fact that way back when, Android had a GPL-in-userspace allergy.

						- Ted
