Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCVP5o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:57:44 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36298 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeCVP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:57:41 -0400
X-Google-Smtp-Source: AG47ELvGIF4MiTLM8xJztXOgw9M4M+8jrMDbZ0Jgq9Ddxl+lthsdrLjYuxNHlPdw8UMaivRyMNVPNMi7xlDMfNaz948=
MIME-Version: 1.0
In-Reply-To: <20180322180756.3978942f@canb.auug.org.au>
References: <20180322180756.3978942f@canb.auug.org.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 22 Mar 2018 08:57:40 -0700
Message-ID: <CAPcyv4gLZk5Euy5ZbXag47jh5M8MeVeOQnn245R--_M5mO+LdA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the nvdimm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding kbuild robot folks ]

On Thu, Mar 22, 2018 at 12:07 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Dan,
>
> After merging the nvdimm tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>
> fs/xfs/xfs_file.c: In function 'xfs_break_layouts':
> fs/xfs/xfs_file.c:759:20: warning: unused variable 'ip' [-Wunused-variable]
>   struct xfs_inode *ip = XFS_I(inode);
>                     ^~
>
> Introduced by commit
>
>   6ea4108852e9 ("xfs: prepare xfs_break_layouts() for another layout type")

Thanks for the report I'll clean this up. I did leave this on a branch
for 0day for 24 hours before pushing to -next, but seems either the
compilers are different, or 0day is having an outage?
