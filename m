Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42885C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AA1208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AA1208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeGKDSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:18:01 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:42313 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbeGKDSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:18:01 -0400
Received: by mail-ed1-f42.google.com with SMTP id g12-v6so18005640edi.9;
        Tue, 10 Jul 2018 20:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qs4WRZ4P/OmprYevA1O/RpZloAJir/OFtGeBwdjo51I=;
        b=Ti1Th1AIrZ7TxV25PocaYfe6rR5/vBHJuuQGGAPGnAXswg9xGYkEb185zqN32QPYBQ
         lATcyXQYboZqTrak/d4t6hfLiYZaCMxcSF461B29lQl9NTyOTGd+HIRPFUNxG02+HnXZ
         wbMqv94w1vDQFGSHa8NI/Q12mOoC8Xm4csOLPW/ls7e46+th+LbZltAT8iLrgCv2tfX0
         JRinwO/Ias9vJl0ZdzyrbcR39OkGXQydlryTzjoKtP8h18sUkrWZAszOgpEvYM/Ge/J/
         H8LSOSARgDn+S+UDPbYZ+vAeHoIgZkDMHOcGZHlRuEEqWBD0NgunhIRdstithLyGj37o
         saPA==
X-Gm-Message-State: APt69E0jIplaAVDb0tXRx7nBbEf5UYyYLCwu0cQOuBJfW7zd9uqkae7c
        dZ4tkIxuFS2A11rKlpdUTX4uBGhi
X-Google-Smtp-Source: AAOMgpegYVkD0C11WKar/5wUbKT+o0CRGFM+dzQzhGPIKAyz0aeA/3Lbza7k2XwIPCUP57C/+e+DDg==
X-Received: by 2002:a50:c082:: with SMTP id k2-v6mr19925592edf.294.1531278951262;
        Tue, 10 Jul 2018 20:15:51 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id y6-v6sm97011edo.46.2018.07.10.20.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 20:15:50 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id b15-v6so16577803wrv.10;
        Tue, 10 Jul 2018 20:15:50 -0700 (PDT)
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr21796690wrb.155.1531278950202;
 Tue, 10 Jul 2018 20:15:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 20:15:29
 -0700 (PDT)
In-Reply-To: <20180710203511.18454-18-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180710203511.18454-18-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 11:15:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v66nDZqN86Rxr3CoUXkeeiSD2DdF7diuxo9rJEK6ypOsWA@mail.gmail.com>
Message-ID: <CAGb2v66nDZqN86Rxr3CoUXkeeiSD2DdF7diuxo9rJEK6ypOsWA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] drm/sun4i: tcon-top: Remove mux configuration at
 probe time
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

On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Now that R40 TCON migrated to runtime mux configuration, old code can be
> removed.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
