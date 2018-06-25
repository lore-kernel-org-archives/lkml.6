Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E21C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B8625603
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B8625603
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbeFYIkh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:40:37 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41807 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeFYIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:40:35 -0400
Received: by mail-ua0-f194.google.com with SMTP id a5-v6so8085276uao.8;
        Mon, 25 Jun 2018 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f+WLbWLC9i5pzqwLOMCTbuHNa/67+8zYYTajmlwAKPE=;
        b=g8o3vVuimZBOYpAlo6pb2zoJelC6yPFdfpete+lsZFDTMPOIKjdRhb5hWyPGBen/Gx
         cf3KXirFldTwNqyjVkyhV/WJxjk4qWImj3/9v2zN5eIttNoPZLOhZkOXlZKwwF+xeLDg
         5ltRWTBG3tmtSPJrVuKR4gHEgBH7hEwWuWChFjBeCrnDtgco2r93dZVxLXdsS+GslLqY
         Oko/rqHmOSZITrSe2iXhevXW8+GPSmw0itEtRwTj2Jticpr/Y3rRP9nB31oDo+eCvdsg
         5q/yGD01//UYJZCEWO9u8eYu/E8nFmVxwCKgWVbo09xefGJnF+swUjSn/lcWv2A2SK26
         h34Q==
X-Gm-Message-State: APt69E0HCTrVnR1FnvcYRXRX3EC/n84wdIDX6D2ivZt396UPQryAnSJa
        zfKDj8t0V4CqlujF6k16MimUZwyK2ZRJvTVRRlA=
X-Google-Smtp-Source: ADUXVKKkUEIGuc1z64yyhklkJn+33uvUlho4Yzb8XuYiJu5QnwW08up7RKfQECLUT6+535BeBJC6oA/29nLoZtJCmfM=
X-Received: by 2002:ab0:5922:: with SMTP id n31-v6mr7850319uad.114.1529916034784;
 Mon, 25 Jun 2018 01:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180425154602.GA8546@bombadil.infradead.org> <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba> <2491cfa6-c227-9c91-6630-f56d86cd80e5@gmail.com>
In-Reply-To: <2491cfa6-c227-9c91-6630-f56d86cd80e5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jun 2018 10:40:23 +0200
Message-ID: <CAMuHMdXC5F_p7HNuu274WmDMexzVhT_cRaGq-XOd4+wFNLiyCg@mail.gmail.com>
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving
 unmaintained filesystems to staging)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        jdow <jdow@earthlink.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, Jun 25, 2018 at 9:53 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> OK, I'll prepare a patch and submit it to linux-block for review. I'll

Thanks a lot!

> have to refer to your testing back in 2012 since all I can test is
> whether the patch still allows partition tables on small disks to be
> recognized at this time (unless Adrian has a 2 TB disk and a SATA-SCSI
> bridge to test this properly on).

Sparse file and loopback mounting with losetup --partscan?

> Am 24.06.18 um 21:06 schrieb Martin Steigerwald:
> > Michael Schmitz - 27.04.18, 04:11:
> >> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
> >> indicate the RDB parser bug is fixed by the patch given there, so if
> >> Martin now submits the patch, all should be well?
> > Ok, better be honest than having anyone waiting for it:
> >
> > I do not care enough about this, in order to motivate myself preparing
> > the a patch from Joanne Dow´s fix.
> >
> > I am not even using my Amiga boxes anymore, not even the Sam440ep which
> > I still have in my apartment.
> >
> > So RDB support in Linux it remains broken for disks larger 2 TB, unless
> > someone else does.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
