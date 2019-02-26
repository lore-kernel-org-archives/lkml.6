Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A867D21852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182380;
	bh=iSxVGfcHyO1/HyIjHx6vacQhEm5qzYAuyQ7UE0/fStc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K53h3e4OyIQS8GMyMqC4M3nck2Q8gnUdeyXL+vJfO/+B3EFkzRGjQgFtdP/TAGZdH
	 ZH4wdUAI/ldo/HMJzblM3K+wNSy8CdSl2uuc+4AfyYqLIIxZoRDxwzF/AjD/ho57d7
	 pXd3drrwQqh6bN7fmjQmHbjIGa3dT061Uu33Bif0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfBZL7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfBZL7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:59:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F095217F5;
        Tue, 26 Feb 2019 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551182377;
        bh=iSxVGfcHyO1/HyIjHx6vacQhEm5qzYAuyQ7UE0/fStc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wx1T8SA/6er/QQaqFw2y4T7hAndXnXcSn3sSu3ZgqHo/jVM2hLx3LxBt0dsJEF+fv
         o3Qf2wSeLgEmJ5ddBrCKvkhNEaABRy+d+ALoUeqge4TF/tnqJy6EI6e+aOs/QJ4Jg4
         HVOYyqAtvFnb0e3jw/ZfxtwVAwvL07oRjiiPd8jE=
Date:   Tue, 26 Feb 2019 12:59:35 +0100
From:   Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     adham.abozaeid@microchip.com, ajay.kathat@microchip.com,
        =?utf-8?B?5LqO5rOi?= <yuzibode@126.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: fix incorrect type in initializer
Message-ID: <20190226115935.GA18727@kroah.com>
References: <20190226060032.26495-1-tsu.yubo@gmail.com>
 <CAKq8=3L5tQNuB1EBjp4osZk83XBX48aWtPN7YiB0sbCg+j6q9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKq8=3L5tQNuB1EBjp4osZk83XBX48aWtPN7YiB0sbCg+j6q9g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 07:29:56PM +0800, Bo YU wrote:
> On Tue, Feb 26, 2019 at 2:00 PM Bo YU <tsu.yubo@gmail.com> wrote:
> 
> > Fix sparse warning following:
> >
> > drivers/staging/wilc1000/host_interface.c:444:49: warning: incorrect type
> > in initializer (different address spaces)
> > drivers/staging/wilc1000/host_interface.c:444:49:    expected struct
> > cfg80211_bss_ies const *ies
> > drivers/staging/wilc1000/host_interface.c:444:49:    got struct
> > cfg80211_bss_ies const [noderef] <asn:4> *ies
> >
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
> >  drivers/staging/wilc1000/host_interface.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/wilc1000/host_interface.c
> > b/drivers/staging/wilc1000/host_interface.c
> > index cdcb52aec779..89ae22d40f71 100644
> > --- a/drivers/staging/wilc1000/host_interface.c
> > +++ b/drivers/staging/wilc1000/host_interface.c
> > @@ -441,7 +441,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss
> > *bss,
> >         const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
> >         const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
> >         int ret;
> > -       const struct cfg80211_bss_ies *ies = bss->ies;
> > +       const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
> >
> >         param = kzalloc(sizeof(*param), GFP_KERNEL);
> >         if (!param)
> > --
> > 2.11.0
> >
> > Hi,
> I do not Ccing wireless-list, Does it matter?

It would be nice to do that in the future.
