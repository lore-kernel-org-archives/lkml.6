Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC13C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02BF2186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550437708;
	bh=VjgWKBrAGiRK1KqNr6D/pSf3vwKER3XAlgc+J1todFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kEUM4s6l3KpGw3qdcqJXKuk+g46dJNBnKeBAmg7d9hFeCxx2rgTeSWOVLFKp+zWhm
	 cq30U3N+zWILQDLS9fZ8OMxqKGYCVKggvpfEBlFY5zuwXnBS9+tOmt5f9RLIylX630
	 ee0ml9APbDsGaECN7H0ds2fAkG1t/t3V4RxwCVsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBQVI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:08:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfBQVI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:08:27 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BBC218A6;
        Sun, 17 Feb 2019 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550437706;
        bh=VjgWKBrAGiRK1KqNr6D/pSf3vwKER3XAlgc+J1todFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lushgwu3PGm09zj8znG4dVyzyi3zM5Tm20wunnlIRCQ5ynOubQKTR61Z5K2jZSjFq
         IqqfF90niZViHDjGtgSPpsXU8SwteT6gYGNWgVXtjT86ZQH0XQ4ccJclkLKm/WkUeu
         iSJL4Kz9AHRs/I1kv88wzfOuwD4RaBlnypCh9Ekc=
Received: by mail-qt1-f169.google.com with SMTP id o6so17135226qtk.6;
        Sun, 17 Feb 2019 13:08:26 -0800 (PST)
X-Gm-Message-State: AHQUAubY6vtUN73PqIGPR//4dPaf+HdCqcZUNost78zlXOsaUFVNNGsu
        J/5pkeu+n5r/P/VxF8yazosl+lOC+zPwJWpTTw==
X-Google-Smtp-Source: AHgI3Ia5fcrTqgzUD8CRAAUGJ6Z4NacRgN1SaCsAxVaVbCtpsAj7NuIeHCukqU4Necdf3jjX8rMNUJYZ6BLPDMU+t8g=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr15190092qvi.90.1550437705335;
 Sun, 17 Feb 2019 13:08:25 -0800 (PST)
MIME-Version: 1.0
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org> <1549296944-17285-3-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1549296944-17285-3-git-send-email-jcrouse@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 17 Feb 2019 15:08:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0FX=dbQb34bvZcdbWibjKnS2VXGsApT_Vz+UcjUxCSQ@mail.gmail.com>
Message-ID: <CAL_JsqJ0FX=dbQb34bvZcdbWibjKnS2VXGsApT_Vz+UcjUxCSQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] dt-bindings: drm/msm/a6xx: Add GX power-domain for
 GMU bindings
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 10:15 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> The GMU should have two power domains defined: "cx" and "gx". "cx" is the
> actual power domain for the device and "gx" will be attached at runtime
> to manage reference counting on the GPU device in case of a GMU crash.

power-domains are supposed to be actual regions on a chip die which
can be power gated. However, they are often abused by being defined in
terms of kernel PM domains which are not always the same thing. This
description sounds like the latter case.

Rob
