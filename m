Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD292173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2Z0F3Of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfAHFuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:50:04 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38936 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfAHFuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:50:04 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so4516424itl.4;
        Mon, 07 Jan 2019 21:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWvCasaGEng9FXeUAWZryKZ30PKcNxsGSlD7TD/OKCw=;
        b=P2Z0F3OfBdVvTYWLuCxJcyiWeizRCBPfYOY3CPEHW4gdifdmnBh+xxn8Z1oOZtDWX/
         KDzX5vv2OXM/A3iljI52eyEpHXNnx0wfBEWTpn2S8KKfjslqi+daJ3DQ5SJAz8M8sl+7
         jBrRD0dcvWYWiCJyJb5B8JmKr67OWAZnCsk6jOCaIyBoJOgSGlOAow9xL/f6vgN9/yxg
         NXb20wf1JqTT7Xd+eG0bp13o4hPjJWUuQze5zD+8VFdOaD3ZOTTiWxXV4fBJ6iG7QCag
         R/tl26kbmcTWBdJ3XrAgg430CirOJIlwfl8f9Ki6lnOSBgqepC/Ut2TI0Zhf3Ku1oeYS
         RW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWvCasaGEng9FXeUAWZryKZ30PKcNxsGSlD7TD/OKCw=;
        b=Nba2nHYY7WXOb+ijJoVNmW0a7NOuRiyubQvflXKtjSEXTI9baRinHORPm/hEtShFiN
         MJ+gXdGmQa9y+dWD15Zd1qimxLC0sf6Koe85jPIolCVbuPtk0ID8T01dR/2xTERQSCcD
         Wk9cKEWFlNwL0smkQBh1lf0mJq4FtERSIXl0BHDxYwGsw+kz1EY4jcwSWT0ANmpr6He0
         l8zj7zzu/IyYODCad1gHarxlGh5Uk1C7fx4ZA/I5Qe+zk9Ierm2IAjcg9Lx9FSdhn9LI
         U9MURBtSOOsWKvk2e1pKewoSbtherqok6pyxZUrEyVLTHG61vN88Pz9Ul43x59jh7YCb
         rVXA==
X-Gm-Message-State: AJcUuke9xOq+XmGcVPEoHRIkYpuZNX7SDiAc1bi+gva5rmBupcBv/B4+
        Fwt6qD9e8mDrawG+/evPUsECqCxccUKcOmJtNA==
X-Google-Smtp-Source: ALg8bN70hUYANPkOlTuk95WZ1UOI/x7EZV3t6vDsz1Te3znSg01/IrN5fitPwynEga/IH990OOr7hqZI4YNljNVNsEQ=
X-Received: by 2002:a02:8244:: with SMTP id q4mr235400jag.43.1546926603139;
 Mon, 07 Jan 2019 21:50:03 -0800 (PST)
MIME-Version: 1.0
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com> <7d72567c-2ed8-e2ae-8518-115cd9c8a82a@intel.com>
In-Reply-To: <7d72567c-2ed8-e2ae-8518-115cd9c8a82a@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 8 Jan 2019 13:49:51 +0800
Message-ID: <CAFgQCTtjD-3z52aETURY9YN-_qfy=u=xSYrdcnmMpSWow3kvjg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by
 pushing forward the parsing of mem hotplug info
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:04 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/7/19 12:24 AM, Pingfan Liu wrote:
> > Background about the defect of the current bottom-up allocation style, take
> > the following scenario:
> >   |  unmovable node |     movable node                           |
> >      | kaslr-kernel |subtree of pgtable for phy<->virt |
> >
> > Although kaslr-kernel can avoid to stain the movable node. But the
> > pgtable can still stain the movable node. That is a probability problem,
> > with low probability, but still exist. This patch tries to eliminate the
> > probability. With the previous patch, at the point of init_mem_mapping(),
> > memblock allocator can work with the knowledge of acpi memory hotmovable
> > info, and avoid to stain the movable node. As a result,
> > memory_map_bottom_up() is not needed any more.
>
> I'm really missing the basic problem statement.  What's the problem this
> is fixing?  What is the end-user-visible impact of this problem?
>
Sorry for the misaligned figure. It should be
   |  kaslr-kernel    |subtree of pgtable for phy<->virt    |
                              |--- boundary between unmovable node and
movable node
Where kaslr kernel can be guaranteed to sit inside unmovable node
after patch: https://lore.kernel.org/patchwork/patch/1029376/. But if
kaslr kernel is located near the end of the movable node, then
bottom-up allocator may create pagetable which crosses the  boundary
between unmovable node and movable node.  It is a probability issue,
the factors include -1. how big the gap between kernel end and
unmovable node's end.  -2. how many memory does the system own.
Alternative way to fix this issue is by increasing the gap by
boot/compressed/kaslr*. But taking the scenario of PB level memory,
the pagetable will take server MB even if using 1GB page, so it is
hard to decide how much should the gap increase.
In a word, this series fix the probability with certainty, by
allocating pagetable on unmovable node, instead of following kernel
end.

> To make memory hot-remove work, we want as much memory as possible to he
> hot-removable, which is basically what movable nodes are used for.  But,
> it sounds like, maybe, that KASLR can place the kernel image inside the
> movable node.  This is somehow related to the bottom-up allocation style
> currently in use.

Yes, currently kaslr kernel can stain the movable node, but it will
not do this soon after the patch:
https://lore.kernel.org/patchwork/patch/1029376/

Thanks,
Pingfan
