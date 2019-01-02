Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92691C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D1B218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NRmpAgFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfABTxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:53:54 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44993 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfABTxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:53:54 -0500
Received: by mail-lf1-f43.google.com with SMTP id z13so21719551lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikxVp6zc4xz0kip1YhbhjKbDAlBHVVUMk50g71OLSt8=;
        b=NRmpAgFg5FPleEA7gDJ7M6EqsD9WTZ19Phyr0npkz5YDxv7xg5bJGeslpPRR3CrJvj
         bXKfX7MKLKev2zP1o5NzIPVTLqZ6pUX2ab0sJ/hQ/BsFiQjIBgb+1O2aUokp9gTF4XPn
         MlkRR9UIzozzKIphZMCCDOMI4TWFRkkRDHBhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikxVp6zc4xz0kip1YhbhjKbDAlBHVVUMk50g71OLSt8=;
        b=dw+NJoCPlLppvnzSybuc/WKDb1/epMGutlccqLNIzL6iO3XV9a3RT87RcEGEqeBrZR
         o/DvWchCfHT9jZHYE1aEh3Bf6dJCmY2I12KEULoXABupuh7EAmVQpHhPY+BvIjLRyZUF
         3QQsGPTjcsjdkR1purzUyE3qOayj3rwBvzhANHN/aD7cfcBzjaYFy9daCukoY+c2YZmu
         MnPvBihufmlG7FlYqvblWsbFznOvCp9DkPi4Cs6KIFliuyCJdrVvNTJT7TTQFi3tNDQJ
         rJxWoKuhD+0CnO++K2D3z62rl+7XjAJ2grGc/iVy5b97/drZaxrHZyZI+ew5Q/d8AaI1
         3EiQ==
X-Gm-Message-State: AJcUukd5IFlgbRubUOLdG8V+yLnTJfbte622bMxrJ1Y9xKCPe6kSuBIO
        8GrqYVaFc/mIlypu6oriJlCRbnIpX3M=
X-Google-Smtp-Source: ALg8bN5cq3bXidLj4YSuBS3b+EWdTJ7NKiezyoYWLVbxeLhkl4vLb88h7ZSF1p4XEihR0xZ+25QpCg==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr891794lfe.137.1546458831930;
        Wed, 02 Jan 2019 11:53:51 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d10sm10355615lfa.71.2019.01.02.11.53.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:53:50 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id n18-v6so27938220lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:53:50 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr27545713ljx.6.1546458830210;
 Wed, 02 Jan 2019 11:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20190102005704.GC17624@shao2-debian>
In-Reply-To: <20190102005704.GC17624@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Jan 2019 11:53:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
Message-ID: <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
Subject: Re: [LKP] [mtd] c4dfa25ab3: kernel_BUG_at_fs/sysfs/file.c
To:     kernel test robot <rong.a.chen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm..

Adding a few more mtd people to the cc.

On Tue, Jan 1, 2019 at 4:57 PM kernel test robot <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: c4dfa25ab307a277eafa7067cd927fbe4d9be4ba ("mtd: add support for reading MTD devices via the nvmem API")
>
> [   81.780248] kernel BUG at fs/sysfs/file.c:328!
> [   81.781914] Call Trace:
> [   81.781914]  sysfs_create_files+0x60/0x180
> [   81.781914]  mtd_add_partition_attrs+0x14/0x30
> [   81.781914]  add_mtd_partitions+0x11f/0x260
> [   81.781914]  mtd_device_parse_register+0x38d/0x4c0
> [   81.781914]  ns_init_module+0x1033/0x117d
> [   81.781914]  do_one_initcall+0x18f/0x39e
> [   81.781914]  kernel_init_freeable+0x2b4/0x353
> [   81.781914]  kernel_init+0xa/0x120

This actually looks like a very old bug, just exposed by a new error case.

In particular, the mtd code seems to do this in mtd_add_partition():

        int ret = 0;
     ...
        add_mtd_device(&new->mtd);

        mtd_add_partition_attrs(new);

        return ret;

where 'ret' is actually never set to anything but that initial zero.

And in fact, it looks like it never was used.

I _think_ that what's going on is that "add_mtd_device()" historically
never really failed (although it *can* fail), and then
mtd_add_partition_attrs() is called on something that doesn't really
exist.

It looks like the error handling for the add_mtd_device() case nmever
actually existed, and now the nvmem patch makes that fail in the
test-case, and the lack of error handling is exposed.

There is another call-site of add_mtd_device() (in
add_mtd_partitions() - same pattern, notice the "s" at the end of the
function name) that also lacks the error handling.

Both cases go back to 2010.

Greg, Rafael: it does strike me that the "BUG_ON()" in
sysfs_create_file_ns() could easily have been a

        if (WARN_ON(..))
                return -EINVAL;

which would have made the machine boot and probably make things easier
for normal users to report. The kernel test robot doesn't care, but
non-booting kernels are usually not nice to debug or report for normal
human beings..

                 Linus
