Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C85C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0372087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0372087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeILOCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:02:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44446 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeILOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:02:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id s10-v6so1107447edb.11;
        Wed, 12 Sep 2018 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dALS/OETNspkEDAXHXhNB23qEiHtPEbb5udY9vU56LY=;
        b=rqTM0vPNuBmeKere/A2KBF1uIIxHq6KVKOIA4PokxLgH+MQJPVrA01EdjjVmG5DuHm
         QOXBxNtg8yMxbZeM2KWumRQ68wRVXYPoIDaW0ulkVljw4akP3mrBv2/BsUOc4zRSX1+h
         MQsUsTlpd5FgceYgyj8QGi/pnrtmqNwydji9sGHSB3lEW344Zl/O5sIaXduNMTTEThGR
         ef8HVEQURc7h9VgLlQNSpTaf+QWwDCZ446OcXXSyBV/FBQ673UXpH0Kfv5dnh3Sr9zxE
         JRcg8l0SwIhtri1xg4pr6GyUDKps2zdQPHd0HRxeIGHtxng6pL+FRIjPwX5DQHfDaBkA
         yzSg==
X-Gm-Message-State: APzg51CDm5tWm+Q5C8HWX4D362nodRpqPmyyHTFJmZqog/RU4QwAZQ9u
        IKyX6+h1XCBiqDul5/L6x+IXT9qT
X-Google-Smtp-Source: ANB0VdYVT6yLNYPQBHAOmpi0Kz0eDUpbjQDI5T9aIwSrkHAIthjceXZyUozgC/HP4f+mraddnpBLlg==
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr1655124edk.12.1536742710977;
        Wed, 12 Sep 2018 01:58:30 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id e15-v6sm395594edb.60.2018.09.12.01.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:58:30 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id w11-v6so1143312wrc.5;
        Wed, 12 Sep 2018 01:58:30 -0700 (PDT)
X-Received: by 2002:a5d:4a44:: with SMTP id v4-v6mr721015wrs.278.1536742710159;
 Wed, 12 Sep 2018 01:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180907041948.19913-1-wens@csie.org> <20180907112331.wjml25rfkyabvwwt@flea>
In-Reply-To: <20180907112331.wjml25rfkyabvwwt@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 12 Sep 2018 16:58:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v66PFTL+LJvi-d3LXNBfZCBZoRL06ORXsb4npvgEg7pZ4Q@mail.gmail.com>
Message-ID: <CAGb2v66PFTL+LJvi-d3LXNBfZCBZoRL06ORXsb4npvgEg7pZ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] drm/sun4i: Support color dithering for LCD panels
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jonathan Liu <net147@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 7:23 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Sep 07, 2018 at 12:19:42PM +0800, Chen-Yu Tsai wrote:
> >
> > Hi,
> >
> > This is v2 of my sun4i-drm LCD color dithering series. v1 was from back
> > in April [1]. Most of the driver code is unchanged.
> >
> > Changes since v1:
> >
> >   - Explicitly list properties from the simple-panel binding that apply
> >     to the Bananapi 7" panel
> >
> >   - Moved an incorrectly squashed change from patch 3 to patch 1, where
> >     it belongs
>
> Applied the first three patches, thanks!

Any comments on patches 4 and 5?

Thanks
ChenYu
