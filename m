Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F289C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD5A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvabOtmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD5A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJ2Xp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:45:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38699 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJ2Xp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:45:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so4154743pfi.5;
        Mon, 29 Oct 2018 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IusJJhakUU7MEBNIT7tc+H0KmzYjjL0B/+9I2KbAtxI=;
        b=uvabOtmE6T0kbxa/+gfZEsVGF0gujpx6ykjkjpF8GL6OgevsLWRKWwFTfuMuecAsy9
         FIdJo6WgN1WHut5scspyLXk6TGCImVG039Q0djUkTRlDTln8T+M/Lz8UTZgWSkGksSAr
         /oEQngHxTA8ENodCM/GjQ0uf2eAsm7bvWn8+KBNx+Oze4/89zkW5ZysRjaKYTRN1TotX
         mhlkTqX5kfX1JX0N+fmbE+YHUWtfwHjZ5LMMpQA8oACC0WtK0Vvj3zq5WMKMbFilTVYF
         q4ZJBlUhUj/F+17g7heJrDNVY4pd8rJWhadhxisLSNVlAyGibjgn+TqqHeXaK+Ib2Uks
         C2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IusJJhakUU7MEBNIT7tc+H0KmzYjjL0B/+9I2KbAtxI=;
        b=aSTpBGee3rbhn6jacbM7/zCMJpkroYVXrtzIgbABqliBB4yze41YAgMr6pLTgxFFGe
         /dhxntnx5u4EtByIJaOZMLk4wqCgEAWsdHJcbifJNq7Yk1zgUzqm5dJZf42upukWRWNg
         9ujhQxme7Yc/6eA66LmsIcxsKS+K3KhlJZnqXeODb73uWEJh6JD3JkQWkaxzPLJRmDu6
         yAiZWm+Hmgf+qBR8LnzvM579I+ihUzMmHI7LDEeF7+4SmoLmlSnzJf3ACcYRnUs6KqO1
         dqhQwLTW7hVe2dc+WZ28oveft9d/LMk0nyJPyx7hwqrxHlpAKzp4479Rdl+NBfH9umK8
         k5Nw==
X-Gm-Message-State: AGRZ1gKHljZ/ZupEP6PP2zk2uA9xN07GBEmVd9LdysIJ36ptfyQbhcS3
        ps3m6asnVEMTQyLDV1JEeak=
X-Google-Smtp-Source: AJdET5eWsXYzCCa0JG4ArfA7fYB4rnV+4huLKls3Sh6EHsmFV5N+ra3agWyA9AtC0se0g/GsQbfNcw==
X-Received: by 2002:a63:504d:: with SMTP id q13mr6831159pgl.319.1540825018797;
        Mon, 29 Oct 2018 07:56:58 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id i13-v6sm5537111pgs.51.2018.10.29.07.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 07:56:58 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:56:56 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Message-ID: <20181029145655.vzlhz7dipzmpw52m@mail.google.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-5-changbin.du@gmail.com>
 <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com>
 <20181028125106.azcn2dxia3snplin@mail.google.com>
 <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
 <20181028131357.parhzj32feapxncb@mail.google.com>
 <CAK7LNAQ0iZDHP8zQZ_Ws4Wy4H6rwiV5p-A0bM1yVJLP51sqQeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ0iZDHP8zQZ_Ws4Wy4H6rwiV5p-A0bM1yVJLP51sqQeg@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:01:44PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> On Sun, Oct 28, 2018 at 10:14 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > On Sun, Oct 28, 2018 at 10:09:21PM +0900, Masahiro Yamada wrote:
> > > Hi Changbin,
> > >
> > > On Sun, Oct 28, 2018 at 9:52 PM Changbin Du <changbin.du@gmail.com> wrote:
> > >
> > > > >
> > > > Thanks for pointing this out and kind suggestions. I have tested with your
> > > > modification. Will update patch serias soon.
> > >
> > >
> > > I have one more request.
> > >
> > > The patch subject
> > > "kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
> > > optimization"
> > > is too long (83 characters)
> > >
> > >
> > > I'd like the subject to be within 70 columns or so.
> > >
> > oh, I just sent new version. Could me update the title if there are more
> > suggestions then?
> 
> 
> 
> How about this?
> 
> 2/4: kernel hacking: add a config option to disable compiler auto-inlining
> 3/4: ARM: mm: fix build error in fix_to_virt with -Og optimization level
> 4/4: kernel hacking: support building kernel with -Og optimization level
> 
> (The CONFIG name is so long that the subject
> would easily exceeds 80-columns with it.)
> 
> 
> I applied this series to linux-kbuild,
> and will send another pull request in this MW.
> 
> 
> If you come up with better patch titles,
> please let me know.
> I will fix them up locally.
>
I am just fine with these new titles. Thanks.

> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
