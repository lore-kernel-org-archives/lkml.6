Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5231C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5BB2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NquwsiAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfALRqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:46:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37381 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfALRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:46:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so7667127pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FNpuV0Jeqd2hLiCq+naeMY4DzT7VhZ4Nn7IyjsD8+Zg=;
        b=NquwsiAx/qwQceiDtU3koMlRxQ/SymVS3EMpvC0j4ImHfVqzT1YV7TDTH0aWLdhBtz
         jIc5BJ3EjoKowO6eHMrcaAiaaBl4zTOfe3GecmaJKM6Efazmn4bgKnGT8WHlHyHO4QMZ
         gj/9MlihtYsnniJr9Sg8y2rk8/1QHIDyUjp5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNpuV0Jeqd2hLiCq+naeMY4DzT7VhZ4Nn7IyjsD8+Zg=;
        b=ImcRFlK10/gIHbMLLdtK4Jg6tXZ21iQ9BBW9dnTKX89WjU1RxYoQReH++pq2TKhTa6
         EI2U4EPQjyRkkCEAVUM9o+fWmHMB9lWl0OOWbPSDV5vk45aroj8joByzRfADxX5Ks80a
         U8FCqZILPeOin5HbWKoic2NuI/zSFsNp5P3YmfYQfadZ6wgLkZeSH+eBXQxY6hIBG80a
         WLLSdDPiajodFx7GnqOj3Xvm8NtBgIGqaYQvawjyBIZK4e51bnnPo8N/kGCTcloJulSb
         PY4jvJWVJg4f/VATUwoQZz0E7bzB55kVkIbvocYXbpgEe3RCLwxFbx7jVrjDeMJKCcjK
         TE0Q==
X-Gm-Message-State: AJcUukfK00E9iMTKMpsUgMNAIie1WfPLjAy6/2QKArDxDQ3Edoft11iS
        HthReomthTTIqm2xnv3/etyTcQ==
X-Google-Smtp-Source: ALg8bN6GyhdRrVnZHRxp1wR/ILSflI6d6WR3sHx0vc4aGPUfUC0q7p1t1AznUwQ8tt0iN0xA/snFRg==
X-Received: by 2002:a63:e247:: with SMTP id y7mr14568508pgj.84.1547315205685;
        Sat, 12 Jan 2019 09:46:45 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z7sm104117304pga.6.2019.01.12.09.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 09:46:44 -0800 (PST)
Date:   Sat, 12 Jan 2019 09:46:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: Consider device limitations for dma_mask
Message-ID: <20190112174642.GC1992@tuxbook-pro>
References: <20190111225402.6133-1-bjorn.andersson@linaro.org>
 <CAD=FV=WdCVENn8-5qBUPmiWm5z95_+pxuKv=075e6n1tcaS97w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WdCVENn8-5qBUPmiWm5z95_+pxuKv=075e6n1tcaS97w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Jan 15:33 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Fri, Jan 11, 2019 at 2:54 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Qualcomm SDM845 the capabilities of the UFS MEM controller states
> > that it's capable of dealing with 64 bit addresses, but DMA addresses
> > are truncated causing IOMMU faults when trying to issue operations.
> >
> > Limit the DMA mask to that of the device, so that DMA allocations
> > is limited to the range supported by the bus and device and not just
> > following what the controller's capabilities states.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/scsi/ufs/ufshcd.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 9ba7671b84f8..dc0eb59dd46f 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -8151,11 +8151,14 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
> >   */
> >  static int ufshcd_set_dma_mask(struct ufs_hba *hba)
> >  {
> > -       if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
> > -               if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
> > -                       return 0;
> > -       }
> > -       return dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(32));
> > +       u64 dma_mask = dma_get_mask(hba->dev);
> > +
> > +       if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT)
> > +               dma_mask &= DMA_BIT_MASK(64);
> > +       else
> > +               dma_mask &= DMA_BIT_MASK(32);
> 
> Just because I'm annoying like that, I'll point out  that the above is
> a bit on the silly side.  Instead I'd do:
> 
> if (!(hba->capabilities & MASK_64_ADDRESSING_SUPPORT))
>     dma_mask &= DMA_BIT_MASK(32);
> 
> AKA: your code is masking a 64-bit variable with a value that is known
> to be 0xffffffffffffffff, which is kinda a no-op.
> 

You're right, so I took a stab at reworking the patch, but we end up
with something:

	u64 dma_mask;

	if (!(hba->capabilities & MASK_64_ADDRESSING_SUPPORT)) {
		dma_mask = dma_get_mask(hba->dev);
		dma_mash &= DMA_BIT_MASK(32);
		return dma_set_mask_and_coherent(hba->dev, dma_mask);
	}

	return 0;
}

Which makes me feel I need a comment here describing that what happens
in the 64-bit case (i.e. nothing). So I think the proposed form is
clearer, even though the compiler is expected to optimize away one of
the branches.

James, Martin, do you have a preference?

> 
> ...other than the nit, this seems sane to me.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks,
Bjorn
