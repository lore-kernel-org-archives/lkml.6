Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6233EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FC5218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfBZXmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:42:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41223 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfBZXmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:42:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so12729054otk.8;
        Tue, 26 Feb 2019 15:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EMTqJAlbAmmh8lqxubVAQkymadkrwCdqRRjus+dEoA=;
        b=SrFpBgMXYtC8LWenDtGzt8d0l3cpDbS4YSu7Bf6sYFv+lZThHKyN3J/GhF9E6I3mqr
         3KmbYnHGMKadWiI3tPGE5vuTwTAUseg16+dNezoF6ZO6kxmy0mg8owtfSJ0u7Y/n533W
         S9kaqj+3MXXQAMqNnFrNj5vAzsQ6xKmB5X94IwY8A2MqiIDbKIEsLEeDMMUlEMuccImK
         Vby5n2Sgw+k9CRqUCqURmA0lwD8v2MR4M9/v5D+xcEeTGtJTv0fDbGD+au1TPyZQP2d+
         OiWTgQPdL/JphqJP4L5xkH8L1nsoBuXw4WMWWCmuUi5N0vxriYyYUNmQkhmVudvApxBs
         PIiw==
X-Gm-Message-State: APjAAAUjoI56QkdGQrlMv32x6h0xPUp23zS1bMExPJo+61s2m8LQ1xBF
        rYVXQAO5KzKUucVGe2sCp+dIra6vbQQ=
X-Google-Smtp-Source: AHgI3IZexqrqbLASchqeoj/7hrfJnkdFvyQL7SGiYqq89W4rocOa6ljZm+iP6lrV50ofL8uvNNHJfw==
X-Received: by 2002:a9d:6e17:: with SMTP id e23mr368330otr.302.1551224565920;
        Tue, 26 Feb 2019 15:42:45 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id q25sm5371733otl.15.2019.02.26.15.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 15:42:45 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id q24so12805519otk.0;
        Tue, 26 Feb 2019 15:42:45 -0800 (PST)
X-Received: by 2002:a9d:6206:: with SMTP id g6mr360329otj.338.1551224565113;
 Tue, 26 Feb 2019 15:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20190223084816.28985-1-ioana.ciornei@nxp.com>
In-Reply-To: <20190223084816.28985-1-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 26 Feb 2019 17:42:33 -0600
X-Gmail-Original-Message-ID: <CADRPPNRoipCbKJj5LwnPzdaOpzEwQ4+_uguf2jFreJ74-oav6Q@mail.gmail.com>
Message-ID: <CADRPPNRoipCbKJj5LwnPzdaOpzEwQ4+_uguf2jFreJ74-oav6Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 2:49 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> The first two patches enable cache stashing and configure the core cluster
> destination per software portal while the third patch is the one
> configuring the amount of stashing on a queue.

Series applied for next.  Thanks.

Regards,
Leo
>
> Ioana Ciornei (3):
>   soc: fsl: dpio: enable frame data cache stashing per software portal
>   soc: fsl: dpio: configure cache stashing destination
>   dpaa2-eth: configure the cache stashing amount on a queue
>
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  7 +++-
>  drivers/soc/fsl/Kconfig                          |  1 +
>  drivers/soc/fsl/dpio/dpio-cmd.h                  |  5 +++
>  drivers/soc/fsl/dpio/dpio-driver.c               | 52 ++++++++++++++++++++++++
>  drivers/soc/fsl/dpio/dpio.c                      | 16 ++++++++
>  drivers/soc/fsl/dpio/dpio.h                      |  5 +++
>  drivers/soc/fsl/dpio/qbman-portal.c              |  4 +-
>  7 files changed, 87 insertions(+), 3 deletions(-)
>
> --
> 1.9.1
>
