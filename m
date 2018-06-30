Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CA2C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A37D280F8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A37D280F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936844AbeF3BLv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:11:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35120 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934996AbeF3BLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:11:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so8175609edt.2;
        Fri, 29 Jun 2018 18:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cYJfxaw3pnudhB4+vfg1WRfg7U8DHSVUVPWndQxasGs=;
        b=Nk+VhMByqErvakvtsXAOccH/bqXY+lkXDBvifKddXZdU8AN3VsJndVV+En7Z3w+9w+
         AU8aXAx8N3/huqATQ/cXOneGUDOilL6Erc23Y0KFvMzwIsWkGhYETB8udlQiRn3PuAfj
         l9dZ3+lY6IaBKb2seKahZpkaP2eJQDz3EGXfYycY2mbIvNFImJrIlyapT3wB1G4zXu2g
         etuvzo+yFVyrUuakJi3CXR1M9iKKirq63LdI7Hm97haYjIkaSiREnybMM2ot4WcwpGsG
         d3S2MN9SPV55CsVRvlLDoyTIak8rvG2ts5nzkkBE/HSKvCzMdpynpXj0V77xMYyN9v4X
         sj6w==
X-Gm-Message-State: APt69E2XQjwglogKyGfO4aKemyfA1/r/WlHJZbspdKfJOi0YtHmwQjWi
        rm+7DTzpYQMDNxyqR7knKftAfo/9
X-Google-Smtp-Source: AAOMgpeayOr7gThVGcO3u/aC82uOnZQJIvyj9I7RGd4Pn7EOqgIlIpKoStgCkxz/bLGb8F6GkahZtQ==
X-Received: by 2002:a50:90e7:: with SMTP id d36-v6mr14119043eda.279.1530321103188;
        Fri, 29 Jun 2018 18:11:43 -0700 (PDT)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id x40-v6sm1095383ede.23.2018.06.29.18.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 18:11:41 -0700 (PDT)
Received: by mail-wm0-f48.google.com with SMTP id n17-v6so3651101wmh.2;
        Fri, 29 Jun 2018 18:11:41 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr3179899wma.143.1530321100951;
 Fri, 29 Jun 2018 18:11:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 18:11:20
 -0700 (PDT)
In-Reply-To: <3131254.YlICBQirlu@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-17-jernej.skrabec@siol.net> <CAGb2v65En4RbVdRu7c6MJUztVhC36dWr0kaO9bqc9PtuXAcsww@mail.gmail.com>
 <3131254.YlICBQirlu@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 30 Jun 2018 09:11:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v64UY9t9oKPQiEJkFsTyxJOJTG9dvJMNJYoHy7CKQ4Ap2Q@mail.gmail.com>
Message-ID: <CAGb2v64UY9t9oKPQiEJkFsTyxJOJTG9dvJMNJYoHy7CKQ4Ap2Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/24] drm/sun4i: Enable DW HDMI PHY clock
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 3:19 AM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> Dne četrtek, 28. junij 2018 ob 04:22:36 CEST je Chen-Yu Tsai napisal(a):
>> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > Current DW HDMI PHY code never prepares and enables PHY clock after it is
>> > created. It's just used as it is. This may work in some cases, but it's
>> > clearly wrong. Fix it by adding proper calls to enable/disable PHY
>> > clock.
>> >
>> > Fixes: 4f86e81748fe ("drm/sun4i: Add support for H3 HDMI PHY variant")
>> >
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>
>> So why does it work on the H3? Because there's only one PLL that the whole
>> display pipeline uses?
>>
>> We should probably tag this for stable. So,
>>
>> Cc: <stable@vger.kernel.org>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> Same question as before, how this should be handled? Can I send separate patch
> with same content to stable ML only?

Yes, including the hash of the commit which is already in Linus' tree. So
you have to send it after the next -rc1.

ChenYu
