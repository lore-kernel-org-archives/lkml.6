Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06420879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LC7UiFC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E06420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeLETbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:31:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51182 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLETbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:31:03 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so23260250iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+VLMRUHlbZnRncuw0g8QgA4tl13hFpm296+rm37XvpI=;
        b=LC7UiFC5HwTn2963xkCRYAsyQplGwpjb20dJBrZ8WXrDm28sm6xwFkH0zMdGZq4/3h
         fiRp7+zlqUqcX/vjApYYkfUfGQrfUBEME9u8xzkE4lHQ9A8I2aM1FIWngMWwDhTZUXYG
         XO6HwMQ26mm2Dq94hFnnY53jzgLM3v/c+7ORclWmjXF3MT5xZ3zsWLxpA7ITFv2Zr3ZB
         ss74cmnwoMGA1se7LSQ1i7G2f1arAZ9J2JihbhFWBjFnr/MmiYbQsy+QZ4GRkDcnUtT6
         M973QIyZqOMXTNNkffJQIlDIBFTT1KeSmBkQVL6xcMNplxUEyGFsPJjA/WTVaJpS0t2K
         e7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+VLMRUHlbZnRncuw0g8QgA4tl13hFpm296+rm37XvpI=;
        b=k0cgiVFr9LfcSPxtMqRUro0Of80hY9FWsIhuQa0l5Bn5k9AS2W9IKBE7i5Nm694Psf
         FWvQBLeUwEuaiyG1qj1VIRKeK1qMn8fU6Uok1r8kN0779m95wAGAmqpJ68diUmZfvrf7
         NvlMivFz7XqeWgRAkGgg/u8oNYGVtkk/5tLVeX0SI0+EkA4Q+vVEn0sEp11apKgWSkP9
         8xZoZqtSov7rcdMWwzCVmsyT5XusUYj/0fV7R4lKfm17JeY9mh74fu1+cF5PnJacrE8K
         mUeWx5Ej+S8WKG6fTjaVgmVRehcdVtoMZBNbiMdVekTIv535AjgPPdNqpfG0T/OP/CKf
         SZqA==
X-Gm-Message-State: AA+aEWYk3xUeslmP+WLmQmRnN/IpZ5VAnsJd8rP71Zx4PP0/ra0LU9Wx
        i1aJBC22k0/i1yaUDVBvwrv8ew==
X-Google-Smtp-Source: AFSGD/XEsZvp+qtpCOJf99LMiUJNPljbRqcM+Mg+rF4AVIXwFlyMKS2hNAvaJmdC5tWDFP2aCJ2Q4g==
X-Received: by 2002:a02:89a4:: with SMTP id p33mr23749124jaj.0.1544038262375;
        Wed, 05 Dec 2018 11:31:02 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id z10sm9009189ioh.20.2018.12.05.11.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:31:01 -0800 (PST)
Date:   Wed, 5 Dec 2018 12:30:59 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: fix amd_iommu=force_isolation
Message-ID: <20181205193059.GA224713@google.com>
References: <20181204223716.214159-1-yuzhao@google.com>
 <20181205160955.p3juusqdxarmo2yc@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205160955.p3juusqdxarmo2yc@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:09:55PM +0100, Joerg Roedel wrote:
> On Tue, Dec 04, 2018 at 03:37:16PM -0700, Yu Zhao wrote:
> > The parameter is still there but it's ignored. We need to check its
> > value before deciding to go into passthrough mode for AMD IOMMU.
> > 
> > Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  drivers/iommu/amd_iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index 1167ff0416cf..3e4219e6cff0 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -2195,7 +2195,8 @@ static int amd_iommu_add_device(struct device *dev)
> >  
> >  	BUG_ON(!dev_data);
> >  
> > -	if (iommu_pass_through || dev_data->iommu_v2)
> > +	if (iommu_pass_through ||
> > +	    (!amd_iommu_force_isolation && dev_data->iommu_v2))
> 
> This breaks the iommu_v2 use-case, as it needs a direct mapping for the
> devices that support it.

Actually this is what we want. We occasionally use this parameter
to isolate v2 device when debugging memory corruption that we
suspect is caused by DMA. It helped us before. Now with the patch,
we caught another v2 device doing DMA write to memory areas that
it's not supposed to.

> I think the force_isolation parameter does not make sense anymore today
> and should be removed.

Could you please suggest an alternative? Otherwise, we won't be able
to force v2 device out of direct mapping for the reason mentioned
above.

Thank you.
