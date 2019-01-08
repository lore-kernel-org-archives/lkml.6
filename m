Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948CAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6979A205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546971179;
	bh=iTeIBg8m5CalfDLbBTyuXyAJBuK+9/zsJWikhWNbRt4=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=VqnBp385o1lb13BH1Q65EFttvMnk07kLacaq9NvKYdZYU/7aszXSfLA7tDQ2xTiES
	 3PYvaVE69r+WDsVn1ieAEjRpK/452gSUgKC04WpnorMSMpBqf49TEQj5SSmOkEsi9P
	 rl1bI43xRxtgBmECBeA7/ljS4gcpyH2ezhTYdkfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfAHSM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:12:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43027 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:12:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so4304954otr.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/LEZbyrwpQwK3zVuHr1t2qbnhLXWjst40t4Frr+TtLU=;
        b=qhUiNf9DrOmuAwO0JF1IJ69VNMz2DDedejRWoYlUQ+Nkf3ZjkE3zRZ6s7OihrGWbMz
         j+CC9yc1jeAV24h5WyvdceK36UL3hHoRU4i2hzno0VHWP2trmrrtnusW/AxgY76ZEj1l
         KuLK/P5YFMIuYAbqMw17Dm4ZgHnS0wsTUBGplsUtKd2WZ/AYDPAoRA6jmoBPgBUI0prJ
         FTqEypQdzj5WeXLlEbfkAzyv55VC1O8R16lmjZCwjJNeTV6dDo0bJ0SeDb4wALkE06K3
         xstbIKlOaoPz126dkI4dSoaVAc+fhF3dmA5zWiXNoZf4x+IW+GLjy9aXB3/vuplXI4Z1
         J2xw==
X-Gm-Message-State: AJcUukdpdRtXBKKoeamVDkpbxzgh4GASM7ygct6maVXozehdFJQ69iMS
        0ilJMB8HGnbbo9fm28PompHNtSz4PNgYuBqwpro=
X-Google-Smtp-Source: ALg8bN5E0h3XbYXj/NP+59ELGTbE6LVgA2bXWO0lB1VithxDMWtyfnDUwyTenFJunlpvjLW6Z8F0SC/6mvjvT6DZMDE=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr1928345otg.139.1546971176902;
 Tue, 08 Jan 2019 10:12:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546915794.git.tsu.yubo@gmail.com> <8c73ad4b2b29bda53f2dfb6624b8b7984b52e307.1546915794.git.tsu.yubo@gmail.com>
 <CAJZ5v0iiPKNVz3SE1oumOUDPGTrCHd5-hEoe6O=SsqSKD39XNg@mail.gmail.com> <20190108125355.yc7ryyl34s2me4z7@yubo-2>
In-Reply-To: <20190108125355.yc7ryyl34s2me4z7@yubo-2>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jan 2019 19:12:45 +0100
Message-ID: <CAJZ5v0gntQsDjqs17g=165if4g9rYR3C2vzKkXnjzt6b87kE+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kobject: use pr_warn to replace printk
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:54 PM YU Bo <tsu.yubo@gmail.com> wrote:
>
> Hi,
> On Tue, Jan 08, 2019 at 10:39:57AM +0100, Rafael J. Wysocki wrote:
> >On Tue, Jan 8, 2019 at 4:11 AM Bo YU <tsu.yubo@gmail.com> wrote:
> >>
> >> This is a fix to replace printk with pr_warn
> >
> >You call it a "fix", but what exactly is wrong with the code as is?
> Is there any differentions between pr_* and printk?
> If they were the same with functionial, i think it  would be better
> to use pr_* to replace printk.There are two lines code with printk only
> and others are pr_* in kobject_uevent.c.
> In fact,as you know, the code is fine.I just want to keep consistency with
> looks like

OK, so please don't call it a "fix" as doing so suggests a functional
defect in the current code that is addressed by your patch which is
not the case.

You can write something like

"Replace printk() with pr_warn() in kobject_synth_uevent() to make it
consistent with the other code in kobject_uevent.c."

in the changelog which would be clear enough IMO.
