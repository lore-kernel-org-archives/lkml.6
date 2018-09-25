Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB11C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E092D2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="HxLnF202"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E092D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeIZCZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:25:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36053 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:25:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so6847385ljb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E/TE5dDYMPJ9+lpAsUcAQjjkai2/BLm8ZBmkJRf+kdM=;
        b=HxLnF202cPAcTSQVbQQQsefbduI3S2X0mC1uHiRe598rWhwo216nzPInETYmRR/2me
         nOCvbORW0VVjiculXm96bqCWNnfkr5g1g7WRJ/7ABQ5ZSyQT3vMSjSUZPBQq8ZZoIn5N
         +yTl2AwFCNBoh8yPLXgK1rhL+DYGWmq4vpGytmCOPKl0p2AzsuVyKD02v19MK1F9ZmJ/
         E0BAxemeKpeXMPt3CCHe6/bPTyWZH6Lj1Ec0gJ3atP4LVV+I3fcl42luyOE7CiiNhd6t
         mOhrrEZPGUAqOxMrtOz2Bo0FR9QTQAirMdrdqIJT6bCEpiWA+wbV08kSsRQpdsEIM9Ay
         LRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/TE5dDYMPJ9+lpAsUcAQjjkai2/BLm8ZBmkJRf+kdM=;
        b=njGvS7c7IaHgDnfI2vVJIQnAAzOY4rWFwW0cwUuNSaOqCoL0l+N6AlBx7dv2Zl8W24
         jnnxggt+Ir+lkHH6s8gA1gS3QQKlOpPbLbofVRsxpBYPk/v+WRSFLJM7iA4cJn7QtCdD
         WW5NNab3YFOQY3CfDKRbXH7AmuWRGP8Y86vb458gG4DH/KmbNdn/ILTUw7R7YhAEejrl
         VM4uOdDVDapZ6LDpSEXjtfZzGF1QzV63G6kkW2JAj47OfSVsLscldbYWRptJxm36imSi
         9hDuZJLPjorj4ubPOz6bnQO6lPSEhwztXQJ5tloJOJCnzv3hfAd/uZpORE0sLaSUs46J
         KjwQ==
X-Gm-Message-State: ABuFfojlGG/GywAhTJXmA9CgBTSBOZIo1pO91BinDO0MaPyO1XgADMt0
        O8Rn5VIk97Ffm+jYecvW09p2Sw==
X-Google-Smtp-Source: ACcGV62pe0NpioLAcEL+eTFvTE2dlN7p5cAAzrJnLEPuAVf4OeI/fG+wh5pXPwscg2QW99/ZbT352Q==
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr2047045ljh.68.1537906555050;
        Tue, 25 Sep 2018 13:15:55 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 3-v6sm575963ljs.69.2018.09.25.13.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:15:53 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:25:49 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        arm-soc <arm@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Set ARM/LPC18XX architecture orphan
Message-ID: <20180925192549.4igjjk6s6sjymdl5@localhost>
References: <1537764195-19117-1-git-send-email-daniel.lezcano@linaro.org>
 <CAK8P3a0YjbCHRHaTzev-rwi5qM3aBeFUUObL1dPKww_o_J_2vw@mail.gmail.com>
 <bfffe304-b42c-b2a2-f164-642469aff640@mleia.com>
 <CAK8P3a0mSqO+VFHLMYHYa01HjDxbrZejNkxC8-eHKKpVsGvt3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0mSqO+VFHLMYHYa01HjDxbrZejNkxC8-eHKKpVsGvt3A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 05:42:00PM +0200, Arnd Bergmann wrote:
> On Mon, Sep 24, 2018 at 5:19 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
> > On 09/24/2018 04:19 PM, Arnd Bergmann wrote:
> > > On Mon, Sep 24, 2018 at 6:43 AM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >> While sending patches around, Joachim Eastwood was Cc'ed but I got an error
> > >> its mailbox was full and the mail can not be delivered which makes me think
> > >> there is no body at the other end of the line.
> > >>
> > >> After doing some statistics, it appears the latest commit as author/commiter
> > >> is:
> > >>
> > >> commit b16ebc017ebf52a81e5e88743ccd68fc25e99ba9
> > >> Author: Joachim Eastwood <manabian@gmail.com>
> > >> Date:   Mon Oct 31 14:45:17 2016 +0000
> > >>
> > >> Remove the maintainer entry and set the component as orphan.
> > >>
> > >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >> Cc: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > I also checked the github account and any other mails I could
> > > find from Joachim, which stopped around the same time.
> > >
> > > I've added the lpc32xx maintainers to Cc, as the two platforms are
> > > related. Maybe they are interested in picking up support for this
> > > as well, and/or merge the two directories into one (there is only
> > > one trivial file in mach-lpc18xx, the rest are drivers).
> > >
> >
> > I'm interested in maintenance of lpc18xx/lpc43xx, I have one board
> > powered by LPC4357, so it would make the maintenance easier for me,
> > also multiple controllers are equal on lpc18xx/lpc43xx and lpc32xx,
> > and thus familiar to me.
> >
> > And I greatly appreciate Joachim's contribution, all platform drivers
> > written by Joachim are of perfect quality.
> >
> > I'll send a patch to MAINTAINERS later on.
> 
> Awesome, thanks for stepping up!

Yeah, that's great! I'll hold off applying this if you think you'll send it in
the next couple of weeks.


Thanks,

-Olof
