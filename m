Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38106C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B2C25B70
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B2C25B70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeF1CSV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:18:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45250 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeF1CSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:18:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id x22-v6so4190417edq.12;
        Wed, 27 Jun 2018 19:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3gfKohr3AfdYTs5nSg0MTXAmMKmuACwolIM/ah/Usd8=;
        b=pFbow34egCij7h5sH8xjCWPkMydfRLdZGUwG634g3vbL2y9IeMjB9NV4x6WuS8Y2AG
         ClJx6E10xFpuN1+/ifK7YkaxXdVYBW7ShkcRMU9cmN7acf2msSHdzRWFYQdC2b0PKZ2P
         8nEeAJghWwVtZdF/s6q4pdPW9bhpnHqZzDlU0xu1buHO6LAiEjxN+8Y9xwZv/IE2zq7U
         MkmZhzu+6tSEqq7ZxAUL2e84b9R6bnnLN3CvQTYdA7zfPcSIHi48HiOVDPP2DPp/82QM
         aAw2WZyskOa6Qt4g0/eGQXYCxsPgQ5oLA7VUDb51qbcAAzwS5DlYRG8JTaT5Q/lJg0OR
         YpUg==
X-Gm-Message-State: APt69E0hCpzCFTSQs9e2RmjqzYuohWhDhWoFdWbhoxQSZLK4oHB29g/F
        Ly+2X7KALRuBlicaSsBrek7gBdBW
X-Google-Smtp-Source: AAOMgpeSrJIEshMCzsHkci3sfNW3whumrgSCVEV9RKGJKRMJquZEGEOzqazvGCgZ8lMqLThWO1y78w==
X-Received: by 2002:a50:f4d8:: with SMTP id v24-v6mr7675881edm.162.1530152295216;
        Wed, 27 Jun 2018 19:18:15 -0700 (PDT)
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id y32-v6sm2399962eda.38.2018.06.27.19.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:18:14 -0700 (PDT)
Received: by mail-wr0-f180.google.com with SMTP id h10-v6so3819363wrq.8;
        Wed, 27 Jun 2018 19:18:14 -0700 (PDT)
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr6950364wrr.105.1530152294296;
 Wed, 27 Jun 2018 19:18:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:17:53
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-14-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-14-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:17:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v67wgNUmK20r2u9DyZ-rP76GG9_spob3AQM681N3xLSewQ@mail.gmail.com>
Message-ID: <CAGb2v67wgNUmK20r2u9DyZ-rP76GG9_spob3AQM681N3xLSewQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/24] dt-bindings: display: sun4i-drm: Add R40 mixer compatibles
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 DE2 mixers are similar to those found in A83T, except it needs
> different clock settings.
>
> Add a compatibles for them.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
