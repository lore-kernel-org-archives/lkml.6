Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F12AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABB1206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2pEi4Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABB1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeKRD3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:29:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34822 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRD3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:29:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so9851588oif.2;
        Sat, 17 Nov 2018 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAjZ85lZCzOMaGnH9MK28qV2yy+kOp3Qt8yiSIyRI3w=;
        b=g2pEi4VegBwRKWE1Xq35D+aHTCNCsNTRTjmW7E5Wqb7/wa4ZngtlWHM+rbY/inwsrM
         vBdjQqdI260J6lUaYdpE1VLaxyRpxExCwdNryTRVuzAJfMMLPsbn0uiMymN2Rj5fPGks
         6DIvdvnUykH7ZAs7i9nhVT/X5gndKp3LmdQW8f5wlqvCapdCvwble/n1aZBnoGhSubSb
         a3ks7q2gfduvH3gvX5TrQ0fcu/5i9MFoYWF7r6wLIqcx4lxOU+iQCuDRnsnveuJOxKe9
         6yg0M9fuA2BKBLL4Z9bPql/IKPxnZIFVNoDCLnkLP0lbNMNiqJmDc9OGz6OV0jowSM6r
         sm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAjZ85lZCzOMaGnH9MK28qV2yy+kOp3Qt8yiSIyRI3w=;
        b=A+P5zn7Psr+8kfzXSkUoTCyXqEFjeEOEQbhIQTDxAFpt5yKyk969t7EwbhCZ9W6zGv
         8LCE2IFlj3rsVUpoPeTpdjyeGEKAiEdl89+s6ulmnwb0gZItozrZpFOiiUUNQjCX+Huw
         CADgxtHUYfJG3OYkeD84KJ6/GDVNTiaZs/QtVNz0ZmairsYZPsWrz0DpgV2iqB8udJOD
         JueUNOegiucM/uSCVGzGKVplwNFYOJQGrijEaoSqco0JX6k08m4K4q6HfN0j9tmV7rlY
         M2ElgitbW6iqcxRpijNbREMETgo1v6wSfTJzuNzB4NL+4njFjQ06nSyQ2kAcFFsWS3zV
         YOLQ==
X-Gm-Message-State: AGRZ1gI3Ir1AVUrTKYkPLbbH6h161j/WFitHV/cvwhpqBaon+iyemclp
        KR+SGiJOq8iqHeBXdX3puSUQcSU41LiLMbXYbaY=
X-Google-Smtp-Source: AJdET5dyCxTwjfLM+KlHOFrz6IPO2fhC6ndDB34R/cEBv1YS5SBnTXILCbFDkcMDiz4gHY5hQqqyyAj7w/L0E+6Hwhw=
X-Received: by 2002:aca:a881:: with SMTP id r123mr3589558oie.207.1542474735096;
 Sat, 17 Nov 2018 09:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-4-anarsoul@gmail.com>
 <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
 <CA+E=qVegv61NgF4peK=Bz2RDvjCUX+M_njrpC4Ph+Jv+r2KFgg@mail.gmail.com> <CAGb2v65vDRTUDo894nXvOi8xEkMzeymbU=OQjdyY-Eh38T7F+A@mail.gmail.com>
In-Reply-To: <CAGb2v65vDRTUDo894nXvOi8xEkMzeymbU=OQjdyY-Eh38T7F+A@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sat, 17 Nov 2018 09:11:48 -0800
Message-ID: <CA+E=qVfVEiE0Mvc_0HxWkkpXb9U5CJmtZtPxVPLrOZKD1JfkUg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on Pinebook
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 8:02 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 15, 2018 at 1:48 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Wed, Nov 7, 2018 at 11:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > +
> > > > +       speaker_amp: speaker_amp {
> > > > +               compatible = "simple-audio-amplifier";
> > > > +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> > >
> > > You might want to add a sound-name-prefix property. See
> > >
> > >     Documentation/devicetree/bindings/sound/name-prefix.txt
> > >
> > > Also this should have a reference to its power supply regulator.
> >
> > You're right, it should reference its power supply which should be a
> > fixed regulator controlled via GPIO from AXP803.
> >
> > Unfortunately there's no AXP803 GPIO support yet and
> > simple-audio-amplifier doesn't have regulator property.
> >
> > I have no time (and interest) to work on it in near future, so if
> > anyone wants to pick it up - feel free to do so.
>
> Understood. I can try to pick it up when I have some extra time.
>
> On the other hand, I tried this series on my Pine64 and (with
> the necessary device tree changes) on my Bananapi M64. While
> audio played (did not stall), no audio was actually coming out
> of the headphones I had plugged in. I made sure that all needed
> mixer controls were enabled, and the DAPM graph read all green
> from the DAI to the Headphone jack.
>
> Any ideas?

Please show output of amixer. My guess is that you don't have 'AIF1
DAC' enabled.

>
> Regards
> ChenYu
