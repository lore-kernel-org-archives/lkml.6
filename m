Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF179C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AEE2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Snc/ToSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AEE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJXQt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:49:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52705 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeJXQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:49:55 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so5130257itz.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlkTYngJqdwsOJoFOggl3HV+2Mu3T9oGVSVCRDcq2P8=;
        b=Snc/ToSv3XFkyzaUnkKWtZJHKJqRA4ZHhsf3R59+G+NlUgBn/sXvjceH7gc8mmT+6z
         ooAurBWn0TWDOaSvxdvnVr7ldkxac+bmrgCWJdiBeaTngzMUyp/evXiBTzF2n5RQRVLr
         Gq3hyg0akOMeGtU+EcTxgA4X4CqCAyAcjw3qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlkTYngJqdwsOJoFOggl3HV+2Mu3T9oGVSVCRDcq2P8=;
        b=JCaOwnysCOrZFUX6GeUiI+X5lDQ80VCgxZjSVqBu3sYMFzhZ+TMvZ4Z/8BJQHXtTxT
         PMQ++8cdIf/nVT3B8XcWm9pheAc3hHa9ZEJiV2hfOEue4zHsVUnAME5Y7dggpZgBtAMk
         Sz8vedvKyro9zob7x0Q962qNnVJhlXcbsFA69vxIf59Iy5HA9ABDzV6UXtxJ1hgB8PmX
         RhbbDDi9iegdlSI7yslU7+46KxKvuV2OTU3N/lP7ponebfFrS82/tooGyBmAA/p1Ky0X
         FN0W5yeD+kobL7AtDzLFelIQp0ZK3+FdRC2g7nkWzkjBsTptfakKuhRYT/xD8LM/tfze
         YiTw==
X-Gm-Message-State: AGRZ1gIaqhtvZ9NXd4+95mh5W4zzOtdoDOrJhPzQOszg8bvYLFbHgIlp
        1/bFwztapZKXAn5/HMeFW1JtG6OUqD+LCfu4vv/8gA==
X-Google-Smtp-Source: AJdET5cqkKu5khBXvD4Lf9ycXR7zk6COfbihRV6RFOTiLKM2lw+uotvlcZS+gOa+KBCDIrEysu3hAQqsW3+srbSQuo0=
X-Received: by 2002:a24:9f82:: with SMTP id c124-v6mr866897ite.32.1540369369124;
 Wed, 24 Oct 2018 01:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180731133828.2582-1-jagan@amarulasolutions.com> <20180731134036.mzgntiv6fwxg2vja@flea>
In-Reply-To: <20180731134036.mzgntiv6fwxg2vja@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 24 Oct 2018 13:52:37 +0530
Message-ID: <CAMty3ZC2==BYChib71qyzd7oRkUHB3hunKw2FGRj3t=U2vK5nw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] arm64: defconfig: Enable MFD_AXP20X_I2C
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 7:10 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jul 31, 2018 at 07:08:28PM +0530, Jagan Teki wrote:
> > The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
> > connected via I2C.
> >
> > Enable the driver for this PMIC.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Can you apply this? needed for mmc to detect on H6
