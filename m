Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 214DBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8BB2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8BB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbeFMIEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:04:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40678 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbeFMIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:04:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so3458831wmc.5;
        Wed, 13 Jun 2018 01:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2KwO9bdDHrW4VEGYUkZAbm/f3ErEFVi8KQjEohL0RUc=;
        b=bHnuUkcnlLcZBwoSnei+uVXazu/nQ42X0EpPDDvm2OyAp38y1l9nhF1UhXrGVnwLi1
         mGzb+6ja4ytuczGGB4EuDfg5al7ec9ZePs6LXJIMbuweYR9APHsWQkXPYERMJNklCWfe
         wUVA2MyHO5yMGIE6Z6eXrGEVc/PsAF9fZW8M5zDrjCVk1AvJyfTsozCjUaRyTR2dL15J
         Xn0+zIhqTDF/HEX+T+LLhMm4b5Yt2IjTgmRLsMfr8xE24OAYHMWfxnP6a9hOtdJLJRwK
         G7Ovphb98g7FhpN6mFQfLuy+6LNaV3w+HwbpKqbnpzN5TQZES4yt7r4e2lAtMd1Ot0Pr
         sQHQ==
X-Gm-Message-State: APt69E1+PTB6T94y8Yo3yjlXNYSnRsj3llnAq4WfI4eNbRWfWmcsP78p
        6ZXt/4GwtfTtua/IcvTLo/no8CtZ
X-Google-Smtp-Source: ADUXVKIxazK5mUbULuhUy7hm5OylvOD8o9pU4cUW9+6/y/bzdi0iMOFnqJJv4Yhca/ZlX3a1LDc7ZA==
X-Received: by 2002:a50:9442:: with SMTP id q2-v6mr3011044eda.70.1528877082713;
        Wed, 13 Jun 2018 01:04:42 -0700 (PDT)
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id m19-v6sm986111edr.33.2018.06.13.01.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 01:04:41 -0700 (PDT)
Received: by mail-wr0-f177.google.com with SMTP id d8-v6so1684726wro.4;
        Wed, 13 Jun 2018 01:04:40 -0700 (PDT)
X-Received: by 2002:adf:e94e:: with SMTP id m14-v6mr3264615wrn.126.1528877080735;
 Wed, 13 Jun 2018 01:04:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a158:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:04:20
 -0700 (PDT)
In-Reply-To: <20180613074621.5phumovcyymbkfbn@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-15-jernej.skrabec@siol.net> <20180613074621.5phumovcyymbkfbn@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 13 Jun 2018 16:04:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v66QWr2CQhcfQ9BQds-0xeG=pS4MDzaNn7_HGz+q3gfkWA@mail.gmail.com>
Message-ID: <CAGb2v66QWr2CQhcfQ9BQds-0xeG=pS4MDzaNn7_HGz+q3gfkWA@mail.gmail.com>
Subject: Re: [PATCH v2 14/27] drm/sun4i: Don't check for panel or bridge on TV TCONs
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
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

On Wed, Jun 13, 2018 at 3:46 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Jun 12, 2018 at 10:00:23PM +0200, Jernej Skrabec wrote:
>> TV TCONs are always connected to TV or HDMI encoder, so it doesn't make
>> sense to check if panel or bridge is connected to them.
>>
>> Check if TCON has channel 0 and only then check for connected panel or
>> bridges.
>>
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index b1205a7bc20f..c9ffa5381185 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -1189,13 +1189,19 @@ static const struct component_ops sun4i_tcon_ops = {
>>  static int sun4i_tcon_probe(struct platform_device *pdev)
>>  {
>>       struct device_node *node = pdev->dev.of_node;
>> +     const struct sun4i_tcon_quirks *quirks;
>>       struct drm_bridge *bridge;
>>       struct drm_panel *panel;
>>       int ret;
>>
>> -     ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
>> -     if (ret == -EPROBE_DEFER)
>> -             return ret;
>> +     quirks = of_device_get_match_data(&pdev->dev);
>
> We should probably check ofr the pointer value before dereferencing it.

I think we've discussed this before. If the driver has data structures
for all the supported compatible strings, and it is device tree only,
then we should just let it blow up in the user's face, since they are
obviously doing something they shouldn't be doing to get the driver
to probe without a compatible string match.

ChenYu
