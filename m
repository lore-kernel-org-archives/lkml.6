Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D3520660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h8u3bzgk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YE5ZWAMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D3520660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeKZPWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:22:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeKZPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:22:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01CF16086A; Mon, 26 Nov 2018 04:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543206549;
        bh=BMYbuek/RlOM1z9mg1oVwke7qOyeo8rnj9Sw71HHi78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8u3bzgkM+K8zUPaR8i6OLv90zPukOfbEbDCj0ieD48XN4dAPDtmjN5bnrIc06cCA
         xtH7fk01DBIr1j1lHAUvGEhyKyDXoImKb3URDvO028suaOXM0MiwWcjxs7XvK+HbV9
         8756buaPeRCQcMzDVfvkx9aRe49dRRFUwhxyrSUQ=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D14D60722;
        Mon, 26 Nov 2018 04:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543206548;
        bh=BMYbuek/RlOM1z9mg1oVwke7qOyeo8rnj9Sw71HHi78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YE5ZWAMHkvLTbHBgbsAXx2hUMTUXjpBIuw1OOogXKLUS9J4C10Pw11dnciAr1lMHY
         fHNTWJFqHpdlIHl+ffVp4Mb6vAdT+j08O4k9dPeSW68+gY/++YkYY/FItS9csuqHUc
         yRLyxyv5+iUqJZjq7ipkTSPkzSdumKgvAKhZjYXU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D14D60722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 26 Nov 2018 09:59:03 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to allow node segment for GC by ioctl path
Message-ID: <20181126042903.GD9838@codeaurora.org>
References: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
 <f94e8b8c-0c20-0668-16ad-4978b0600d36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f94e8b8c-0c20-0668-16ad-4978b0600d36@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 06:23:55PM +0800, Chao Yu wrote:
> On 2018/11/23 13:12, Sahitya Tummala wrote:
> > Allow node type segments also to be GC'd via f2fs ioctls
> > F2FS_IOC_GARBAGE_COLLECT and F2FS_IOC_GARBAGE_COLLECT_RANGE.
> 
> IIRC, only F2FS_IOC_GARBAGE_COLLECT_RANGE pass a valid segment number via
> @result parameter in get_victim_by_default(), so in commit message, it
> needs to remove F2FS_IOC_GARBAGE_COLLECT, right?
> 

Yes Chao, my mistake. Thanks for pointing it out. I will update it
and send the patch for review.

> Thanks,
> 
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/gc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index a07241f..e4689c6 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -323,8 +323,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >  	p.min_cost = get_max_cost(sbi, &p);
> >  
> >  	if (*result != NULL_SEGNO) {
> > -		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
> > -			get_valid_blocks(sbi, *result, false) &&
> > +		if (get_valid_blocks(sbi, *result, false) &&
> >  			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
> >  			p.min_segno = *result;
> >  		goto out;
> > @@ -404,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >  		}
> >  		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
> >  
> > +	}
> > +out:
> > +	if (p.min_segno != NULL_SEGNO)
> >  		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
> >  				sbi->cur_victim_sec,
> >  				prefree_segments(sbi), free_segments(sbi));
> > -	}
> > -out:
> >  	mutex_unlock(&dirty_i->seglist_lock);
> >  
> >  	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
> > 
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
