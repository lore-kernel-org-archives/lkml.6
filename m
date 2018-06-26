Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E3EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BBA2640F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXAX7D7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BBA2640F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965295AbeFZCXV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:23:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34765 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965199AbeFZCXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:23:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id g3-v6so2600336pfi.1;
        Mon, 25 Jun 2018 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BNbI5hu1k57yG+f7s5vxV/GTuq/VhNvriwGrXL/WGfE=;
        b=rXAX7D7pBNCHuADi7IPipTjTXHEp394OpW00V23oksCrnPAHfW8KfH02T+AKWPC3mC
         OSfXEhXDdP3BA6+jAhP0wqU5WDn/sHaHefmfDOD1/24S6xf7U57NIhAk2M/HTVWkdOjN
         S/V+vdmg8XS5F0ReQAE1AjbwhBQaDvJvY6fbxicd36HTzWaDPrfwmnHuBY/2e3bzKbye
         SMVidk0ZrWRA524Bkwh0aI1u1hpe/6UlY2PptKHJQ6VhlfpN4iBVcfAJljUPE8mGODy5
         S4vWEBOv7VUnkDHBkxs7hgwKnTwkPYDu9B4WJC+/GY/RsUMKS/CgdFUs5DeT0q2tMRst
         xxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BNbI5hu1k57yG+f7s5vxV/GTuq/VhNvriwGrXL/WGfE=;
        b=lDyUDmIDm7CA2OH0F6lEtydbeH3zSe9+Lge2UVtbDW7WVDlH7Bd7eKaZT0zYWLYgh6
         WJjIxKjf0BekXmCx6a06gKQBmxmFNmjYB31V98ux28sFPTbEL3sIFNsnHnFYjYW/iqZE
         XtOBI5PC9uLknnAUqXUT0ugoiHx0YarHxLGhb3WbjfkfK8yNJyeNaR8jPhpKWHPQs8Bz
         VFKMuLPMWx9NA5M8Jdamp6FY+frFGrRhLzBEIfmqsxix2YrpyRf4EF34UvMWDWo1Mm6s
         XEJh130GiqFF/F3fXrPNgTyPav1h5zJ5RPYiSUzVDp4x+0aFGAz7kvlUznI0dIXfsOW3
         qrig==
X-Gm-Message-State: APt69E3z0Axu8T/YaqTM7lHvLedH+Qn+F45lUBHsAhIh3qyLOPRu2GfD
        wie/kM7iBoVl+AhnEdvdVA1sDt/dyT7WuOGV1tM=
X-Google-Smtp-Source: ADUXVKJiI6I32d7tu8lD0QlTCnUB2M/MUiKRhBpvCR2mnMTCWeFMmdcRDoRG7Wl8jACjoMxRP0Xf9xhkqujgZ5/eW60=
X-Received: by 2002:a65:52c3:: with SMTP id z3-v6mr12853960pgp.69.1529979796707;
 Mon, 25 Jun 2018 19:23:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3aee:0:0:0:0 with HTTP; Mon, 25 Jun 2018 19:23:16
 -0700 (PDT)
In-Reply-To: <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
References: <20180425154602.GA8546@bombadil.infradead.org> <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba> <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Tue, 26 Jun 2018 14:23:16 +1200
Message-ID: <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
Subject: Re: moving affs + RDB partition support to staging?
To:     jdow <jdow@earthlink.net>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joanne,

Martin's boot log (including your patch) says:

Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
(LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2 spb
4)
Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
Attached SCSI disk

so it's indeed a case of self inflicted damage (RDSK (512) means 512
byte blocks) and can be worked around by using a different block size.

Your memory serves right indeed - blocksize is in 512 bytes units.
I'll still submit a patch to Jens anyway as this may bite others yet.

Cheers,

  Michael


On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
> BTW - anybody who uses 512 byte blocks with an Amiga file system is a fam=
n
> dool.
>
> If memory serves the RDBs think in blocks rather than bytes so it should
> work up to 2 gigablocks whatever your block size is. 512 blocks is
> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk in block ma=
ps.
> Go up to 4096 or 8192. The latter is 35 TB.
>
> {^_^}
> On 20180624 02:06, Martin Steigerwald wrote:
>>
>> Hi.
>>
>> Michael Schmitz - 27.04.18, 04:11:
>>>
>>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=3D43511
>>> indicate the RDB parser bug is fixed by the patch given there, so if
>>> Martin now submits the patch, all should be well?
>>
>>
>> Ok, better be honest than having anyone waiting for it:
>>
>> I do not care enough about this, in order to motivate myself preparing
>> the a patch from Joanne Dow=C2=B4s fix.
>>
>> I am not even using my Amiga boxes anymore, not even the Sam440ep which
>> I still have in my apartment.
>>
>> So RDB support in Linux it remains broken for disks larger 2 TB, unless
>> someone else does.
>>
>> Thanks.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
