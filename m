Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E6C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEF32075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="w4Je8Wyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEF32075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeJXDW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:22:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36106 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeJXDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:22:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so2034284oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1SBoNgBzY4auKZHsX217UML/qh3ROWdL83mSub6KBs=;
        b=w4Je8WywGMloSfxug1LunK79CUiSStlnUcyg10ShXQcF+qxCMXp+gXA/H3KvXf+JPx
         XzkXIOWjFN0c+WfEvEaDHpEjPChdGSlU5hUilQtk9lXNMN+WGA9KQVXnCPRNgH0rELxJ
         gnARnrfanRS0KXks9xtkdZfk291zgXh+QbICGYWZRCrldymJ1XD9IP5tRiWAN5JAc4A6
         rVkQGd15AIHp9JRm1t84uXOvb95e2eLawHxQaM0H8gDlzb+amVUYJMVshkOkcY4TQZyO
         6eYculjNp8fkn0yvvFjdbtBAZxi7bxr1vg0U1AkVtajcy8ZgEaSTB7timRrqhilLxOrF
         W5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1SBoNgBzY4auKZHsX217UML/qh3ROWdL83mSub6KBs=;
        b=hNJElYM93T+pYR2zHIfXg3FUC+ReqAu2cgSiN5BbjewqomOnilbCougQXjuRBGa0xk
         R1NlQVtIZqer48Xu9oWlP9e0YFSuGtwujKRIPYG1dY8M3t81qBBX1vU9aNyu2n0SJl3n
         XqaS5tq+vYRNOqRbezFGYPFoP3NEhYYLXNB91+nWWMB1/8wB3HEm+RoMBpGBsLLKc48b
         Bxhnet/UGN9sNnJ3JyOrSEqdZcFIbBseMgA8UqVP5cd75D8u5GsN0icq0GhkEKZ/0P3I
         N0zMz4JoiqSLaCtN49PPrQ+0tiu9qleQcaxlSBz8aAL32EmybEn0TnXF4A/8Bohotk6K
         zK6g==
X-Gm-Message-State: ABuFfogtTaLwIU2qRGb1z0Dv/CDdIBtaBF36B+ixh/201J4W1EDOmUFy
        qJojYIwkZGHIFlaTAUiIuZxoJGYDR4kaibNJwQh5MA==
X-Google-Smtp-Source: ACcGV62GoqiM6Rf0TgfB0/Mpg5vs3FDP6lt4YouPzayd7+QQuqa0hae3DZeDV/vsZ+CBSYQULbvQ5wykUcWweciK8Pc=
X-Received: by 2002:aca:44d7:: with SMTP id r206-v6mr25971312oia.280.1540321097521;
 Tue, 23 Oct 2018 11:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181022201317.8558C1D8@viggo.jf.intel.com> <CAPcyv4hxs-GnmwQU1wPZyg5aydCY5K09-YpSrrLpvU1v_8dbBw@mail.gmail.com>
 <AT5PR8401MB11694012893ED2121D7A345EABF50@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <2677a7f9-5dc8-7590-2b8b-a67da1cb6b92@intel.com>
In-Reply-To: <2677a7f9-5dc8-7590-2b8b-a67da1cb6b92@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Oct 2018 11:58:06 -0700
Message-ID: <CAPcyv4jcgRTR-NnHPpsLm=z8uSLJZYN530nGm5f9k6Q3WGHr0g@mail.gmail.com>
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michal Hocko <MHocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, zwisler@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:17 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> >> This series adds a new "driver" to which pmem devices can be
> >> attached.  Once attached, the memory "owned" by the device is
> >> hot-added to the kernel and managed like any other memory.  On
> >
> > Would this memory be considered volatile (with the driver initializing
> > it to zeros), or persistent (contents are presented unchanged,
> > applications may guarantee persistence by using cache flush
> > instructions, fence instructions, and writing to flush hint addresses
> > per the persistent memory programming model)?
>
> Volatile.
>
> >> I expect udev can automate this by setting up a rule to watch for
> >> device-dax instances by UUID and call a script to do the detach /
> >> reattach dance.
> >
> > Where would that rule be stored? Storing it on another device
> > is problematic. If that rule is lost, it could confuse other
> > drivers trying to grab device DAX devices for use as persistent
> > memory.
>
> Well, we do lots of things like stable device naming from udev scripts.
>  We depend on them not being lost.  At least this "fails safe" so we'll
> default to persistence instead of defaulting to "eat your data".
>

Right, and at least for the persistent memory to volatile conversion
case we will have the UUID to positively identify the DAX device. So
it will indeed "fail safe" and just become a dax_pmem device again if
the configuration is lost. We'll likely need to create/use a "by-path"
scheme for non-pmem use cases.
