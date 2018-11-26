Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1871C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6052D20856
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="CCyTpzIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6052D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeK0KzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:55:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41704 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0KzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:55:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so15010982lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dtxb/gAAdv0SWRFdJzThyq6cqOuYXqVCh4d7fsrqnTg=;
        b=CCyTpzIY6W3vkG2LztILrllgKTN5oeMR+M6jlPgOe/rPxolu628/Ph8X0gCn9c5nne
         DAjVctOQuJL3Dum23vMB9UcoTIeujE8IMz/pL8aw8Zw9pIIsSuRZ0/fe+sUV/9klkQav
         Yz1J2F5zrf3X/Tm5RDsuRYVEs9t2mub7bgJevolfSqat8tx6YZ0z9DpkE+Ysu4yWT6ud
         JkxM164Bsh7JvHe+9NEtaYyMvVBsO+oCB+WpEc9ZY3Z41heQO4g9QUR8m6vCycG34A8p
         7W2StEc9qOW+LPzG/5LkfXZMO/qkRobi110/VsylVif22ic9em8rhHM2HZxe/RmurOxU
         CPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dtxb/gAAdv0SWRFdJzThyq6cqOuYXqVCh4d7fsrqnTg=;
        b=VQl3++tGT94j6bclbqbVxYqer0xzecxUwxbeTU2buTS9aDzHDxRDp6CLdmzh/mtOw6
         em3F2W0q+rf/0VFaV1RWOQG+fUkhylk7oMQSeSRW3+Q/wzJDVWpLI4sOoTO5N6dlAQ15
         4eW5gnlNkSIBLsWaSWgV1zFTOAWv9w/kUe5Utznp9DJdPuA6LHrQiutGXDPpWIHHBe8A
         xTLDEWJjUwpDTqA+nqm3huL0HFef/krIx3tak6UeBFe5thi27FpQLns6jXsmX8ultpO+
         iZdzSeYlBste85Xo+isH/Ntg4gyPOKAgSPZPjpBzVBjaZSLi9Gn3Cq5p29VinIJnhkAY
         BjVA==
X-Gm-Message-State: AGRZ1gIBz+/KH7yq4faea4pMIpoc0k+L+3okPewxIsiBLLGu8IlKkXn1
        8Xn1ofGa/PW2g05Cseka1XOvEw==
X-Google-Smtp-Source: AJdET5e7sjMGRbZruNqh+6v/+RuqkfpBmWd1lyDPvOJtr1qYtv94RZ6SFvdxZtj6dWpFZARVP+Zgyw==
X-Received: by 2002:a19:4345:: with SMTP id m5mr16747977lfj.142.1543276751989;
        Mon, 26 Nov 2018 15:59:11 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 75-v6sm280643ljs.50.2018.11.26.15.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 15:59:10 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:58:56 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        snikam@nvidia.com, praithatha@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        talho@nvidia.com, yhsu@nvidia.com, nicolinc@nvidia.com,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        avanbrunt@nvidia.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
Message-ID: <20181126235856.vnseoe5lucfryc5p@localhost>
References: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Wed, Oct 31, 2018 at 04:43:45PM -0700, Krishna Reddy wrote:
> NVIDIA's Xavier (Tegra194) SOC has three ARM SMMU(MMU-500) instances.
> Two of the SMMU instances are used to interleave IOVA accesses across them.
> The IOVA accesses from HW devices are interleaved across these two SMMU instances
> and they need to be programmed identical.
> 
> The existing ARM SMMU driver can't be used in its current form for programming the
> two SMMU instances identically. But, most of the code can be shared between ARM SMMU
> driver and Tegra194 SMMU driver.
> Page fault handling and TLB sync operations need to know about specific instance
> of SMMU for correct fault handling and optimal TLB sync wait. Rest of the code doesn't
> need to know about number of SMMU instances. Based on this fact, The patch series here
> rearranges the arm-smmu.c code to allow sharing most of the ARM SMMU programming/iommu_ops
> code between ARM SMMU driver and Tegra194 SMMU driver and transparently
> handles programming of two SMMU instances.

Based on what I can see, it seems that you're trying to describe two
pieces of hardware with only one device in the DT. That seems like an
odd choice. Also, it seems like all three SMMUs share the same interrupt
line? That's somewhat suboptimal IMHO, but harder to change.

Why not instantiate both of them and create a reference between then
such that the TLB and sync ops are done on both of them in the native
driver? I.e. two arm_smmu structs and a pointer between then (i.e. add a
"next shared smmu" pointer in the struct arm_smmu).

As long as devices only references one of them, locking only that one should
provide suitable protection as well.

Seems like a simpler approach than adding a new layer to the driver, but maybe
I am missing some complexity here?


-Olof
