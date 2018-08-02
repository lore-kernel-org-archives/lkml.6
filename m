Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3520421501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="acTf64q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520421501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbeHBOww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:52:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51076 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbeHBOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:52:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so2441888wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDrKni4UF4qB4c66vNLtEVRQwqI+Pn5j7eMBwkFr7RE=;
        b=acTf64q3Mx45mn+JRkrZNj/Gx2CqwCB2lFUP9TPNek8ja6844xOkwyti/rtzYntDtK
         Bge/H52LhO9CjmnBgm8emEETvVSAvE/tGTFPSVgP8PsACgdfPDtsBvACraA2140ChlNI
         TMGhNq0D/clcVqq3IBzbAxTToz3SqOd4uDnppTxDezC/Ipe1IikY/H3vNc82oDePw6o2
         3uIMcpvnBLtKhrHMFAvENb7RJU1Nk8GNKtUmCeiFjOrPyiB8nmOn/wJxWxmB43U1BQkh
         UZWXqLyiS1UGDhg4JAwvZC12EfQOEauFsNfB9RgMUs4LUBHYen86N7TWXatyRgUBmtQA
         tIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDrKni4UF4qB4c66vNLtEVRQwqI+Pn5j7eMBwkFr7RE=;
        b=UoOeqBKUlvxea9O1YnghqwX5+dp1mjiLbwiD0+opJy5wa6kC5Yf9TdA3beU93BIR93
         GWyfJU1Qi//zGO3h+t0pgRRMxduPFCBqvXW2enlzGojyzXWnKYzRzjdCHucENMujjTxZ
         GCsDxzSAshWUIj/yhunyHDUDRD2/UBv7mvr+cx/3ANO/zUTLJpqEPNxg9g6oNJ/mFiLl
         dgiztQaDZgO+2XsB4HTulTxQQDAxIw6PrO5ATtgE3R5Q6yV7GGCl7vWdPzCrZHRJ3Uoz
         Ph3ap5QAvr4uMTJdGmb7N9B+sOLAMcASrkFMwE9cLtiKWx2GVOWy+/WkD6+wmpKkJbNZ
         8Sig==
X-Gm-Message-State: AOUpUlF7LqZbD4asXL/GaN6+C05cTjZIIwAOVD5VSrh7JcXGVK/H1j7N
        TGchPKyGh8n3fW9a/zleYycoBg==
X-Google-Smtp-Source: AAOMgpeoSaA/Hy+JMAhF4bZ2bvME+AHmp5VP5IbC31eo1CtcjVHoNV/raOxk4+sqJUtwcmQsTXcJyA==
X-Received: by 2002:a1c:cf05:: with SMTP id f5-v6mr1974455wmg.64.1533214903985;
        Thu, 02 Aug 2018 06:01:43 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14-v6sm2271363wrr.71.2018.08.02.06.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 06:01:42 -0700 (PDT)
Message-ID: <843e41de9fa7d5f87309ff4e0db2ed84a1153a4c.camel@baylibre.com>
Subject: Re: [PATCH 4/4] drm/meson: convert to the new canvas module
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Date:   Thu, 02 Aug 2018 15:01:41 +0200
In-Reply-To: <CAHStOZ6B-R7=5utGqb49OsFBsUsMVsn=WMrzNK8Wk-zcgbnPuA@mail.gmail.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
         <20180801185128.23440-5-maxi.jourdan@wanadoo.fr>
         <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
         <CAHStOZ6B-R7=5utGqb49OsFBsUsMVsn=WMrzNK8Wk-zcgbnPuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 14:34 +0200, Maxime Jourdan wrote:
> Hi Jerome,
> 
> 2018-08-02 10:39 GMT+02:00 Jerome Brunet <jbrunet@baylibre.com>:
> > I looks like the consumer of your 'canvas' devices must know how the canvas
> > device is organized internally. Maybe something better can be done ?
> > 
> > Your canvas driver could provide a consumer API, for example:
> > meson_canvas_get(): to translate for struct device_node to whatever abstract
> > pointer you would need.
> > meson_canvas_alloc(), setup(), etc ...
> > 
> > ... This is just adding a bit of indirection but it would help hide the plumbing
> > of your canvas driver from the consumers (and repeat this code in each). This
> > might be usefull if you ever to make this canvas driver evolve.
> 
> Overall the inner workings are hidden as there is an ops struct
> instead of public functions.

What I don't like is precisely that you need to expose this 'struct ops' to the
consumer. I would prefer an API for this (it can be a 1:1 mapping). The canvas
should remain some abstract object you get from DT.

IMO, this is the same as a reset, a syscon or whatever other phandle you get
from DT. The consumer should not have to 'care' how it works (how data are
organized), it should just use it.

Whatever you need to do to deal with your canvas phandle should (IMO) reside in
your soc/amlogic/meson-canvas.c, and not be spread in the consumers.

> 
> I agree that the "fetch the node" boilerplate code could be put behind
> a helper, but at the same time this code helps remind the developer
> that there needs to be a canvas node in the dts, and that it has to be
> linked in your own device node.

This is why we have a DT documentation.

And, as far as I understand amlogic's display and decoder stuff, you won't get
very far w/o a canvas, so 'the developer' will be reminded fairly quickly ;)

> 
> I would like to keep it that way if that is okay with you.

It's just my opinion, I'm not the one merging it ... :P


