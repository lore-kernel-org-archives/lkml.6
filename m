Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC0C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE962216E5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="NwJkoCt2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BogTMRmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE962216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeHHHnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:43:11 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:41029 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbeHHHnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:43:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id D6055349;
        Wed,  8 Aug 2018 01:25:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Aug 2018 01:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NJ61PDHsya3BtHIcFEgx29MCwXRWqNineuFDly6u++8=; b=NwJkoCt2
        v/CvGNr5nyQj+QqdB3EZHC95VnZ5qnZ81ajyYcUAsLrRNDorJ/AhI2Lm1utBFMM1
        R3qTiOg9e0U7u11CRDzDEaUKrPtQ6/Kewt0l12Sf5kqKvYV6h59xvzGl1K/QIABk
        ajGGpbzcbIZN3hI20QcrqpHXxebSycu4e9uyGSkEG1CD2W9+80UWhro8VbCV/vyQ
        DSDG6L6KH4dAUoWr9RacorlyoI1/3WOHSWP/DvYLDx0YljLws8PxoUxQqrXKkLJZ
        Qe4CT/NexYTlDwdSizHcmwFQZmyGLgYOKNMRwX1QX1PI6gtK8fBbNfX5X/ENfcGw
        r6Rac8VWpBWcFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=NJ61PDHsya3BtHIcFEgx29MCwXRWq
        NineuFDly6u++8=; b=BogTMRmUtEKQh4ElE2iBriMQmQbWTNnw65VfamclL4JU1
        bc5dgVMKSW9miPjEmmbmUCdScKAeGFleGP+AAux6dhojdeW9qZ76gTJGeso+KqJ1
        RRicR3SB0Z+Om+hkcCvXCLJRxBqAua2eWIR0MGdUpTAhv4DdKqMjJXaexbDlNf3U
        lDXtLrWUNDOzup4eh+uqFdByTIWCnP0A8o3RXM2nOiBQK9pSkknqr3zWYJBAG4sD
        9s1Ssc2gwpgImDx8XDewhEPUZ9ODR4EzPeNo1kMTP43e/nQL3FxyR+Ab1oadihrd
        TJpG9U3CakbI2xV2WZHhva3DXBt2mkp+cjcnNfyrA==
X-ME-Proxy: <xmx:vX5qWyLwdPVncya_mZ8Bm4xTQN075LwRCgrZE2Ice7Hu1aC4q-q5nQ>
    <xmx:vX5qWwJqdEb0KZ0V2k08iGy9XYgNnnHrtkgS_MRut_4nxbCn5GxigA>
    <xmx:vX5qWwXl70C2ZtaWmee6918H0CfRx5Ez42vvO-mBECisGtKWlmq69Q>
    <xmx:vX5qWyhKXcxrVXKniv0AURdf2V6XmY_zSjsgqqdCITgzhwDTyGnluQ>
    <xmx:vX5qW78A_8rR3dFs4OjuBtWER_6udkxTUjBcHCAETDfYo8jMbRyHWg>
    <xmx:vX5qW2QMovcPrdt0v0MZ3wtjMsSMrSIdIY12P7Achfi9N50AWmKEldNRD00>
X-ME-Sender: <xms:vX5qW_5HxzIXnb4_0MgHH47TbP8uHJGv80JTdQ98J-bKC5ew7U1CpQ>
Received: from localhost (unknown [194.244.16.108])
        by mail.messagingengine.com (Postfix) with ESMTPA id ABB4010268;
        Wed,  8 Aug 2018 01:25:16 -0400 (EDT)
Date:   Wed, 8 Aug 2018 07:25:14 +0200
From:   Greg KH <greg@kroah.com>
To:     xiao jin <jin.xiao@intel.com>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        yanmin.zhang@intel.com
Subject: Re: [PATCH] dm-bufio: adjust the reserved buffer for
 dm-verify-target.
Message-ID: <20180808052514.GA20034@kroah.com>
References: <1533704823-5448-1-git-send-email-jin.xiao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533704823-5448-1-git-send-email-jin.xiao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 01:07:03PM +0800, xiao jin wrote:
> We hit the BUG() report at include/linux/scatterlist.h:144!
> The callback is as bellow:
>   => verity_work
>   => verity_hash_for_block
>   => verity_verify_level
>   => verity_hash
>   => verity_hash_update
>   => sg_init_one
>   => sg_set_buf
> 
> More debug shows the root cause. When creating dufio client it
> uses the __vmalloc() to allocate the buffer data for the reserved
> dm_buffer. The buffer that allocated by the __vmalloc() is invalid
> according to the __virt_addr_valid().
> 
> Mostly the reserved dm_buffer is not touched. But occasionally
> it might fail to allocate the dm_buffer data when we try to
> allocate in the __alloc_buffer_wait_no_callback(). Then it has
> to take the reserved dm_buffer for usage. Finally it reports the
> BUG() as virt_addr_valid() detects the buffer data address is invalid.
> 
> The patch is to adjust the reserved buffer for dm-verity-target. We
> allocated two dm_buffers into the reserved buffers list when creating
> the buffer interface. The first dm_buffer in the reserved buffer list
> is allocated by the __vmalloc(), it's not used after that. The second
> dm_buffer in the reserved buffer list is allocated by the
> __get_free_pages() which can be consumed after that.
> 
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> ---
>  drivers/md/dm-bufio.c         | 4 ++--
>  drivers/md/dm-verity-target.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
