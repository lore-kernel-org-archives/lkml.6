Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62732C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A3C208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A3C208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbeGKOAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:00:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33029 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:00:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so15604711edr.0;
        Wed, 11 Jul 2018 06:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pSOMbzFEMzEzZ3pl/qaLz33bAlLlEYF7aakQfvmSQfg=;
        b=fcPDFVOqi3Vyq0fp41/LGyO4aqIddfMCxEAjBpSHnFGxqpm1HXHClCLDFTixb3V87X
         L4dgWx8dopc5EIUZP/ZCwmIedH2l6p6mShjWVNFALWX1SvmVyN7vxaB3zHWzWz6UWi5Y
         UBGfCQMsTEyjX0DJ2rMILLax58w0SdfuKuCkkV8Kohc2miQBB5rI0md6jfLsyd8ykDG2
         qqCrM4juLLk7CwOaAnKnPC+50WM0WW2tDsBa9DVgGsnfVNfhgQ0tofL+3BJxj8kSdjRU
         05KVDSiBteSBF/E5G56/WgVWIMLCdrjqOIlj8f3/0r5U/dc8dnd0nI2Mz8Vuo3As/hEt
         O5Kw==
X-Gm-Message-State: APt69E1EsAY4LQyZMg5xheU5lJVwZOcYrFYGC549jVVdIokhFTpS2Wuh
        AWZeH2Ua24NaAsO2TBD18+szm3aj
X-Google-Smtp-Source: AAOMgpdpNux2pxxFtP1EB7grote0ZCwKhHXmLacp/3plePke3dSff3Te47oolPr7KPCHGICEiAeC9A==
X-Received: by 2002:a50:b642:: with SMTP id c2-v6mr18074234ede.288.1531317353871;
        Wed, 11 Jul 2018 06:55:53 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id u3-v6sm3074339edo.44.2018.07.11.06.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:55:52 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id p1-v6so18277660wrs.9;
        Wed, 11 Jul 2018 06:55:52 -0700 (PDT)
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr20504958wrr.105.1531317352474;
 Wed, 11 Jul 2018 06:55:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 06:55:31
 -0700 (PDT)
In-Reply-To: <20180711112706.30222-1-jernej.skrabec@siol.net>
References: <20180711112706.30222-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 21:55:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ShNTqYAKXRWwhKxzcyVw512bVmNrr-Kv-oDdVq+=yEQ@mail.gmail.com>
Message-ID: <CAGb2v67ShNTqYAKXRWwhKxzcyVw512bVmNrr-Kv-oDdVq+=yEQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3] drm/sun4i: mixer: Read id from DT
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 7:27 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> case). Old way is to just traverse of graph backwards and compare node
> pointer. New way is to match TCON and engine by their respective ids.
> All SoCs with DE2 enabled till now used the old way, which means mixer
> id was never used and thus never implemented.
>
> However, for R40, only the new way will be used. To prepare for that,
> implement mixer id fetching from DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
