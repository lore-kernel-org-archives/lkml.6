Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223F222E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sraO2dKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407672AbfBNP6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:58:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBNP6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7yxkoEzS4QjuNnxIRh6YpcQaAq+V3CiGcH9UrrGfU/4=; b=sraO2dKfGurn/cdQ8MUQHJV+d
        KTso1iNS3bKo7FYHy6VrKO+XSPbDZcVBYV3BjbVYf+nI2HyTZGV+3Lot9Ewh7vYEkoviAVwtlhBqc
        wZ0LfQd9DQ4mKHzPPBA8rIwHdjd8H7S6pfvP6WB4SYwEr5UGKxTKJ7IEruTfSBoYmAWZ8TC9ZJ4Va
        4XD9GKeJZF1W6qfrn9TKk2SbJF5vsw0t3kJYeBFy3MEeGfKE8WaPhodMM771JzdA3w+UbgCFx/Bao
        iUoAt0V/lRdy15gNx3ZLBbwV/1bMT6VzCCYf9DfVgmFec4pFdEMD2JCMKL4RVgakadTKsCprxdhuL
        VL55s9+7g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guJPG-0001r4-QR; Thu, 14 Feb 2019 15:58:36 +0000
Subject: Re: linux-next: Tree for Feb 14 (fanotify)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
References: <20190214175138.3f69ec91@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b005f0f9-6db1-e9dc-a04c-bf37b37be8ce@infradead.org>
Date:   Thu, 14 Feb 2019 07:58:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190214175138.3f69ec91@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 10:51 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190213:
> 

seen on i386:

when # CONFIG_EXPORTFS_BLOCK_OPS is not set:

ld: fs/notify/fanotify/fanotify.o: in function `fanotify_alloc_event':
fanotify.c:(.text+0x25a): undefined reference to `exportfs_encode_inode_fh'
ld: fanotify.c:(.text+0x29e): undefined reference to `exportfs_encode_inode_fh'




-- 
~Randy
