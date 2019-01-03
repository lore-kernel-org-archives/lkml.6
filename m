Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFD8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10A92184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546541233;
	bh=g2HH9JarLGmtyTiZKCPjZu7qVyP+a9isFYubhO4rW0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0uZOlCFzfjK0O4ROVUw9zXQIL0xq3GUJ4Eaf/HRhxAVvx9vRQGUq0o+/wiE6HoQvY
	 ULBGwjdcW9dukQhtCNwUeTf2tWf1i2gqSnXLE0L9AGGc7ecAE+mzb5QNsFaH6RBfIx
	 /rEwPMKBEPjzuNh171dQuOmF//jzc2ep0NYP0eRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfACSrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:47:12 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38462 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfACSrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:47:12 -0500
Received: by mail-yw1-f68.google.com with SMTP id d190so12467258ywb.5;
        Thu, 03 Jan 2019 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4bOgmdZh/nJPyrF+8x/aLXpuypken7zoGySe9tnJ9I=;
        b=BbF+StVcAsbKYa+YESUcgLIXbzs+ceCqm+J3Pyi9Rw9nhq40x+scqvRmm5u4ZFP1A2
         iCXCQZ2qkpz9BVM/5DXLS08lhGlVMnOpJHl/YxDE8aR9IAh4qxsoaGVeWbS3SDI0Yygg
         GQtrMYby6BZlCM0Ql7Lf/uwr2vaIDXerVzTjJsOagXsqCMnqGqL1pE6z6WHMAq+69Ueh
         GONVQ5bPh3+F5eWCyaX/P+sEA2wb29Abvid0MvhmWMKzjFs1I4ySQVSbheZ0KpJ31qVU
         tPEWIWypQ+ZjGi62cFprpsww5zBVZGCwsBENlgMubuNWYph/x1DDwaGq0P13ZCd6fGib
         dzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4bOgmdZh/nJPyrF+8x/aLXpuypken7zoGySe9tnJ9I=;
        b=hSUuTM7GvCJWAihPuZpRO79Z3oITKEDMg8Sn1aclvg9ReYre46K8K1IJ+fHz6UpSvf
         2WY0IEyRv/eRNMZSKNny08AR2XR2p5FhyT/ViDrQo5t3d9bew+Va/zGsKiOSC7my9XXc
         /Mm/xMBkdWElNTfMfHsoZBUqU9PjeQAJDaPACRW1ySg/u3r06jCCOtTwsVp0vBINMRrf
         kVM8BNw2IW1RXnr1BN2HmNNClrfEycqTQczgAnnP+3NoesKORYkcJTsFKJ2qG0scKCGf
         NHo2cD+3P/d8HIh7xNtRBABNY/e4NHjwzmZi0KFronB+x1YpVYktLDx6+TETHM3u/yVG
         8Wyw==
X-Gm-Message-State: AA+aEWZe1Cw41JI6hA/VnQMTENmNuWXJsTxIm/I9nH7juTrDFQvQNerS
        j/U7p9rx01lLk6Lo9DzCjtw=
X-Google-Smtp-Source: AFSGD/XhmAMrMT2qThEcz39tCOTv4k+G229egTs4UbvqWK5EfmjvUHIfyley5dtHnW7qT3bNMGE8Xg==
X-Received: by 2002:a81:ad49:: with SMTP id l9mr48990106ywk.260.1546541229988;
        Thu, 03 Jan 2019 10:47:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:f935])
        by smtp.gmail.com with ESMTPSA id o124sm15374839ywe.75.2019.01.03.10.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 10:47:08 -0800 (PST)
Date:   Thu, 3 Jan 2019 10:47:06 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Pingfan Liu <kernelfans@gmail.com>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of
 bottom-up after parsing hotplug attr
Message-ID: <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-2-git-send-email-kernelfans@gmail.com>
 <20181231084018.GA28478@rapoport-lnx>
 <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
 <20190102092749.GA22664@rapoport-lnx>
 <20190102101804.GD1990@MiWiFi-R3L-srv>
 <20190102170537.GA3591@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102170537.GA3591@rapoport-lnx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 02, 2019 at 07:05:38PM +0200, Mike Rapoport wrote:
> I agree that currently the bottom-up allocation after the kernel text has
> issues with KASLR. But this issues are not necessarily related to the
> memory hotplug. Even with a single memory node, a bottom-up allocation will
> fail if KASLR would put the kernel near the end of node0.
> 
> What I am trying to understand is whether there is a fundamental reason to
> prevent allocations from [0, kernel_start)?
> 
> Maybe Tejun can recall why he suggested to start bottom-up allocations from
> kernel_end.

That's from 79442ed189ac ("mm/memblock.c: introduce bottom-up
allocation mode").  I wasn't involved in that patch, so no idea why
the restrictions were added, but FWIW it doesn't seem necessary to me.

Thanks.

-- 
tejun
