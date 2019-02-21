Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07A620855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vcBQmd12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kW0O3e7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfBULod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:44:33 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56397 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbfBULoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:44:32 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C4F1B2FBC;
        Thu, 21 Feb 2019 06:44:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Feb 2019 06:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=QdHa+hmbuwyay79tjqPJqF1rI6N
        CnwJRVTTAewz+uNo=; b=vcBQmd12CZpdBZILKcRtWBHem7ESuPbTYDvs4KBh8Gz
        80wdsJDY2Ulw/PHeRkq3GLEArYmxXOVZhaOBAWQWItMY+1Tbsf02oBYb3BC3HpZP
        8VGurb2bMO9rUbnwgEdco+TzR2eBC740GQ/EcwIxfn21uIkWdbciKbG1aYkKinef
        WLYj97k2iaoKMFk4pPd6JlAfqCXO2REyoZ3a8Jy3i876yXuPlABo1rfSkxnW+S2d
        Y1yUJy6YVY24Nxe8x3Sff8pF4CZwn2+R1vhdgBwYUOAKADUIWbYMbc0NcOxk2hQt
        dbkKwml2qqm4AoZuxQaU/TInn2jGmZvPZW/OxZY1Jig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QdHa+h
        mbuwyay79tjqPJqF1rI6NCnwJRVTTAewz+uNo=; b=kW0O3e7nDf3uK+6LsjWM2D
        KjAY7qHBA8Y0ftoWZC+Tbqe2vaW/wFgga0bedmbBBQrTsrWYBLPha2eozDcP1KUV
        r7EBq/n5lVleoUasHkFWobZhrbgkfWAMokOApSjVO/77F+G3iSShEngSVSthKHAm
        8Bb5MdQJncWaDXt51TsQlll+omf3S+fgLcNMsKXqNEVWxgkzqLRNiSPTObuLNkKJ
        oOY76haxnt7N5HqgotIVRhYR4ORRGzDohLBLGJNX+xZ1SBGCFhRMdltFbWjlOe1D
        StK2nTMRbBTT9zDCOWMbYnKmLjdLvSnPFrlFg9sBjjNq1+UUSHH2NWxJl9tFBTQQ
        ==
X-ME-Sender: <xms:Ho9uXMyDm2lRbGmGQX2W8pUb_sj1a-feljr_4rO0t2BOiPSNEG00zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgdeffeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Ho9uXJVbH3GjnMUjOpoGcNfRnLwPB9ZO14g_iVRmuQsu3zPJnW1yHg>
    <xmx:Ho9uXHY5av55fzL3RmC206RHhpUxAQZmW8ZbWVCeouud0a6O63SXag>
    <xmx:Ho9uXGT6hDDWg7lf3BYHQcZLPhQ-o8jzrXP6OaPB9W5jkhkuzH04aQ>
    <xmx:H49uXLKhCmDe_F-u1BnvR28IG_Pf3M5X0NHMpGjPYplEK6HGDa1rFg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3254F100E5;
        Thu, 21 Feb 2019 06:44:30 -0500 (EST)
Date:   Thu, 21 Feb 2019 12:44:28 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     weiyongjun1@huawei.com, stable-commits@vger.kernel.org
Subject: Re: Patch "scsi: target/core: Use kmem_cache_free() instead of
 kfree()" has been added to the 4.20-stable tree
Message-ID: <20190221114428.GD10737@kroah.com>
References: <20190221054323.53B072086C@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221054323.53B072086C@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:43:22AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     scsi: target/core: Use kmem_cache_free() instead of kfree()
> 
> to the 4.20-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      scsi-target-core-use-kmem_cache_free-instead-of-kfre.patch
> and it can be found in the queue-4.20 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit d95e5d7f77bae4d48a66cda1341c934790898c67
> Author: Wei Yongjun <weiyongjun1@huawei.com>
> Date:   Mon Dec 17 12:19:53 2018 +0000
> 
>     scsi: target/core: Use kmem_cache_free() instead of kfree()
>     
>     [ Upstream commit 8b2db98e814a5ec45e8800fc22ca9000ae0a517b ]
>     
>     memory allocated by kmem_cache_alloc() should be freed using
>     kmem_cache_free(), not kfree().
>     
>     Fixes: ad669505c4e9 ("scsi: target/core: Make sure that target_wait_for_sess_cmds() waits long enough")

Based on this tag, it also needs to go to 4.19.y.  I'll go queue it up
there...

greg k-h
