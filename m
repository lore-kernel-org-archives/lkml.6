Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E823C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406F520666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt9Y0Vj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406F520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeI1VNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:13:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45511 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeI1VNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:13:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so216268wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FyCMNpdJofF+fxKabWgdc1SZVV1S2ynpaFRSONyMSO8=;
        b=Bt9Y0Vj1MynhrBzHKuWBZyqDls24wyFuXy4XocjCjmh6ZX7zYPDPFJC0sCKqYguMSP
         AAb9gMN6BX6asvSA7pG0SAdOOl7Ecaqu9BMk6d9EyO1Un6fKRYEgMmucbV564Y2GBhYL
         KaAe7T3XcWJaVMLP80ZpnjNa7YsmsTXaRvWFTndYcnBlL36YMEuKW5HjvuG6T4gMf18A
         WCygE5+a9oFSxQ8jVa5z+4qPfS8XjAfIJA7bf3CvVWxH1rTsmHZLEFO4von9NADBfm8W
         6RuI7ttClwmcYVTxvDUO3wykvLtq/XsGT++c/q2fi4q1Dw7U5KRdfSPyiSOLgzuYojc2
         WMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FyCMNpdJofF+fxKabWgdc1SZVV1S2ynpaFRSONyMSO8=;
        b=qzXwNWpk3D9yB7aCIAdHBJGiqwb7J1nvsvovBECkyyLcylqkr77nUSHiN+AXklj+xS
         0413PMMwJONqZT5ih701uA/HOgkLN+0fVN19tDzBdHp0zpi/NT83RIzMfz+yEmBJz1pf
         CNBMwcsoQSNzErAdLLZ5Ovqu5tUWeYQO2UqTdOiMm1OzUA57JBQdFAx8VkWi69JHVn4f
         27a5IKPG6OgwmiStV55tpbLbEHnfpbXYQyb7jQk2TcGMxuUCoLojREjZDUt2JRN0Pd3L
         AaaePobH/D4RckeKC17wVQOuAV7GvD+M0yLda+f1smYBw9yLY78c5n2yc9i3yn5fFOQN
         YtXA==
X-Gm-Message-State: ABuFfogtSzRZ3wG70nIJVPhDk6G784BBAvRlMo8pj4qt0KSKXjJdhQsv
        gEsNzV+zqKsht8raVzBEyW8=
X-Google-Smtp-Source: ACcGV60Qfa8ZIzBhlxuMwiTHQV+1WI/rZ4a5dmt4xxh3CEP2Xl6j9xev+t05DyOCkbHCLQZpdg2shg==
X-Received: by 2002:adf:fb0e:: with SMTP id c14-v6mr12628263wrr.117.1538146138989;
        Fri, 28 Sep 2018 07:48:58 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f3-v6sm1889053wmf.30.2018.09.28.07.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 07:48:58 -0700 (PDT)
Date:   Fri, 28 Sep 2018 07:48:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: bcm2835-camera: Avoid unneeded internal
 declaration warning
Message-ID: <20180928144856.GA22524@flashbox>
References: <20180928005038.1697-1-natechancellor@gmail.com>
 <CAAoAYcMMiiDXCcnZ=DP9Y9Xs+xdq-jasj8G_W0jrnQV9so79=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAoAYcMMiiDXCcnZ=DP9Y9Xs+xdq-jasj8G_W0jrnQV9so79=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:04:29AM +0100, Dave Stevenson wrote:
> Hi Nate
> 
> Thanks for the patch.
> 
> On Fri, 28 Sep 2018 at 01:53, Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/staging/vc04_services/bcm2835-camera/controls.c:59:18: warning:
> > variable 'mains_freq_qmenu' is not needed and will not be emitted
> > [-Wunneeded-internal-declaration]
> > static const s64 mains_freq_qmenu[] = {
> >                  ^
> > 1 warning generated.
> >
> > This is because mains_freq_qmenu is currently only used in an ARRAY_SIZE
> > macro, which is a compile time evaluation in this case. Avoid this by
> > adding mains_freq_qmenu as the imenu member of this structure, which
> > matches all other controls that uses the ARRAY_SIZE macro in v4l2_ctrls.
> > This turns out to be a no-op because V4L2_CID_MPEG_VIDEO_BITRATE_MODE is
> > defined as a MMAL_CONTROL_TYPE_STD_MENU, which does not pass the imenu
> > definition along to v4l2_ctrl_new in bm2835_mmal_init_controls.
> 
> There's a slight confusion betwen V4L2_CID_MPEG_VIDEO_BITRATE_MODE and
> V4L2_CID_POWER_LINE_FREQUENCY in your description.
> 
> However you're right that MMAL_CONTROL_TYPE_STD_MENU calls
> v4l2_ctrl_new_std_menu which doesn't need a menu array (it's
> v4l2_ctrl_new_int_menu that does). That means the correct fix is to
> define the max value using the relevant enum (in this case
> V4L2_CID_POWER_LINE_FREQUENCY_AUTO) and remove the array.
> 
> The same is true for V4L2_CID_MPEG_VIDEO_BITRATE_MODE - max should be
> V4L2_MPEG_VIDEO_BITRATE_MODE_CBR, and remove the bitrate_mode_qmenu
> array.
> 
> Thanks,
>   Dave
> 

Hi Dave,

Thank you for the review, I appreciate it. I had certainly considered
that solution first butnfigured this was the more conservative change.

I will send a v2 soon with the suggested change.

Nathan

> > Link: https://github.com/ClangBuiltLinux/linux/issues/122
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/vc04_services/bcm2835-camera/controls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > index cff7b1e07153..a2c55cb2192a 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > @@ -1106,7 +1106,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
> >         {
> >                 V4L2_CID_POWER_LINE_FREQUENCY, MMAL_CONTROL_TYPE_STD_MENU,
> >                 0, ARRAY_SIZE(mains_freq_qmenu) - 1,
> > -               1, 1, NULL,
> > +               1, 1, mains_freq_qmenu,
> >                 MMAL_PARAMETER_FLICKER_AVOID,
> >                 &ctrl_set_flicker_avoidance,
> >                 false
> > --
> > 2.19.0
> >
> >
> > _______________________________________________
> > linux-rpi-kernel mailing list
> > linux-rpi-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
