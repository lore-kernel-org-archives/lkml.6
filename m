Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E85C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1ED216FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ir06/Lkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1ED216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeHOFvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 01:51:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33352 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbeHOFvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 01:51:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so10147602pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NC5t8huGFTHb/EokVDrdq/8OfB2XJ62ZP38O80MZNz0=;
        b=Ir06/LkncUF7/UhHuJYI8QMoYIDyiTf7YgfOU2rk+yiJjUlJTKFpto8uLi57PE3f5M
         Wy1CXGbA73O+E5kYrQZfE1+rP/wkhX+FCbsCxZ+W3pHmflp0Ck23mI156KK31nNb1WQb
         JzcpQCkOI3BSkwTBSD9yIpUZKjpzRZWufGY56zAnkEbKR/3HQM7XlmyjAXXgAz+F6y2m
         dnOCeUtVLnH1WlX1W+H7LaUX8BzIJTwsLHdnDTGY2dZn6StmTaBwfOZZ/NI41Dzwx4n5
         lXX44Jz+ImDP31UH+/wRPlHdC9I6l1n1Oy+NLyT8bQq9d63ieI+jhv7EnnRfzQuGQjwN
         2Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NC5t8huGFTHb/EokVDrdq/8OfB2XJ62ZP38O80MZNz0=;
        b=a2ZBaogMPIcW/kHy001vzLNxJQ1p7YUD+7GzRTkDB31lzkklomNnquEU/txeDAXaD6
         zr/w1d+foRSZ4v0tOa/cwjW6C33oLvA6IGG+EEIdARBZoewYR2xWN2UdN/wcPcDZrUpl
         sPCHeUbfa/focG/fDN/FLK8XoPyPDRet3ZGTY51vrwv0WmCid7StfAsZIEV2ztPDhscJ
         pQTTMeXGxXmrE/KT2UOTO1zSfvtVYIjzaTo3fWa0qrIIdxmFhQn50dfJCA1HCLx9kauW
         vNOum/jnsEqHanmkGxVm9KAiw7FiWbanhRLpq5xf3/P9/VBcfN4IjxzVy5RsRkOtLB6j
         aukA==
X-Gm-Message-State: AOUpUlFdIX3mhtnZvnCaUkgzhUDrA86fcn3eFMSSM08tmGEiSFY0R2wD
        ikTZsuJ0rmsSYWfISE5Q10QQAmqMpZ8=
X-Google-Smtp-Source: AA+uWPy17MMX6iYZYolscloYln+tTPdcqO16gGeD3youe3vbnTtlrnpmF/iNiJk70ucM9mpw6FrcWw==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr23506893pgd.372.1534302094330;
        Tue, 14 Aug 2018 20:01:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id c85-v6sm43656061pfd.110.2018.08.14.20.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 20:01:33 -0700 (PDT)
Date:   Tue, 14 Aug 2018 20:01:32 -0700
From:   Joel Fernandes <joelaf@google.com>
To:     LKML <linux-kernel@vger.kernel.org>, wangnan0@huawei.com,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        acme@kernel.org, Chenbo Feng <fengc@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: samples don't build on v4.18
Message-ID: <20180815030132.GA204101@joelaf.mtv.corp.google.com>
References: <20180815012054.GA70201@joelaf.mtv.corp.google.com>
 <CAJWu+orb35w6O5B9KyHdYtwc2RbaR9d72HW-i5Bsup72QP8Oag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+orb35w6O5B9KyHdYtwc2RbaR9d72HW-i5Bsup72QP8Oag@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 06:22:21PM -0700, Joel Fernandes wrote:
> Forgot to add the patch author, doing so now. thanks
> 
> On Tue, Aug 14, 2018 at 6:20 PM, Joel Fernandes <joelaf@google.com> wrote:
> >
> > Hi,
> > When building BPF samples on v4.18, I get the following errors:
> >
> > $ cd samples/bpf/
> > $ make
> >
> > Auto-detecting system features:
> > ...                        libelf: [ OFF ]
> > ...                           bpf: [ OFF ]
> >
> > No libelf found
> > Makefile:213: recipe for target 'elfdep' failed
> > -----------
> >
> > I bissected it down to commit 5f9380572b4bb24f60cd492b1
> >
> > Author: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Date:   Thu May 10 10:24:39 2018 -0700
> >
> >     samples: bpf: compile and link against full libbpf
> > ---------
> >
> > Checking out a kernel before this commit makes the samples build. Also I do
> > have libelf on my system.
> >
> > Any thoughts on this issue?

There is some weirdness going on with my kernel tree. If I do a fresh clone
of v4.18 and build samples, everything works.

However if I take my existing checkout, do a:
git clean -f -d
make mrproper

Then I try to build the samples, I get the "No libelf found".

Obviously the existing checked out kernel tree is in some weird state that I
am not yet able to fix. But atleast if I blow the whole tree and clone again,
I'm able to build...

Is this related to the intermittent "No libelf found" issues that were
recently discussed?

- Joel

