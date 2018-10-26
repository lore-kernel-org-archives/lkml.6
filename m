Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B103ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DC720831
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="e2TZwEul";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="S4VuniwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DC720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJ0Bx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:53:29 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:53938 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbeJ0Bx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:53:29 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id w9QHAn9o014933
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 18:15:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=rDe3CEEfSK6LaWS3chprLoGWpPwrwv5EOQW75dVZ7/I=;
 b=e2TZwEul2YEIYvRMH9lk/5hCvwxjTOZzT38e1QtfP3UnxxCGd6Zws1E0bagaWah7cq+8
 /XhCqDg1v7pU1ObhR8vArg5jYSJzgLa817RE+Vvaekaokqquq+56bLqUWF9bMPD49bC+
 6lkzE5xC9ILS6RHMvCVZWea0NlVIO2D0PsXvBGSfyDqU2DSjFp1RaPEk7TJhwNGEZsoe
 ayMVGEorgF8Se1wPNxfYLI7HRZ4ZQbVmulbnwC1h5iRNUUVCWfMsGu7GtTe3cM2oG6Fv
 iADI+85K/cRAghfZ1HuLDq3lfPi2huGvQNoUd0/B3vtUx+gm2Honh2dZPjgxPlZIKjnx jg== 
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by mx08-00252a01.pphosted.com with ESMTP id 2na3wssqbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 18:15:37 +0100
Received: by mail-pf1-f199.google.com with SMTP id d7-v6so1231159pfj.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDe3CEEfSK6LaWS3chprLoGWpPwrwv5EOQW75dVZ7/I=;
        b=S4VuniwYt4gDCo8U1SlnDzx7EXugNs9wGGOn6hXohXpGbg/ZuEqbp2jZU3yv+2Mfz1
         orfvChbqShYI3jSMnHHMNcdCzVyqSSOlfeQzxyLxZohb6Sme2QAGBUHHdo2KdjuKjA16
         sj49xOPOhTVGQePOJqwGqovZ0AOij+3mWQhgpxyHikicUcQN0l9zcXTwKNnPDC4tgtUp
         HR0E2guDcSFrIeUqzmpeKc9eTas0BEUxzXoUxNJlyPITXHTXjF3/KR7nC2D1aZZ47Tp4
         5I5sxPA9Q0vc7Z0BW65mLmhaGRmIPkqTp25kJYzjeY7oTm9uHzAxbFtrXDdZ2aYt1x6z
         slvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDe3CEEfSK6LaWS3chprLoGWpPwrwv5EOQW75dVZ7/I=;
        b=sDtqtluyfUQs4yITScktYqp3MBo5qZL7KQSsquYtDJLlE+9nWIPGf8dBiipq29FbeE
         AF/jg1cQ3Zs5Lm9UW8YPUvQcWp9wqnhEuoMxYT3ewNh+vshPKw/swxHlOghqmR0Ej677
         i3S2TLX4qUfJ38uKbbgJTYNXraTap6+Vt+Qgmardh288IYFk4Vlg4aVAIX1xPg1lSc7p
         Mmwmb3Uhxc0hlQ3r+ad7IISQYlv0LDCRy89GN8jVN6lQgGheg/ZaOwMG1RIAlvupjOu3
         D8hnXnlPqZMGG1zEP7E2R8q6toyTFLWBrTStvXpcYtiMk0LqQVh2vNngjlh7uwmLOP+U
         chdw==
X-Gm-Message-State: AGRZ1gIipMbyXyzRQ2KA0ymLeyR6HsqJnmPJzjo1FHRsV6fkwk7vppCA
        YJGgdDPeuRkmyWbxyUJv9I5l6BLL9y3MueesWwfRVManxVYBBonov/b76w4H6M4Rog3I/X2RjWJ
        J/1TS6qd8YMbscdheMUOHOM5bwRtbNHuKGuYYddk=
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10-v6mr4197271pls.245.1540574135367;
        Fri, 26 Oct 2018 10:15:35 -0700 (PDT)
X-Google-Smtp-Source: AJdET5eZs76fiMjAJdTyPtl2jZyHV9ll0Kre/lruBdnOSzO1qYre9aPScBKa+3AO4+2x6h6nSaggSX9Rx68XeuzYBLc=
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10-v6mr4197240pls.245.1540574134967;
 Fri, 26 Oct 2018 10:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de> <20181017101831.b5kvh5jw3sqqhbat@mwanda>
 <87bm7stwhv.fsf@anholt.net> <CALeDE9ORBiWh0aLqv17DGZaWW5BM4Var5C-hO5P-u2OYyqU7HQ@mail.gmail.com>
 <CAAoAYcPyB-Xjh+BfSsUgbmRGP+M3LmHcjxshnDDqB8=JvMrjCg@mail.gmail.com> <f358db9f-1b7f-d0c6-ace5-64b908f08b63@i2se.com>
In-Reply-To: <f358db9f-1b7f-d0c6-ace5-64b908f08b63@i2se.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Fri, 26 Oct 2018 18:15:21 +0100
Message-ID: <CAAoAYcMjr7ZgyNPCjrTuJwJ9DzJUex7DBmU4pR4gajZ3W+LiHg@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>, devel@driverdev.osuosl.org,
        tuomas.tynkkynen@iki.fi, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 at 10:38, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Am 18.10.2018 um 11:22 schrieb Dave Stevenson:
> > On Wed, 17 Oct 2018 at 17:51, Peter Robinson <pbrobinson@gmail.com> wrote:
> >>>>>> Drop various pieces of dead code from here and there to get rid of
> >>>>>> the remaining users of VCHI_CONNECTION_T. After that we get to drop
> >>>>>> entire header files worth of unused code.
> >>>>>>
> >>>>>> I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
> >>>>>> snd-bcm2835 can still play analog audio just fine.
> >>>>>>
> >>>>> thanks and i'm fine with your patch series:
> >>>>>
> >>>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>>>>
> >>>>> Unfortunately this would break compilation of the downstream vchi
> >>>>> drivers like vcsm [1]. Personally i don't want to maintain another
> >>>>> one, because i cannot see the gain of the resulting effort.
> >>>>>
> >>>>> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm
> >>>>
> >>>> I feel like everyone else already knows the answer but why don't we just
> >>>> merge that code into staging?
> >>> Dave's been working on a new VCSM service where the firmware can call
> >>> back into Linux to allocate (instead of just having a permanent carveout
> >>> of system memory that the firmware allocates from), and lets us make
> >>> dma-bufs out of those buffers.  That driver makes a no-copies v4l2 media
> >>> decode driver possible, which would then let Kodi and similar projects
> >>> switch from downstream kernels with closed graphics to upstream kernels
> >>> with open graphics.
> >>>
> >>> Given that the new VCSM service is a rewrite, it's not clear to me that
> >>> importing the old VCSM driver is a win.  But maybe we should go raid
> >>> https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2a and grab
> >>> the new drivers.  Upstreaming the VCHI audio driver to staging has
> >>> clearly been a win for it, so maybe other eyes on the new v4l2 codec
> >>> could help Dave along in stabilizing it.
> >> I think that makes sense as long as the firmware side changes are in
> >> place so it can actually be used.
> > The firmware has supported the necessary for dmabuf import since Sept 2017.
> >
> > The new vcsm driver currently only supports importing from other
> > kernel modules as I cut it back to the bare minimum to ease
> > upstreaming. To be a complete replacement of the existing then it
> > needs to support userspace alloc/free/import/mmap. I did have most of
> > that working, but will add it in stages.
> > The codec code is working for decode but something is off for setting
> > formats on encode.
> > Both drivers are loading through DT at the moment as I couldn't get
> > Eric's platform driver stuff working. IIRC A combination of modules
> > not getting loaded and getting the appropriate coherent DMA mask set
> > (being under soc in DT gives the correct mappings, but being a
> > platform driver didn't).
>
> I'm working on these issues and i will post a proper solution soon.
>
> In case you need a hack in order to test your stuff, i can prepare a
> branch for you.

Thanks Stefan.
I've picked up your latest patches which mean I can get the driver
loaded via the (almost) approved method.
I do seem to still have issues with not getting the expected address
ranges, so the driver/VPU was trying to map cached alias memory. As
your patches only came through yesterday I haven't had a chance to dig
through why yet. I've done a temporary hack to ensure we always map
the uncached alias, but that can't persist.

> >
> > I'm fire-fighting a networking issue at the moment, but hope to be
> > back on codecs next week.
> > Could you hold off raiding my trees until say Fri 26th Oct so I can
> > ensure they are fully up to date? If I get a chance then I'll start
> > the work of porting into staging before then.
>
> The merge window will open soon, so i don't see the need to hurry.

The networking issue has been resolved :-)

I've pushed where I've got to to
https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2b
It's a touch messy due to integrating in your patches in the last 24
hours. It needs a full rebase so that my changes are on top of yours
rather than haphazard.
As we're moving to 4.19 fairly soon I may well abandon my 4.14 tree
and jump to either that or directly on staging. I'll see where I get
to early next week.

  Dave
