Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8ECC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2508221486
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="x+duXVvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2508221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJGAFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:05:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40172 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeJGAFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:05:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so12822738oib.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ngIs1RadAHa2B2Y7t8SJNs6/pvSDPRHSyYOW9Dnewk=;
        b=x+duXVvfD3d/oS09RB48NVUrDS/05GJSzYtELtSab+yt2C7hNmfWvm5dBjr2LKU+t2
         alqD0+fDwXoWjaubGQBsxGO3pxrUlUsuQ5+wgZ/Z8V2QkByjMo3ahMXUHk5taD+y9pMw
         hiazdIMqlO88dK1pYb12RCuZSP0QqS4gt6ufjj8NzCDLgGgr32mBt3u3bSJ59sYGRPX4
         8VmC5weyFRIOhI+ymSI8HlF2zVO8IX3J+sSQlzvGXZxsL9WMa9q8uybq3Lv+1aYF72uo
         EGRiAP4o+U0f3F2Fw7Hflm0MquCln+Hpfw9mBg8gHWCyiy+6qcuzwi9L/ZkODoNgjXLM
         1HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ngIs1RadAHa2B2Y7t8SJNs6/pvSDPRHSyYOW9Dnewk=;
        b=GzvC3yplXY5MgnbjTGJrUOTFA0PbIOIGdTMGEZPFOjnNK3zkRgFpUyGyAn0FLiH7Cw
         jMIs2JKfwBb/FZSOp/jWfy1od0/r1lWofJmCVAMfOMaluxqpny/9q+OXr4uh6QUIZTep
         EgEvmJBiWBzjyN4a2LCqTD33TZG33cGISbDGQvnG5qEyuaeVJxeHY+aNEC97/j++WhhV
         U4EWEdcoywYl0EGawSFjcrTzkEDylWYegd+dk3NGV/YtJxN4b8ZsBVWYnjJheUxjTjYb
         qyuNpkBkkm1yWtgKR5tnvVDpawkByqh/u5sKYeL7dqiG2I0mAHK2n5VF6sMf0W6ZJf9Y
         cBtg==
X-Gm-Message-State: ABuFfojencDHSaCtJA1cPKuN438/cl+FmXY6C0nP7etLbIqhhjDx9kEz
        AkA+0k5fVRObgbvrDiy7Dyn4KS5S/DhMyNn5SUUTFw==
X-Google-Smtp-Source: ACcGV61aMSQQZ3mDxrIoq413KR51Q+EZ8kNo3YvyhqXGdBt3jSG9OF8DVoMhDVAFsUHPlU8MKwmoiJP2RQnQZsSDmQY=
X-Received: by 2002:aca:1c19:: with SMTP id c25-v6mr1637560oic.246.1538845289992;
 Sat, 06 Oct 2018 10:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181004074457.GD22173@dhcp22.suse.cz> <CAPcyv4ht=ueiZwPTWuY5Y4y1BUOi_z+pHMjfoiXG+Bjd-h55jA@mail.gmail.com>
In-Reply-To: <CAPcyv4ht=ueiZwPTWuY5Y4y1BUOi_z+pHMjfoiXG+Bjd-h55jA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 6 Oct 2018 10:01:17 -0700
Message-ID: <CAPcyv4jKGJLGqTHbxPvSD0X=kNGce-iJCYvTHJA8x2JSST5ETQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Randomize free memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:44 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Hi Michal,
>
> On Thu, Oct 4, 2018 at 12:53 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 03-10-18 19:15:18, Dan Williams wrote:
> > > Changes since v1:
> > > * Add support for shuffling hot-added memory (Andrew)
> > > * Update cover letter and commit message to clarify the performance impact
> > >   and relevance to future platforms
> >
> > I believe this hasn't addressed my questions in
> > http://lkml.kernel.org/r/20181002143015.GX18290@dhcp22.suse.cz. Namely
> > "
> > It is the more general idea that I am not really sure about. First of
> > all. Does it make _any_ sense to randomize 4MB blocks by default? Why
> > cannot we simply have it disabled?
>
> I'm not aware of any CVE that this would directly preclude, but that
> said the entropy injected at 4MB boundaries raises the bar on heap
> attacks. Environments that want more can adjust that with the boot
> parameter. Given the potential benefits I think it would only make
> sense to default disable it if there was a significant runtime impact,
> from what I have seen there isn't.
>
> > Then and more concerning question is,
> > does it even make sense to have this randomization applied to higher
> > orders than 0? Attacker might fragment the memory and keep recycling the
> > lowest order and get the predictable behavior that we have right now.
>
> Certainly I expect there are attacks that can operate within a 4MB
> window, as I expect there are attacks that could operate within a 4K
> window that would need sub-page randomization to deter. In fact I
> believe that is the motivation for CONFIG_SLAB_FREELIST_RANDOM.
> Combining that with page allocator randomization makes the kernel less
> predictable.
>
> Is that enough justification for this patch on its own? It's
> debatable. Combine that though with the wider availability of
> platforms with memory-side-cache and I think it's a reasonable default
> behavior for the kernel to deploy.

Hi Michal,

Does the above address your concerns? v4.20 is perhaps the last
upstream kernel release in advance of wider hardware availability.
