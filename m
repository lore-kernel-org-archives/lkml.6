Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EECC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03480218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kgyLyJLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBKMLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:11:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36340 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfBKMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:11:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so17040747otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KC8LXiCQQI99XcUi6fwU9wUEtaVFh0/UTHlyNNxO9Mw=;
        b=kgyLyJLrMuAmA4gRztU+a6frP99l+jEVRu6XZkc+mmGb5hGMj+Fru4SrE+5Zrc2JKB
         exV3XCzWUyLt0clgZIvwsLo7QTo5ZIPuwdPtsRzJF/HraLVbZNvLpsmeFVuOuU8yUrYx
         jfvMV0IO5kThmEupWBu3w0TPCKs56HW7Q9mT00iWVQKFfXY0ASIeOy5reDd5nRjJawCo
         6ICYAlpkfTrF+NEw4CUdgAAn6Md1n2ooljJzDE4l72wMBhDueyX3E285wu6oMfwmrJEl
         H/o5MwWDe3mLAZm127dzFHKHF/CWH5GAFLOEh0oyY3b1KLJcMdA2nuJS8qFjRyYano8n
         H+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KC8LXiCQQI99XcUi6fwU9wUEtaVFh0/UTHlyNNxO9Mw=;
        b=XfwtjoENh5UVudpeBP2hFtxyjpGYimjLYRmUujMy59tmcMKSmtUDDfpsK5yf+Bbjfc
         ogw5bilkUprL1xPH2gpdc8+fhMNu5mj5ek408+lfn5VQ6PrswJYCtE9lGsFjQijqYNiD
         IaIaKQTdLIDfiEWkPDLxMZe2GURZtwUcWHaxgVjvgSr88v/4J5PB95GgVWNxcDQ4pS5o
         DWsXUn+M6sb8F22NF3vQj6GTY98vhQHzPOWlMUs7HzjJKVLTYLP3djsn1TVcp/UDbgGd
         6mx9cLws1nNjgwt017KNy1O2vJ39cutrLMwmo5cZU1si7UeFErPnDXzNb/W/MU6P6Xz8
         OUuw==
X-Gm-Message-State: AHQUAuafBTihrYqmSJ4NaksXRypm4ezzwWy5X6/LYS+5+SNvDhoPgMJ7
        +j3xaSa8NgHTT+n3eSBLzhZb1bhtsK59wHp21OhG/g==
X-Google-Smtp-Source: AHgI3Ia1HjxvXShN20b9umX/+fo76bxp8cVITE8fngptLKa+cLPQSR1zsPoNl8LykasNpStTlif+dI6OY2wWt+99MBI=
X-Received: by 2002:a9d:76c5:: with SMTP id p5mr26621538otl.108.1549887082094;
 Mon, 11 Feb 2019 04:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20190208173458.4801-1-brgl@bgdev.pl> <50671542-c055-1796-c58e-276ba3d414d0@ti.com>
In-Reply-To: <50671542-c055-1796-c58e-276ba3d414d0@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 11 Feb 2019 13:11:11 +0100
Message-ID: <CAMpxmJV34X=C4HMGNiAUxoVkPP+1nY3186QHOisqQtwT9pNtyg@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] ARM: davinci: modernize the irq support
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 11 lut 2019 o 12:54 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> + Jason, Marc
>
> Thomas, Jason, Marc,
>
> On 08/02/19 11:04 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This series ports the davinci platform to using SPARSE_IRQ, cleans up
> > the irqchip drivers and moves them over to drivers/irqchip.
> >
> > The series can be logically split into four parts. The first (1-8) aims
> > at introducing support for SPARSE_IRQ. It contains a couple changes
> > required for that functionality and the final patch actually selecting
> > it.
> >
> > Second part (9-19) makes the aintc driver suitable for drivers/irqchip
> > and eventually moves it over there.
> >
> > Part 3 (20-32) does the same for the cp-intc driver.
> >
> > Last patch removes unnecessary code.
> >
> > The series has been tested on da850-lcdk (for cp-intc) and
> > dm365-evm (for aintc).
>
> With your ack, I would like to try get it merged to v5.1 via ARM SoC tree=
.
>
> Bartosz, I noticed that Jason and Marc were not originally CCed. You may
> have to resend if they don't have the series in their inbox.
>
> Thanks,
> Sekhar

Sorry for that, I'm not sure how this happened, since they do pop up
in get_maintainer.pl output for that series.

I'll resend it.

Bart
