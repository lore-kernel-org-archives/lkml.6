Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2537AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F7226FDE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F7226FDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeF1G72 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:59:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41631 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeF1G70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:59:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id b12-v6so4483533edt.8;
        Wed, 27 Jun 2018 23:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U3ivltB5NPgkWDRA2ek/0OwMf6Yk2NzDbTIa/6EgiLo=;
        b=Agdpr1qKBN0oa415Bdy9JEhxU/3vzDCEnxBoL3GWeCoA7ZsVVrp5z2ieHRHFLazxkF
         Lh8T9tp51uDeBMHOfbUhrapjXY0jPJ3tSP2knn46x0EDWsfh5GU/cCGYs/oyYJhX+Q2P
         TDLcf4/GgrQV1R+/cCLDAPpcSjCN4cvjNXHKlkxo9fVZLDbrruFMGipAWELP76m3SkD/
         p2zNs2oX3Z+B7qvz9RyLmb7XHfa6Nhq71sDx5+mOOkybwREXjIjVZfWOFqdsoM+zhIo0
         AUji5EPFoPuJ3Hz6G4OgbOPYzAxPa91wDrMabbAOLMo5nuh4kkN21fpG5OduNP5Ww6EZ
         leUQ==
X-Gm-Message-State: APt69E14+Tq2TII3xeNZrSQIksEEZfz8c82LqhVT/M1yJGc9rtoKI7le
        zM3lVtJ3Uv0Y/USrIO8XF+9kviEW
X-Google-Smtp-Source: AAOMgpehFGd+L86vSq1BW9yjREXJd7tL6uGARjNpG+dPxEBtkOWw/McvL+FB27cvIZa91nuReHV5hg==
X-Received: by 2002:a50:84e9:: with SMTP id 96-v6mr7991841edq.118.1530169164675;
        Wed, 27 Jun 2018 23:59:24 -0700 (PDT)
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id g33-v6sm1321581ede.10.2018.06.27.23.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 23:59:23 -0700 (PDT)
Received: by mail-wr0-f171.google.com with SMTP id c13-v6so4293030wrq.2;
        Wed, 27 Jun 2018 23:59:22 -0700 (PDT)
X-Received: by 2002:adf:ca13:: with SMTP id o19-v6mr7552031wrh.148.1530169162728;
 Wed, 27 Jun 2018 23:59:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 23:59:02
 -0700 (PDT)
In-Reply-To: <52771065.UHJ1SZMy5a@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-19-jernej.skrabec@siol.net> <CAGb2v651RGegpAi-2efhBUkyFf1iC+zxOGTbRkmjuWcYSTgYJw@mail.gmail.com>
 <52771065.UHJ1SZMy5a@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 14:59:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v66HOrbjm4w-EoVpvPde7SoVE5X3tfcyW_Ny-vQ+ax141Q@mail.gmail.com>
Message-ID: <CAGb2v66HOrbjm4w-EoVpvPde7SoVE5X3tfcyW_Ny-vQ+ax141Q@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 18/24] drm/sun4i: DW HDMI PHY: Add
 support for second PLL
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:56 PM, Jernej Škrabec
<jernej.skrabec@siol.net> wrote:
> Dne četrtek, 28. junij 2018 ob 04:25:54 CEST je Chen-Yu Tsai napisal(a):
>> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > Some DW HDMI PHYs, like those found in A64 and R40 SoCs, can select
>> > between two clock parents.
>> >
>> > Add code which reads second PLL from DT.
>> >
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>
>> This patch by itself does not do anything. It should be merged with the
>> next one.
>
> Maxime said clock changes should be separated from DT changes.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/578775.html

OK. I think the boundary between these two is bit blurred in this case.
And I think implementing support for two or more parents, then actually
adding the second parent makes more sense.

ChenYu
