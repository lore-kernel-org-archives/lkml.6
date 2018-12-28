Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96A22146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545974368;
	bh=y5wLA7g5cuSaXSJmD8mTycoS1aYJK1QqyC981zkZlgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iN5c8gYpJykXnyZ6yMFJXvnrIgpN3/o57YxELnmAp3vb/z/9BVnwfK+cU99THzbSp
	 kt+IEmKcjBTL9RR+cZXsBhaKu4XvLmAkHaG4UOphnqOm6sEYx2NbdUASAiv7dCbHPb
	 G62vXNLZ2PNvfHsSRE0Ld5nJePypHuniIFCwsqJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbeL1FT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 00:19:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38063 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeL1FT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 00:19:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so10007031pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9KDkb/3kAizBGYloacyarWHlr+VIIGbdHCDqT6Pgl8=;
        b=SGTazf0/wVgLOoGbQrbN5rBiliD4P++zgFJZO28ZY/RdFbsrV4WFYmpAb6ComSu+py
         zZYz8ZxoVf827OSzs4ell4Ca/GnshybeMPWzKnQE+pidAuMeT66RwfmBJyMLs2HxwJPZ
         ZEosN1HrPKzbc7V8q1K46zedTh6LRL+NYrukY9qKO0WcPQLXhnXiJzdNEBYfgCOzJJq0
         ocV5CFo2jcfTcT1GSMWZ7xhMf+MaLbOagGTMulDg+bLpqcHlU4xAyrFGYaHPDTsubWTf
         VCFxiyALndKIz16OLJuM0YVxkscK470PjgfuG9EgLgPrZ7EuQHF5cAODsJDlkagOqp7a
         yi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9KDkb/3kAizBGYloacyarWHlr+VIIGbdHCDqT6Pgl8=;
        b=QvhtLUqCIAJ8GRpadL8swGyJPyqi46sNm3ar2k6ENs2WwZii4qacfuRYCtBjU94p1G
         3Lan9xTuFAAXEP/96odvIFWtTk4AaQoxdVXMSFtZK+9XzmJ5toziNTZnrPIdsDTi5wLI
         g/MC29LGODj58G5iyyRhkIgsUCyk/OwgKQ2LOA8N5WEyH7XgVIpRQorpc32nEL7DZ3be
         DRQqAHNgCUlxgq26AwplGArMtuAZJzsOTZSPAvMUqMFs7MsRwLvwb231SS/Kzq1+N1GO
         XPBFLhqxlyFnotbESeCFbo/11I09VJXqQ+S3Si0nUJBjJmpxJJXVAEmRrDW6jCo+YIMl
         Io0g==
X-Gm-Message-State: AA+aEWatCHfX8LA6sjPWa3me7gAhpiJV2ObQT9uZlhaCHlxEw1cAzqlw
        +CkrKUyN8ySeVENZGMplCVTF7pDLWl8=
X-Google-Smtp-Source: AFSGD/UDyG9SjWWNSj10K/ClNN4fSL2eBaer79Jv8+kD2dDTlxlLVcCW+tRDPBywZ4sYY3Arcjf8LA==
X-Received: by 2002:a62:109b:: with SMTP id 27mr26219574pfq.227.1545974366296;
        Thu, 27 Dec 2018 21:19:26 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id e65sm73290265pfc.74.2018.12.27.21.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 21:19:24 -0800 (PST)
Date:   Fri, 28 Dec 2018 14:19:20 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        srnvs@google.com
Subject: Re: [PATCH] zram: idle writeback fixes and cleanup
Message-ID: <20181228051920.GA63763@google.com>
References: <20181224033529.19450-1-minchan@kernel.org>
 <20181227022624.GA30091@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227022624.GA30091@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Thu, Dec 27, 2018 at 11:26:24AM +0900, Sergey Senozhatsky wrote:
> On (12/24/18 12:35), Minchan Kim wrote:
> [..]
> > @@ -645,10 +680,13 @@ static ssize_t writeback_store(struct device *dev,
> >  		bvec.bv_len = PAGE_SIZE;
> >  		bvec.bv_offset = 0;
> >  
> > -		if (zram->stop_writeback) {
> > +		spin_lock(&zram->wb_limit_lock);
> > +		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
> > +			spin_unlock(&zram->wb_limit_lock);
> >  			ret = -EIO;
> >  			break;
> >  		}
> > +		spin_unlock(&zram->wb_limit_lock);
> [..]
> > @@ -732,11 +771,10 @@ static ssize_t writeback_store(struct device *dev,
> >  		zram_set_element(zram, index, blk_idx);
> >  		blk_idx = 0;
> >  		atomic64_inc(&zram->stats.pages_stored);
> > -		if (atomic64_add_unless(&zram->stats.bd_wb_limit,
> > -					-1 << (PAGE_SHIFT - 12), 0)) {
> > -			if (atomic64_read(&zram->stats.bd_wb_limit) == 0)
> > -				zram->stop_writeback = true;
> > -		}
> > +		spin_lock(&zram->wb_limit_lock);
> > +		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> > +			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
> > +		spin_unlock(&zram->wb_limit_lock);
> 
> Do we really need ->wb_limit_lock spinlock? We kinda punch it twice
> in this loop. If someone clears ->wb_limit_enable somewhere in between
> then the worst thing to happen is that we will just write extra page
> to the backing device; not a very big deal to me. Am I missing
> something?

Without the lock, bd_wb_limit store/read would be racy.

CPU A                                                           CPU B
if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
                                                            zram->bd_wb_limit = 0
    zram->bd_wb_limit -= 1UL << (PAGE_SHIFT - 12) 

It makes limit feature void.

> 
> 	-ss
