Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C452082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C452082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeHaGiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 02:38:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44102 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHaGiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 02:38:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so7938250edb.11;
        Thu, 30 Aug 2018 19:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQc2rJ+K0deI5qyYgaHkMrsHQPryPSCoTVBNvWldhu0=;
        b=QqulupjHNyJIMkTlIDOuhy3mFrYQM1vGxQvVFpS9TfG4EA5H+tNYCXNtP7Cgf5boGU
         Hl0D9EZL2pBwNcYOZGfbCq8s/hnR3VQe9ldnmoGFwc9S0r/bU4JMvjn11XoWq3hsn3dX
         fSE4oH8GD2d0Ihgv4NTxPf4D9MRZ0wry+/AyE7j3Uq3Fdhp5+hvbDRjbvE2I2jRfWiJP
         W2wSrX0XUXmZg4WePy8KEwy3yads2IVIqacN7A5gmAaDfMqguohHD2t2BL7+5rALEYVm
         G7qx2LSE05hEvlD6wQjHJt7Vyzq1unrwn6ZCJzmEWqM4WO1e2Is333tz0vDBS+QjK/fS
         bowA==
X-Gm-Message-State: APzg51Bx24DsXUkDgXk79wlGhwgWawb0VdNdFcANFhUBVLWTQiIrOv39
        DX7W9vXuKkJLI+NAof73N4e9SFIBx1o=
X-Google-Smtp-Source: ANB0Vda3bkq9XZrZjrvI9lfGNC2T1+wUfcdD4odn7vv5BBUSWmZajmy/78dA4udpcG4oo39wwcYArw==
X-Received: by 2002:a50:8843:: with SMTP id c3-v6mr15868847edc.146.1535682787490;
        Thu, 30 Aug 2018 19:33:07 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id c28-v6sm4568215edc.52.2018.08.30.19.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 19:33:07 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id a108-v6so9721168wrc.13;
        Thu, 30 Aug 2018 19:33:06 -0700 (PDT)
X-Received: by 2002:adf:e486:: with SMTP id i6-v6mr9448989wrm.145.1535682786107;
 Thu, 30 Aug 2018 19:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190120.722-1-clabbe.montjoie@gmail.com> <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
In-Reply-To: <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 31 Aug 2018 10:32:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
Message-ID: <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
To:     axboe@kernel.dk, LABBE Corentin <clabbe.montjoie@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> > Hello
> >
> > This patchset add support for allwinner R40 AHCI controller.
> >
> > The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> > on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> > by this serie, so no regression should come with it.
> >
> > The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> > but will be resent for inclustion when all patchs will have hit linus
> > tree.
>
> Applied 1-12 with Hans's blessing, thanks Corentin.

Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
merge them through the sunxi / armsoc tree. Having them in separate trees
introduces conflicts when we have other stuff going through our tree.

Corentin, it's best to lay out the plan to get patches merges in the cover
letter, specifically which maintainer should take which patches, or if an
immutable tag/branch is preferred, when things can't be separated cleanly.
This helps other subsystem maintainers that don't routinely deal with armsoc.

Also, we probably can't merge the last patch that removes the PHY code,
since we have to support old device trees.

Thanks
ChenYu
