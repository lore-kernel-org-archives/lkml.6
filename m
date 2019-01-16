Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6EFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CB420868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCWldirx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfAPUih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:38:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38101 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfAPUih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:38:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so3498355wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 12:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXENUcZQeQc4GpVOepu2JqCrBL5FekqSojjxZTgabJE=;
        b=JCWldirxMg//hUX4ioKgbonPMZuWXWN6HEC9HdxBMzSAWVFoVoWJFm2Y1KiskwlPZW
         itiYT++UShcarFg/zFJy8KfTI6HqbRYAx+Evx7qIm3jOSs5MIbE4O0B4BNrPyARXDOuh
         KYtUN/4omxn44KaN83fCPBSMxtFKU26Cpa7PSMnCyXCyFIvYoGWRLqWdhqFnCvNYz6R2
         bhyLV3sWl+Ry+Iavnwp1Y9cl8CTO0T6Yyf7rx7fXds+A3Q63fKpeqMH4+NiVCakFGIEa
         ukB4vm2Kzt9V0x/tHozpZDaq1KyFXdiu+LTze5Kf7P66vr1MMeZPfYZh+5FLzMfPMuRF
         ulJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXENUcZQeQc4GpVOepu2JqCrBL5FekqSojjxZTgabJE=;
        b=DEbPh3Uv8wOdwgmmnkbIumJHCut2YDZwu+J5VAGAtLyOy1TlmFN+wmUEJqv23rbv1A
         0mr9B9MVy4RX8rcw2Tj83FBHst4S7acvfkaazOJ55n1njr95cXf4noBEKbWl6bE70UyD
         KpeppLraKTkHsSwo4sbb0AHgR5+2f6P9+9UtDe6J9m0CmCcay5uIoLhfyHQq2ehaYjjf
         XM/H20m+o0BEvkYXxPP+aPWyj59na+91DREbxxK8MMWwPum/d6uAsD41gsb1awjftb9w
         11piG9lLQbhNXw62ke9znFsDseNwdduBhxsZwPHB1k01/H2S/d8iY3/yF7tdZcJwQQG+
         yq7g==
X-Gm-Message-State: AJcUukfrFPcCbXpmJZTEHRzFusCK6Bje9i2/F577aGqV7AeLeORuyh7o
        epjX8qgVtkAvPlwaSl4mN0QLLNhk9qW2Cou8Vgfn
X-Google-Smtp-Source: ALg8bN7gpC1zQUf/Ur28gfRRSuGlQu5VnHpLdE4eoVuPZp4DpLFxmDk6C1d/4OcIeclkzK7A6gnxawWFV23BB9YbhG8=
X-Received: by 2002:a1c:8d53:: with SMTP id p80mr9476229wmd.68.1547671114168;
 Wed, 16 Jan 2019 12:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20190116181859.D1504459@viggo.jf.intel.com> <20190116181901.CAF85066@viggo.jf.intel.com>
In-Reply-To: <20190116181901.CAF85066@viggo.jf.intel.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 16 Jan 2019 14:38:21 -0600
Message-ID: <CAErSpo63av+jnkSY-V_ZNKy1LDX7rGZ6rK1bWbTf3fgrhXqrwQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/resource: return real error codes from walk failures
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     dave@sr71.net, Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:25 PM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> walk_system_ram_range() can return an error code either becuase *it*
> failed, or because the 'func' that it calls returned an error.  The
> memory hotplug does the following:
>
>         ret = walk_system_ram_range(..., func);
>         if (ret)
>                 return ret;
>
> and 'ret' makes it out to userspace, eventually.  The problem is,
> walk_system_ram_range() failues that result from *it* failing (as
> opposed to 'func') return -1.  That leads to a very odd -EPERM (-1)
> return code out to userspace.
>
> Make walk_system_ram_range() return -EINVAL for internal failures to
> keep userspace less confused.
>
> This return code is compatible with all the callers that I audited.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
>
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>
>  b/kernel/resource.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -puN kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1 kernel/resource.c
> --- a/kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1      2018-12-20 11:48:41.810771934 -0800
> +++ b/kernel/resource.c 2018-12-20 11:48:41.814771934 -0800
> @@ -375,7 +375,7 @@ static int __walk_iomem_res_desc(resourc
>                                  int (*func)(struct resource *, void *))
>  {
>         struct resource res;
> -       int ret = -1;
> +       int ret = -EINVAL;
>
>         while (start < end &&
>                !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
> @@ -453,7 +453,7 @@ int walk_system_ram_range(unsigned long
>         unsigned long flags;
>         struct resource res;
>         unsigned long pfn, end_pfn;
> -       int ret = -1;
> +       int ret = -EINVAL;

Don't you want a similar change in the powerpc version in arch/powerpc/mm/mem.c?

>
>         start = (u64) start_pfn << PAGE_SHIFT;
>         end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
> _
