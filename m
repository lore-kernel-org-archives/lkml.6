Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F24E2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+nL6fBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeL0TcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:32:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45778 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeL0TcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:32:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so11389560qka.12;
        Thu, 27 Dec 2018 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAjCO3GnuR7K5LykI+2+0VuB0+2IVvgrxN27c6QBKuM=;
        b=L+nL6fBGB68bgCmWUTBV8p4elnCb/9wH8Hf0dO7WF3Csk8nhG6AF1w/gPOqIZncq68
         udkbk9UmTSxHS0HNnPEUEU9WZ6PaB1ZcQKp0+HacB1TMvdOWRjwVw4RwgGnKcw46QSNn
         Phld/Tv2zx2aAbW4lFVnlQ2w3d2JY4Al+LMzqQZKmUaQQc538rYZ1aGDxRwD2dhZ4/kX
         FhqiRpLRSURikdn5zXL+pI89VvrcO8z+N1zXnfz22WTRcvokvqHj5c8iPY9DIyFDuZMJ
         Bx6EfCrhC7pYka5a5C+fb0c1yY283/FP3K9H9ZzPuMAAbJzOJp6lr2Rgae3j0WQJ0tMT
         39Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAjCO3GnuR7K5LykI+2+0VuB0+2IVvgrxN27c6QBKuM=;
        b=pD8BBDFlLfD5Cq336HECdUeNY0wN8dBPWQC8eWdakSDeee361BIDMV3GLWI3gyRF8J
         i2SLHUmc+8r+5kRuENV6siOCYIaDOS964Kam7XrUPvCTQhYQ2zq9AnqQy1SEuQuouwTq
         Grpzn1wDuMfW2pdV6CsyzDLv6fFnljmambkwkeSHNqbNdw1cNMNdr9LFQhWLWTHbjRJR
         EjzRBzwvmDB5uqCCK8QVgFBXaeI07ry9yXs2H5mRuc1wkdkQbj72riD1Qgfe4VpTX58I
         XaWXOTVBhPWYIDf5QpaJ+PgRu5ZlPhYZAlO2amrhjTJ3KjCl0zVf3PqpDVWapLkJl7aB
         I02Q==
X-Gm-Message-State: AJcUukcZ7UbCq2qxZgqQdKoMynNtBsfrDp9Zxbbvo6J/3lmFa8nY21n8
        iWUMNhw225VWRVSxkfZ7xr49JtLxJMcE32pk4s0=
X-Google-Smtp-Source: ALg8bN7cFEH0nAFiavDtrruWYIkUr4bNP4bbMHbm0mHq2lQX9nStpzzZ24Gosp7aYu/35ejoJO5uu3Ki8y5W6l7TT8g=
X-Received: by 2002:a37:9281:: with SMTP id u123mr23363934qkd.0.1545939137848;
 Thu, 27 Dec 2018 11:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20181226131446.330864849@intel.com> <20181226133351.106676005@intel.com>
 <20181227034141.GD20878@bombadil.infradead.org> <20181227041132.xxdnwtdajtm7ny4q@wfg-t540p.sh.intel.com>
 <CAPcyv4hBBvcHiUSU4ER6WV7Po_GEwDjFcJy2aE3VW5Nwiu+Qyw@mail.gmail.com>
In-Reply-To: <CAPcyv4hBBvcHiUSU4ER6WV7Po_GEwDjFcJy2aE3VW5Nwiu+Qyw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 27 Dec 2018 11:32:06 -0800
Message-ID: <CAHbLzkqR2z+wcVXkKRoHysXtjtn12P33emr15h_HB=jMaByV5w@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 01/21] e820: cheat PMEM as DRAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 9:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Dec 26, 2018 at 8:11 PM Fengguang Wu <fengguang.wu@intel.com> wrote:
> >
> > On Wed, Dec 26, 2018 at 07:41:41PM -0800, Matthew Wilcox wrote:
> > >On Wed, Dec 26, 2018 at 09:14:47PM +0800, Fengguang Wu wrote:
> > >> From: Fan Du <fan.du@intel.com>
> > >>
> > >> This is a hack to enumerate PMEM as NUMA nodes.
> > >> It's necessary for current BIOS that don't yet fill ACPI HMAT table.
> > >>
> > >> WARNING: take care to backup. It is mutual exclusive with libnvdimm
> > >> subsystem and can destroy ndctl managed namespaces.
> > >
> > >Why depend on firmware to present this "correctly"?  It seems to me like
> > >less effort all around to have ndctl label some namespaces as being for
> > >this kind of use.
> >
> > Dave Hansen may be more suitable to answer your question. He posted
> > patches to make PMEM NUMA node coexist with libnvdimm and ndctl:
> >
> > [PATCH 0/9] Allow persistent memory to be used like normal RAM
> > https://lkml.org/lkml/2018/10/23/9
> >
> > That depends on future BIOS. So we did this quick hack to test out
> > PMEM NUMA node for the existing BIOS.
>
> No, it does not depend on a future BIOS.

It is correct. We already have Dave's patches + Dan's patch (added
target_node field) work on our machine which has SRAT.

Thanks,
Yang

>
> Willy, have a look here [1], here [2], and here [3] for the
> work-in-progress ndctl takeover approach (actually 'daxctl' in this
> case).
>
> [1]: https://lkml.org/lkml/2018/10/23/9
> [2]: https://lkml.org/lkml/2018/10/31/243
> [3]: https://lists.01.org/pipermail/linux-nvdimm/2018-November/018677.html
>
