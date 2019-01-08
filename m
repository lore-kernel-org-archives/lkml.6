Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F76A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drDTJlEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfAHJza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:55:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39905 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfAHJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:55:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so2966863otl.6;
        Tue, 08 Jan 2019 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svhKsKCiABRxonqIjUmJekJLRJDfZ3nlzbhqIqiBQws=;
        b=drDTJlElHMm06JDYEaEqSrrMtM9Z1Bicrft3plGhUeod0fOE6R3F6xY9lKx2/rfTQ6
         X6LK9EYylMeOnNXo23c1YiBDviHkmcRd7GLQ6A5+4AkcjJaRY/fZufdUmrPtwVrBVIYk
         gPgyRssQsxQW+P0iAEbi3remUtyn0j4qIRhKtv6xNr9uesvZ5n5WmYTkfZ3EXMZ4Uchy
         VovRkrGTgioBwp1At5IbuFCnMZe1d6++m7LHc9a8XCnG+V30N9kWZR9YQ0eRlPSitl7q
         90pM4auS9nBd3LA2XxGwgp0ftKjbFUGH1U++ZYdOCbW3YSNz3aeek7L/U44ALQZb3sFc
         lAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svhKsKCiABRxonqIjUmJekJLRJDfZ3nlzbhqIqiBQws=;
        b=rJfdSpqzCLQdt5SimySdht7A9P+FVQDqekrf1brZ7oHqYX+bgaA9Rrry3i4aAhyXRG
         baK5wAsDclkoDYTyPYcZNdiDkkAzkqDA0Piain0IcJnc11lRFoaxO1ls9ILIuVFYt6RI
         1n0H5+c1CVPZMRvjC+fYXCHyVJ/amuZCdJvFOVLl0b0aZWCJN0s1C17pXi60zsQQLIw5
         rbU3pzJ9Mt7bohp17l3OHYaUkl9Sf4X/YPY67QCDYghfO9ldc/K+9lkaK0Lj1OwggYxu
         SClH9Ys/ZfOHc/4G61Sbgi3CnS7wxIZDPP5DlEQXhXXF+OUAS7GWMJSpJDhT6FyhUwIX
         23ZQ==
X-Gm-Message-State: AJcUukcDyNPj3fcqnuFvclptE+PxrmwF9AH5njzs42oGZGv6IPj/Wwn3
        XHkn45z3LBhuyuMRadhWMvw0qyDABwGEWQAv9Ms=
X-Google-Smtp-Source: ALg8bN4ySlnRHP7p/hw3+4VRBNxaeeKZ5OeM6weME32TDjDJjTAJizIN/iHoTwLJljcbXVbLvsL4YZ30XtvTVpS6gHg=
X-Received: by 2002:a9d:4546:: with SMTP id p6mr767759oti.24.1546941329241;
 Tue, 08 Jan 2019 01:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.372621917@linuxfoundation.org> <20190107105337.790421457@linuxfoundation.org>
 <CADVatmNw3X2WuUXSY9hP_n7ar2Hi8xUCh+BovQz2=c8RGRnwkQ@mail.gmail.com> <20190108073804.GC2102@kroah.com>
In-Reply-To: <20190108073804.GC2102@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 8 Jan 2019 09:54:53 +0000
Message-ID: <CADVatmMjQwBMP+_-Kh+0J17vNVWOUmuKkODMhf8WOOfQSEgCuQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 090/101] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 7:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 07, 2019 at 09:17:22PM +0000, Sudip Mukherjee wrote:
> > Hi Greg,
> >
> > On Mon, Jan 7, 2019 at 1:14 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Huacai Chen <chenhc@lemote.com>
> > >
> > > commit bb53fdf395eed103f85061bfff3b116cee123895 upstream.
> >
> > This has been fixed by 66a4059ba72c ("MIPS: Only include mmzone.h when
> > CONFIG_NEED_MULTIPLE_NODES=y")
>
> That commit is already in the queues for 4.14, 4.19, and 4.20, so all
> should be fine, right?

I am not seeing it in 4.14.92-rc3.  Am I missing something?


-- 
Regards
Sudip
