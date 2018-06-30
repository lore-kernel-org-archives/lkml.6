Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE4DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C2927365
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C2927365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936726AbeF3BK1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:10:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38140 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933615AbeF3BKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:10:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so8169482edt.5;
        Fri, 29 Jun 2018 18:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B851uiW137F+Ir2WRxenTuEtm5kPvpqwRv9uzBn+S4A=;
        b=cB1n3BsGQOLk+2bmfaK00SdQORrKaQUSf/62/xLI46IDbiwhlxf1kViVlZx+mh1YTX
         hZlc3XePSg4eSCGgt8UImocyY9y92zyNVsXwm3SZ1jOYzx6iaUH+TpqlnkUMflzsFp5V
         DdP5wuY0M2xwKYUIzWGur2NKToVfxQS3wUNDFPJSHAe86BdqAebzbBC19swBtGET96kR
         Ez8Yy7S19nq55vwntE5TsShJZ48XbMafPoL5E98YxONRPHXy79lgunSyKOKJYdDfGXAF
         E8v7hPqVYouynspz7gpdkRlxdexWoc7uUo0wIAfq7qe2L14UUhr1DgPqIGCcweylCBlf
         lYFQ==
X-Gm-Message-State: APt69E0Aj85P+vb89EctuBScC8Hbs6sQyW6L/BbnI5WKUU+aJbGPzEHr
        zXco1PJn036IHOgTKcRPZp0tGD/Y
X-Google-Smtp-Source: AAOMgpeKtrYfsbGjKMBfdr2sjoR7LDcWh6Y5MrzCgAkQ/lr27FOc2hc/7oLSMF1u5yi4UspeGvK1ow==
X-Received: by 2002:a50:e615:: with SMTP id y21-v6mr14846299edm.278.1530321021103;
        Fri, 29 Jun 2018 18:10:21 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id t3-v6sm4438893edq.50.2018.06.29.18.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 18:10:19 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id v25-v6so2800429wmc.0;
        Fri, 29 Jun 2018 18:10:18 -0700 (PDT)
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr446798wmi.16.1530321018190;
 Fri, 29 Jun 2018 18:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 18:09:57
 -0700 (PDT)
In-Reply-To: <3837144.KdEe8HRubn@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-7-jernej.skrabec@siol.net> <CAGb2v65dNvqcWa7MUMesrEeDGfEmd0xPpKQmbqJ60_FHe=Y_JA@mail.gmail.com>
 <3837144.KdEe8HRubn@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 30 Jun 2018 09:09:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v65xZe8VM+dOd1fchXgekpgzvj1s75zdjz-6Met4K-5nBg@mail.gmail.com>
Message-ID: <CAGb2v65xZe8VM+dOd1fchXgekpgzvj1s75zdjz-6Met4K-5nBg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 06/24] drm/sun4i: Fix releasing node when
 enumerating enpoints
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

On Sat, Jun 30, 2018 at 3:15 AM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> Dne četrtek, 28. junij 2018 ob 03:53:36 CEST je Chen-Yu Tsai napisal(a):
>> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > sun4i_drv_add_endpoints() has a memory leak since it uses of_node_put()
>> > when remote is equal to NULL and does nothing when remote has a valid
>> > pointer.
>> >
>> > Invert the logic to fix memory leak.
>> >
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>
>> Given this is a fix, it should have Fixes and stable tags.
>
> How should be this handled given that the patch is already merged and cannot
> be dropped?

We can't. We'll have to manually submit it for stable once this lands
in Linus' tree.

ChenYu
