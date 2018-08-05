Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2463AC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E03219A6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9q+fRkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E03219A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeHFBWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 21:22:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43071 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeHFBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 21:22:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17-v6so5317113pgv.10;
        Sun, 05 Aug 2018 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xk+Ahdq6AFV4FhDrII76CuafDL6QRo5TpDnOtB5nxrw=;
        b=c9q+fRkf+30A87Q7qFbWDnwUDGMefPmbr0XWvuRFSxNZ6M5mnWlc6DE5hyRzUpbWS/
         ljRBemOqH1f1ee9r4fMeG8NLydHRDBAaspuIDx3T4mA1M0TKwMsSFZAdzfLVoASXWARn
         JtGvstWzPf04+jzmoVKka//bYtsgKOrPZy83PUN0OJXBswA9+38psDEnl6VPwPahEy+t
         wgJcOe8h/e7+j1vrnALOen0M8UGgnZLxH1q0uBvsWLP/KspzEisV4qoSjmxSqtrjOaS7
         0bFd/B2ChjWSNQEEXy4i/Tuc3L4hgSFrp0BAUtTZPbBPWGvipthwmxS91B4yXFS2/gmn
         jj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xk+Ahdq6AFV4FhDrII76CuafDL6QRo5TpDnOtB5nxrw=;
        b=BHlGF/XS70sd/wWYc1xYOAVPm1qZBQbvYPA++HgU7IJbxxtl9q5BBNtrbuc8puLU+4
         hlDiX2mFAjG7scpW23leuCQzx6Wlahag23rh84hny6KxolY/Pjp8F0TmZg0Ohe3VtMxD
         NKrbGz1XStvYwp2ftZ51Tp6K4zc67aHZMvzD7eDK6z7AzxeG/xMMzgFrfiZ4SCuKJBxb
         l2vifI/xRecwVZU84RtU2GUeJXXeQ1MCoH+nFMxIussXhtrUPyPvJ7kOZrgrndDG0J2l
         sRv4SbZ4Dht0gOp3MJ37d/izcsBbuCa16fBW+McGNHrjLgf5KflquGa+3xA6IRkDl5H6
         i+4w==
X-Gm-Message-State: AOUpUlE+J9NXgzew7LXmt6AH7P/Wau0cKkt3lB1GvLvhJ/dTGIDAfmb0
        GEYlcifJMV2HY4YyBngF7dk=
X-Google-Smtp-Source: AAOMgpdBLCR47+I7VU+y6xqHiTdZX117aEkNiCiw4ExUqkXcwIZZG3XTXRSXv9MLPfdKGs6mCjXwvg==
X-Received: by 2002:a62:8387:: with SMTP id h129-v6mr14474985pfe.79.1533510950902;
        Sun, 05 Aug 2018 16:15:50 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id v23-v6sm13253622pfm.80.2018.08.05.16.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 16:15:49 -0700 (PDT)
Date:   Mon, 6 Aug 2018 08:15:44 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180805231544.GA209075@rodete-desktop-imager.corp.google.com>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
 <20180803025143.GA86818@rodete-desktop-imager.corp.google.com>
 <20180803162818.8c4719232d6dfece21ebea30@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803162818.8c4719232d6dfece21ebea30@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Aug 03, 2018 at 04:28:18PM -0700, Andrew Morton wrote:
> On Fri, 3 Aug 2018 11:51:43 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > > Is it legitimate to be altering the bdi capabilities at this level?  Or
> > > is this hacky?
> > 
> > Most of device's bdi capability seems to be static but there are few drivers
> > which can change capability. For example, BDI_CAP_STABLE_WRITES
> > 
> > drivers/scsi/iscsi_tcp.c
> > drivers/md/raid5.c
> > 
> > I believe it's driver itself advertisement stuff so I hope it's not hack.
> 
> The bdi is per-disk (per-queue).  So if zram changes the bdi for a
> particular partition then it is accidentally mucking with the other
> partitions as well, and it shouldn't do that.  At least, I think that's

Aha, I didn't know that. Thanks for the heads up.
However, I think zram doesn't support partitioning due to lacking of
probe feature via blk_register_region. ;-)
