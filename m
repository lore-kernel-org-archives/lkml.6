Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0605C2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0605C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeKCGbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:31:41 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43994 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKCGbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:31:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C5F26609F83D;
        Fri,  2 Nov 2018 22:22:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4Q8TZt4pNKjN; Fri,  2 Nov 2018 22:22:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 74E0B606C48D;
        Fri,  2 Nov 2018 22:22:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RzpRRODlm8HX; Fri,  2 Nov 2018 22:22:54 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 08AF96088980;
        Fri,  2 Nov 2018 22:22:53 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nkela@cisco.com,
        xe-linux-external@cisco.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Rod Whitby <rod@whitby.id.au>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Make JFFS2 endianness configurable
Date:   Fri, 02 Nov 2018 22:22:53 +0100
Message-ID: <2265901.Da3O5o3T4q@blindfold>
In-Reply-To: <20181102211444.nqqqbd4w5diyqrfw@zorba>
References: <20181101225603.17806-1-nkela@cisco.com> <CAFLxGvy-0-A1Ta1vf=o4q0tcJAdr+uv9eQc7UrnwqF9NkJiWUw@mail.gmail.com> <20181102211444.nqqqbd4w5diyqrfw@zorba>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. November 2018, 22:14:44 CET schrieb Daniel Walker:
> > Make it a mount option and store the endianness mode in the super block.
> 
> It's actually a mkfs option currently. I'm not sure how that factors in,
> 
> from the mkfs.jffs2 man page,
> 
>        -l, --little-endian
>               Create a little-endian JFFS2 image.  Default is to make an image with the same endianness as the host.
> 
>        -b, --big-endian
>               Create a big-endian JFFS2 image.  Default is to make an image with the same endianness as the host.

As long this setting is not stored in the filesystem itself, it is useless.
IIRC it just controls the endianness setting for mkfs.jffs2's
t32() and t16() macros.

That's why I think of a mount option like "force_endian=".

Thanks,
//richard


