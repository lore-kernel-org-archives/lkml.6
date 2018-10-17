Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19580ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIKeerdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B707A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeJRH03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:26:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34803 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeJRH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:26:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id o17-v6so32273072qtr.1;
        Wed, 17 Oct 2018 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TwSwRq6Lp+IkOvv3E5dW3c6BPaaHqT0LGoaeKncAi38=;
        b=dIKeerdO8pj5yEveuLhK7+f2xG7/1oPDQV/j44ZIkkmLw94G1AQ2DYVSpn51BWlQqy
         garDzeeEJvculjwAqJ2pThg3JmDORBfwgumEpBQm3dqdBUpLmWG2IrqT5Y9An3qh831N
         6LFXud1xr6ljuAYguUt5pkRY9VoUpRMNxLTb3WufZaWuC4pu+7v5gzAxCRdCt29dngAL
         RowLf8z1dF5ObVA0TjTbA+FZpOY8/QCYAnGgbEUvSC5NbwIT93Hpva9H5Z/90XPZ9Xuj
         lfIBoIXcoUzUXZs7NMfbiGVPEyzgwWlM5rnrs9G+e8iTq8TX2Nrkn8n+ENrqYH4S5dlP
         UrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TwSwRq6Lp+IkOvv3E5dW3c6BPaaHqT0LGoaeKncAi38=;
        b=AFeexVc6eR9zdg3yxYE1kNOskAlEO4uPWNX+H1TMjN83Ecuz9zPAzArdD+NK3iYwoS
         J6QUOD9h8FsedkQTFp/JgCDWl3hJ1seSxojb/bxHkwwsgGIkMq+DOKcTUG7R/mkh9gn4
         2MHmz853o/bmPm3KA8r0DbndOHdlcN3MejmmPUiFls79etFsQX8XYEw+B33yuk6AFn6p
         XSbLjVZs4InIOeAzaMQi2JqOYLMAkS+bx0d9dyzI5ON4nWYgu9u/3RC4uSln9zD4GDQK
         SssIPp4vG1vluza8GVLveh91gfzu6F91wtFRJBRLqAQlPZujmZSN+pQfc7aWlRbPbpKe
         OIfg==
X-Gm-Message-State: ABuFfojx21BBsGuZyqRIZjh8rjipPd3Srwjc2SnhMMLGoNt9wYlMLvew
        5KGGz2s/WZL9ceyMygn92W4=
X-Google-Smtp-Source: ACcGV60KHSoc/W1HWumFLjmoE99eeuR1FLhIpNVZaHoi6UMLFK7evd4h069MTYBh6xtGZrFZqczcQA==
X-Received: by 2002:aed:3a29:: with SMTP id n38-v6mr26108455qte.111.1539818906267;
        Wed, 17 Oct 2018 16:28:26 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id p3-v6sm14923244qtp.55.2018.10.17.16.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 16:28:25 -0700 (PDT)
Date:   Wed, 17 Oct 2018 20:28:20 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vyacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH] hfs: fix array out of bounds read of array extent
Message-ID: <20181017232820.dyvl7crdlilcqtaw@eaf>
References: <20180831140538.31566-1-colin.king@canonical.com>
 <20181017150117.fef4f8d8e814aa2d25adba5e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017150117.fef4f8d8e814aa2d25adba5e@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:01:17PM -0700, Andrew Morton wrote:
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

Sorry, I missed that.  This bug has actually been here since before the
first git commit.

> 
> > --- a/fs/hfs/extent.c
> > +++ b/fs/hfs/extent.c
> > @@ -300,7 +300,7 @@ int hfs_free_fork(struct super_block *sb, struct hfs_cat_file *file, int type)
> >  		return 0;
> >  
> >  	blocks = 0;
> > -	for (i = 0; i < 3; extent++, i++)
> > +	for (i = 0; i < 3; i++)
> >  		blocks += be16_to_cpu(extent[i].count);
> >  
> >  	res = hfs_free_extents(sb, extent, blocks, blocks);
> 
> Well, that's quite the bug.  Question is, why didn't anyone notice it. 
> What are the runtime effects?

This is only triggered when deleting a file with a resource fork.  I may
be wrong because the documentation isn't clear, but I don't think you can
create those under linux.  So I guess nobody was testing them.

> A disk space leak, perhaps?

That's what it looks like in general.  hfs_free_extents() won't do anything
if the block count doesn't add up, and the error will be ignored.  Now, if
the block count randomly does add up, we could see some corruption.
 
> I worry a bit that, given the fs was evidently working "ok", perhaps
> this error was corrected elsewhere in the code and that "fixing" this
> site will have unexpected and undesirable runtime effects.  Can someone
> help me out here?

I don't think so.  This bug also makes extent point to the wrong place on
the following call to hfs_free_extents().  There is no way this can work
correctly in general.
