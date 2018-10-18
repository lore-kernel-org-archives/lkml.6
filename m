Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5650EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12982145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="nBrfHl1x";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="S9RmmmYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12982145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJRRW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:22:58 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:25771 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbeJRRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:22:58 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9I9HoOI011979
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:22:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=IyRLhhvbZ8Ph6Cy6MXWTmebo+RTt9CnBCstKe8alZNM=;
 b=nBrfHl1xtf5HQ6Ym3EsLQag3hGkH0RvBMbteZjqPLjbc8D1YgEZJS3cRJ/ZGknAIULzL
 fE+wHNT1TZ38CqoalmldB5dGp2uEiYHk8oyjPVw3UUBKS2nDf3A/kq0KT8PV+YQqOHyD
 zKFeVbca48l3zhPdmFPAa8VJlL5Ju6VpWA+sVuw49MYnOvkcRph3Oi8McqY8Vxffd5n4
 tSuApewKmhyuiRBQ9sGQQA61rpNDcMsKFZ8uqAKpj9LuMPsCb4tEE7F43ff3yVb1biLJ
 z4D7SqZ+CmbwbvnKgRjXsqJTj+yDYzGP0GEzl/6mh9xjSnNadZNBLiZ42zoxKCWgvxlR iw== 
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by mx07-00252a01.pphosted.com with ESMTP id 2n3641ap2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:22:49 +0100
Received: by mail-pf1-f199.google.com with SMTP id t28-v6so15395490pfk.21
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyRLhhvbZ8Ph6Cy6MXWTmebo+RTt9CnBCstKe8alZNM=;
        b=S9RmmmYk1aRUmIexKwFTpC/+xYjoK/D3mWm/BEQT3uI6XOf1dt+eFD5fz/KkccsSZ3
         9CBJClpkqsv+Y9G0lam2xA1yl6x8iLI/uehoiYJSaCpvrWFr0wNg8+pL/yeqq2jPOyMy
         +Gyx/aXNfr3UM8i5zzsbyfVz1QGAktSDJC0yoGXaDIn18qOI2274guhrXgsIlUOWzPTK
         d9xSusqY+OKI62IaG2z1ErLIXN6kug7In4zM3sgTsERoee/67KAmIvX4HM84r7ro2fA3
         ZoMh53maD9/uMGuOgrqOWiZJpEkWA3lT5fIcFijslVkI0ncw/s+9PnN3JTBFFWOLuREj
         kstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyRLhhvbZ8Ph6Cy6MXWTmebo+RTt9CnBCstKe8alZNM=;
        b=qn0+RilHh50FTts7vLlhn7rlPoEQaBzPacimWV7eMCUgD7XQC4tOL6l3NO7JjyMdpB
         3eYVPwr5e13HQe8hfvy1uB02jnvoXeRjh2vxRtxHUnRQXDviHrRc9A8ZsbA8LfKPZ8iz
         xnCHo2Kn4W/VGbpo/+9XPtnJfRzhD8D/JUU1ckP8ReKKBVqpOfyDvLo7cmyn6BYZinWp
         5gaFkrCsO5TbJ10NxVpyH3P+ZSoV3PxnhQxCQpstnL0K+392dYv30s/G8c8B+6nSEYOh
         +RhIFyjGG+9o0DmRpvBESSwy3CexAbQ4//J/zT7odzq7eISytocncixby/viT/se/C8A
         clrA==
X-Gm-Message-State: ABuFfoir0+DcXH4iXQHGpNhh4bQ8gaMPBsU2ZAiYr/7w4DL/t3ui7tSb
        w33cgzV/G18IMjt6bqKpiL/Mfm3vP9YJRwzSI8Xl2i4BvIuKAz1z+Te91zqSidImR/dXxYb0Qpn
        ficR8OlB+r02Pw7aY1YrKnWTYrkbJQZHPU7WfjgI=
X-Received: by 2002:a62:5441:: with SMTP id i62-v6mr30013231pfb.155.1539854566961;
        Thu, 18 Oct 2018 02:22:46 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61ItC99QQhPspnFeW5e6oR3/3A2ttV2U2Ah4bf/34VpGx2HLUR7c44J23IiHVPIL8nv1IfCTfkwIocpm/MSnHk=
X-Received: by 2002:a62:5441:: with SMTP id i62-v6mr30013211pfb.155.1539854566660;
 Thu, 18 Oct 2018 02:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de> <20181017101831.b5kvh5jw3sqqhbat@mwanda>
 <87bm7stwhv.fsf@anholt.net> <CALeDE9ORBiWh0aLqv17DGZaWW5BM4Var5C-hO5P-u2OYyqU7HQ@mail.gmail.com>
In-Reply-To: <CALeDE9ORBiWh0aLqv17DGZaWW5BM4Var5C-hO5P-u2OYyqU7HQ@mail.gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Thu, 18 Oct 2018 10:22:32 +0100
Message-ID: <CAAoAYcPyB-Xjh+BfSsUgbmRGP+M3LmHcjxshnDDqB8=JvMrjCg@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
To:     pbrobinson@gmail.com
Cc:     Eric Anholt <eric@anholt.net>, devel@driverdev.osuosl.org,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, tuomas.tynkkynen@iki.fi,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-17_15:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 at 17:51, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > >> > Drop various pieces of dead code from here and there to get rid of
> > >> > the remaining users of VCHI_CONNECTION_T. After that we get to drop
> > >> > entire header files worth of unused code.
> > >> >
> > >> > I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
> > >> > snd-bcm2835 can still play analog audio just fine.
> > >> >
> > >>
> > >> thanks and i'm fine with your patch series:
> > >>
> > >> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> > >>
> > >> Unfortunately this would break compilation of the downstream vchi
> > >> drivers like vcsm [1]. Personally i don't want to maintain another
> > >> one, because i cannot see the gain of the resulting effort.
> > >>
> > >> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm
> > >
> > >
> > > I feel like everyone else already knows the answer but why don't we just
> > > merge that code into staging?
> >
> > Dave's been working on a new VCSM service where the firmware can call
> > back into Linux to allocate (instead of just having a permanent carveout
> > of system memory that the firmware allocates from), and lets us make
> > dma-bufs out of those buffers.  That driver makes a no-copies v4l2 media
> > decode driver possible, which would then let Kodi and similar projects
> > switch from downstream kernels with closed graphics to upstream kernels
> > with open graphics.
> >
> > Given that the new VCSM service is a rewrite, it's not clear to me that
> > importing the old VCSM driver is a win.  But maybe we should go raid
> > https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2a and grab
> > the new drivers.  Upstreaming the VCHI audio driver to staging has
> > clearly been a win for it, so maybe other eyes on the new v4l2 codec
> > could help Dave along in stabilizing it.
>
> I think that makes sense as long as the firmware side changes are in
> place so it can actually be used.

The firmware has supported the necessary for dmabuf import since Sept 2017.

The new vcsm driver currently only supports importing from other
kernel modules as I cut it back to the bare minimum to ease
upstreaming. To be a complete replacement of the existing then it
needs to support userspace alloc/free/import/mmap. I did have most of
that working, but will add it in stages.
The codec code is working for decode but something is off for setting
formats on encode.
Both drivers are loading through DT at the moment as I couldn't get
Eric's platform driver stuff working. IIRC A combination of modules
not getting loaded and getting the appropriate coherent DMA mask set
(being under soc in DT gives the correct mappings, but being a
platform driver didn't).

I'm fire-fighting a networking issue at the moment, but hope to be
back on codecs next week.
Could you hold off raiding my trees until say Fri 26th Oct so I can
ensure they are fully up to date? If I get a chance then I'll start
the work of porting into staging before then.

  Dave
