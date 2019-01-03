Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A87AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FBC208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolivas-org.20150623.gappssmtp.com header.i=@kolivas-org.20150623.gappssmtp.com header.b="0dhz8+tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfACXQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:16:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51392 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfACXQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:16:55 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so47655179ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kolivas-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqPG/2FkWa5IrnD0rf3tmDqk7Rwj+xBM62Kj2sLGdME=;
        b=0dhz8+tWEI1gx7ESudnKeE6i0I1H3BoxC2WVkclBam0MuSAs8HJoiObLLcFwwG/UNq
         6npf3/6b04N2Do0/s72TwuHI3FslbwZwf2Z0V+JOriQVUYlS4/taQjx7PvhE2CmBr20S
         MX9R5+muQDDNgcSnu0bZBfLRF8Uyb9kLmp6sbLGfeoFykd9kjIhaFLHplAtiIWxZMrZw
         j3qQdb/li/vQ0G2MOeagdtuMbwGzX03t4mk0u2uuCft5nBppM5AP2M3zYehrJuluwtvs
         kYe8NHde/ZnpxdktWipQLJu9vLh5HeRNnAxrgmNEczItA9vfVquOpAq1/oER3UX+EQZf
         rB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqPG/2FkWa5IrnD0rf3tmDqk7Rwj+xBM62Kj2sLGdME=;
        b=gD9saROyAmJFhnnVdkdPKaieVMFY1V5xpyN278eR4Ovn0jEgAIR90SxSZb8JWlLLL8
         s/xHACRFmPaeGVmppRKEHRQ64UFru1tEv4PyIGFPYj+vTnkI1nAt99tVSaohMB35iech
         B5HiZXE8zZ+u/p4IahoKFViTP7skpVXeDfLwzZnA0iQAgZzaUjhICvPO4EPu5F3U2EYq
         NCZPrbfinJ9QbAq04DiB8J340Ze5l8WHjah2YI2YOgisbJFyTkKeApS3+ga9pP4ZKLoc
         27ZwD93CCTrJf/o7w8YexFSqALZFbysz1O5s0REAkhGa3XjB9wxqxb6Ek2wvQppltWh7
         5JbQ==
X-Gm-Message-State: AJcUukcsUMDM2lg94rPuaP+N3J08bCQCj3E6ocq5v3q/uxHZxxIZr+Xn
        YIwjb/lsFjfRAjx3xxZx8ODmcF6Dnt+hySDtKILyeA==
X-Google-Smtp-Source: ALg8bN7lDJHMEEz9DbIckCO6766QsfsKQu2BzeLO/d3YKdzRRfC0icA9HMrH7fAd0XJm+4AGFz+CUI8psXsCJU5gmkM=
X-Received: by 2002:a24:2842:: with SMTP id h63mr12899925ith.58.1546557413548;
 Thu, 03 Jan 2019 15:16:53 -0800 (PST)
MIME-Version: 1.0
References: <CABqErrECNH+gRiZXM+z=igjAw895e7KLeV6H0EKvMkW0UsVvJw@mail.gmail.com>
 <s5hsgy96fiu.wl-tiwai@suse.de>
In-Reply-To: <s5hsgy96fiu.wl-tiwai@suse.de>
From:   Con Kolivas <kernel@kolivas.org>
Date:   Fri, 4 Jan 2019 10:16:42 +1100
Message-ID: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
Subject: Re: ALSA:usb audio Higher sample rates on usb audio no longer working.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, saranya.gopal@intel.com,
        felipe.balbi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iwai-san.

Added some relevant CCs.

On Fri, 4 Jan 2019 at 00:23, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 03 Jan 2019 12:43:54 +0100,
> Con Kolivas wrote:
> >
> > Upon switching from 4.19.0 to 4.20.0, pulseaudio started complaining
> > that sinks that previously worked are no longer supported.
> >
> > On 4.19.0 trying 24 bit 88200, 176400, and 192000 I get the following
> > output from pulse.
> > resampler.c: Forcing resampler 'copy', because of fixed, identical
> > sample rates.sink-input.c: Created input 15 "Playback Stream" on
> > alsa_output.usb-DSPeaker_Anti-Mode_X4-00.iec958-stereo with sample
> > spec float32le 2ch 176400Hz and channel map front-left,front-right
> >
> > Switching to 4.20 gives me:
> > alsa-sink.c: Sink does not support sample rate of 176400 Hz
> > and
> > alsa-sink.c: Sink does not support sample rate of 88200 Hz
> > and
> > alsa-sink.c: Sink does not support sample rate of 192000 Hz
> >
> > Sample rates of 44100, 48000, and 96000 work fine, but 88200, 176400,
> > and 192000 no longer work
> >
> > Switching back to 4.19 immediately fixes the issue.
> >
> >
> > I tried looking through the alsa changelogs but there were too many to
> > give an obvious culprit, and haven't had time to do a git bisect. If
> > there's an obvious choice patch to back out I'd be grateful for the
> > heads up.
>
> Hm, through a quick glance, there hasn't been any relevant changes in
> USB-audio part (sound/usb/*).  Also, the changes in sound/core/* are
> irrelevant with your problem.
>
> So I have no idea what went wrong.  The bisection, or at least,
> narrowing down the commits would be helpful.

I've done a git bisect and found the offending commit:

commit f13912d3f014a7f2fa5c35d25ee8c3f96bda6272 (refs/bisect/bad)
Author: Saranya Gopal <saranya.gopal@intel.com>
Date:   Wed Sep 12 08:46:26 2018 +0530

    usbcore: Select UAC3 configuration for audio if present

    USB audio class 3.0 specification introduced many significant
    changes like
     - new power domains, support for LPM/L1
     - new cluster descriptor
     - new high capability and class-specific string descriptors
     - BADD profiles
     - ... and many other things (check spec from link below:
    http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip)

    Now that UAC3 is supported in linux, choose UAC3
    configuration for audio if the device supports it.
    Selecting this configuration will enable the system to
    save power by leveraging the new power domains and LPM L1
    capability and also support new codec types and data formats
    for consumer audio applications.

    Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
    Reviewed-by: Felipe Balbi <felipe.balbi@linux.intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reverting this patch fixes the problem for me.

Hope this helps.

Thanks,
Con
