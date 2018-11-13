Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0586222360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9rlp2E8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0586222360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeKNDhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:37:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34337 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeKNDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:37:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so6372512plo.1;
        Tue, 13 Nov 2018 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tYc97vSuzDNoxj8RrLp//Pzo9D+r6eDHSOuOQ7yPIzc=;
        b=N9rlp2E8xryi8VApVoOkfC6yWPj/p/8gIxig5n0+91Uf0axAWj0uEZ00X+UlC0DRYY
         DuKHirxgZmeoIcb3bh5Vng6Cm28uGBWCrCO/adv0tRcj8mCShLH4KP3aRdkjnk9PAkDF
         db+PIeBOF46kyOoSOOZseNHZ/7bsBrb1CPFswCndFcEACxXrz2GNZmsdjaur+UAWFmsV
         QshDzTvYJXu0mJ1cD5xJeLRN+OyVNIDMiQH4g2BtrHLyphyd3jJ72x27LlC+oG971cf0
         wzHeQZeKKlxZSDNGwtB38oQonVvkDeKiD14YX+bpU1+UFBn9ez6I2X4OvhDuSdwt8eC9
         80iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYc97vSuzDNoxj8RrLp//Pzo9D+r6eDHSOuOQ7yPIzc=;
        b=fItj2W9wHZlrp+OxJ3To5JsSQ8m6salPAL5ZFCoYhR6Pvs5HY31zT4yObcr0UTcoY4
         tdb4LklKc9sRldrYUwARAHKVfots5ooyLbZNGgk/1GMkOkSlM3d63ArArFjefvm9URE8
         otmeekQJzaKSnPjS5H/omyCim3ih9U/vvg4AmTv5MM25PFczm5hCvJ3cRuALxJTQAJd3
         CTyn/f8XIfGPIbeKFPVg8bSne5aPHDT9heijFT3k0wjP00wg+nOd15K/klzbkl4Pl4c1
         ecq/9bDze1VRELtT41wNn+rhBZOL0kq+FWcvTdDwCRrjAWw/Kdi63H0Im1nc+UmFyYuv
         Ht2w==
X-Gm-Message-State: AGRZ1gLGm6+KrYvrfE5ZoeoEySxx7D+PD9mMM40mEcYEgrskkN/Lop9Z
        NlOlsOoqWQ7OyoQzpu38jE8=
X-Google-Smtp-Source: AJdET5c6CPBAUC3LjtzLX5rCl8Odr8CyoPz0LENw2dYO1Zh6BjOzez8Mz2N2mPcXx+5ScfysXdz3Cg==
X-Received: by 2002:a17:902:aa4b:: with SMTP id c11-v6mr5611470plr.303.1542130706246;
        Tue, 13 Nov 2018 09:38:26 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-88-98-70.san.res.rr.com. [76.88.98.70])
        by smtp.gmail.com with ESMTPSA id f32sm18821212pgf.80.2018.11.13.09.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 09:38:25 -0800 (PST)
Date:   Tue, 13 Nov 2018 09:38:22 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>, pawel@osciak.com,
        kyungmin.park@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2-core: Fix error handling when fileio is
 deallocated
Message-ID: <20181113173821.GA11925@myunghoj-Precision-5530>
References: <CGME20181112005053epcas4p1c674759797b4a930cfcce3abc7edd9ad@epcas4p1.samsung.com>
 <20181112004951.GA3948@myunghoj-Precision-5530>
 <9402424d-6e0c-b628-c6c2-8f87b5276a36@samsung.com>
 <636c6ed7-25ef-fd51-4555-3aeb28e96f89@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <636c6ed7-25ef-fd51-4555-3aeb28e96f89@xs4all.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:56:18PM +0100, Hans Verkuil wrote:
> On 11/13/18 11:27, Marek Szyprowski wrote:
> > Hi Myungho,
> > 
> > On 2018-11-12 01:49, Myungho Jung wrote:
> >> The mutex that is held from vb2_fop_read() can be unlocked while waiting
> >> for a buffer if the queue is streaming and blocking. Meanwhile, fileio
> >> can be released. So, it should return an error if the fileio address is
> >> changed.
> >>
> >> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> >> Reported-by: syzbot+4180ff9ca6810b06c1e9@syzkaller.appspotmail.com
> > 
> > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Sorry:
> 
> Nacked-by: Hans Verkuil <hans.verkuil@cisco.com>
> 
> This addresses the symptom, not the underlying cause.
> 
> I have a patch that fixes the actual cause that I plan to post soon
> after I review it a bit more.
> 
> Regards,
> 
> 	Hans
> 

Hi Hans,

Thanks for explaining the root cause. I was also thinking a similar
patch with your second one. It looks like the reported syzbot is needed
to be added to your first patch.

Regards,
Myungho

> > 
> > Thanks for analyzing the code and fixing this issue!
> > 
> >> ---
> >>  drivers/media/common/videobuf2/videobuf2-core.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> >> index 975ff5669f72..bff94752eb27 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >> @@ -2564,6 +2564,10 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
> >>  		dprintk(5, "vb2_dqbuf result: %d\n", ret);
> >>  		if (ret)
> >>  			return ret;
> >> +		if (fileio != q->fileio) {
> >> +			dprintk(3, "fileio deallocated\n");
> >> +			return -EFAULT;
> >> +		}
> >>  		fileio->dq_count += 1;
> >>  
> >>  		fileio->cur_index = index;
> > 
> > Best regards
> > 
> 
