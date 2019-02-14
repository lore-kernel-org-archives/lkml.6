Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31053C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F348C222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbguojB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437588AbfBNRj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:39:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42348 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437540AbfBNRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:39:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so7761224qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ANs0KXyVl1itNeqe46nRlAralSJekcIJY9UIIgxw9oQ=;
        b=rbguojB5aTsDrlXZcUbRrsjwObxyS5Iz6JOvp6dXq3lmeKjgB0bilmvGMMSKW3osgv
         +ex059Ss749IyBSgFkYyAVRO4AatmXwB6d4BhhlRZ/2rXuyaqDi15BpKRp5XCKJjhjqH
         9Ew3KetirOR2RDRYmUB7bB/cyOK8aWGNAnoqnj5hyryLskF7uagL1C7gfkinH/K1JucZ
         3SuF6QDpqGHvIE1meKS61z7448WJD2TzGX6XsHicGif1DGqYg9wm/Ptjtc5ep6wqSPVr
         uUO/LZvaMmDO5CuDawuEy0WR0oP5GXFA5OOyufOGFjLDLuMvY8436GNOApUgf/67m990
         xwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANs0KXyVl1itNeqe46nRlAralSJekcIJY9UIIgxw9oQ=;
        b=a5w+ChE1TbSlCcPApOhlnfykQz/Sx4jv/w7L+uQ4OLr0TTrkDyK2cpNFelQH5o35r/
         HMyeo/nPNQRSJRVIKmtheKr1HIfzgwXrEK7v3vt+elFswGHs82c2Lg5zNRYX+uhb3fOe
         bwHy5+ShkFONiwtVfFZbNsz/C/GxnK1xV6QxSE5mKf0vUxB7BQG4xwdHwlpjes0EgkhN
         FjVo4POEHlA1YmW+cin0gpDqTHaWQFeLJ80afkKMzCZbFKU+6ftpaWTKvEcgUVM82GO7
         9lBVFC4lA/6PjBU3/th/kdUONBK0DD/UR0tx6Rr8d6c7NV31OiiM5ARwXr8l4Q+USgLD
         tmdA==
X-Gm-Message-State: AHQUAubCDuX8NzI9mNUqSHEoR6Sby1FyTJfb2HiihhVdqz5hVWW+8LmI
        ZqP5fwX3+uCJliP38P4bTw==
X-Google-Smtp-Source: AHgI3IbVouU/x7JjlXXaM16Alkr33sfzl40j5htGSYte3VtVqNEy60aK0YZBAY1mpR/n9FPpOo0E8Q==
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr4004554qvd.161.1550165993403;
        Thu, 14 Feb 2019 09:39:53 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o4sm1639140qke.30.2019.02.14.09.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 09:39:52 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:39:46 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kirill@shutemov.name Thomas Gleixner" <tglx@linutronix.de>,
        x86@kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/mm: Adjust the padding size for KASLR
Message-ID: <20190214173945.utbawbfbdjkw7dif@gabell>
References: <20190212013118.28203-1-msys.mizuma@gmail.com>
 <20190214101236.GE14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214101236.GE14858@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

Thank you for your review.

On Thu, Feb 14, 2019 at 06:12:36PM +0800, Baoquan He wrote:
> Hi Masa,
> 
> On 02/11/19 at 08:31pm, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > The system sometimes crashes while memory hot-adding on KASLR
> > enabled system. The crash happens because the regions pointed by
> > kaslr_regions[].base are overwritten by the hot-added memory.
> > 
> > It happens because of the padding size for kaslr_regions[].base isn't
> > enough for the system whose physical memory layout has huge space for
> > memory hotplug. kaslr_regions[].base points "actual installed
> > memory size + padding" or higher address. So, if the "actual + padding"
> > is lower address than the maximum memory address, which means the memory
> > address reachable by memory hot-add, kaslr_regions[].base is destroyed by
> > the overwritten.
> > 
> >   address
> >     ^
> >     |------- maximum memory address (Hotplug)
> >     |                                    ^
> >     |------- kaslr_regions[0].base       | Hotadd-able region
> >     |     ^                              |
> >     |     | padding                      |
> >     |     V                              V
> >     |------- actual memory address (Installed on boot)
> >     |
> > 
> > Fix it by getting the maximum memory address from SRAT and store
> > the value in boot_param, then set the padding size while kaslr
> > initializing if the default padding size isn't enough.
> 
> Thanks for the effort on fixing this KASLR&hotplug conflict issue.
> I roughly go through this patch, seems three parts are contained:
>  
> 1) Wrap up the SRAT travesing code into subtable_parse();
> 2) Add a field max_addr in struct boot_params, and get the max address
>    from SRAT and write it into boot_params->max_addr;
> 3) Add kaslr_padding() to adjust the padding size for the direct
> mapping. 
> 
> So could you split them into three patches for better reviewing?

Yes, I will split into the three.

> 
> Another thing is for the 3rd part, I also queued several patches in my
> local branch, they are code bug fix patches, and several clean up
> patches suggested by Ingo and Kirill. They can be found here:
> 
> https://github.com/baoquan-he/linux/commits/kaslar-mm-bug-fix
> 
> In my local patches, Ingo suggested opening code get_padding(), and
> about the SGI UV bug, he suggested adding another function to calculate
> the needed size for the direct mapping region. So I am wondering if you
> can rebase the part 3 on top of it, or you add a new function to
> calculate the size for the direct mapping region so that I can rebase on
> top of your patch and reuse it.
> 
> What do you think about it?

OK, I will rebase my patches on top of your patch.
Could you add CCing me when you post your patches?

Thanks!
Masa
