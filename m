Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ED620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="JROnxVcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfAQJwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:52:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36826 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:52:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so4587955pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 01:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=H7mpXeJ8YyGT/a6rEEiKtA/OLa1cWu67WVt0ug1SozE=;
        b=JROnxVcceCADeYyMIbsvZKCdtUVAHyJIQIrRL3kKxj7XpM2HfiQbhIkkbYLu/K1hGh
         KsauEtoTe00VS2iPF8Wh2Kc+YAeADn15qOT7znnYyb+k/XFtEx2K2kx3wWYkQ/cUMR92
         PsoBan5ySWHhkfaFN+0oN63eGlEJFwUOMpb3bopEm7QE7xsg99sB+KsSBfeRgWOxMjIw
         0krvbFDWp09J57tmZnG3oK7J/kAqkkuiXfUOAtvRHt9AJ76/1e3MYEdeiRYW/bdSkhnN
         mELvOElsYD4KSzQmYfPzGqQkESICGDEost/xvXJORe1c0Tg/ZX03NSZ5HR0xDDZ6/i9w
         qexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=H7mpXeJ8YyGT/a6rEEiKtA/OLa1cWu67WVt0ug1SozE=;
        b=IzVZnO9U51LdzbH1UfBmqakHq7Y5gpn8SvhHaVzYZ7cZSxhHuIyZvAGrGr2RNJ9QvR
         zbmgCnyvrQ3pLv/Rs58fGTslrk0Fh+wz1Z3e+I9UpJLsfNlFZdEUPM1J2pAPTnJVBZJd
         Fs95EWpW7plTY1+bnDpJ9mQkEggdr3FWz7boL4AeroOlPj1GkymZ3yHWbR+oS1rL64zb
         +EkgbwTCihfXmVD8oNuQTU7YFd3wX5DPByvL5aP6EXUPgjRVZnAWSm/XycRY+CtJJBTM
         K0o4SUBmUYWxJzsgMZzsHYO14c1D2PcyZ/LEddV/zmHtQplLZyLtuNTFO5O1xYxLRRTB
         M9KQ==
X-Gm-Message-State: AJcUukePXhEZVOxzYgjJTJ713mBK4YCDT2YUf6HIlij4/2CtMk6iaSrb
        XwdDvi4VlH4S3ZgRSiiEnI4jYQ==
X-Google-Smtp-Source: ALg8bN66QuI0CtY0wncM5QWN91qtA/gFoKZvbdntqOL0AMt6rKB4qQ62Ce1NLZuoW/bwUliqVUN6dg==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr14072115pfj.58.1547718751042;
        Thu, 17 Jan 2019 01:52:31 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id j21sm2075070pfn.175.2019.01.17.01.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 01:52:30 -0800 (PST)
Subject: Re: [PATCH 2/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, colin.king@canonical.com
In-Reply-To: <20190117091646.GA11828@kadam>
References: <1547696703.4339.21.camel@Centos6.3-64>
         <20190117070227.GM4504@kadam> <1547714827.5079.19.camel@Centos6.3-64>
         <20190117091646.GA11828@kadam>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 17 Jan 2019 17:52:28 +0800
Message-ID: <1547718748.5079.34.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 12:16 +0300, Dan Carpenter wrote:
> On Thu, Jan 17, 2019 at 04:47:07PM +0800, Ching Huang wrote:
> > On Thu, 2019-01-17 at 10:59 +0300, Dan Carpenter wrote:
> > > On Thu, Jan 17, 2019 at 11:45:03AM +0800, Ching Huang wrote:
> > > > >From Ching Huang <ching2048@areca.com.tw>
> > > > 
> > > > Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
> > > > 
> > > 
> > > What does this look like from a user perspective?  Does it fail every
> > > time or does it only fail sometimes?
> > > 
> > > What's the bug exactly?
> > > 
> > > There is no Fixes tag...
> > >From user's perspective, hibernate/resume are OK.
> > But following IO may cause 'isr get an illegal ccb command' in
> > log/messages sometime.
> > > 
> 
> 
> You will need to resend with that information included in the commit
> message.
OK. I will resend this patch later.
> 
> > > > Signed-off-by: Ching Huang <ching2048@areca.com.tw>
> > > > ---
> > > > 
> > > > diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
> > > > index a94c513..b98c632 100755
> > > > --- a/drivers/scsi/arcmsr/arcmsr.h
> > > > +++ b/drivers/scsi/arcmsr/arcmsr.h
> > > > @@ -508,9 +508,9 @@ struct MessageUnit_A
> > > >  struct MessageUnit_B
> > > >  {
> > > >  	uint32_t	post_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > -	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > +	volatile uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > 
> > > There is a well known rule of thumb that when someone uses "volatile"
> > > in the kernel it means there is a locking problem...  Is this __iomem or
> > > something?
> > The done_qbuffer was a command completion queue, it was an area written
> > by IO processor and read by device driver. So, ...
> 
> I'm not totally positive I understand this sentence.  I can find a bunch
> of places which read from this buffer, but I haven't immediately found
> which place writes to it.  Can you give me a function name that I should
> read?
Well, we allocate memory for struct MessageUnit_B in
arcmsr_alloc_ccb_pool(), by assign to acb->dma_coherent_handle2.
Then we tell IO controller its DMA address in arcmsr_iop_confirm().
When a command was completed, controller's firmware program will write a
completion ccb in done_qbuffer through DMA. So, you can't see any driver
funtion write to it.
> 
> > > 
> > > >  	uint32_t	postq_index;
> > > > -	uint32_t	doneq_index;
> > > > +	volatile uint32_t	doneq_index;
> 
> The volatile here is not right.  It's just normal memory.
Right. this volatile is not necessary.
> 
> regards,
> dan carpenter


