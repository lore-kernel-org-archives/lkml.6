Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EF0A1C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A658D208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A658D208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeFLHYy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:24:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:50977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932944AbeFLHYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:24:53 -0400
Received: from [172.17.45.7] ([122.224.77.194]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MMkgl-1fK6Ph1gMh-008eZV; Tue, 12
 Jun 2018 09:24:47 +0200
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] gfs2: add error handling for kmem_cache_zalloc
From:   "cgxu519@gmx.com" <cgxu519@gmx.com>
In-Reply-To: <1528774692-38990-1-git-send-email-jiazhouyang09@gmail.com>
Date:   Tue, 12 Jun 2018 15:24:41 +0800
Cc:     "cgxu519@gmx.com" <cgxu519@gmx.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C20C8754-0C63-4EB2-B3E9-68E4EE29338D@gmx.com>
References: <1528774692-38990-1-git-send-email-jiazhouyang09@gmail.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
X-Provags-ID: V03:K1:PG5soE5SB63s6dvjyhZYRGuHzJc8EN8XMyZbq2LnGQto4AQrtTi
 1FITaMiqYvUN9LpZs1CsR3OCm7+IroPTfYs69xDNmnP90CewXo4VUyb9ABawR6Eu2gQLeXb
 1ET059+Tr3v7pCCPNrs/TVYUq00AypCfl1BYZQIvJNlPnGzRuvnR58evN91+agGyYix8vJP
 YdTmijtWZXLqPoY9ik8CA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YiMrRCEEeig=:iRB4D+x62cfQ1Z9U6tJ2XV
 eLUfHbESEUJDKAhSmGVjMu60V5Fuypk9Ulo6ClmpD3bPyBG8NLXXRWf268sRcDFEmNVoy+gcI
 0Ha9SIpDSG7OJPKFkqudBH5gZaRiIaq07hG2HxXAaquT0O0V5ScLyNnRvvUNWQNJLxM34D7oL
 bO0wPf+EEyBAztOnFuJhOEzYqk2aTzojgDafVDv5XhZoiLU4IYwSlWC2rjJ+xgqiOe63fwqSO
 2QrUzJu3kMt+/2R9uqIiT9gb9pvj65rTfTfr/ppafZumIsyxIdQwOFCcdzuC0cyZaybqvlQ4/
 dfUd5dpj6B+wvS0A9W+xLhTb14JJBZl23JTM0Ak76/yb5HOQNG09WWi6zFSo3DsqQ6kbGim6W
 2ySCOi9QVeV84SLRcZJzUAxQwvFAgSnq/p6lz/A50DT5YsieiDmQ1B/+VSGDI3Jl68FJT9Ltk
 3fxdnnldhbJlFg0omcBE/ImNpT4KD67QohJQQUFoCzLfE0c76a+hrdBuXcaxUCDwLRV9VcVFQ
 +rUmO7qXRQzPwfFPWsTwL3Na9BI2BHt7BEzDH1vcDh7u0CzLbGmhz3eWqXYo/GZ73ERok+Xkw
 qMHUUXCtN3M1oDhQyizEm3g2uxkBWApGy/DVbeV/SnLzzegaOVjoTQ+Xu926yfkAyYGwPYPim
 3eUBKR1LSP4wcVFIzhVzS1lT47J/4qgNboiVT3lJkC6nVsXWkf6Tk1h53oz/cuSPDX8LYA5ql
 9E6pijx+KWNq6Ocvh+9fboDafOfMHY9qUZHV8q2c7laIzMktHC8hvTnML525n4OLM8a4p2jVm
 vunxREP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 在 2018年6月12日，上午11:38，Zhouyang Jia <jiazhouyang09@gmail.com> 写道：
> 
> When kmem_cache_zalloc fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kmem_cache_zalloc.

Should not fail on this case.

Thanks,
Chengguang.


> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> fs/gfs2/trans.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
> index 064c9a0..da81eb4 100644
> --- a/fs/gfs2/trans.c
> +++ b/fs/gfs2/trans.c
> @@ -130,6 +130,9 @@ static struct gfs2_bufdata *gfs2_alloc_bufdata(struct gfs2_glock *gl,
> 	struct gfs2_bufdata *bd;
> 
> 	bd = kmem_cache_zalloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL);
> +	if (!bd)
> +		return NULL;
> +
> 	bd->bd_bh = bh;
> 	bd->bd_gl = gl;
> 	bd->bd_ops = lops;
> -- 
> 2.7.4
> 

