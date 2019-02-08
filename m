Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1982FC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF522146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz/j3uMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfBHOYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:24:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38737 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:24:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so1740589pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=x+4xnTqcwhgr98uo5XuFLhUJxPlaJMi636SG2kQk7Gc=;
        b=Nz/j3uMDOKKjlKfg8XkmSjsG+hq2GR57pmu0ELyhtTHaop/CIhVuBiNmxAs7/l4tAN
         IH7DDFeg2O3lQoH2msMZB5B/Sv3dSO44F6NfISmiVVc7i9K5li5IFXUSL7dPPHAUnBjv
         jHyoBdO8IFrRB80q/A2jg0qitDMXVHmjY4Ez3kpFaSd3gxAJ/Nvk1nYi1eGg++1lnmJt
         MrI3kFS/n2Txb5QmiVQ2LNf0Vr6jmxZOshrL9lUmPxHBd4g0MYkMnfBQNjK+QzeZHrNz
         JIu0KcWGIax+ElLWafh0ggLLr1yya+MvO4fdqhuyfebBHtxJa4pd3ifXt4wMsLODY4Cf
         +ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=x+4xnTqcwhgr98uo5XuFLhUJxPlaJMi636SG2kQk7Gc=;
        b=I0KEpvYawPrlqeqNsPXPtdE5HHW3Mg0jQPUNnWoLz/gXUYMlpP6xObKxlhtFSi3DS6
         2/YM49rEeD9l4OuYbxrB7EVx1qy9Hrj/Bekcn+DNSOxcvOxpT0NfPapxS4FKvBG7SrWI
         SNvHuoFNfRcgpRfesrY67AovUEEp+KTvsP6WOm/an/6Vue+wP9x1OiiQHMBunz3LyQ95
         LqT+8f6FWZAGQvQMQEwe6Iio1krF43RmrcOq2dhM//bwnLK5FelbKKVU8BAl7Fq83FoX
         irljZ0aCaDGHbkTutJEXJ9/0WHnchle8wwXaBu9XgvQ38YV/YVTobHJKE2Gns55z5lXz
         e/fw==
X-Gm-Message-State: AHQUAubmoucMdmh4QxARUgKTKfpkCcE/HkW1ZeHhQ5NWaaV8evrecrrG
        L+cuszQJJRVqCFrjp32MyQY=
X-Google-Smtp-Source: AHgI3IY4R6s1tLE+JvJyuE1UiIUeBdRtoYeDhXLsW1itG54bMV7XXx3OOKwfh+GIO/qb+YohauwqiA==
X-Received: by 2002:a62:1c86:: with SMTP id c128mr23246203pfc.54.1549635869414;
        Fri, 08 Feb 2019 06:24:29 -0800 (PST)
Received: from ikegamiPC (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.gmail.com with ESMTPSA id f12sm2680980pgo.13.2019.02.08.06.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:24:28 -0800 (PST)
From:   "Tokunori Ikegami" <ikegami.t@gmail.com>
To:     "'Sobon, Przemyslaw'" <psobon@amazon.com>,
        "'Boris Brezillon'" <boris.brezillon@collabora.com>
Cc:     <keescook@chromium.org>, <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <joakim.tjernlund@infinera.com>,
        <linux-mtd@lists.infradead.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, "'Liu Jian'" <liujian56@huawei.com>,
        <ikegami_to@yahoo.co.jp>
References: <1548977439-318904-1-git-send-email-liujian56@huawei.com> <20190203092645.18d1495b@bbrezillon> <20190203093509.269bf1e1@bbrezillon> <acd16b85676e4d1d89f3acfbeda30107@EX13D07UWA001.ant.amazon.com> <20190207095635.0fc3b411@kernel.org> <193621849.44066.1549580387922.JavaMail.yahoo@mail.yahoo.co.jp> <632ed76bd3844ceab75066d1f30a7115@EX13D07UWA001.ant.amazon.com>
In-Reply-To: <632ed76bd3844ceab75066d1f30a7115@EX13D07UWA001.ant.amazon.com>
Subject: RE: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Date:   Fri, 8 Feb 2019 23:23:59 +0900
Message-ID: <149101d4bfb9$fdc5a330$f950e990$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKzD+8bzTNJb3fYn6g+Txlclt4a6gHKPVnTAnthz5oB7umc8AJnC6FFAd0fx9ABvvwx96O3jtDw
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Przemek-san,

Thank you so much for your explanation.

> I have seen a case myself where a value was written, chip changed
> state to "ready" but when I was reading the value was incorrect.

I also know the similar issues for the both buffer and word write.
Both issues were able to reproduce the write error behavior.
  Note: The word write issue is able to reproduce now also.

Those were resolved by using chip_good() instead to check the state.

> This can happen as result of intermittent issue with flash. It is
> hard to fall into scenario when testing on limited number of devices
> but with large enough population you can see that.

If possible I would like to know the issue detail and its cause also.

> Another situation
> is when a flash chip reaches its maximum number of writes. So for
> example a chip is designed for 100k writes to a page. Once you
> reach that number of writes you can have invalid data written to
> flash but chip itself reports everything was good and switches to
> "ready" state.

Yes I see.

Regards,
Ikegami

> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf
> Of Sobon, Przemyslaw
> Sent: Friday, February 8, 2019 8:51 AM
> To: ikegami_to@yahoo.co.jp; Boris Brezillon
> Cc: keescook@chromium.org; marek.vasut@gmail.com;
> ikegami@allied-telesis.co.jp; richard@nod.at;
> linux-kernel@vger.kernel.org; joakim.tjernlund@infinera.com;
> linux-mtd@lists.infradead.org; computersforpeace@gmail.com;
> dwmw2@infradead.org; Liu Jian
> Subject: RE: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
> do_write_buffer
> 
> Hi Ikegami,
> 
> I have seen a case myself where a value was written, chip changed
> state to "ready" but when I was reading the value was incorrect.
> This can happen as result of intermittent issue with flash. It is
> hard to fall into scenario when testing on limited number of devices
> but with large enough population you can see that. Another situation
> is when a flash chip reaches its maximum number of writes. So for
> example a chip is designed for 100k writes to a page. Once you
> reach that number of writes you can have invalid data written to
> flash but chip itself reports everything was good and switches to
> "ready" state.
> 
> Hope this explanation is clear. Please let me know.
> 
> Regards,
> Przemek
> 
> > -----Original Message-----
> > From: ikegami_to@yahoo.co.jp <ikegami_to@yahoo.co.jp>
> > Sent: Thursday, February 7, 2019 3:00 PM
> >
> > Hi Przemek-san,
> >
> > Could you please explain the case detail that the value is written
> incorrectly?
> > I think that the value is only written correctly except a bug.
> >
> > Regards,
> > Ikegami
> >
> > --- boris.brezillon@collabora.com wrote --- :
> > > Hi Sobon,
> > >
> > > On Tue, 5 Feb 2019 22:28:44 +0000
> > > "Sobon, Przemyslaw" <psobon@amazon.com> wrote:
> > >
> > > > > From: Boris Brezillon <bbrezillon@kernel.org>
> > > > > Sent: Sunday, February 3, 2019 12:35 AM
> > > > > > +Przemyslaw
> > > > > >
> > > > > > On Fri, 1 Feb 2019 07:30:39 +0800 Liu Jian
> > > > > > <liujian56@huawei.com> wrote:
> > > > > >
> > > > > > > In function do_write_buffer(), in the for loop, there is a
> > > > > > > case
> > > > > > > chip_ready() returns 1 while chip_good() returns 0, so it
> > > > > > > never break the loop.
> > > > > > > To fix this, chip_good() is enough and it should timeout if
> it
> > > > > > > stay bad for a while.
> > > > > >
> > > > > > Looks like Przemyslaw reported and fixed the same problem.
> > > > > >
> > > > > > >
> > > > > > > Fixes: dfeae1073583(mtd: cfi_cmdset_0002: Change write buffer
> > > > > > > to check correct value)
> > > > > >
> > > > > > Can you put the Fixes tag on a single, and the format is
> > > > > >
> > > > > > Fixes: <hash> ("message")
> > > > > >
> > > > > > > Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> > > > > > > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > > > > >
> > > > > > [1]http://patchwork.ozlabs.org/patch/1025566/
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
> > > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > index 72428b6..818e94b 100644
> > > > > > > --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > @@ -1876,14 +1876,14 @@ static int __xipram
> do_write_buffer(struct map_info *map, struct flchip *chip,
> > > > > > >              continue;
> > > > > > >          }
> > > > > > >
> > > > > > > -        if (time_after(jiffies, timeo) && !chip_ready(map,
> adr))
> > > > > > > -            break;
> > > > > > > -
> > > > > > >          if (chip_good(map, adr, datum)) {
> > > > > > >              xip_enable(map, chip, adr);
> > > > > > >              goto op_done;
> > > > > > >          }
> > > > > > >
> > > > > > > +        if (time_after(jiffies, timeo))
> > > > > > > +            break;
> > > > > > > +
> > > > > > >          /* Latency issues. Drop the lock, wait a while and
> retry */
> > > > > > >          UDELAY(map, chip, adr, 1);
> > > > > > >      }
> > > > > >
> > > > >
> > > > > BTW, the patch itself looks good to me. Ikegami, can you confirm
> it does the right thing?
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Boris
> > > > >
> > > >
> > > > One comment to this patch. If value is written incorrectly quickly
> > > > we will be stuck in the loop even though nothing is going to change.
> > > > For example a value was written incorrectly after 1us, the loop was
> > > > set to 1ms, function will return after 1ms, this solution is not
> > > > optimized for performance. I considered same when working on this
> change and decided to do it different way.
> > >
> > > Seems like you're right if we assume that checking for GOOD state does
> > > not require a delay after the READY check, but if that's not the case
> > > and an extra delay is actually required, you might end up with a BAD
> > > status while it could have turned GOOD at some point with the 'check
> > > only for GOOD state until we timeout' approach.
> > >
> > > TBH, I don't know how CFI flashes work, so I'll let you guys sort this
> > > out.
> > >
> > > Regards,
> > >
> > > Boris
> > >
> > > ______________________________________________________
> > > Linux MTD discussion mailing list
> > > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> > >
> >
> >
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

