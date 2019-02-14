Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412DE21902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfBNBeV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:34:21 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:53852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728073AbfBNBeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:34:21 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 846197B2D9206E023798;
        Thu, 14 Feb 2019 09:34:18 +0800 (CST)
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.114]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 09:34:16 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Tokunori Ikegami <ikegami.t@gmail.com>,
        "'Sobon, Przemyslaw'" <psobon@amazon.com>,
        'Boris Brezillon' <boris.brezillon@collabora.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joakim.tjernlund@infinera.com" <joakim.tjernlund@infinera.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ikegami_to@yahoo.co.jp" <ikegami_to@yahoo.co.jp>
Subject: RE: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Topic: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Index: AQHUuWkt1Ktbb1R8x0aeT193FccfoKXNO3aAgAACWYCABA2QAIACQc+AgADriICAAA4wAIAA9AiAgAkb77A=
Date:   Thu, 14 Feb 2019 01:34:16 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D026236F3@DGGEMM528-MBX.china.huawei.com>
References: <1548977439-318904-1-git-send-email-liujian56@huawei.com>
 <20190203092645.18d1495b@bbrezillon> <20190203093509.269bf1e1@bbrezillon>
 <acd16b85676e4d1d89f3acfbeda30107@EX13D07UWA001.ant.amazon.com>
 <20190207095635.0fc3b411@kernel.org>
 <193621849.44066.1549580387922.JavaMail.yahoo@mail.yahoo.co.jp>
 <632ed76bd3844ceab75066d1f30a7115@EX13D07UWA001.ant.amazon.com>
 <149101d4bfb9$fdc5a330$f950e990$@gmail.com>
In-Reply-To: <149101d4bfb9$fdc5a330$f950e990$@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.97.126]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Best Regards,
liujian


> -----Original Message-----
> From: Tokunori Ikegami [mailto:ikegami.t@gmail.com]
> Sent: Friday, February 08, 2019 10:24 PM
> To: 'Sobon, Przemyslaw' <psobon@amazon.com>; 'Boris Brezillon'
> <boris.brezillon@collabora.com>
> Cc: keescook@chromium.org; marek.vasut@gmail.com; richard@nod.at;
> linux-kernel@vger.kernel.org; joakim.tjernlund@infinera.com;
> linux-mtd@lists.infradead.org; computersforpeace@gmail.com;
> dwmw2@infradead.org; liujian (CE) <liujian56@huawei.com>;
> ikegami_to@yahoo.co.jp
> Subject: RE: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
> do_write_buffer
> 
> Hi Przemek-san,
> 
> Thank you so much for your explanation.
> 
> > I have seen a case myself where a value was written, chip changed
> > state to "ready" but when I was reading the value was incorrect.
> 
> I also know the similar issues for the both buffer and word write.
> Both issues were able to reproduce the write error behavior.
>   Note: The word write issue is able to reproduce now also.
> 
> Those were resolved by using chip_good() instead to check the state.
> 
> > This can happen as result of intermittent issue with flash. It is hard
> > to fall into scenario when testing on limited number of devices but
> > with large enough population you can see that.
> 
> If possible I would like to know the issue detail and its cause also.
> 
> > Another situation
> > is when a flash chip reaches its maximum number of writes. So for
> > example a chip is designed for 100k writes to a page. Once you reach
> > that number of writes you can have invalid data written to flash but
> > chip itself reports everything was good and switches to "ready" state.
> 
> Yes I see.
> 
> Regards,
> Ikegami
> 
> > -----Original Message-----
> > From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On
> > Behalf Of Sobon, Przemyslaw
> > Sent: Friday, February 8, 2019 8:51 AM
> > To: ikegami_to@yahoo.co.jp; Boris Brezillon
> > Cc: keescook@chromium.org; marek.vasut@gmail.com;
> > ikegami@allied-telesis.co.jp; richard@nod.at;
> > linux-kernel@vger.kernel.org; joakim.tjernlund@infinera.com;
> > linux-mtd@lists.infradead.org; computersforpeace@gmail.com;
> > dwmw2@infradead.org; Liu Jian
> > Subject: RE: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
> > do_write_buffer
> >
> > Hi Ikegami,
> >
> > I have seen a case myself where a value was written, chip changed
> > state to "ready" but when I was reading the value was incorrect.
> > This can happen as result of intermittent issue with flash. It is hard
> > to fall into scenario when testing on limited number of devices but
> > with large enough population you can see that. Another situation is
> > when a flash chip reaches its maximum number of writes. So for example
> > a chip is designed for 100k writes to a page. Once you reach that
> > number of writes you can have invalid data written to flash but chip
> > itself reports everything was good and switches to "ready" state.
> >
> > Hope this explanation is clear. Please let me know.
> >
> > Regards,
> > Przemek
> >
> > > -----Original Message-----
> > > From: ikegami_to@yahoo.co.jp <ikegami_to@yahoo.co.jp>
> > > Sent: Thursday, February 7, 2019 3:00 PM
> > >
> > > Hi Przemek-san,
> > >
> > > Could you please explain the case detail that the value is written
> > incorrectly?
> > > I think that the value is only written correctly except a bug.
> > >
> > > Regards,
> > > Ikegami
> > >
> > > --- boris.brezillon@collabora.com wrote --- :
> > > > Hi Sobon,
> > > >
> > > > On Tue, 5 Feb 2019 22:28:44 +0000
> > > > "Sobon, Przemyslaw" <psobon@amazon.com> wrote:
> > > >
> > > > > > From: Boris Brezillon <bbrezillon@kernel.org>
> > > > > > Sent: Sunday, February 3, 2019 12:35 AM
> > > > > > > +Przemyslaw
> > > > > > >
> > > > > > > On Fri, 1 Feb 2019 07:30:39 +0800 Liu Jian
> > > > > > > <liujian56@huawei.com> wrote:
> > > > > > >
> > > > > > > > In function do_write_buffer(), in the for loop, there is a
> > > > > > > > case
> > > > > > > > chip_ready() returns 1 while chip_good() returns 0, so it
> > > > > > > > never break the loop.
> > > > > > > > To fix this, chip_good() is enough and it should timeout
> > > > > > > > if
> > it
> > > > > > > > stay bad for a while.
> > > > > > >
> > > > > > > Looks like Przemyslaw reported and fixed the same problem.
> > > > > > >
> > > > > > > >
> > > > > > > > Fixes: dfeae1073583(mtd: cfi_cmdset_0002: Change write
> > > > > > > > buffer to check correct value)
> > > > > > >
> > > > > > > Can you put the Fixes tag on a single, and the format is
> > > > > > >
> > > > > > > Fixes: <hash> ("message")
> > > > > > >
> > > > > > > > Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> > > > > > > > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > > > > > >
> > > > > > > [1]http://patchwork.ozlabs.org/patch/1025566/
> > > > > > >

So, do I need to send a v2 patch? Or use Przemyslaw's new patch http://patchwork.ozlabs.org/patch/1038395/

> > > > > > > > ---
> > > > > > > >  drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
> > > > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > > b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > > index 72428b6..818e94b 100644
> > > > > > > > --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > > +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > > > > > > @@ -1876,14 +1876,14 @@ static int __xipram
> > do_write_buffer(struct map_info *map, struct flchip *chip,
> > > > > > > >              continue;
> > > > > > > >          }
> > > > > > > >
> > > > > > > > -        if (time_after(jiffies, timeo) && !chip_ready(map,
> > adr))
> > > > > > > > -            break;
> > > > > > > > -
> > > > > > > >          if (chip_good(map, adr, datum)) {
> > > > > > > >              xip_enable(map, chip, adr);
> > > > > > > >              goto op_done;
> > > > > > > >          }
> > > > > > > >
> > > > > > > > +        if (time_after(jiffies, timeo))
> > > > > > > > +            break;
> > > > > > > > +
> > > > > > > >          /* Latency issues. Drop the lock, wait a while
> > > > > > > > and
> > retry */
> > > > > > > >          UDELAY(map, chip, adr, 1);
> > > > > > > >      }
> > > > > > >
> > > > > >
> > > > > > BTW, the patch itself looks good to me. Ikegami, can you
> > > > > > confirm
> > it does the right thing?
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Boris
> > > > > >
> > > > >
> > > > > One comment to this patch. If value is written incorrectly
> > > > > quickly we will be stuck in the loop even though nothing is going to
> change.
> > > > > For example a value was written incorrectly after 1us, the loop
> > > > > was set to 1ms, function will return after 1ms, this solution is
> > > > > not optimized for performance. I considered same when working on
> > > > > this
> > change and decided to do it different way.
> > > >
> > > > Seems like you're right if we assume that checking for GOOD state
> > > > does not require a delay after the READY check, but if that's not
> > > > the case and an extra delay is actually required, you might end up
> > > > with a BAD status while it could have turned GOOD at some point
> > > > with the 'check only for GOOD state until we timeout' approach.
> > > >
> > > > TBH, I don't know how CFI flashes work, so I'll let you guys sort
> > > > this out.
> > > >
> > > > Regards,
> > > >
> > > > Boris
> > > >
> > > > ______________________________________________________
> > > > Linux MTD discussion mailing list
> > > > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> > > >
> > >
> > >
> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/

