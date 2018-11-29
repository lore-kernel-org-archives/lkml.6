Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A248C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06169206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rDzDTkc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06169206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeK2Lid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:38:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45912 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeK2Lid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:38:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so81750pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hndcEIZvQSPxo331N4IP2E3Cu/Bllx4uMSSHcVyGMbs=;
        b=rDzDTkc1rqdCDn021yXemMAI/PGfBc4LcVeeCp451EsSqOr62YTwKA9Lg8zpiZ41cn
         uXgys0veMOi+lUCpcSVzvg7S5pT1M1vz8MudcGr3ynYUH8xkpThiBZMXFaGyo1Mvc3CE
         wpn3yf1AtbSo+xDwf5eWtvqPJTe8tRD+KInbOFl8s54WCrozRCK/iuQtppIABAJ+A5N+
         1Jpk25n/gPAutYwmPJYLMDwd03c+pu2J05jWCUFLC2v0ULCjwFdJBy0dhSTM3lWu9lDX
         uEmmphxwU8JT/VxQhgw09FMdXclbWFH/7d+1GkS3PbPzuhpf1mOlTzbLP+EBQ69BNP+j
         3S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hndcEIZvQSPxo331N4IP2E3Cu/Bllx4uMSSHcVyGMbs=;
        b=GWdItbg5CQ+nqXZj5BE0d4WF4rXWx/dpyV2HaS3zHbTf/e4tzsDEFPVWzzPt6l6Tl/
         NbWFrAuPD2VyrAIJVebdiB660bGfSmjYuP86fvEfkmNDKgmbVnvThyIVDC+l8MV7I69M
         lTMXzlFVyl5li0su88Pb7QtKYa/wygm+xSQ+nv0mYRnEKvhJsKldrtAeQcdsR+IB0QK5
         9/PRJvMRj4cnJA4WcXCjW+vj98fh4kjeBqFnxUQXSk4P5gXfcH0JLVsTVeHZYZaNthyY
         YSK8Gr4KDADBUftJFfzrDmMSyHwv3KiBvm+7S3+OKE5/xHBeb+QNwUPGodvIpq0/maiE
         fwTQ==
X-Gm-Message-State: AA+aEWZvrFVXhAgfrFjav1l+3mduMBVTmqSvp03CSZ0lk0f2gEr7ERL2
        RG2MYD9pEXub/4NhnZlVGCnNwg==
X-Google-Smtp-Source: AJdET5eNbymMWRP6oVFgUZR7KcmYlW27zVjbx/sq+Jk0CfYWqYxj+BXqPviuj0HAmUvdZFsoQW4DqA==
X-Received: by 2002:a63:4e15:: with SMTP id c21mr35208834pgb.50.1543451704773;
        Wed, 28 Nov 2018 16:35:04 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id t13sm127956pgr.42.2018.11.28.16.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:35:04 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Carlo Caione <carlo@caione.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] ARM64: dts: amlogic: Add all CPUs in cooling maps
In-Reply-To: <2778d0d4813cc56be851719846afecbab5f2e657.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org> <2778d0d4813cc56be851719846afecbab5f2e657.1542362530.git.viresh.kumar@linaro.org>
Date:   Wed, 28 Nov 2018 16:35:03 -0800
Message-ID: <7hd0qod8lk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
>
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
>
> Update cooling maps to include all devices affected by individual trip
> points.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued for v4.21,

Thanks!

Kevin
