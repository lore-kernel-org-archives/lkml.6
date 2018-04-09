Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754863AbeDIDiQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 23:38:16 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:39723 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDIDiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 23:38:13 -0400
X-Google-Smtp-Source: AIpwx4/amAB0wAKquffGqj2Pu5cyp1TBlLk36OEfNo8OT47GEJEGOaO6oke3AhvOY0WnbywSq4rRuWcmqTeVXVBbzlo=
MIME-Version: 1.0
In-Reply-To: <20180409131619.0bc5fb45@canb.auug.org.au>
References: <20180409131619.0bc5fb45@canb.auug.org.au>
From: Oliver <oohall@gmail.com>
Date: Mon, 9 Apr 2018 13:38:11 +1000
Message-ID: <CAOSf1CHToZ5+k90n_sgh_9ezJjXpx21E5-K66TWkdU7t7kUiEw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 1:16 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Dan,
>
> After merging the nvdimm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> ERROR: "of_node_to_nid" [drivers/nvdimm/of_pmem.ko] undefined!
>
> Caused by commit
>
>   717197608952 ("libnvdimm: Add device-tree based driver")
>
> X86 seems to not have a version of of_node_to_nid() even though CONFIG_OF
> and CONFIG_NUMA are both 'y' in this build.

It's a side effect of a driver selecting CONFIG_OF accidently. There's
a patch to fix this in the drm-misc-next tree:

https://lkml.org/lkml/2018/4/3/17

> I have used the nvdimm tree from next-20180406 for today.

That works too.

Oliver
