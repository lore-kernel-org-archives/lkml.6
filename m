Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CCCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D5D218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YIikThvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeL0FNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 00:13:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45305 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeL0FNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 00:13:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so15478158ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 21:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftfuiarJULp6LGAC1L+YMAmCWxT2Y+iCGWC6BJNMoXo=;
        b=YIikThvLQ8IAZpHYpIhHe29MuKFyMl7UkFM4k4x03s8/UTgokT39mAcnWeWrfjejGT
         +bR4zVFoLG3Ki81dw/+0Fscg0HG9n1uZT228sCoeV77peVYuV6dXMti4nLzxbDmrSR52
         QjRbQbRUEZaakYYBEujqD///8n9dfsrXvL1qZzdNtnx8NocSTIWZSd4QpyZejOJ0HRaz
         W+2ahbcJIYS7RMwEBOCnzaoi8igwnpnfQY5sqBoZkpKCBi1KTVFEJCF27KCIDJaPcFP7
         IAb/w0ce6b7+5A7w0qQRAdd32TUMK/Fgvy0IApu7yMHCPUGGI8ujRdfrnq6fGuVIPP20
         49aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftfuiarJULp6LGAC1L+YMAmCWxT2Y+iCGWC6BJNMoXo=;
        b=c97Vr2RXAuzIVW5jcxpx0YXOXGqJts/NUnCglxZZwijvsg90srBVd+VKfZecYkzhuv
         6QZ5qLF+v6QC5KviglIB7QAuaaj44/ZgrQ0wgrcz8PXSiR5INVVIJWn0zZt87eAkPfUS
         LRSE19wUqzmNQKdpdSuAAIO3dcpmKJIjYOE17P4cvCJ9ycyen3CcMHc6qBrEIsxLvZZz
         fX36ntIRVl2feuif0y7ZeGeDMP+aBX54bhgoWw8j8AZMfyBhWawBGSS8N1oSchKV8UFw
         btguuiJwpoEQwqIc+Elhc63gI1dsv97JkbqFfRiFKDbaelABOwzlKxjTfGLwLQ1HfvC/
         ARuA==
X-Gm-Message-State: AJcUukdTv50Ux5B7ZjlEkzQYi9Gi0LlG4tst+GuUkkuWZ1KeGPUOMUWU
        IXv6FT/SnwI4vIWFCFsOlQtarI+u+4tv4jNUzb+XNA==
X-Google-Smtp-Source: ALg8bN6Dxet1e8l14A8HQYdHaiIuWMpqBmLTwhbymWcx5qe0/GbeewX38xDJMTNKauZxJps/A7yeR/FdC+aeyPO9jco=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr14682282otq.353.1545887632331;
 Wed, 26 Dec 2018 21:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20181226131446.330864849@intel.com> <20181226133351.106676005@intel.com>
 <20181227034141.GD20878@bombadil.infradead.org> <20181227041132.xxdnwtdajtm7ny4q@wfg-t540p.sh.intel.com>
In-Reply-To: <20181227041132.xxdnwtdajtm7ny4q@wfg-t540p.sh.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Dec 2018 21:13:41 -0800
Message-ID: <CAPcyv4hBBvcHiUSU4ER6WV7Po_GEwDjFcJy2aE3VW5Nwiu+Qyw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 01/21] e820: cheat PMEM as DRAM
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

On Wed, Dec 26, 2018 at 8:11 PM Fengguang Wu <fengguang.wu@intel.com> wrote:
>
> On Wed, Dec 26, 2018 at 07:41:41PM -0800, Matthew Wilcox wrote:
> >On Wed, Dec 26, 2018 at 09:14:47PM +0800, Fengguang Wu wrote:
> >> From: Fan Du <fan.du@intel.com>
> >>
> >> This is a hack to enumerate PMEM as NUMA nodes.
> >> It's necessary for current BIOS that don't yet fill ACPI HMAT table.
> >>
> >> WARNING: take care to backup. It is mutual exclusive with libnvdimm
> >> subsystem and can destroy ndctl managed namespaces.
> >
> >Why depend on firmware to present this "correctly"?  It seems to me like
> >less effort all around to have ndctl label some namespaces as being for
> >this kind of use.
>
> Dave Hansen may be more suitable to answer your question. He posted
> patches to make PMEM NUMA node coexist with libnvdimm and ndctl:
>
> [PATCH 0/9] Allow persistent memory to be used like normal RAM
> https://lkml.org/lkml/2018/10/23/9
>
> That depends on future BIOS. So we did this quick hack to test out
> PMEM NUMA node for the existing BIOS.

No, it does not depend on a future BIOS.

Willy, have a look here [1], here [2], and here [3] for the
work-in-progress ndctl takeover approach (actually 'daxctl' in this
case).

[1]: https://lkml.org/lkml/2018/10/23/9
[2]: https://lkml.org/lkml/2018/10/31/243
[3]: https://lists.01.org/pipermail/linux-nvdimm/2018-November/018677.html
