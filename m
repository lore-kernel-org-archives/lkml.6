Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E88EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C712080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab8yy9Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C712080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeJWXnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:43:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33661 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:43:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id r25-v6so2022603edy.0;
        Tue, 23 Oct 2018 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ua1z2d3HFvEPCqEAltIm0ylWFUcAw0J/WOp/67VgqL8=;
        b=Ab8yy9WsBpxLV05FOGoTDikawNRdvYDu0cEm+T+GQbIsHOuLlQSGH8CL0KSaTVc0mj
         +3mMWudSQSerPdSxwZhhD/w8hJjG4g40i98iZeM/tATdEEfvo7foP1xX952DLg6CZqgR
         PlRkLXJ13dv87PJrPM5W//RV0xRu4mXJUP/s8ekUNe7CTPhtVczztdgINNdzEe57S5Zc
         7cUnCpPQqTy7tC3bDFaRdb8THEK3RI/ukxGbOUjXg2WaGsDDaebwAxBZxdczd0oV5UsS
         JS8snwBXb1hd+cw7yvLh0u/PsXg98eO5uyCW8hPuKC4C98+IbwdIYssi/U6JBRm0S25p
         NrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ua1z2d3HFvEPCqEAltIm0ylWFUcAw0J/WOp/67VgqL8=;
        b=hndx1Q4FW3SYPcsf+eaMRtpZiU+gRA5M1yIVVweUow75nFQ5xz5OBFpwZD2Ru1dPGw
         GV+xYf9uyOMRCypTiDMjqpESya5m0Vk5D5O0hmy9Ef0gZS7cJcSptqTu2+iVWwAF6243
         eHWohTYz53hr28mhuBsIV2LW2PxGSYnJ4FB30KWz2lpCXgdvHz4zbT+fxtrM1015N9VY
         ApxgbMVQj0EJQyMthKN8TNS5BbFOKWWLBHrJJpqnhEsszvbr5zKj7XrX5NEqduSSYvWs
         ZlmqjhNjuOTRVlLg0ZadxvK/axZJwX9P9Q7io4FZY0p8ICTAkyBsDhBrqrTTFb7izFCi
         bmOw==
X-Gm-Message-State: ABuFfoie5LfxSfurcJF7w8at6HUpG59oF4ZJ96gmNBTFWkh4RCMwPJ8k
        NqG3Af9tFeXWosE9s4cMj+fLeQEnMsM1aujO62A=
X-Google-Smtp-Source: ACcGV61ix1Mu7gh8eJUVMTgnYsMfTDkXZf2Oja5anQrbKYsYUr05BXHKyqf6aBlc48l7IDFaVm9LfppVj9i8bXWRYnk=
X-Received: by 2002:a50:a48b:: with SMTP id w11-v6mr16511221edb.74.1540307980371;
 Tue, 23 Oct 2018 08:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180920145658.GE16851@w540> <CAHCN7x+U=Y=-v1UP5UYvY8WtUFRJGjmx=nawTuE=YcHdm_DYvA@mail.gmail.com>
 <c1cb34b0-b715-cf08-6f75-2842f1090c5d@mentor.com> <20181017080103.GD11703@w540>
 <CAHCN7xLx6uAmYiGh3p=piZFwE0VkfixTLqdjETibKwk2+DhMzA@mail.gmail.com>
 <CAHCN7xJKuPYg04WfRzbYWO4bGoHHnD16LBPRsK1QsiYY1bL7nA@mail.gmail.com>
 <20181022113306.GB2867@w540> <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
 <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
In-Reply-To: <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 23 Oct 2018 10:19:28 -0500
Message-ID: <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Fabio Estevam <festevam@gmail.com>
Cc:     jacopo@jmondi.org, steve_longerbeam@mentor.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        p.zabel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        gstreamer-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 7:40 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Mon, Oct 22, 2018 at 9:37 AM Adam Ford <aford173@gmail.com> wrote:
>
> > Thank you!  This tutorial web site is exactly what I need.  The
> > documentation page in Linux touched on the media-ctl links, but it
> > didn't explain the syntax or the mapping.  This graphical
> > interpretation really helps it make more sense.
>
> Is capturing working well on your i.MX6 board now?

Fabio,

Unfortunately, no.  I built the rootfs based on Jagan's instructions
at https://openedev.amarulasolutions.com/display/ODWIKI/i.CoreM6+1.5

I tried building both the 4.15-RC6 kernel, a 4.19 kernel and a 4.14 LTS kernel.

Using the suggested method of generating the graphical display of the
pipeline options, I am able to enable various pipeline options
connecting different /dev/videoX options tot he camera.  I have tried
both the  suggested method above as well as the instructions found in
Documentation/media/v4l-drivers/imx.rst for their respective kernels,
and I have tried multiple options to capture through
ipu1_csi1_capture, ipu2_csi1_capture, and ip1_ic_prepenc capture, and
all yield a broken pipe.

libv4l2: error turning on stream: Broken pipe
ERROR: from element /GstPipeline:pipeline0/GstV4l2Src:v4l2src0: Could
not read from resource.
Additional debug info:
gstv4l2bufferpool.c(1064): gst_v4l2_buffer_pool_poll ():
/GstPipeline:pipeline0/GstV4l2Src:v4l2src0:
poll error 1: Broken pipe (32)

I can hear the camera click when I start gstreamer and click again
when it stops trying to stream.

dmesg indicates a broken pipe as well..

[ 2419.851502] ipu2_csi1: pipeline start failed with -32

might you have any suggestions?

thanks,

adam
