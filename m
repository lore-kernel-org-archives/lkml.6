Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A56C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D5021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EfSLbIJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D5021547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbeIUUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:45:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32889 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUUpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:45:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so11663895oip.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVfjyqOJ0d+twOaPAVBfnS76qDdlaAnz37+1o5vyifM=;
        b=EfSLbIJz8TfdiPRIUHj5HghqftRXU23MDYF0q3ebyXVJKxyGuNX3O+UlQ2+KyFX0Pm
         DUEHSlZYlfHVOqpZ02FScOeU31dj6W6wh00Oa6BW6RpyHGInbsTY12uSpuo3XDtXxlGF
         w7+TpXU95GUFnlDdHEw4GeG8cSezcW41HLHp92VUo7n/9FkvQwZyaXczKCSjdSMVlgaH
         1ZgwNlSmSYk0Url9TipJb2LQLqnZqu0qrSLNuOuybhl+K900EOODMuvDXYTAn/ukFfZG
         XMWzM/SUnJEwa/cOdFzH6ZV74Ng+J/xJ7Lfo4pQDIIUoPk2NUosJuMNCxwuZe7lbt19z
         MUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVfjyqOJ0d+twOaPAVBfnS76qDdlaAnz37+1o5vyifM=;
        b=gB2v3jSxV4PTQeIa0wXLizfbmIOUiHlpEs8PlxvHPDlAbgmJfYaNrvBOLCR8IG4SBa
         HlRtfyGR4gmU8e7sMpE1DSrbhnebohoebcxXa8Qh7DbeEO9uUOf4w1gaUBxPm3j/XY8H
         H5WNhtzWUG4FIuvtKoBUsRt71NzbFl8ZBV0HYgUPKgBT9I/Ra0DBMi3oQIAEC+jd84C+
         C5j9G33wLrpQUWxs1j4yrgANjXLB06AzGXC69cTOLYXvrpAOllg5GLnQZlCUPA/Q0+oD
         pwgV9OVavIsj0LMekihT4+LIh5vtH1z0EMiSU3GTe9IRA8PUJN8mO4NjKfVJnWSThRgy
         TBoQ==
X-Gm-Message-State: APzg51CHqwODQEqTvfsceMWRH9H7/5stzac7frce5GHzZO61JDIAsWTy
        cCFih5aXU09aG8AVHYdy/UkZsnt6SpeTDmX1oD9hbQ==
X-Google-Smtp-Source: ANB0VdbxRoTE2oj+UftUpZH3ZhFAGKNWp81l10oYI/Qi2EfEsxTEIl6TO7qfHQH3WR6v1DCil82jrCH1SGmIriNvxNE=
X-Received: by 2002:aca:b355:: with SMTP id c82-v6mr1940983oif.9.1537541792186;
 Fri, 21 Sep 2018 07:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222951.19464.39241.stgit@localhost.localdomain> <CAPcyv4hAEOUOBU4GENaFOb-xXi33g_ugCexfmY3DrLH27Z6MKg@mail.gmail.com>
 <b7e87e64-95d7-5118-6c7d-ad78d68dc92e@linux.intel.com> <CAPcyv4iE=mrvdfXQ94O1r_u1geLbxpF0so3_3z4JLky4SuUNdw@mail.gmail.com>
 <0d6525c1-2e8b-0e5d-7dae-193bf697a4ec@linux.intel.com> <CAPcyv4hqERm3YbgsE19M=8SRfrhyEo__LrLdcEj_YsLr2bLviA@mail.gmail.com>
 <6e17294f-4847-9e7a-2396-6fffaf8a8f4a@linux.intel.com>
In-Reply-To: <6e17294f-4847-9e7a-2396-6fffaf8a8f4a@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 07:56:20 -0700
Message-ID: <CAPcyv4jP_fx4Y3tmxqXC67nf9NFOEAU9cnesrydu8p3aC3R3=Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] nvdimm: Schedule device registration on node local
 to the device
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
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

On Fri, Sep 21, 2018 at 7:48 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
[..]
> > I was thinking everywhere we set dev->parent before registering, also
> > set the node...
>
> That will not work unless we move the call to device_initialize to
> somewhere before you are setting the node. That is why I was thinking it
> might work to put the node assignment in nd_device_register itself since
> it looks like the regions don't call __nd_device_register directly.
>
> I guess we could get rid of nd_device_register if we wanted to go that
> route.
>
> >> If you wanted what I could do is pull the set_dev_node call from
> >> nvdimm_bus_uevent and place it in nd_device_register. That should stick
> >> as the node doesn't get overwritten by the parent if it is set after
> >> device_initialize. If I did that along with the parent bit I was already
> >> doing then all that would be left to do in is just use the dev_to_node
> >> call on the device itself.
> >
> > ...but this is even better.
> >
>
> I'm not sure it adds that much. Basically My thought was we just need to
> make sure to set the device node after the call to device_initialize but
> before the call to device_add. This just seems like a bunch more work
> spread the device_initialize calls all over and introduce possible
> regressions.

Yeah, device_initialize() clobbering the numa_node makes it awkward.
Lets go with what you have presently and fix up the comment to say why
region devices are special.
