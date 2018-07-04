Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18AFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DDA208B4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyFxJYIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DDA208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeGDQAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:00:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36934 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeGDQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:00:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id h20-v6so2974030pfn.4;
        Wed, 04 Jul 2018 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q5l/PO/pcDSllcoSIjhy7/BFe5u9X14ZO50evzKvZPA=;
        b=GyFxJYIvjwF7fdWDRmZy9/pxdzJ6BUHls/tqAoVUbfNP/0No30d6wh6FPuAxVRdZC5
         K0pZAJi/ny9emb/BojWnXJRRoGYXZ+oIAahQgOzcvwGluvMkXtftBITSG0wEaBtHPyRN
         03BEE3I1oQbM3NZCTE2BL5psioSxsZpH1FcZp7d9HyuOGK5xk/oc8rD1w+b/sZ36fvge
         Dn7hkNSJ0bG1ixiy1LB5IqrrmZuh1mSvadrINy8OKsOACFoM2PWYd//ngkwAsgoBVC4r
         GbI0F0jukjd4mTBo5X01DW4cuRjHz/R8fve+AAi2P9eEodKabtrmwa8gS+mf3s5oj1WT
         gZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q5l/PO/pcDSllcoSIjhy7/BFe5u9X14ZO50evzKvZPA=;
        b=WCqGJdBBliqTyVqWCSAtg2mXsiyEtzk9o9ociBYGF1vHWIjN8+Ku+XGCIPtbWFtIIe
         p7VP42RQ8Xooss8TBoe5gCjaj1YdlxHNGrwuOSDBex9AqGPYzoFZUvC73FvWs9hxtRqU
         +Lhu0FC/uv/iaaQOk7vIPOOxmJ5BPv9LjDFADO5ssMBc72nU3FFLgR2wKKj6Ntm131i/
         9k+3SsDHbsp/0xp48rysCYOnnAsDIKIdJyxlrcPH53Zl16nJqj5rtxatDk52FdQ2XtZl
         /hcjZVgEhv8XyeuwfsqZKF6pq78nvI/za/2n4Ib/TIcZAtLxYnFO5znPQfwSPKsAnFpF
         TWJw==
X-Gm-Message-State: APt69E2C3Mirp7uyXMzYgrNck2/gqyc8HbT21wmX0m81prARV3/XQ9Dr
        L6hGsnnhkJ+fpEkPWdgRe+2YcLss
X-Google-Smtp-Source: AAOMgpcC7QUvqAtlT7WifUe06gJJSefiow+2EYmXUXaEoIM5bXfKiiHG0qQHxEyZi1b8SWPiUoylcw==
X-Received: by 2002:a17:902:8308:: with SMTP id bd8-v6mr2675002plb.329.1530720031678;
        Wed, 04 Jul 2018 09:00:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id v66-v6sm8885761pfb.84.2018.07.04.09.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 09:00:30 -0700 (PDT)
Date:   Wed, 4 Jul 2018 09:00:28 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove dead code
Message-ID: <20180704160027.GA21690@localhost.localdomain>
References: <10747698.EAsn0e6Ddm@amdc3058>
 <CGME20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1@eucas1p2.samsung.com>
 <3318201.BAqn4C3t6k@amdc3058>
 <20180702163010.GA2380@localhost.localdomain>
 <8e1b81d0-2ae4-90aa-b079-7bc778a2f015@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e1b81d0-2ae4-90aa-b079-7bc778a2f015@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:40:25AM +0530, Keerthy wrote:
> 
> 
> On Monday 02 July 2018 10:00 PM, Eduardo Valentin wrote:
> > Keerthy,
> > 
> > On Fri, Jun 29, 2018 at 06:10:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >>
> >> Hi,
> >>
> >> On Wednesday, May 02, 2018 03:20:35 PM Bartlomiej Zolnierkiewicz wrote:
> >>> Majority of this code (i.e. functions from ti-bandgap.c) has been
> >>> introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
> >>> SoC thermal driver"). Just remove it altogether (in case it is needed
> >>> it can be easily resurrected from git repo).
> >>>
> >>> While at it fix incorrect "not used" comments.
> >>>
> >>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> ---
> >>>  drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
> >>>  drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
> >>>  drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
> >>>  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
> >>>  drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
> >>>  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
> >>>  drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
> >>>  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
> >>>  drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
> >>>  9 files changed, 5 insertions(+), 654 deletions(-)
> >>
> >> Gentle ping.
> >>
> >> It would be great to see this patch in v4.19.
> > 
> > Any objections on this removal / cleanup?
> 
> Tested the patch on dra72-EVM.
> cpufreq cooling works well.
> 
> Tested-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Keerthy <j-keerthy@ti.com>

Thanks, queueing this cleanup.

> 
> Thanks for the clean up Bartalomiej!
> > 
