Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6FC208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SuFqG7pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6FC208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJBEmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:42:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38836 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBEmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:42:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id u197-v6so12596416oif.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RkkFyiSuSjZDFXQ7/F9AJqBd90KKZAOUQfjKYppXWA=;
        b=SuFqG7pFrdjpryB/HWQOkPx1t2xPPVMfoKwSFdGNxvW4E681Fdl2/gX8Q7r5O+7sOZ
         Dh0U33Q9gwdgnLTKe7TteAGWNkHKXZshWpda6S2X3nb1ru8UrSi6W5VpotyNErLPVIQc
         wvav55K6vHmDZlOwC0Lr0aRC+q69yRg6l4Fo2h/p/38YB7/5XDPj1SLC3yCthQ4F0xRp
         fljAMEF2b0x6XbE/qhTaBINoHHhSGsDxnMh7acaRUoKk8TTw2SADSa4SXksC1Bb7oR4q
         dha/JhMgWjVAeFO+aOk0KAg3s3relPuxBiGzEnzW3PKPOV688A2UAxveFkuWwKx8eOKr
         IevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RkkFyiSuSjZDFXQ7/F9AJqBd90KKZAOUQfjKYppXWA=;
        b=Mun54Ss1Vr95aQ88VdkdYDe+0HSlPgSAdkkdYfO6TbiGz8+ZUpEY96y1nJE1oS2hCF
         sY2DIahwT1iNc5llOf+jDyozvpG63m0tAtzJjA1ifJ4zxWyrLYpH9JKK2imEmEkR1xgN
         fDYHS28RghgY7eX0Y0BGWfZJKN+dy24rG5jXLbgo0bKpFM9IMWtVn+ZI0tHRWZ6Inanb
         DCkj/iH7YhqUDPmhstwXDWvUYT/ZFdKUJ1lsTAGVtJ0CrOy+uD3EIL6udlknjJMwsaEY
         mj5l763TfOVH+fCERfsRgslwmtrCtWPf6QYEQaEtCm4Mssyi1RzKM8b/hg4HCd1X38uj
         colg==
X-Gm-Message-State: ABuFfogUwoOQ2G7KOoJ9+ChK2gH5O50DEEEhRQy3o0BcfBHKtWZrVxI5
        a1eFdKSQ9e2LS2jVlmnF610OVbvNpIVC02jazfIoPHsl
X-Google-Smtp-Source: ACcGV63f07qxrATNKf0KPQuyn/8YsPoSq+pnygiRZNG2JAVUpwkMx5hQyGCkJ999tz6WaaBwIYEWoA9L6ilst3HLTWI=
X-Received: by 2002:aca:60c1:: with SMTP id u184-v6mr5614167oib.99.1538431377406;
 Mon, 01 Oct 2018 15:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <153842839852.2679462.16816747305002065908.stgit@dwillia2-desk3.amr.corp.intel.com>
 <71e2a4b6-68d9-d90d-b927-90840d8c6ee1@linux.intel.com>
In-Reply-To: <71e2a4b6-68d9-d90d-b927-90840d8c6ee1@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Oct 2018 15:02:45 -0700
Message-ID: <CAPcyv4jQ7eAbEaUUP0R_JFKRADGU1kXhMd_Q=Gw5+1Xki5WYjA@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm, dimm: Maximize label transfer size
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 2:54 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
>
>
> On 10/1/2018 2:14 PM, Dan Williams wrote:
> > Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
> > operations. Given the expense of calling into firmware, maximize the
> > amount of label data we transfer per call to be up to the total label
> > space if allowed by the firmware, or 256K whichever is smaller.
> >
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes in v2:
> > * clamp the max allocation size at 256K in case large label areas with
> >    unlimited transfer sizes appear in the future.
> >
> >   drivers/nvdimm/dimm_devs.c       |   14 ++++++++------
> >   tools/testing/nvdimm/test/nfit.c |    2 +-
> >   2 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > index 863cabc35215..3616e2e47788 100644
> > --- a/drivers/nvdimm/dimm_devs.c
> > +++ b/drivers/nvdimm/dimm_devs.c
> > @@ -111,8 +111,9 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
> >       if (!ndd->data)
> >               return -ENOMEM;
> >
> > -     max_cmd_size = min_t(u32, PAGE_SIZE, ndd->nsarea.max_xfer);
> > -     cmd = kzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
> > +     max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
> > +     max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
> > +     cmd = kvzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
> >       if (!cmd)
> >               return -ENOMEM;
> >
>
> So I wouldn't use 256K as the limit, maybe 256K minus the sizeof(*cmd).
> Otherwise you are still allocating additional memory to take care of
> that little trailing bit that is being added.

Does it matter? This is a slow / infrequently used path and I do don't
see the practical difference of 256K vs slightly less than 256K.

> > @@ -134,7 +135,7 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
> >               memcpy(ndd->data + offset, cmd->out_buf, cmd->in_length);
> >       }
> >       dev_dbg(ndd->dev, "len: %zu rc: %d\n", offset, rc);
> > -     kfree(cmd);
> > +     kvfree(cmd);
> >
> >       return rc;
> >   }
> > @@ -157,9 +158,10 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
> >       if (offset + len > ndd->nsarea.config_size)
> >               return -ENXIO;
> >
> > -     max_cmd_size = min_t(u32, PAGE_SIZE, len);
> > +     max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
> >       max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
> > -     cmd = kzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
> > +     max_cmd_size = min_t(u32, max_cmd_size, len);
> > +     cmd = kvzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
> >       if (!cmd)
> >               return -ENOMEM;
> >
>
> For the set operation I am not sure you have any code that is going to
> be updating things multiple labels at a time. From what I can tell the
> largest set call you ever make is probably for a namespace index and
> odds are that will only ever be 256 or 512 bytes.

Inside the kernel, true, but we do perform large sets from userspace.
That said I don't see why this low level routine should encode
layering violation knowledge of how it might be used.

> Also the limitations here could probably use some additional clean-up.
> For example you have a check for offset + len > config_size above this
> min_t calls. As such it should be impossible for length to ever be
> greater than config_size so you shouldn't need to test for the min of
> both and could just use the min of len versus the max_xfer.

Again that's a case of this leaf routine encoding assumptions about
how it might be used. I'd rather be pedantic since this is not a hot
path.
