Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A51C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94CC2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="n9JWPvAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfBBB2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:28:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38723 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfBBB2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:28:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so7700414otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 17:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50BM2EtV/rLAKUMfxaHipv1V7XdaEIH2BD6ExorzKUM=;
        b=n9JWPvABcvegUOYCs+pHC0v1uZV/3Fbb8NqkAlBC7f+G7RM94HnTPiFT7zOA7BVwZC
         Q6CPYJJB6I5DB88N/fhjbuesv1a7Avc9cZQ3Essca2Idg6Qk4uT8+ZElHPXc6IllRn6Q
         jhjXQM6THXfNDpLz+AqwWebVMnWrydTHFEt4xGHG0a1A27Tx32vACZsONA3flpFPHO8k
         ZFTErLVDDQFZllFi9YTGnOM6gNkmitg+LaqTjJW1jCIqgasPu4BjUkZwryMMDnFwD2aA
         J6KHS0tJu1iGYAECULPCpOV5DMEePhnhxrfN5+RynQpruJebSFhxVolUvcgMxpUfIcgo
         kmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50BM2EtV/rLAKUMfxaHipv1V7XdaEIH2BD6ExorzKUM=;
        b=D4pnmAfBPSVLgyLT4pR4UgvIOI7EVLSnhzFxwDpQpPaDWHNYROur+tEcg+SwrybKjF
         2fjMHazETtWP51e4c5SIALh4JsPOVhzOJ0YxQv8JWHT+3Tj7+PW0NxKGocfnU1Homnhf
         JzZpqA16S7O6DZt95qb6DuTT4k3RbBeBWkiHPXbfzGPFQTYUWZy9DxA+1d9GEqh+G9fc
         mvV9M/3Pin6LgnxgVcqaDxq3xIV2r8+V/8zbE4JiPX3lAK+xJ8x4td28X8qdRgQqFsWi
         udabka1zYqAkjTp1YM8CrKVnRvrTZdcczxYGC0QsZN6K1tc2CXDvRjClzraxuQ0YGB3q
         wYng==
X-Gm-Message-State: AJcUukeTP3JVBEcpgqTjur367dEKPX0YQLgGShUtbtwFuzdlFAfTfcuk
        VeYpvs43xjPVxql+P2097ejp1yYrjot6+AKwqr515w==
X-Google-Smtp-Source: ALg8bN64cB3kvCB8S+Cp+9GJNDaZCfvUpUQwH9UhW9GJXi9jgt2PqGhpBvV8tDVcnVcOvZPBv+oWsEiHfssDtilKBo8=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr30127850otc.229.1549070932011;
 Fri, 01 Feb 2019 17:28:52 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
 <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Feb 2019 17:28:39 -0800
Message-ID: <CAPcyv4iEcCG0h+HLPkfSC0aNDLq9hdoO00XErF93PHTmEgO-TQ@mail.gmail.com>
Subject: Re: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Josh Poulson <jopoulso@microsoft.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 5:06 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Linux-nvdimm <linux-nvdimm-bounces@lists.01.org> On Behalf Of
> > Dexuan Cui
> > Sent: Friday, February 1, 2019 4:34 PM
> > > > > ...
> > > > > Those reads find a namespace index block
> > > > > and a label. Unfortunately the label has the LOCAL flag set and Linux
> > > > > explicitly ignores pmem namespace labels with that bit set. The reason
> > > > > for that is due to the fact that the original definition of the LOCAL
> > > > > bit from v1.1 of the namespace label implementation [1] explicitly
> > > > > limited the LOCAL flag to "block aperture" regions. If you clear that
> > > > > LOCAL flag I expect it will work. To my knowledge Windows pretends
> > > > > that the v1.1 definition never existed.
>
> On the libnvdimm-pending branch, I get this:
>
> root@decui-gen2-u1904:~/nvdimm# ndctl list
> root@decui-gen2-u1904:~/nvdimm# ndctl list --idle
> [
>   {
>     "dev":"namespace1.0",
>     "mode":"raw",
>     "size":0,
>     "uuid":"00000000-0000-0000-0000-000000000000",
>     "state":"disabled"
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"raw",
>     "size":0,
>     "uuid":"00000000-0000-0000-0000-000000000000",
>     "state":"disabled"
>   }
> ]
>
> With the patch that clears the LOCAL label (BTW, the initial value of flags is 0x3,
> meaning a read-only local label) :
> @@ -2496,6 +2500,7 @@ static int init_active_labels(struct nd_region *nd_region)
>                         if (!label_ent)
>                                 break;
>                         label = nd_label_active(ndd, j);
> +                       label->flags &= ~NSLABEL_FLAG_LOCAL;
>                         label_ent->label = label;
>
> I get this:
>
> root@decui-gen2-u1904:~/nvdimm# ndctl list
> root@decui-gen2-u1904:~/nvdimm# ndctl list --idle
> [
>   {
>     "dev":"namespace1.0",
>     "mode":"raw",
>     "size":0,
>     "uuid":"c258aaab-f72b-e546-bfa5-be5e07761dbc",
>     "state":"disabled",
>     "name":"Microsoft Hyper-V NVDIMM 1 Label"
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"raw",
>     "size":0,
>     "uuid":"9f0497a7-4453-7c40-ad35-21a791e00345",
>     "state":"disabled",
>     "name":"Microsoft Hyper-V NVDIMM 0 Label"
>   }
> ]
>
> The "size" and "mode" still don't look right, but the improvement is that
> now I can see a good descriptive "name", which I suppose is retrieved
> from Hyper-V.

Mode is right, there is no way for Hyper-V to create Linux fsdax mode
namespaces it requires some setup using variables only Linux knows.
Can you send the output of:

ndctl read-labels -j all

>
> With Ubuntu 19.04 (4.18.0-11-generic), I get this:
> (Note: the "mode" and "size" are correct. The "uuid" is different from
> the above "9f0497a7-4453-7c40-ad35-21a791e00345" -- this is weird.)
>
> root@decui-gen2-u1904:~# ndctl list
> [
>   {
>     "dev":"namespace1.0",
>     "mode":"raw",
>     "size":137438953472,
>     "blockdev":"pmem1"
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",
>     "map":"dev",
>     "size":33820770304,
>     "uuid":"35018886-397e-4fe7-a348-0a4d16eec44d",
>     "blockdev":"pmem0"
>   }
> ]

This is because the Ubuntu kernel has the bug that causes _LSR to fail
so Linux falls back to a namespace defined by the region boundary. On
that namespace there is an "fsdax" info block located at the region
base +4K. That info block is tagged with the uuid of
"35018886-397e-4fe7-a348-0a4d16eec44d".

> I'm trying to find out the correct solution. I apprecite your insights!

It's a mess. First we need to figure out whether the label is actually
specifying a size of zero, or there is some other bug.

However, the next problem is going to be adding "fsdax" mode support
on top of the read-only defined namespaces. The ndctl reconfiguration
flow:

   ndctl create-namespace -e namespace0.0 -m fsdax -f

...will likely fail because deleting the previous namespace in the
labels is part of that flow. It's always that labels are writable.

Honestly, the quickest path to something functional for Linux is to
simply delete the _LSR support and use raw mode defined namespaces.
Why have labels if they are read-only and the region is sufficient for
defining boundaries?
