Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2170EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAB926F1F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wOGbov2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAB926F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeFZSdJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbeFZSdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:33:07 -0400
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com [209.85.214.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C30526F1D;
        Tue, 26 Jun 2018 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530037986;
        bh=SmqjXu3LAQqA+r2hnntwqO+IXyBSGdfBs42ExHtIFH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wOGbov2/LFsH0UHqAd6w25kwidxroBCwVNlu3nkrCN2UjKf++Bw2AGFp67VkYb9fV
         gfWkCnOD3rtQZ7o6YP6Nwja1XAOQd/klmC0RDd2hPVUpSWByr2J9JCNYgyEQkhsog0
         Ll6BjyBCzqcGyjlkaOxmldBCgKZqaLjsqHk9WWE0=
Received: by mail-it0-f44.google.com with SMTP id 16-v6so3780372itl.5;
        Tue, 26 Jun 2018 11:33:06 -0700 (PDT)
X-Gm-Message-State: APt69E3iXvKsKwNqDhf6Wjnu7chXqg8muLRWRZPACBYULnJuWiHDqBNB
        DqXkAa597Ky1Pzm8K6kDfFWmPaHn28BL1fYcNA==
X-Google-Smtp-Source: AAOMgpcCvkBuX8wEvMpsb2L340syXn94ori2P8cas9dL9XRmZrLJdNpjlHEUzsJnY0KayXQwGgs/N7mm6C+BUI7/HZw=
X-Received: by 2002:a02:4142:: with SMTP id x63-v6mr2345649jaa.46.1530037985959;
 Tue, 26 Jun 2018 11:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1524820923.git.mbrugger@suse.com> <64ca273429d92f581568a48f3efe6035af65f579.1524820923.git.mbrugger@suse.com>
 <20180430103029.GD5147@dell> <4ead47f6-2f69-2afa-bfcc-a240a9845dc4@gmail.com>
In-Reply-To: <4ead47f6-2f69-2afa-bfcc-a240a9845dc4@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Jun 2018 12:32:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+TTsgCeFeSXYdF1e8MyrOmmFvnR7ZwyQzv+FYK1G5R6w@mail.gmail.com>
Message-ID: <CAL_Jsq+TTsgCeFeSXYdF1e8MyrOmmFvnR7ZwyQzv+FYK1G5R6w@mail.gmail.com>
Subject: Re: [v3 01/10] dt-bindings: mediatek: mmsys: Add support for mfd
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, matthias.bgg@kernel.org,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 9:39 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 30/04/18 12:30, Lee Jones wrote:
> > On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
> >
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> Add binding description for the mmsys mfd for some Mediatek
> >> devices. mmsys has some registers to control clock gates (which is
> >> used in the clk driver) and some registers to set the routing and enable
> >> the differnet blocks of the display subsystem.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 --
> >>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
> >>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 ++++++++++++++++++++++
> >>  3 files changed, 28 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt

Please CC DT list on bindings.

Rob
