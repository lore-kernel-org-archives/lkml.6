Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056B3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="FypbHQHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056B3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeK0Lpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:45:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36308 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeK0Lph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:45:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so17774102oix.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=ZOP2fhf8zqwgTql8cY3u5e7NUjaixFNXZgGZ5//fBqs=;
        b=FypbHQHEpfmrrPa3c7bd+KNdN1edJmggXC113Mm0JEzK0+m8IFyq2kQFbG6XElisDG
         L8KLrHr6Pa3MtLpfGK6KM2HzMrp99Qu9pTqbmTHdCTNx1B5YZ4uOhlWVdC8NhVS6X8JK
         G+psyfW0ZYjPHxP9ziIQINkZQN1YbHjmpT1MrgClMy5hiDLS01gU6HELx4jsr6KHM/9c
         x8jN4En4aSnwWkW/vdKB/MRVqS7FBccQJT8gpoBJ/huXeDccjiDVShwFBDj1wT7LGT0b
         FW7UJrQsh/fA2INrgf4SEJo+ahZzXng1u53VD2sYS+PACodJXRflfV3+R/wT2Xc2SSVS
         HC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=ZOP2fhf8zqwgTql8cY3u5e7NUjaixFNXZgGZ5//fBqs=;
        b=J9zT3kiF+Xjh+5j4nO0Pia40dAq6bcYGjsaJHe2krN3u1v6PHLSurlMBU3Pv2kZPGf
         yb/TlAbwd7WbCNPMUXpaHWsq+e31JduOUgtwKfdkQWDFxpadFW95fxqf3MYxHYDGCKoT
         Q87FDsVdGYttsELuwevJRyBsVsMZAXrCg0McD2VE7FdKDblNjeA85WQr7SzBRU3RFxbH
         ClscbSpKe3u8oAxE07ib457Gpk5MAthjOMSW8bx3FiZtSwmJV79Cm+9+bkR6mBWfnFev
         tKSBc4DJzY4bZmFjshSkJRr0Tyga/fpJ1+KzV25gOyNrNDLl53nbBqEXFfVSLEeN6w+f
         r5GQ==
X-Gm-Message-State: AGRZ1gKslrjh/N+GuEPpPLEqcSXHsxqETzLwGaflrrImSDF6ZNbinKb+
        np/g5W9WA+ojvYvQdsrS4eiy/A==
X-Google-Smtp-Source: AJdET5eMhKWTIg++S194au4VL4gDAjkcm6iGO/8es6POAyqBP/0tgEa6C3LZrQ9Cp87uAXI2N51M1w==
X-Received: by 2002:a54:418a:: with SMTP id 10mr17738220oiy.128.1543279775983;
        Mon, 26 Nov 2018 16:49:35 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id v3sm2345268oib.57.2018.11.26.16.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 16:49:34 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-oi1-f172.google.com with SMTP id w13so17726885oiw.9;
        Mon, 26 Nov 2018 16:49:34 -0800 (PST)
X-Received: by 2002:aca:5906:: with SMTP id n6-v6mr16029038oib.268.1543279773994;
 Mon, 26 Nov 2018 16:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20181126173506.24068-1-otavio@ossystems.com.br>
 <20181126173506.24068-4-otavio@ossystems.com.br> <2433008.lBIgasatsU@phil>
In-Reply-To: <2433008.lBIgasatsU@phil>
Date:   Mon, 26 Nov 2018 22:49:18 -0200
X-Gmail-Original-Message-ID: <CAP9ODKp9B4pu_PdAxjmO2Z3G2eqHp4WsNpTmWnZdiMXy8jHTdg@mail.gmail.com>
Message-ID: <CAP9ODKp9B4pu_PdAxjmO2Z3G2eqHp4WsNpTmWnZdiMXy8jHTdg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: rockchip: Add internal timer support for rv1108
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On Mon, Nov 26, 2018 at 10:29 PM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Montag, 26. November 2018, 18:35:06 CET schrieb Otavio Salvador:
> > Add support for the internal timer peripheral on RV1108.
> >
> > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> > ---
>
> looks good, but due to the newly added compatible
> I'll let this sit a bit longer to give Rob a chance to add a
> Review-tag or so.

Sure, it is fine. Thanks for your support.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
