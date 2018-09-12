Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2199F20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XfyJQlTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2199F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeILKve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:51:34 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37187 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeILKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:51:34 -0400
Received: by mail-oi0-f68.google.com with SMTP id p84-v6so1382112oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DUC52jmXOo/la54B8L8KiWDI6l30RSSu4mpnLr5NLwo=;
        b=XfyJQlTGdmzreNTMQ590wRDVzKXJxMiOQXHIScdJB9tcaPJqWA+XhcMgWkhX7NQz6D
         LIuOm0BcFRlK1gH3bcX3J/c35dxA55XVjU8FaPyW5Zt21ijjQhiJrgXae3f+YMw3ysPw
         gyjTpz2q6TY2DkrhzO+Tt+xJFvw31rOJr76Kg44CYyLZ39x6rKomghlg2Gm6oi0D5OuY
         ZffNEwIpIxDBgraxJW/YPyNZADSCACtAB9VihWNvDnj0rQiEAj0ymbvQBFMNyCnY/avR
         /4giw8aB4SFBzeWMP4vbhlVaUwMCYbRKw9gFYzE73+DZJhFLjBpHcWO9jhlez3wXid+T
         HYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DUC52jmXOo/la54B8L8KiWDI6l30RSSu4mpnLr5NLwo=;
        b=t2QW6R37eTU33YD3YnNPEYrK82L6SazhsZfZKVMb51Jx7TRJ5qFmiZvdXqV2LXs3fy
         rdJd99/g48vb9jWyifX4YyofPSfKZYH3Bt9U4Myy2FNewi370JCba2ZGTVaxqjaFwH67
         9njdh9J+5Kk0DDErlWTJc5ho7PwytlDfp83S39thsXYJbmMc6iaqeBD7kmzaDEtfG9iq
         FzDYclV0iwxHh+srZJLFfZdc6KJFWaHvmtHyyXpEo4rMm0ckhRZvx/NGUj3zuPOgmkj1
         9QxFJnW4galBmRsuTedv3tq5nnOTpOeeYlw/KimrdaQfPAu00ydc95EC1d+wfAwk1IlG
         F2og==
X-Gm-Message-State: APzg51CPgg315ycI1vBn/FCrfKk5+CYWhpXJYDcM2yzsnA8oIczUejPB
        RMvd7csDqmIaZbzIQUyM6r3upUsg0GbDuH/jeE62Hg==
X-Google-Smtp-Source: ANB0VdblHVSBd1RdfVWTbqWP6naVkEIpNpncCf340yUtkNk565KsBZ/Hl88FOQBnxVT6UjkVTw5V4Pta1Pl39SDtwXU=
X-Received: by 2002:aca:ed57:: with SMTP id l84-v6mr295506oih.62.1536731321366;
 Tue, 11 Sep 2018 22:48:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 22:48:40
 -0700 (PDT)
In-Reply-To: <20180910234400.4068.15541.stgit@localhost.localdomain>
References: <20180910232615.4068.29155.stgit@localhost.localdomain> <20180910234400.4068.15541.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Sep 2018 22:48:40 -0700
Message-ID: <CAPcyv4gm30sT_us0j27jLmNTV_Fug4d8EW4xTmiTMFdwGSjN-A@mail.gmail.com>
Subject: Re: [PATCH 4/4] nvdimm: Trigger the device probe on a cpu local to
 the device
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 4:44 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> This patch is based off of the pci_call_probe function used to initialize
> PCI devices. The general idea here is to move the probe call to a location
> that is local to the memory being initialized. By doing this we can shave
> significant time off of the total time needed for initialization.
>
> With this patch applied I see a significant reduction in overall init time
> as without it the init varied between 23 and 37 seconds to initialize a 3GB
> node. With this patch applied the variance is only between 23 and 26
> seconds to initialize each node.
>
> I hope to refine this further in the future by combining this logic into
> the async_schedule_domain code that is already in use. By doing that it
> would likely make this functionality redundant.

Yeah, it is a bit sad that we schedule an async thread only to move it
back somewhere else.

Could we trivially achieve the same with an
async_schedule_domain_on_cpu() variant? It seems we can and the
workqueue core will "Do the right thing".

I now notice that async uses the system_unbound_wq and work_on_cpu()
uses the system_wq.  I don't think we want long running nvdimm work on
system_wq.
