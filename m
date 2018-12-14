Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05B2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30D20811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ViZahRdo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HhDmyFI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E30D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeLNH4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:56:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLNH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:56:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5804D601E7; Fri, 14 Dec 2018 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544774169;
        bh=YltP5Ymc8P58vLDSqSibG5ijwdYWstrgXL6k4FFRnpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViZahRdo9GZNOlAd/34rLscm7rF+NPufx2Fvp2a0N9MLhWTDje8svF0eE44cb9wtP
         /9YIdctWe4Ig5BXFSLcvewq8/rxC3NAD0AIEyeVFclTFnCQO9Vj7laFRxqXrQhw3oU
         mpKEmfj4I+qk/WWTLSbhHlSWFbjE99iHHFxdiXAM=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A9F3606DD;
        Fri, 14 Dec 2018 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544774168;
        bh=YltP5Ymc8P58vLDSqSibG5ijwdYWstrgXL6k4FFRnpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhDmyFI068uZCNqAuME89XAzvhn135jU2hGO7IfqTeehX9xll9yHGPwXknP3x3pNS
         5Lsz1EtL5h9GjHu/Q9x06VmdSdvc30bMID9BlOFQkbo+TxaQMg34FudtaZpBuhCeWT
         i5Nh9dGH04auXUR1Mmtlwdn4CqIW4Rtbh6bG+JuE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A9F3606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Fri, 14 Dec 2018 13:26:02 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix sbi->extent_list corruption issue
Message-ID: <20181214075602.GA15236@codeaurora.org>
References: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
 <20181127003050.GG55960@jaegeuk-macbookpro.roam.corp.google.com>
 <fc8c38f6-a039-7b63-d25c-966b0d4396d8@huawei.com>
 <20181129033239.GE9838@codeaurora.org>
 <20181130203339.GB71781@jaegeuk-macbookpro.roam.corp.google.com>
 <49285288-cf99-5f5a-0d1a-c2e0accd8d3d@huawei.com>
 <20181212031749.GF9838@codeaurora.org>
 <0167a499-8479-6be4-946d-4446bd02ff63@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0167a499-8479-6be4-946d-4446bd02ff63@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:36:08AM +0800, Chao Yu wrote:
> On 2018/12/12 11:17, Sahitya Tummala wrote:
> > On Fri, Dec 07, 2018 at 05:47:31PM +0800, Chao Yu wrote:
> >> On 2018/12/1 4:33, Jaegeuk Kim wrote:
> >>> On 11/29, Sahitya Tummala wrote:
> >>>>
> >>>> On Tue, Nov 27, 2018 at 09:42:39AM +0800, Chao Yu wrote:
> >>>>> On 2018/11/27 8:30, Jaegeuk Kim wrote:
> >>>>>> On 11/26, Sahitya Tummala wrote:
> >>>>>>> When there is a failure in f2fs_fill_super() after/during
> >>>>>>> the recovery of fsync'd nodes, it frees the current sbi and
> >>>>>>> retries again. This time the mount is successful, but the files
> >>>>>>> that got recovered before retry, still holds the extent tree,
> >>>>>>> whose extent nodes list is corrupted since sbi and sbi->extent_list
> >>>>>>> is freed up. The list_del corruption issue is observed when the
> >>>>>>> file system is getting unmounted and when those recoverd files extent
> >>>>>>> node is being freed up in the below context.
> >>>>>>>
> >>>>>>> list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> >>>>>>> <...>
> >>>>>>> kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> >>>>>>> task: fffffff1f46f2280 task.stack: ffffff8008068000
> >>>>>>> lr : __list_del_entry_valid+0x94/0xb4
> >>>>>>> pc : __list_del_entry_valid+0x94/0xb4
> >>>>>>> <...>
> >>>>>>> Call trace:
> >>>>>>> __list_del_entry_valid+0x94/0xb4
> >>>>>>> __release_extent_node+0xb0/0x114
> >>>>>>> __free_extent_tree+0x58/0x7c
> >>>>>>> f2fs_shrink_extent_tree+0xdc/0x3b0
> >>>>>>> f2fs_leave_shrinker+0x28/0x7c
> >>>>>>> f2fs_put_super+0xfc/0x1e0
> >>>>>>> generic_shutdown_super+0x70/0xf4
> >>>>>>> kill_block_super+0x2c/0x5c
> >>>>>>> kill_f2fs_super+0x44/0x50
> >>>>>>> deactivate_locked_super+0x60/0x8c
> >>>>>>> deactivate_super+0x68/0x74
> >>>>>>> cleanup_mnt+0x40/0x78
> >>>>>>> __cleanup_mnt+0x1c/0x28
> >>>>>>> task_work_run+0x48/0xd0
> >>>>>>> do_notify_resume+0x678/0xe98
> >>>>>>> work_pending+0x8/0x14
> >>>>>>>
> >>>>>>> Fix this by cleaning up inodes, extent tree and nodes of those
> >>>>>>> recovered files before freeing up sbi and before next retry.
> >>>>>>>
> >>>>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>>>>>> ---
> >>>>>>> v2:
> >>>>>>> -call evict_inodes() and f2fs_shrink_extent_tree() to cleanup inodes
> >>>>>>>
> >>>>>>>  fs/f2fs/f2fs.h     |  1 +
> >>>>>>>  fs/f2fs/shrinker.c |  2 +-
> >>>>>>>  fs/f2fs/super.c    | 13 ++++++++++++-
> >>>>>>>  3 files changed, 14 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>>>> index 1e03197..aaee63b 100644
> >>>>>>> --- a/fs/f2fs/f2fs.h
> >>>>>>> +++ b/fs/f2fs/f2fs.h
> >>>>>>> @@ -3407,6 +3407,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
> >>>>>>>  bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
> >>>>>>>  						struct rb_root_cached *root);
> >>>>>>>  unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
> >>>>>>> +unsigned long __count_extent_cache(struct f2fs_sb_info *sbi);
> >>>>>>>  bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
> >>>>>>>  void f2fs_drop_extent_tree(struct inode *inode);
> >>>>>>>  unsigned int f2fs_destroy_extent_node(struct inode *inode);
> >>>>>>> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> >>>>>>> index 9e13db9..7e3c13b 100644
> >>>>>>> --- a/fs/f2fs/shrinker.c
> >>>>>>> +++ b/fs/f2fs/shrinker.c
> >>>>>>> @@ -30,7 +30,7 @@ static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
> >>>>>>>  	return count > 0 ? count : 0;
> >>>>>>>  }
> >>>>>>>  
> >>>>>>> -static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
> >>>>>>> +unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
> >>>>>>>  {
> >>>>>>>  	return atomic_read(&sbi->total_zombie_tree) +
> >>>>>>>  				atomic_read(&sbi->total_ext_node);
> >>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>>>>>> index af58b2c..769e7b1 100644
> >>>>>>> --- a/fs/f2fs/super.c
> >>>>>>> +++ b/fs/f2fs/super.c
> >>>>>>> @@ -3016,6 +3016,16 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
> >>>>>>>  	sbi->readdir_ra = 1;
> >>>>>>>  }
> >>>>>>>  
> >>>>>>> +static void f2fs_cleanup_inodes(struct f2fs_sb_info *sbi)
> >>>>>>> +{
> >>>>>>> +	struct super_block *sb = sbi->sb;
> >>>>>>> +
> >>>>>>> +	sync_filesystem(sb);
> >>>>>>
> >>>>>> This writes another checkpoint, which would not be what this retrial intended.
> >>>>>
> >>>>> Actually, checkpoint will not be triggered due to SBI_POR_DOING flag check
> >>>>> as below:
> >>>>>
> >>>>> int f2fs_sync_fs(struct super_block *sb, int sync)
> >>>>> {
> >>>>> ...
> >>>>> 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >>>>> 		return -EAGAIN;
> >>>>> ...
> >>>>> }
> >>>>>
> >>>>> And also all dirty data/node won't be persisted due to SBI_POR_DOING flag,
> >>>>> IIUC.
> >>>>>
> >>>>
> >>>> Thanks Chao for the clarification.
> >>>>
> >>>> Hi Jaegeuk,
> >>>>
> >>>> Do you still have any further concerns or comments on this patch?
> >>>
> >>> Could you try the below first?
> >>>
> >>> --  How about adding a condition in f2fs_may_extent_tree() when adding extents?
> >>> -- Likewise, if (shrinker is not registered) return false;
> >>>
> >>> If we can fix what you described directly, I don't want to rely on such the
> >>> assumptions saying we won't do checkpoint. This flow literally says syncing
> >>> and evicting cached objects, which opposed to what we'd like to drop all caches
> >>> and restart fill_super again.
> >>>
> >>> Let me consider this as a final resolution.
> >>
> >> Jaegeuk,
> >>
> >> Still I want to ask, what kind of scenario we have to add retry logic in
> >> fill_super for? As in android scenario, it must be extreme rare case that
> >> system runs out-of-memory in boot time...at least, I didn't get any kind of
> >> report like that.
> >>
> > Hi Chao,
> 
> Hi Sahitya,
> 
> Thanks for letting me know that, I git-blamed the code, and found the
> original intention is like what you described:
> 
> commit ed2e621a95d704e6a4e904cc00524e8cbddda0c2
> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> Date:   Fri Aug 8 15:37:41 2014 -0700
> 
>     f2fs: give a chance to mount again when encountering errors
> 
>     This patch gives another chance to try mount process when we encounter
> an error.
>     This makes an effect on the roll-forward recovery failures as well.
> 
> But I doubt that if we failed in recovery, maybe there is corruption in
> this image, would it be better to fail the mount, and let user fsck it and
> retry the mount? otherwise, the corruption may be expanded...
> 

Hi Jaegeuk,

How do you think about this? If you think it is okay, then I will fix the
sbi->extent_list corruption issue, by removing the retry logic. Otherwise,
I will fix it in the extent handling as you have suggested earlier.

Thanks,

> Thanks,
> 
> > 
> > In my case, the first boot up has a failure in recovery as below -
> > 
> > F2FS-fs (mmcblk0p75): find_fsync_dnodes: detect looped node chain, blkaddr:1979471, next:1979472
> > F2FS-fs (mmcblk0p75): Cannot recover all fsync data errno=-22
> > 
> > But in the second attempt, retry will be set to false and because of that
> > recover_fsync_data() is skipped. This helped mount to be successful in
> > the second attempt. 
> > 
> > Thanks,
> > 
> >> Thanks,
> >>
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>> Thanks,
> >>>> Sahitya.
> >>>>
> >>>>> Thanks,
> >>>>>
> >>>>>> How about adding a condition in f2fs_may_extent_tree() when adding extents?
> >>>>>> Likewise, if (shrinker is not registered) return false;
> >>>>>>
> >>>>>>
> >>>>>>> +	shrink_dcache_sb(sb);
> >>>>>>> +	evict_inodes(sb);
> >>>>>>> +	f2fs_shrink_extent_tree(sbi, __count_extent_cache(sbi));
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>>>>>>  {
> >>>>>>>  	struct f2fs_sb_info *sbi;
> >>>>>>> @@ -3402,6 +3412,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>>>>>>  	 * falls into an infinite loop in f2fs_sync_meta_pages().
> >>>>>>>  	 */
> >>>>>>>  	truncate_inode_pages_final(META_MAPPING(sbi));
> >>>>>>> +	/* cleanup recovery and quota inodes */
> >>>>>>> +	f2fs_cleanup_inodes(sbi);
> >>>>>>>  	f2fs_unregister_sysfs(sbi);
> >>>>>>>  free_root_inode:
> >>>>>>>  	dput(sb->s_root);
> >>>>>>> @@ -3445,7 +3457,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>>>>>>  	/* give only one another chance */
> >>>>>>>  	if (retry) {
> >>>>>>>  		retry = false;
> >>>>>>> -		shrink_dcache_sb(sb);
> >>>>>>>  		goto try_onemore;
> >>>>>>>  	}
> >>>>>>>  	return err;
> >>>>>>> -- 
> >>>>>>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> >>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> >>>>>>
> >>>>>> .
> >>>>>>
> >>>>>
> >>>>
> >>>> -- 
> >>>> --
> >>>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> >>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> >>>
> >>> .
> >>>
> >>
> > 
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
