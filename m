Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151CECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D63320645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="B6t80Qbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D63320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJRHeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:34:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39886 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeJRHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:34:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id e67-v6so4437994plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6+rMYdYJn8C5+qZ2z62nvqPvy/alqQzoZS/EBm2TrQ=;
        b=B6t80QbzufQsKOq6sSnGb7G9XmZuRmGMy+3U1cIbCOCWtSrFKPHpvv/LnqQhpGVCK0
         XKluDz571Mj1PmtHyFp2VC368hIEMpdHjeEGET3gsUj9OXPrlreviUa859sbbj8u0me3
         rmmSau50ZtfewE8d93kVl+YcLra0IA51KXL6lYsH7ingnENEh/igKFbm1eFzBAJZnEMC
         69AWs8w82Sb0zzPAwNCrRYHihjhr+tN9pW/X8stk212FZPoo1zCOOfuzg3SW+EdGJJzw
         BMcWFQbQ619sDF5YQkglnzL5cBMgeciGKo0IYrditeb29zhwCXMGXM0aBGMMDlHF13un
         WugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6+rMYdYJn8C5+qZ2z62nvqPvy/alqQzoZS/EBm2TrQ=;
        b=QvpCta6sQGee/htmxnluHmK1qXVOGJ0Cjxsd7xk4sAH7u5yUPoCOAbf6dOWceNs+Zz
         p1SXfQTkSEgnaRkwLty/M1kJpRpOGHVcXAvx6D68e0COgOYd4vYrFlqWPBHi2dKUWnZh
         gb47X3f5aKiP33OcNjSY1W5TP+VC8z7ONTAPww2AiPx3hAHzhBiEs2+3UkUgRriU5/N5
         kNVQp17n1cFemuKfyZOjx8Ga6nhE/3GnXDFRSqDK95onR5iDATn/FTq4keZEjsO4jwq2
         m4Fwi8MdfXqnFGfVgptuIeEpHPPgxF8uhA3HKs3CkTvoSQeu8WNGOr/aSPbcVe4ibehi
         F98g==
X-Gm-Message-State: ABuFfojAiM3n01oMs7HWfIKl2lI1RckFQF5U6GIhKbU/N6w9RtWdjDfy
        fMOgJo7pFISYZuZ15W2INOeO1A==
X-Google-Smtp-Source: ACcGV63K3KiTzd1SU4YaTNKMTQAon3gU+2JwQph6uaeGXiohhxeSgKjbeTPheVmRnK1uJN3zT68v5Q==
X-Received: by 2002:a17:902:9002:: with SMTP id a2-v6mr4493174plp.291.1539819379353;
        Wed, 17 Oct 2018 16:36:19 -0700 (PDT)
Received: from [10.11.47.17] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id i188-v6sm19799951pfc.127.2018.10.17.16.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 16:36:17 -0700 (PDT)
Message-ID: <1539819376.3188.6.camel@slavad-ubuntu-14.04>
Subject: Re: [PATCH] hfs: fix array out of bounds read of array extent
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ernesto A.Fernndez" <ernesto.mnd.fernandez@gmail.com>
Date:   Wed, 17 Oct 2018 16:36:16 -0700
In-Reply-To: <20181017150117.fef4f8d8e814aa2d25adba5e@linux-foundation.org>
References: <20180831140538.31566-1-colin.king@canonical.com>
         <20181017150117.fef4f8d8e814aa2d25adba5e@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 15:01 -0700, Andrew Morton wrote:
> On Fri, 31 Aug 2018 15:05:38 +0100 Colin King <colin.king@canonical.com> wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently extent and index i are both being incremented causing
> > an array out of bounds read on extent[i]. Fix this by removing
> > the extraneous increment of extent.
> > 
> > Detected by CoverityScan, CID#711541 ("Out of bounds read")
> > 
> > Fixes: d1081202f1d0 ("HFS rewrite")
> 
> No such commit here.  I assume this is 7cb74be6fd827e314f8.
> 
> > --- a/fs/hfs/extent.c
> > +++ b/fs/hfs/extent.c
> > @@ -300,7 +300,7 @@ int hfs_free_fork(struct super_block *sb, struct hfs_cat_file *file, int type)
> >  		return 0;
> >  
> >  	blocks = 0;
> > -	for (i = 0; i < 3; extent++, i++)


By the way, the hfs_free_extents() has the same logic [1] of for (i = 0;
i < 3; extent++, i++). It looks like that the bug is not fixed yet. Did
anyone test this patch? What's the real reproduction path for the bug?

Thanks,
Vyacheslav Dubeyko.

[1] https://elixir.bootlin.com/linux/latest/source/fs/hfs/extent.c#L251

> > +	for (i = 0; i < 3; i++)
> >  		blocks += be16_to_cpu(extent[i].count);
> >  
> >  	res = hfs_free_extents(sb, extent, blocks, blocks);
> 
> Well, that's quite the bug.  Question is, why didn't anyone notice it. 
> What are the runtime effects?  A disk space leak, perhaps?
> 
> I worry a bit that, given the fs was evidently working "ok", perhaps
> this error was corrected elsewhere in the code and that "fixing" this
> site will have unexpected and undesirable runtime effects.  Can someone
> help me out here?


