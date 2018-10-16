Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376612148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="brPFVW3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376612148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJQHWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:22:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43871 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:22:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id s69-v6so19553914oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8H3V239BtXTCdLm2SgsF3fXkez3c39kLhbYNnb2RfDc=;
        b=brPFVW3gT1eq5Z7eZ4ma6KSGjP2CCoOQYwMBfdtj4Cq2ssJhj7o+CX8sv5k9m28g9Z
         mczoOLISgerhNGyDH60yjETbq0R3oltQZ2WuViYxMpCp2/7IJbF7wLdQ0wGb/UDcCcMq
         4EH2ED6jaE0SLALTnZ9FKLVPVDEr4OLqgJi9CJkfGEl54429CV5w04OVxY5w5C18Sd1Q
         /gqzgnd/XLv7o6ibo8g24l0lvcO/Sk5cqyLC2WTVLF3sa/Byv2qtB9WliXCw5eQhvoTP
         /fbucd0nDsTb/z+RCENKQ/BIRsKEiGHEKZw5quIScY/2ptx9Pk4j1ktsW9+XXD20vx90
         IImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8H3V239BtXTCdLm2SgsF3fXkez3c39kLhbYNnb2RfDc=;
        b=tner+z2aRD7jxMUbM6lmWgftOLJr4NW3KPZsZKYjnPQi6JW7W2rCoW55yuqAmGBhWL
         bRGGjdnco5RMyzqypwtyV/6m8pKat2Jz+HMYoWsa2+GjOI7kx5He12UprG//2LI5Bcnj
         OXxBGi+7DU5C4GtGLT2EvhJr/4gHU+o1ChX9X6Ld5MjbDZDZNd0Sz7U+DBohhJn4lPdB
         zgESmWRDW68tD03rMGosmBxHwe0QOoJZSF6n+4I9d5MNTh6lgTINP06MQfaXO5EnPGRc
         5UeQo9VBcZkgplZZ7f74FE+1P62r8eI5bu27dy+93pK9d886swN4BEsKjVkmCKaDKlgr
         tT4A==
X-Gm-Message-State: ABuFfoh3Ueuj4j0VKpZX4Wr3ht4CIgTcTrNtdcEQK+VkIcuIYm9nvrQ8
        DdVQeTGi2l/k9QCSDM6ZU8/aK9lcqcysCp7cz2nHVw==
X-Google-Smtp-Source: ACcGV63+RF3UHKhlk8JATuy34/C9WcvSmRkRfR5+5YPemuX/eeP/obY+ttEjtb8BKrQ6a7HS95yDo35/UWIG+vP70cM=
X-Received: by 2002:a54:4696:: with SMTP id k22-v6mr11788982oic.99.1539732590509;
 Tue, 16 Oct 2018 16:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
 <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
 <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com> <d00fec12b481f17ce6e844d86be56b5f12bdb0b1.camel@perches.com>
In-Reply-To: <d00fec12b481f17ce6e844d86be56b5f12bdb0b1.camel@perches.com>
From:   Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Date:   Tue, 16 Oct 2018 20:29:39 -0300
Message-ID: <CAEFO=4DQ7yN33VwW5evNgdMTDf1c_Sffwue_PFT_RvytJst+Bg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad7280a: Lines should not end with a '(' - style
To:     joe@perches.com
Cc:     giuliano.belinassi@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>(There is a linux-usp@googlegroups.com mailing list
>that bounces when I reply, so I removed it from the
>cc list)

Sorry. I think this may be because my HTML mode in gmail was enabled.

> I wrote that to encourage you to do more than
> what checkpatch says.

> I just moved code around and reduced duplication.

> There are many similar opportunities for code
> refactoring in staging.

Thank you :-) I will put effort to improve these points.

> You could test what I wrote, add a good commit
> message with a subject like:
>
> [PATCH V2] staging: iio: ad7280a: Refactor <functionname>
>
> with a commit message that describes the changes and
> perhaps shows the object size difference using
>
> $ size <old> <new>

I will do that. :-)

> Are you doing this for a class assignment?
Yes, I am. I am into a group that aims to contribute to opensource
projects and we chose the Linux kernel. Our mentor suggested us to
contribute to the linux-iio

Thank you
On Tue, Oct 16, 2018 at 8:08 PM Joe Perches <joe@perches.com> wrote:
>
> (There is a linux-usp@googlegroups.com mailing list
> that bounces when I reply, so I removed it from the
> cc list)
>
> On Tue, 2018-10-16 at 19:48 -0300, Giuliano Belinassi wrote:
> > Hello,
> >     Thank you for your review :-).
> >     Sorry, but I am a newbie on this, and now I am confused about my next
> > step. Should I make a v2 based on your changes, or do you want to submit
> > your changes?
>
> I wrote that to encourage you to do more than
> what checkpatch says.
>
> I just moved code around and reduced duplication.
>
> There are many similar opportunities for code
> refactoring in staging.
>
> You could test what I wrote, add a good commit
> message with a subject like:
>
> [PATCH V2] staging: iio: ad7280a: Refactor <functionname>
>
> with a commit message that describes the changes and
> perhaps shows the object size difference using
>
> $ size <old> <new>
>
> Maybe add a Suggested-by: tag if it pleases you, but
> what I did is trivial and I think it's unnecessary.
>
> Are you doing this for a class assignment?
>
>
