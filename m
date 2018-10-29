Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F7C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2A82084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="v+MOaEQi";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="OJ6dGe9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2A82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeJ2TcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:32:11 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:34290 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729230AbeJ2TcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:32:11 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id w9TAcIwr030437
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=UrwfPLYXeu9ymTLkwh2LbQpvcEYouGLoT5f26LmcQFM=;
 b=v+MOaEQidAxB8qUoqkrEyeAmrIYF20nNG90EERvzCgDEkizvJZktz0edIvQP3Wvao4HA
 4H3r+gjttCIZWqgbblQZ6kK9dYVfldnt7KT70H6ooT8Tc2CG7V7vAsRcJmwwCFoa2xQD
 rlnOy4aLQEmt/aAbgfShGLcLLvaF8iwq8o5EMeXh/yLasS2p/qLtO2tSs5FzhSlYAKTh
 4gUunWcFASaazi3Zcdhtmm515Sq5iY9wvj3ctY13WxnEKNPKl1ltV9rKeVERCubD6V1H
 oUEZs0jwCGPZsdyzeRBNBdhitUes5dzVDhFN0d3ZkuyGJG9o2ecsRZfnjJhBtljiqEhA wQ== 
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by mx08-00252a01.pphosted.com with ESMTP id 2nccgfh20d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:44:02 +0000
Received: by mail-pf1-f200.google.com with SMTP id i81-v6so7169705pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrwfPLYXeu9ymTLkwh2LbQpvcEYouGLoT5f26LmcQFM=;
        b=OJ6dGe9ThFSanRgIysmtrN9T8JxizCsOvf9YXesGtZk3oS3qV7Fy76gAxMwDaX+o0X
         5GKveESIpWqIiAxaqlESCzkLObBvd9leZCPJkITjThc9wkBl7LE9PRLw5Id33qix39Ji
         R1yanbJ5UtcBbs1jMPcckR4fp2zRTLuzEgW/2TrGDdfgRQGnsDnwd+VZZErCYOMRfvSF
         7V8F++tx8PvH8T/oVFLfrNEoon11PREwWKgodN01oHtotdAWeI1FWvxmNPbXy3IoEvgt
         f0QS3NLrgQjzF+ca8DZvmE6vl93t4DdUBenNNC0RlDLTPMylzk37OnZyW1JQiSUJtJVp
         4R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrwfPLYXeu9ymTLkwh2LbQpvcEYouGLoT5f26LmcQFM=;
        b=NbtJ4gL0ykIt7Nb8NSF+GRcboIKRqvLFMhpZ2JZpwRcOafC3MWpxnSLazXJtMT2X9E
         phvy7ct5xtS8eWziiQDkI6zOOzUdvYg6U/11+TUimEvPLe5OIcn/YvbJpPObpbHSrRLl
         ICrvrmczuUr35FQ3fTGRnsD7RFkzFejUm3O1l9bkLP75Y4lrh/MYPZ/X6W4Sc6cxRGlr
         0I0rSbkMbyprFa1PcE8jxUeDtS6r2fIRO0TvtAjfM1sPU5NUmSwkBAi8MIu7vh8gZCSR
         SqxhJa65lREtykKIngjIyWTXz/0tcLaLs8gVY5gF+vn1ptVENLjqnSo2jhwBdJ7+Hdr7
         iqCA==
X-Gm-Message-State: AGRZ1gJXcmYg5XFWLWnGn/24N1I3zIiX+LrDGNW1fPk3Qtjkp5eb0lh5
        +gCiyK9bOFPFfNXi83oGxdmoAbJ0lpidHXurj9y12dIKxa3+NfJRYvq8hj97Zjgcndld35ylELV
        XSqPcyYA8DsjBOMtrYXeZ0eq2rxonfJdrZgeNNJU=
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10-v6mr13361304pls.245.1540809840394;
        Mon, 29 Oct 2018 03:44:00 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dBM48jzVvt/j0i4uYReHrCpPCftvGgj/jyiyyRbJGNHPE6nEh5AriC6fBxdeiF7JXXzgZ4OpaVJpvT0bALcF8=
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10-v6mr13361282pls.245.1540809839968;
 Mon, 29 Oct 2018 03:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de> <20181017101831.b5kvh5jw3sqqhbat@mwanda>
 <87bm7stwhv.fsf@anholt.net> <CALeDE9ORBiWh0aLqv17DGZaWW5BM4Var5C-hO5P-u2OYyqU7HQ@mail.gmail.com>
 <CAAoAYcPyB-Xjh+BfSsUgbmRGP+M3LmHcjxshnDDqB8=JvMrjCg@mail.gmail.com>
 <f358db9f-1b7f-d0c6-ace5-64b908f08b63@i2se.com> <CAAoAYcMjr7ZgyNPCjrTuJwJ9DzJUex7DBmU4pR4gajZ3W+LiHg@mail.gmail.com>
 <1503865704.281328.1540715494361@email.1und1.de>
In-Reply-To: <1503865704.281328.1540715494361@email.1und1.de>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Mon, 29 Oct 2018 10:43:46 +0000
Message-ID: <CAAoAYcO293gnvk5cYeNR=wiA6Waq2h=buC0hSGzEbCOMwT4teg@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>, devel@driverdev.osuosl.org,
        tuomas.tynkkynen@iki.fi, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        nsaenzjulienne@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

On Sun, 28 Oct 2018 at 08:31, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Dave,
>
> > Dave Stevenson <dave.stevenson@raspberrypi.org> hat am 26. Oktober 2018 um 19:15 geschrieben:
> >
> >
> > Thanks Stefan.
> > I've picked up your latest patches which mean I can get the driver
> > loaded via the (almost) approved method.
> > I do seem to still have issues with not getting the expected address
> > ranges, so the driver/VPU was trying to map cached alias memory. As
> > your patches only came through yesterday I haven't had a chance to dig
> > through why yet. I've done a temporary hack to ensure we always map
> > the uncached alias, but that can't persist.
>
> does it mean with DT probing it worked before and with platform change it's broken?
> Or anything else cause this regression in 4.19?

Yes, probing via DT with the node under soc gave me the correct DMA
addresses (uncached alias). With the platform changes I get the cached
alias.
Both were under 4.14. I'll try again on a later branch.

> > The networking issue has been resolved :-)
> >
> > I've pushed where I've got to to
> > https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2b
> > It's a touch messy due to integrating in your patches in the last 24
> > hours. It needs a full rebase so that my changes are on top of yours
> > rather than haphazard.
> > As we're moving to 4.19 fairly soon I may well abandon my 4.14 tree
> > and jump to either that or directly on staging. I'll see where I get
> > to early next week.
>
> Sorry, but there is no need for a quick shot against a downstream 4.14. I assumed you make your changes against upstream linux-next + Phil's and my patches.
>
> You can use https://github.com/anholt/linux/commits/bcm2835-audio until 4.20-rc1 is out.
> Using 4.14 or 4.19 doesn't make any sense to me.

As an employee of Raspberry Pi Trading my first responsibilty is to
them, and that means LTS releases feeding in to the downstream kernel.
If these drivers can be pushed upstream then that's a win as it avoids
divergence, but it is not my main goal. At least 4.19 and 4.20 aren't
far apart so there are likely to be fewer differences.

I had it all working on 4.14, therefore it made sense to see whether
your changes allowed me to load as a platform driver. It did, but with
this little niggle over cache aliases. I'll try again on a later
kernel and try to get some more info.

  Dave
