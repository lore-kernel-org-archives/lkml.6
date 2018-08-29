Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A62BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED732086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="EhZXKPr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uyIZWAjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED732086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeH2Kak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:30:40 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56117 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbeH2Kak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:30:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A5C4A3D8;
        Wed, 29 Aug 2018 02:35:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 Aug 2018 02:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=PbPhtZCVZN49VTIZF36yZA7CnNqtk
        /5IjWzEC+dSqUc=; b=EhZXKPr4ZVY7aEyjvCG3bzpxQSQoYUWgOtiN/ylbknFKW
        vE2nF1HzdwcQ1h0j1/kbRHrYlZLrbYB3X4KcmZ4OIEWWgKMaMLlI8cdIotonCWcE
        nEbqyfIPOBV3MBHDPCTISrL9M3Uodnq5sJ1S90jIpti4ybe7rH1B0IZVfFJKcKaI
        xmjbvoOAmuNzmyTWgtJ0CZXRfscC1jJUK8zEd7n47lYSt8VuBE/ZiIi9dMbKBBWe
        m6V7Ip3jecxdeg8gpU3tWqc1YAjgDJGmwKaSxuOBSqPXTUQOXRhk6mkrhiOQF3Pi
        ydzzJq5PYO5l6mvuNirVJzQdETeD2mWdeO1O32Rlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PbPhtZ
        CVZN49VTIZF36yZA7CnNqtk/5IjWzEC+dSqUc=; b=uyIZWAjN+FRG1OKgG6qHyO
        RX6WVRZrVrfzta5hQmzcJz9Cjbs90h7xBYyzCUqkBXFSQqeUh1exQHh/1oguVyqe
        b+CYwYvRZKHBo5lExQTi+eUl/gWeLUgYlWcaDNjRfy5AWGFeJPPlKVkAhTrwjA0C
        N94RVUTDNRGGyIJw2zXxlGbbnE+N1IrYa4leb4cEquf3W+sPPOseD9pJF32CLFpz
        ASNSa+p7P8tUUc/+UHuVHHvjhBGfkY8z+i5lrhbwkIRAFsBfwdAKucxh/PsF7+Is
        2psDO9ev/6KrzOdvFMlfTZw5w8xzDlkvi5G0J42sKP/ZqyLMrV+R0EtH/6m3eEqA
        ==
X-ME-Proxy: <xmx:pj6GWwYLxUkOhm9vuaW2ZTmBgOlvUWjFFMFe-V9Cnt4QT70VI007Ew>
    <xmx:pj6GW_oyGUBHP4KahU1AaHsqz0-4q2Vbo0mjQtbzfOLHbh8EakJ8JQ>
    <xmx:pj6GW2Uu7c-EFt8wcNllZkp_xepzBtKwUhoji6N8SJUEyYyrnD0UpQ>
    <xmx:pj6GW3g3elDO5kkUSrpbLcN-cT3noVbzUrUwhbiKe8aIiVBrooC31g>
    <xmx:pj6GW15L1CzVTF-cuUWQ5_UD4h0dU3t-xwooErMWGVHXr_ibilWa3w>
    <xmx:pz6GW22-7O_nwKV_c4LyMfj-JNmXkx8_Jb6hBn1ToM8kiW45AT-4Wg>
X-ME-Sender: <xms:pj6GW0hqGgmPmmOkCkrbZOIuU0E9IgxgR5_o9lZV1Yrr4xoutYPC2w>
Received: from localhost (unknown [121.44.54.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id DFE44E4519;
        Wed, 29 Aug 2018 02:35:16 -0400 (EDT)
Message-ID: <1535524514.2679.12.camel@themaw.net>
Subject: Re: [PATCH] autofs - fix autofs_sbi() does not check super block
 type
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Aug 2018 14:35:14 +0800
In-Reply-To: <20180827010358.GZ6515@ZenIV.linux.org.uk>
References: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
         <20180827010358.GZ6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 02:03 +0100, Al Viro wrote:
> On Mon, Aug 20, 2018 at 04:37:09PM +0800, Ian Kent wrote:
> > The autofs_sbi() inline function does not check the super block
> > magic number to verify it has been given an autofs super block.
> 
> IMO it's the wrong way to fix it.  The one and only caller where that
> check might trigger is
> 
>                 if (!fp) {
>                         if (cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
>                                 goto cont;
>                         err = -EBADF;
>                         goto out;
>                 }
> 
>                 sbi = autofs_dev_ioctl_sbi(fp);
>                 if (!sbi || sbi->magic != AUTOFS_SBI_MAGIC) {
>                         err = -EINVAL;
>                         fput(fp);
>                         goto out;
>                 }
> with
> static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
> {
>         struct autofs_sb_info *sbi = NULL;
>         struct inode *inode;
> 
>         if (f) { 
>                 inode = file_inode(f);
>                 sbi = autofs_sbi(inode->i_sb);
>         }
>         return sbi;
> }
> 
> First of all, what is that `if (f)' doing in there?  We have just checked
> that in the only caller.
> 
> Next, dereferencing the result of autofs_sbi() does need to be preceded
> by making sure that superblock is autofs one, all right... and what are
> we doing in that first dereferencing, again?
> 
> IOW, turn that into
> 
> 	if (!fp) {
> 		....
> 		goto out;
> 	}
> 	sb = file_inode(fp)->i_sb;
> 	if (sb->s_type != &autofs_fs_type)
> 		bugger off
> 	sbi = autofs_sbi(sb);
> 	....
> 
> and be done with that.  Other callers of autofs_sbi() really shouldn't
> happen to other filesystem's superblocks...

Yes, adding it to the inline does add a little extra for other
callers that won't get a non-autofs super block.

I was tempted to just change autofs_dev_ioctl_sbi() in case other
callers were added but your suggestion is somewhat simpler and
really only requires due attention if changes are made.

I'll send a patch to Andrew based on what you recommend.

Thanks
Ian
