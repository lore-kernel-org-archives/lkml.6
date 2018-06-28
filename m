Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CD2258DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CD2258DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeF1CTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:19:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37928 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeF1CTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:19:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so4195825edt.5;
        Wed, 27 Jun 2018 19:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W3OzRr4qg91qelgZsB7L7s64ueBFhAMb+xEJ23OGPo8=;
        b=hH9Mq/7rPK6MtCXMvJ2SaRd1nOIYU9ZzDBuInnvUPVT6qHysICWNjTrGbeIRxBPpB3
         cLTTAJRZV/7PKMg0idPa/jRwNuysdummAhNJklMowdmbpjpaUODnYyp5H597UbHeVg4/
         Mt23Up3YEljXOcA0Tsk0UaZhmBQeTyecoEpAuRwhL1sPeagNJPzOm6oCqcdOnuekbpEf
         11KXCgAYuNbYaCS1gy+7LA+S1i58sS35iXg4ykGZwspwdmXNDoOqrYk6XmP5rZJsvePo
         am3A4XEwzE6s0mdxZGyl7uyRnkqjVjoYPBqDHaeUpfRIXBQgQpSsFr5pH9JaFt1iWuBH
         cNRw==
X-Gm-Message-State: APt69E1N00IetMUUK2jDMX3yXdF2O5ijkkoZku3U4EsmRll4axb6OgXO
        z+of4faCjbTk2QhPEyVIkV4pVWgG
X-Google-Smtp-Source: AAOMgpczADoY+FxJwuUvy87rhyJNA2wN4vxFSGnlLlKHQbQcvhnPRAbk2OOcvsKXOHKVvh90SI1kLg==
X-Received: by 2002:a50:8405:: with SMTP id 5-v6mr7175251edp.125.1530152356116;
        Wed, 27 Jun 2018 19:19:16 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id d11-v6sm2880032edo.63.2018.06.27.19.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:19:15 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id e16-v6so7750802wmd.0;
        Wed, 27 Jun 2018 19:19:14 -0700 (PDT)
X-Received: by 2002:a1c:454f:: with SMTP id s76-v6mr6535252wma.16.1530152354698;
 Wed, 27 Jun 2018 19:19:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:18:54
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-15-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-15-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:18:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v673mEZD_kMjhEmJtAzYK5NyH6TSFKPBXTaZ_YirK0P_qg@mail.gmail.com>
Message-ID: <CAGb2v673mEZD_kMjhEmJtAzYK5NyH6TSFKPBXTaZ_YirK0P_qg@mail.gmail.com>
Subject: Re: [PATCH v3 14/24] drm/sun4i: Add support for R40 mixers
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
> Both mixers have similar capabilities as others SoCs with DE2.
>
> First mixer has 1 VI and 3 UI planes and supports HW scaling on all
> planes.
>
> Second mixer has 1 VI and 1 UI planes and also supports HW scaling on
> all planes.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
