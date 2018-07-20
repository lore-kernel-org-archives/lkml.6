Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB89ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FDD20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vWsaRxKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FDD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeGTP7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbeGTP7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:59:31 -0400
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com [209.85.223.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE3B20856;
        Fri, 20 Jul 2018 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532099448;
        bh=bH8ke6zhT4Dp7gqRi5kNAqgAbduypomIGJLEXiEOfQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vWsaRxKV6GPi8PcwYzPcxcHrRkPaeCQaswDOFiEov4kJ/lS2OLHYikcxk9h+69GF6
         p4e/yDY5dx6Rz2WDf9r+1/C/PmB+tW5LgvIi+AUuNs2/mhBb9e8++vJbAc7BOyH/yG
         ZmI5VVhXtFDtlmCLKzSu2QDSi0xWacTa2RQk7ELk=
Received: by mail-io0-f174.google.com with SMTP id l14-v6so10202856iob.7;
        Fri, 20 Jul 2018 08:10:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlEBXv1WNFqn0nx72QQ1Alhv+Uu34MDTY+hHykFm6uJ9btFv5YHX
        cUacgeK0U9p+lnIGxuPuaZKmb1TPH1n4M6l0pA==
X-Google-Smtp-Source: AAOMgpfo4qwRTBgy7usK08tIeczYJgY5qEsUc3pBtSkgSx/gOcxS2iK7USj20h2HsSHnkf4P3UveiU44i2yxaZWBLRo=
X-Received: by 2002:a6b:6407:: with SMTP id t7-v6mr2032322iog.111.1532099447486;
 Fri, 20 Jul 2018 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180706053552.11438-1-daniel@zonque.org> <20180706053552.11438-2-daniel@zonque.org>
 <20180711150157.GA18150@rob-hp-laptop> <5070717c-4c9f-c580-8f50-2369dcd74aef@zonque.org>
In-Reply-To: <5070717c-4c9f-c580-8f50-2369dcd74aef@zonque.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Jul 2018 09:10:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL10WT5AK37_8o3M_=UiLx_thcm1W3UNz2qBaB5dRo8XA@mail.gmail.com>
Message-ID: <CAL_JsqL10WT5AK37_8o3M_=UiLx_thcm1W3UNz2qBaB5dRo8XA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, Mark Rutland <mark.rutland@arm.com>,
        szabolcs.gyurko@tlt.hu, Sebastian Reichel <sre@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 6:40 AM Daniel Mack <daniel@zonque.org> wrote:
>
> On Wednesday, July 11, 2018 05:01 PM, Rob Herring wrote:
> > On Fri, Jul 06, 2018 at 07:35:48AM +0200, Daniel Mack wrote:
> >> This patch adds a generic w1 bindings document that describes how w1
> >> slave deviceses are grouped under master nodes. It also augments the
> >> existing w1-gpio.txt document a bit.
> >>
> >> Signed-off-by: Daniel Mack <daniel@zonque.org>
> >> ---
> >>   .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
> >>   Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++++++
> >>   2 files changed, 33 insertions(+), 3 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Note that this will conflict with a unit-address fix that I have queued
> > up for 4.18 (will send this week).
>
> How would we best handle this? Sebastian, are you going to apply this
> series, and add a note to the PR for 4.19 on how to resolve the conflict?

Either 4.18-rc6 or my devicetree-fixes-for-4.18 tag (based on rc1) can
be pulled in. Or just note the conflict. It is trivial enough.

Rob
