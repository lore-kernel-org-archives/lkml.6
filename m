Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1FEC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6325B2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuWp/WtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6325B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeJXWk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:40:29 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34466 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJXWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:40:29 -0400
Received: by mail-yw1-f66.google.com with SMTP id v199-v6so2127225ywg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HuCqK2ARAHcmlEKqmdsiC5mHIpMWzNwmljnZCCYU8T8=;
        b=iuWp/WtNquRQSHgqBmY+aiasvReosGUm5evhj6wjePZWb6fRhXJfKSIXYEMTG5jm32
         slg770pYfImx61Prz04NbJmDV+QXr6L/z471YUd4NX7U7n0FP+jiPf9rSVu/Nh1j9BPR
         95QzqwsxsFe+0zTiLNtGpUc2JuLerqGh+31DEwuam6s6LDgSyPWHPSt4QB7Aj6b4j+6r
         CbEGuptmpDlKTPSdqDlSAqe1NtAiA5hshRRVH0ruAjysjn5dce9IiodbRHQJdva3DPZP
         Yul1u6RYXKJddryeKVP5psbHKRPpSLzINYpAeenJu+6p/393hjn/CywGndgwY+goUjDZ
         S0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HuCqK2ARAHcmlEKqmdsiC5mHIpMWzNwmljnZCCYU8T8=;
        b=XEimXVPFsmgBKLTl5eh5baYzvV7gHIN+Sr5lFNjRhb64PUneT0hw2IcY/XRRHI+goh
         jG6xVA5hptdT7GaCUiJ2hn3XrNrd8Gf5UkIiwv7u7QhQbckAB67iihmrpdsvBXbLxJWJ
         7RMN8YtXENHyKntNCSyXIU0YvpfF9TA5x3y+FbwkWXxv+1WfgMJhajvx91lnQslh1TA4
         gekwBs1cnVSXSqTpi+MtAtgiLZcpbKsZ5ug6xyb483H8I3KiSrafIVn5zJPp7idxI/3H
         bLBgGBEafQAduAb5W6ao89e7XGQTSgxoelHcyotsC9SsV4it9bvOGKo2b6SjG8RQDGqJ
         xQVA==
X-Gm-Message-State: AGRZ1gK/jH2619s1l2Op7z++Bq2WosRxuo0LMMU805HP1X30OvmQICvb
        m2lNSehY3qyDd1bD9QHqpOoW7aVEHDpfp/0UMxo=
X-Google-Smtp-Source: AJdET5fLo1Hx8tt1eHVWftGtaSYRgl7GFt6a6cypOaQbDFctsXEJSIH28nojN68WfOtC9DvcoXuVuWyD1Mdz6Df9iXg=
X-Received: by 2002:a81:5044:: with SMTP id e65-v6mr2397945ywb.392.1540390331125;
 Wed, 24 Oct 2018 07:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181009112837.2517-1-peron.clem@gmail.com> <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
 <CAJiuCceZr8NsDgBJgA2y61VHdQ3JYQ6_3r4jKooKLbVfRD8eJQ@mail.gmail.com>
 <74512aef-d551-30af-b4cf-25f48047a4ac@kernel.org> <20181024065152.yinlj4axprtwdzku@pengutronix.de>
In-Reply-To: <20181024065152.yinlj4axprtwdzku@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 24 Oct 2018 16:11:59 +0200
Message-ID: <CAJiuCcfZ7+gaxA5iGhS48eODPsTaZc5-Bd2zXqaAgtNd0fwSKg@mail.gmail.com>
Subject: Re: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
To:     u.kleine-koenig@pengutronix.de
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Oct 2018 at 08:51, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Oct 23, 2018 at 03:35:31PM -0500, Dinh Nguyen wrote:
> >
> >
> > On 10/23/2018 09:44 AM, Cl=C3=A9ment P=C3=A9ron wrote:
> > > HI Dinh,
> > >
> > > On Tue, 23 Oct 2018 at 16:04, Dinh Nguyen <dinguyen@kernel.org> wrote=
:
> > >>
> > >> Hi Cl=C3=A9ment,
> > >>
> > >> On 10/09/2018 06:28 AM, Cl=C3=A9ment P=C3=A9ron wrote:
> > >>> Cyclone5 and Arria10 doesn't have the same memory map for UART1.
> > >>>
> > >>> Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 =
for Cylone5.
> > >>>
> > >>
> > >> I'm not sure the need for this patch. Are there any cyclone5 based
> > >> boards that has UART1 as the debug uart? I see that all of them are
> > >> using UART0.
> > >
> > > There is no upstream device with this UART used. But the board I have
> > > use it, and there is no limitation to not have it available upstream
> > > no ?
> > >
> >
> > I see. Then I don't think the patch is applicable because none of the
> > upstream devices need it. Now, if you were to upstream your board that
> > uses UART1, then there will be a case for this patch. Do you agree?

I don't think my board is upstreamable it's not a devkit and not
really interesting for the community.

It's really a trivial patch and it will avoid wasting time  to another
owner of CycloneV board who would like to have debug on UART1

Thanks
Clement

>
> I'd not say having to upstream the board is a sensible precondition for
> such a patch. One of the arguments for moving ARM to dt was that this
> allows to separate the machine specifics from the code. So I'd say if
> Cl=C3=A9ment has a need, this is a good enough reason to take this patch.
>
> Just my 0.02 =E2=82=AC,
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
