Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE4AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq5EQZkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF3E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJIAxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:53:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35951 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeJIAxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:53:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id l81-v6so3625419pfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4VIthG9cHI8IjPuoXKhdAk7R6N64M4/LVaRd0Akg81o=;
        b=oq5EQZkZ5ErT+hoSAK1D/kkVOgrM/D0LDg/0v33sOH4mBEnNQ47I3sQiqFRyWWKzIF
         nfR5c+3eaZUWa956caYVzdztoTl/5dVt8C3/Gu+3fiZql+H6vqtDonTXcqvPk+hBTMNC
         KkXa+Yo8F1HEU1n62YrPT0ODBsqTfd/0TPvyx1H1fqxMfkm6rsEuhNSvKokbaIgv+Nh1
         j5vtHYNi14JSKqVcukMmDORRKg7fkEdYz6d1UwO+tCjBOocS64PSPbWZzaa1GH2H3YbX
         6I+PD8cbCGcAC/Jhq9C0PFdL/aTrLcKOhezYNZo/NIy8hK8oxaAN/QNLwlZFNTNZhYes
         vOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4VIthG9cHI8IjPuoXKhdAk7R6N64M4/LVaRd0Akg81o=;
        b=EbncV+uDNuLtQTzU88ODL4gd0WV1QvdeEMldkt0jwYXXkd2zBexOdyyGjg4fnHiaon
         2qI10C69xoy4SL0jwt43HULU6LOesoSHT8E8vls4YCs+hKEbdEXoDHhyTzUUDFQeaTK3
         TE5ocsftuNuEoor+4mjSkSnKBV0izQfVxjuplV53ETupBTo6CDyJSMpx+mLAWQ9O3uUj
         xzAokO0+cYu67v/2WJfG/jdkybbGUO3DNtdgb8lrw2QLejh0HngBWbyed56C3VVu3sDV
         Opqfiad6I7KuyKUOJMPyPYe2bnPp+H/hZ0qxSSMifAS/8Dlsoz20uutWymBVHrh0hgYq
         RfvQ==
X-Gm-Message-State: ABuFfojjcr9Ok/kweysI54++EcIAY9idzYw4wLFD6gCAEg5CCFohU3XP
        F6i47ISekekJDxhsjcxWelI=
X-Google-Smtp-Source: ACcGV60xJsvwIvrxMvlYT3IFHb1kX+73qIIgTAlJYfhpXejGtdQEU9DMoXFB4yOMCSMxSpv5F8qhQA==
X-Received: by 2002:a62:56c1:: with SMTP id h62-v6mr26270394pfj.107.1539020464874;
        Mon, 08 Oct 2018 10:41:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l2-v6sm16941538pgp.20.2018.10.08.10.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 10:41:03 -0700 (PDT)
Date:   Mon, 8 Oct 2018 10:41:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Message-ID: <20181008174102.GA11442@roeck-us.net>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:57:07PM +0000, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Monday, October 8, 2018 10:11 AM
> > To: Koenig, Christian <Christian.Koenig@amd.com>; Peng Hao
> > <peng.hao2@zte.com.cn>
> > Cc: airlied@linux.ie; linux-kernel@vger.kernel.org; dri-
> > devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; Deucher,
> > Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
> > 
> > On 10/08/2018 06:47 AM, Koenig, Christian wrote:
> > > Am 08.10.2018 um 15:33 schrieb Guenter Roeck:
> > >> On 10/08/2018 01:00 AM, Christian König wrote:
> > >>> Am 05.10.2018 um 10:38 schrieb Guenter Roeck:
> > >>>> On 10/05/2018 01:14 AM, Koenig, Christian wrote:
> > >>>>> Am 04.10.2018 um 20:52 schrieb Guenter Roeck:
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
> > >>>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
> > >>>>>>>        In function ‘gmc_v8_0_process_interrupt’:
> > >>>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
> > >>>>>>>        warning: missing braces around initializer
> > >>>>>>> [-Wmissing-braces]
> > >>>>>>>
> > >>>>>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > >>>>>> Was there any feedback on this patch ? The problem does affect
> > >>>>>> us, and we'll need a fix.
> > >>>>>
> > >>>>> Well as discussed using "{ { 0 } }" is as wrong as using "{ 0 }".
> > >>>>>
> > >>>>
> > >>>> Ah, sorry, I must have missed the discussion.
> > >>>>
> > >>>> It is for sure not the best solution, but at least it compiles, and
> > >>>> it seems to be proliferating.
> > >>>
> > >>> Yeah, and exactly that's the problem. As the discussion showed "{ {
> > >>> 0 } }" is buggy because it tells the compiler to only initialize the
> > >>> first member of the structure, but not all of it.
> > >>>
> > >>> That is incorrect and rather dangerous cause it can lead to
> > >>> unforeseen results and should probably trigger a warning.
> > >>>
> > >>>>
> > >>>> $ git grep "{ *{ *0 *} *}" | wc
> > >>>>      144    1180   11802
> > >>>> $ git grep "{ *{ *0 *} *}" drivers/gpu/drm/amd/ | wc
> > >>>>       50     459    5239
> > >>>>
> > >>>>> We should either use only "{ }" or even better make nails with
> > >>>>> heads and use memset().
> > >>>>
> > >>>> I'd rather leave it up to the compiler to decide what is most
> > >>>> efficient.
> > >>>
> > >>> And I would rather prefer to have a working driver :)
> > >>>
> > >>
> > >> So { } isn't correct either ?
> > >
> > > Yes, initializing structures with { } is known to be problematic as well.
> > >
> > > It doesn't necessary initialize all bytes when you have padding
> > > causing random failures when structures are memcmp().
> > >
> > >>
> > >> One thing I found missing in the discussion was the reference to the
> > >> C standard.
> > >> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> > >> "... all
> > >> subobjects that are not initialized explicitly shall be initialized
> > >> implicitly the same as objects that have static storage duration".
> > >> Clause 21 makes further reference to partial initialization,
> > >> suggesting the same. Various online resources, including the gcc
> > >> documentation, all state the same. I don't find any reference to a
> > >> partial initialization which would leave members of a structure
> > >> undefined. It would be interesting for me to understand how and why
> > >> this does not apply here.
> > >>
> > >> In this context, it is interesting that the other 48 instances of the
> > >> { { 0 } } initialization in the same driver don't raise similar
> > >> concerns, nor seemed to have caused any operational problems.
> > >
> > > Feel free to provide patches to replace those with memset().
> > >
> > 
> > Not me. As I see it, the problem, if it exists, would be a violation of the C
> > standard. I don't believe hacking around bad C compilers. I would rather
> > blacklist such compilers.
> > 
> > >>
> > >> Anyway, I fixed up the code in our tree (with { }), so I'll leave it
> > >> up to you folks to decide what if anything to do about it.
> > >
> > > Well considering the known problems with {} initialization I'm
> > > certainly rejecting all patches which turns memset() into {}.
> > >
> > 
> > Please point me to specific instances of this problem.
> 
> I think there are a number of places in DC (drivers/gpu/drm/amd/display) where we applied the original proposed solution before realizing that it would only initialize the first element.  It would be nice to get them fixed up.
> 

I think this is factually incorrect. What you might want to try to say
is that padding may not be initialized when using anything but memset().
But that is a different problem.

Guenter
