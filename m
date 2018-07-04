Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7211824391
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="V87dLcWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7211824391
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeGDPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:33:45 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:45795 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDPdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:33:44 -0400
Received: by mail-oi0-f46.google.com with SMTP id m2-v6so11427547oim.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/NjUOovoztSnetsIj/owgAl7/ESNDLGT5dy1sHazB3A=;
        b=V87dLcWl+4FeOU14EhBAyO3IonMPCNKRdKTCrcHIhdnQKdqFruOT+ERgxWmP9Azalb
         iw2Q2UMeSCO/aBcTStfwkyzu4MxyasrUuvZQ55VArmjlOSMVGQcOlAwYPdiwrTLIIIgN
         XfwYq4QouKMVb7B2Peqd18e/+JgfL50PLeRuLYhbV6Ppvw7PVaYt47auIWMB7MHoxiAP
         7/+J1jXeI/nl4Kk1HjjLKlr5SnQULi2ggagX++qK+dMRDpRf8eBqg5U0j6ZBP4i3Mt7l
         YsNdUh3Xg6BP08Z0B8X5C95RNorFdXRRsVku/dC24HyONAxyonVnWCx3GtxFlpGZ/Xrk
         GoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/NjUOovoztSnetsIj/owgAl7/ESNDLGT5dy1sHazB3A=;
        b=XHy/msLX12ND1zaCPo6RLzomOuky/WnCitA4TqYY6GBgTLMfGulndB3sLh+fKV/lwR
         ADeOhWMuqasUfMi0/9rJpuCBSXUF8sRUxhsoJ2jFV3BSxFJA6e85FkFNxDuw2pvdnlZv
         VSiWAbfloUTf9eVl8NoyL0F09nOti1j6BFjaXvayo3+HkuVMCTOmUDonYgs6jMBJzGkR
         8SfgVZneJ4pr86IhWxlGT3TU3TossHpkbOs5Xb2348m4FQp7d2+HgBi1bEY/uBHY5c+y
         ekTr3VCSiECciHZ6whM5fgt+em/ZaYr7SMAmonhRq9MbEXvxGHCEIyPdDF7pxQ8NvhmI
         W1uw==
X-Gm-Message-State: APt69E00B+UmUJJkHKPxJAn1iieJT5P8NSdJjwrsnSVImVF3tsEJxjQy
        RmJMl/RknsgtufLluma1Mj0shR8GZnY3S6umZn9/pA==
X-Google-Smtp-Source: AAOMgpdzSz3JQNjM7sTLXYC5MD68thru1i1bNCHKkYwy75Zxg+Ah77TBgziIhIkIpfxsUJLRuhzb9c8bgrY4SHC8CpQ=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr2948529oif.9.1530718423354;
 Wed, 04 Jul 2018 08:33:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3e18:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 08:33:42 -0700 (PDT)
In-Reply-To: <7e95bd6a-97bc-b030-26ce-83da66e5f279@lwfinger.net>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
 <f3bf0687-76fb-9411-6fa2-e8ef312efb58@lwfinger.net> <20180704140933.3dk2ylbntltz6jqd@mwanda>
 <7e95bd6a-97bc-b030-26ce-83da66e5f279@lwfinger.net>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 4 Jul 2018 10:33:42 -0500
Message-ID: <CAD8Lp44EG73XQ9omQhH6XiHfm2rMypmndSFyffnf_PVMueTvEA@mail.gmail.com>
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        devel@driverdev.osuosl.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>, yhchuang@realtek.com,
        birming@realtek.com,
        "shaofu@realtek.com >> shaofu" <shaofu@realtek.com>,
        steventing@realtek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 10:13 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> We will have to agree to disagree.
>
> I have no idea what the vendors are doing that cause some motherboards to
> need a different aspm value. What I do know is that we have had to live with
> the idiocy of some vendors saving a few pennies by only including a single
> antenna, rather than two, and then making a problem by miscoding the EFUSE
> bit that indicates which connector is actually in use. As we have no means
> that I know about to detect which boxes have the problem, a module parameter
> was created, just as in this case.
>
> I agree that drivers should work "out of the box", but finite resources and
> lack of vendor cooperation make this a goal that may not be attainable.

As you touched on, the ideal situation is that Realtek solve the
issue. Ping-Ke Shih is on CC and I am adding a few more contacts from
the commit log. The context is that the r8822 driver fails on several
platforms unless setting aspm=0 (the default is 1).

https://gist.github.com/dsd/20c05f0c6d66ee2ef9bfbb17f93f18ba
https://bugzilla.kernel.org/show_bug.cgi?id=199651


If we don't get a timely fix from Realtek though, I think there is a
key difference between the antenna selection headache and this one. In
the antenna case, there isn't a good value that you can set that will
work on all systems. If you change the default behaviour you will
solve the issue for some users while simultanously introducing the
problem on other systems that were previously fine.

However in this case, it's highly likely that setting aspm=0 (off) by
default would work for everyone. It has the disadvantage of using a
bit more power, but especially with the indications that this issue
affects a significant number of systems, I think that having the
driver working out of the box everywhere is more important. The module
parameter can be left in place so that unaffected users that want to
save power can set aspm=1.

Daniel
