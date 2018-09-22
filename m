Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566ACC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA1420870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wqnCHWWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA1420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392186AbeIVGPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:15:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45040 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391689AbeIVGPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:15:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id 36-v6so14666860oth.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzKt0H2ASyMiPG5GQif8m/Z16u/iKRM6Kn8x29FcSMs=;
        b=wqnCHWWyinc9sruuvoNgd7Qt0W+kTlu5uCyNCV6I2tdCwwL166ufg4VdXoS30otW6B
         7XFnIyT+9mP2Tdvi1L+wUEs6iDlFeeilcM+1MXB+tAhWpMtykn9DVuWk+mkKisdxLu8a
         SIKY0Qrf1Cj7pTUQVK9j1Pjll00UT6Nb4agIUao4tK1EHPzhZ9Vpdrr5bsbfMVrzGVZt
         GEFTlcXRlc4amqSGOPkWqyUOAn05fJFG6j3etfRaIRMSCE1N/iVBKoMLr1AdFiCLYxfV
         Si5d1QYVadFxTWyygSv1F7SsSVYbF8HUnx3xwDkqiKJLWoW1wYPLHnHHxYgKcUUaRTxU
         g3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzKt0H2ASyMiPG5GQif8m/Z16u/iKRM6Kn8x29FcSMs=;
        b=TxpCuLafBSYE/zzg7/Gr3+iQH5epYk501hLQ6p5Mw+Lp4TfLV+gxauj90AYvTzMbLR
         hmJo9L6d0Zgy3ukNKqD8OFNUWuKBDFlIT6EBv1TIxtfEX8UjryKX22W2xx+QiKthTwg3
         p7xZVWCG4u3L1NQ6px6aYLkbyLNBH345ez9QTvlPSbReT1uzVx8P66Y8hhBHom9fVLPm
         GeTrV7Sg152kA1kaXcusclmm9TQQ9Ny1Nx4c3NtmYbx8nRt9iZsTm4IXYUWY1EoYDJj5
         071AsjzOb1ym1dj3K4nxWNNVdAMO6z4kuFb4lPoM5x6cSmA/EP7JVw0vo5klMD+z2Wua
         z/aQ==
X-Gm-Message-State: ABuFfoh4XzHHVNJeFehV7vrkyU85N+Yq68+a6BOtprDqS1OPA4D22PW9
        zcQXtoJmQjujZeoz/NkgVbQ6MlDhGaCK0bYwLB7e4g==
X-Google-Smtp-Source: ACcGV63HVdzGjn1uIJvedQNRtjRFBl3QtiNaYet2CoYdxyqLfpvIWVd+buS5a+4Gift83Qwm+T2W/eNGb9Q2Iaw6iHY=
X-Received: by 2002:a9d:50ac:: with SMTP id b44-v6mr93472oth.267.1537575873762;
 Fri, 21 Sep 2018 17:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180919125848.6570-1-pagupta@redhat.com>
In-Reply-To: <20180919125848.6570-1-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 17:24:21 -0700
Message-ID: <CAPcyv4hnFHySmhiBeiYKNsCq0xmbqOXp6LWvUpnGHo+zAA=TUg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: remove duplicate include
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 5:59 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> Removed duplicate include.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/nvdimm/nd-core.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
> index ac68072fb8cd..182258f64417 100644
> --- a/drivers/nvdimm/nd-core.h
> +++ b/drivers/nvdimm/nd-core.h
> @@ -14,7 +14,6 @@
>  #define __ND_CORE_H__
>  #include <linux/libnvdimm.h>
>  #include <linux/device.h>
> -#include <linux/libnvdimm.h>
>  #include <linux/sizes.h>
>  #include <linux/mutex.h>
>  #include <linux/nd.h>

Looks good, applied.
