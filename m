Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0379C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DABD214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DABD214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbeHBPAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:00:14 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:21494 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbeHBPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:00:14 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172])
        by mwinf5d89 with ME
        id JD941y0053jmVAh03D94gb; Thu, 02 Aug 2018 15:09:05 +0200
X-ME-Helo: mail-qk0-f172.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Thu, 02 Aug 2018 15:09:05 +0200
X-ME-IP: 209.85.220.172
Received: by mail-qk0-f172.google.com with SMTP id v17-v6so1440565qkb.11;
        Thu, 02 Aug 2018 06:09:04 -0700 (PDT)
X-Gm-Message-State: AOUpUlGZVd8RVkgZTYfrsCS8PZGB/a7zAqtgSs7SpAqHNEBCiAAS6E1X
        Gl+mlkO/O6E/yPlnr7BqtVDiNnu5cdk9khMPp40=
X-Google-Smtp-Source: AAOMgpcCwsdQgYf/qdvD5yQgUeHTjg1+v3SM0LsBtctJbD/Sr1UdyyE4p4vKzEJBEc4mClrBMBpin3Br7ENwiY22mPU=
X-Received: by 2002:a37:5641:: with SMTP id k62-v6mr2535236qkb.40.1533215343764;
 Thu, 02 Aug 2018 06:09:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 06:09:03 -0700 (PDT)
In-Reply-To: <843e41de9fa7d5f87309ff4e0db2ed84a1153a4c.camel@baylibre.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-5-maxi.jourdan@wanadoo.fr> <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
 <CAHStOZ6B-R7=5utGqb49OsFBsUsMVsn=WMrzNK8Wk-zcgbnPuA@mail.gmail.com> <843e41de9fa7d5f87309ff4e0db2ed84a1153a4c.camel@baylibre.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Thu, 2 Aug 2018 15:09:03 +0200
X-Gmail-Original-Message-ID: <CAHStOZ6v1CAJ-7UVo6V3H0Eu3cYd8x7xSAx33EbO6Eptj0vgdw@mail.gmail.com>
Message-ID: <CAHStOZ6v1CAJ-7UVo6V3H0Eu3cYd8x7xSAx33EbO6Eptj0vgdw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/meson: convert to the new canvas module
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-02 15:01 GMT+02:00 Jerome Brunet <jbrunet@baylibre.com>:
> What I don't like is precisely that you need to expose this 'struct ops' to the
> consumer. I would prefer an API for this (it can be a 1:1 mapping). The canvas
> should remain some abstract object you get from DT.
>
> IMO, this is the same as a reset, a syscon or whatever other phandle you get
> from DT. The consumer should not have to 'care' how it works (how data are
> organized), it should just use it.
>
> Whatever you need to do to deal with your canvas phandle should (IMO) reside in
> your soc/amlogic/meson-canvas.c, and not be spread in the consumers.
>
>>
>> I agree that the "fetch the node" boilerplate code could be put behind
>> a helper, but at the same time this code helps remind the developer
>> that there needs to be a canvas node in the dts, and that it has to be
>> linked in your own device node.
>
> This is why we have a DT documentation.
>
> And, as far as I understand amlogic's display and decoder stuff, you won't get
> very far w/o a canvas, so 'the developer' will be reminded fairly quickly ;)
>
>>
>> I would like to keep it that way if that is okay with you.
>
> It's just my opinion, I'm not the one merging it ... :P
>
>

Fair enough, I'll see to API-ize the module in v2 :).
