Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75700C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B54F2460E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="PRdR8kT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B54F2460E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935303AbeF1Pa1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:30:27 -0400
Received: from imap.thunk.org ([74.207.234.97]:36892 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933604AbeF1PaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vz6JhvmmsHmYqdou6n8cS8VcCVHWEosn48QWhb3Gti0=; b=PRdR8kT72yOLnxb329XanasAVM
        gmNwPW3Te6Y5GXewVxFitAw+tsQnAzZBDrOkhnNQ1rRvHof2wQyeHFMuoBwtvIyvkFeG5ClO/dwKv
        cwQHIs2IMeaan9oMZdCGAlhO1r59TwEzvTH/bmVAGxPc1baYhZZWCbn6zyqmMq1rZkbw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fYYsJ-0008Lo-5h; Thu, 28 Jun 2018 15:30:23 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7C5067A4480; Thu, 28 Jun 2018 11:30:22 -0400 (EDT)
Date:   Thu, 28 Jun 2018 11:30:22 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?Q?H=5D_ext4=3A_e2fsprogs=3A_fix_inode_bitma?= =?utf-8?Q?p?= num not
 integer,incompatible for ancient android devices
Message-ID: <20180628153022.GA8521@thunk.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 07:56:59AM +0000, Gaoming (ming, consumer BG) wrote:
> You see, Inodes per group is 1708,which is illegal as you said.
> 
> So, the problem exists a long time until Jun 21th 2018.
> 
> You complained the problem in 2011, they do not fix it till 2018.
> Just as
> I complained, fix it,  and you do not accept it. ^_^

Here's the commit.  (Note the date.)   Do you see it in your repository?

Or are you using an unusual inode size?  (e.g., not 256 bytes, or 16
inodes per block).


       	   	       	       	     	  - Ted

commit 06c35f935a7adadceb9ee326b3231f952f6ad203
Merge: 480a3b1 96cc54a
Author: Colin Cross <ccross@android.com>
Date:   Sat Apr 30 19:08:09 2011 -0700

    Merge "Make inodes per group a multiple of inodes per block"

diff --cc ext4_utils/make_ext4fs.c
index c9fd992,e37d617..22c9424
--- a/ext4_utils/make_ext4fs.c
+++ b/ext4_utils/make_ext4fs.c
@@@ -214,26 -215,10 +214,27 @@@ static u32 compute_inodes_per_group(
  {
  	u32 blocks = DIV_ROUND_UP(info.len, info.block_size);
  	u32 block_groups = DIV_ROUND_UP(blocks, info.blocks_per_group);
- 	return DIV_ROUND_UP(info.inodes, block_groups);
+ 	u32 inodes = DIV_ROUND_UP(info.inodes, block_groups);
+ 	return ALIGN(inodes, (info.block_size / info.inode_size));
  }
  
 +static u32 compute_bg_desc_reserve_blocks()
 +{
 +	u32 blocks = DIV_ROUND_UP(info.len, info.block_size);
 +	u32 block_groups = DIV_ROUND_UP(blocks, info.blocks_per_group);
 +	u32 bg_desc_blocks = DIV_ROUND_UP(block_groups * sizeof(struct ext2_group_desc),
 +			info.block_size);
 +
 +	u32 bg_desc_reserve_blocks =
 +			DIV_ROUND_UP(block_groups * 1024 * sizeof(struct ext2_group_desc),
 +					info.block_size) - bg_desc_blocks;
 +
 +	if (bg_desc_reserve_blocks > info.block_size / sizeof(u32))
 +		bg_desc_reserve_blocks = info.block_size / sizeof(u32);
 +
 +	return bg_desc_reserve_blocks;
 +}
 +
  void reset_ext4fs_info() {
      // Reset all the global data structures used by make_ext4fs so it
      // can be called again.
