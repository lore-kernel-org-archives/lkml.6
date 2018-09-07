Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC804C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F32920869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F32920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIGJyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:54:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59103 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbeIGJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:54:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09726151|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CnYhkKY_1536297295;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CnYhkKY_1536297295)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 07 Sep 2018 13:14:56 +0800
Date:   Fri, 7 Sep 2018 13:14:55 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 13/26] csky: Library functions
Message-ID: <20180907051454.GB13356@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
 <CAMuHMdW3GhYGPnPf0ph=ZbVpNqiYhAsSMni7SKTC1ZC9zTUUxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW3GhYGPnPf0ph=ZbVpNqiYhAsSMni7SKTC1ZC9zTUUxw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:50:02PM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 6, 2018 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > > --- /dev/null
> > > +++ b/arch/csky/abiv1/memset.c
> > > @@ -0,0 +1,38 @@

> > > +       if ((long)d & 0x3)
> > > +               while (l--) *d++ = ch;
> 
> while ((uintptr_t)d & 0x3) && l--)
>         *d++ =ch;
> 
> and remove the else below?
Ok
 
> > > +                       *(((long *)d)+3) = tmp;
> 
> s/long/u32/
Ok

Thx
 Guo Ren
