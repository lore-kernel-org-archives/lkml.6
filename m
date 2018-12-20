Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD0221773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2tt3Yrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbeLTQiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:38:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLTQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CG/jSNeNChtKOqB2GhAVgwv4KkxMfGgWF7pWoOr89kI=; b=u2tt3Yrf2gIH3x6Lnk4xszbFQ
        DKw9iASYROnevBlH9Xf7ze13R9C39PJ4lpFpZ3KD90t42ccnswbKEo890nx7HyTrjz3rncZL01Djt
        3DOIokdM0vEuFIFV4noCtHDVgZd1KQwohx8FcUY1Fd0L0uB4WEOV5HtQ18Q15XTywKy+FTK2l10WW
        gp67ZHzG5XYNIhudHXe42JPZfbi0ByP9kMr+GFMUy/gRZcCQ1QtBXu+Nnbq92Ka5/FkxNaaRCEq42
        sJ6lrCeCBfkXoTGRNaXeFtdJbA6Vs8K6EGj8bZnNo6bPeFS0NcKBtOBN3rV02VlOCJJH4sp92X6aS
        Jmf/TQA5g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga1Kv-0000cj-Ji; Thu, 20 Dec 2018 16:38:13 +0000
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
 <8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org>
 <96fc8865-c54f-5c6c-f6c8-d7a5a12735e6@leemhuis.info>
 <20181220082819.69fc3e5c@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a02caf89-9221-8e31-4a2d-44b46b81cda2@infradead.org>
Date:   Thu, 20 Dec 2018 08:38:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181220082819.69fc3e5c@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 7:28 AM, Jonathan Corbet wrote:
> On Thu, 20 Dec 2018 16:23:38 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
>> While at it: Jonathan, you mentioned putting the script in scripts/, but
>> according to the Makefile in that directory it is "for various helper
>> programs used throughout the kernel for the build process". That's one
>> reason why it feels wrong to put it there. Another one: that script
>> targets users and thus we should try to make sure they can access it
>> easily. That's why I'm currently inclined to put it in tools/ somewhere.
> 
> Yeah, tools/ is a better place.  Maybe a tools/debugging directory or some
> such?

chktaint is similar (IMO) to scripts/decodecode though.

@Thorsten:
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>


thanks,
-- 
~Randy
