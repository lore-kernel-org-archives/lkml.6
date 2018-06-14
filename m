Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3DDAAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9AA208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i0ooEsvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9AA208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755236AbeFNNBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:01:01 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36691 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755191AbeFNNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:00:58 -0400
Received: by mail-yb0-f194.google.com with SMTP id x128-v6so2192123ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deWsDcOsyAZRzmecUq1PgGESWYMgLoKvgP7bPoc1vAQ=;
        b=i0ooEsvrVasqdiMqCCaNJrwhJ5HlQrhTEAvO7pVOetmxFPGvY17JS38lNagj7Qw2dg
         n8GYy5vPMay5SipHE9Liqa50tcY189LUlEqwWWyDNHqT1oX6xHjqqPygu5bBTqS1ZECf
         9yHn/wbnd8RdGm/RHJzjFjN7Dz4aMt+ebMbIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deWsDcOsyAZRzmecUq1PgGESWYMgLoKvgP7bPoc1vAQ=;
        b=EyDYsDirMuRdZ4xwoAhGoyqsNo6dG9PiV16os1fSxvexn21jFmzUHzLOKwtTQWjELC
         kpXvcxfOOEITGTYexnMDJlbPSr9qsRjQrR2KBbIvqry9+XQvTwLauIj9tt1+s3dSx3Vx
         vAr1THBi/eY69ro0EPo1y0FFGXTDymDgSSXT31WrZKYAD1bE/3ro0riXfvU6/fRL19Om
         i1ujFTbKmYnEBCM3PG3T8cjipKlcei4iqk3BLBnxLF4FfkLg6/t1BSv10XvPUV/lQ5JF
         yGxDyuRocd+LsHiLxTNgprWZi4bp7KDeR6UPCo+peS40fK6Q7MyvXk/JuoqZMEdXn+rl
         7h5w==
X-Gm-Message-State: APt69E3x2XNYKhHSMhHpC0LMdcPDPOCdRT9AxSdnqtOWaz9LoP0GZyWK
        bXgrgy6FEjv3Ig/hhOzBMct21Sq9ZNA=
X-Google-Smtp-Source: ADUXVKK2ttfoybpeXWL0wPvcfXrOub/kUQ8ISLWpy4yVBE1hESS7XU40QjBIe3tvdPRiyafMSbg3GQ==
X-Received: by 2002:a25:d647:: with SMTP id n68-v6mr1275225ybg.113.1528981258050;
        Thu, 14 Jun 2018 06:00:58 -0700 (PDT)
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com. [209.85.161.174])
        by smtp.gmail.com with ESMTPSA id s4-v6sm2200159ywa.9.2018.06.14.06.00.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 06:00:56 -0700 (PDT)
Received: by mail-yw0-f174.google.com with SMTP id p129-v6so2093328ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 06:00:55 -0700 (PDT)
X-Received: by 2002:a0d:e7c5:: with SMTP id q188-v6mr1232321ywe.435.1528981255345;
 Thu, 14 Jun 2018 06:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
In-Reply-To: <20180613140714.1686-1-maxime.ripard@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 14 Jun 2018 22:00:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A-GMBnNnRCfm0-51R9rn_pWw+UC3r-JX-_BE3cdznqig@mail.gmail.com>
Message-ID: <CAAFQd5A-GMBnNnRCfm0-51R9rn_pWw+UC3r-JX-_BE3cdznqig@mail.gmail.com>
Subject: Re: [PATCH 0/9] media: cedrus: Add H264 decoding support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Jun 13, 2018 at 11:07 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> Here is a preliminary version of the H264 decoding support in the
> cedrus driver.

Thanks for the series! Let me reply inline to some of the points raised here.

>
> As you might already know, the cedrus driver relies on the Request
> API, and is a reverse engineered driver for the video decoding engine
> found on the Allwinner SoCs.
>
> This work has been possible thanks to the work done by the people
> behind libvdpau-sunxi found here:
> https://github.com/linux-sunxi/libvdpau-sunxi/
>
> This driver is based on the last version of the cedrus driver sent by
> Paul, based on Request API v13 sent by Hans:
> https://lkml.org/lkml/2018/5/7/316

Just FYI, there is v15 already. :)

>
> This driver has been tested only with baseline profile videos, and is
> missing a few key features to decode videos with higher profiles.
> This has been tested using our cedrus-frame-test tool, which should be
> a quite generic v4l2-to-drm decoder using the request API to
> demonstrate the video decoding:
> https://github.com/free-electrons/cedrus-frame-test/, branch h264
>
> However, sending this preliminary version, I'd really like to start a
> discussion and get some feedback on the user-space API for the H264
> controls exposed through the request API.
>
> I've been using the controls currently integrated into ChromeOS that
> have a working version of this particular setup. However, these
> controls have a number of shortcomings and inconsistencies with other
> decoding API. I've worked with libva so far, but I've noticed already
> that:

Note that these controls are supposed to be defined exactly like the
bitstream headers deserialized into C structs in memory. I believe
Pawel (on CC) defined them based on the actual H264 specification.

>   - The kernel UAPI expects to have the nal_ref_idc variable, while
>     libva only exposes whether that frame is a reference frame or
>     not. I've looked at the rockchip driver in the ChromeOS tree, and
>     our own driver, and they both need only the information about
>     whether the frame is a reference one or not, so maybe we should
>     change this?

The fact that 2 drivers only need partial information doesn't mean
that we should ignore the data being already in the bitstream. IMHO
this API should to provide all the metadata available in the stream to
the kernel driver, as a replacement for bitstream parsing in firmware
(or in kernel... yuck).

>   - The H264 bitstream exposes the picture default reference list (for
>     both list 0 and list 1), the slice reference list and an override
>     flag. The libva will only pass the reference list to be used (so
>     either the picture default's or the slice's) depending on the
>     override flag. The kernel UAPI wants the picture default reference
>     list and the slice reference list, but doesn't expose the override
>     flag, which prevents us from configuring properly the
>     hardware. Our video decoding engine needs the three information,
>     but we can easily adapt to having only one. However, having two
>     doesn't really work for us.

Where does the override flag come from? If it's in the bitstream, then
I guess it was just missed when creating the structures.

Best regards,
Tomasz
