Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52F8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A533E222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550081268;
	bh=pFzHBbCvdyq3cVECZQGHRYjMJbo1Pa/rj/4nX+yOaHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ip2IX4juMezXI94qXrbasRXmQ5tXdyCM826sACHpZIOlptMnAJ2fCEZyDK/B0HsP5
	 wfx8s2E2ZfaQV52V5YlFPv4ryqwgeQEN76C9XJcY2F7wvg6FPL2aLvjXEUVzwoWOgD
	 TAtFKlUiNfS+g/7pBVWNgz8yCjaGmY1VSdAD3/SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404723AbfBMSHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfBMSHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:07:46 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9C5222D4;
        Wed, 13 Feb 2019 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550081266;
        bh=pFzHBbCvdyq3cVECZQGHRYjMJbo1Pa/rj/4nX+yOaHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f/TOVYckq3R4+dKDOQGnYn9AoprZnEJ5QhDWQTAZSmgmwkCBf8BmV2VT64Is6YCLF
         vmLBpJ+jLGqtjrD+U/BcFW5PJL5RAnUa4FAj7pN3X+suVA5AQclHRzdri/cxhjk9aW
         y5hVxI+ROjuUu5XyIjczPW4w6KI5gJfe7/9XnhB4=
Received: by mail-qt1-f182.google.com with SMTP id p48so3701112qtk.2;
        Wed, 13 Feb 2019 10:07:46 -0800 (PST)
X-Gm-Message-State: AHQUAubeUy2li9bntPzlTAQF5kE+7turtxnw8vebI9BDtiVjnbOa7eYq
        MzeRB01ei8TRWyE0Lj1LnvyW+xQh8sWpJd7Ilg==
X-Google-Smtp-Source: AHgI3IYphD4gEEwpJbEIpPFLGoDVstelpR9/ORtmI0GcsKt6TQwo76r2bXs9BQV+GdDuIJRthULn7an6OBk+fC2wtfo=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr1516910qtd.144.1550081265290;
 Wed, 13 Feb 2019 10:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-7-robh@kernel.org>
In-Reply-To: <20181205195050.4759-7-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Feb 2019 12:07:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPJet11X3pru1u5hEUVUH_SCcmncVAaesfDrzxtUEGEg@mail.gmail.com>
Message-ID: <CAL_JsqKPJet11X3pru1u5hEUVUH_SCcmncVAaesfDrzxtUEGEg@mail.gmail.com>
Subject: Re: [PATCH] drm: imx: Use of_node_name_eq for node name comparisons
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which this is.
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/imx/imx-drm-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Philipp, can I get an ack on this? I can commit it.

Rob
