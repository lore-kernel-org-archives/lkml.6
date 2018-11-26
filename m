Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9626620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="quFhUZWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeK0Ajm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:39:42 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38644 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeK0Ajm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:39:42 -0500
Received: by mail-ot1-f42.google.com with SMTP id e12so12276045otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=ojF96BPd8EUFYeGyaKXBzbtc7nCFKd+aDwygkNRVIKk=;
        b=quFhUZWnhKFoxHekc/9HYukk0YvJLzo04Kl8L0jDt2IX122i53iGfuhKz0YhFr9fgj
         WYTZLQ6Djp6Dpz0whv4ohO27GcQ7uUl0mv8BolQwBp3eukUflQ9izsHSVbIMgps0dxQh
         qVcwN2Qi5MAb54p3WYwrfQsbI+Vc6nX1bQEm+MPTykmguybpMpxFvUyFyAU3I51mfYaM
         bHiyfUljkYlK/wd6mX3Cw6JyEeXnCgtTxKqiuh6BuHKnDJPsB37zjWaMVQjty71BBQ4e
         fUKKTP/5HSl2iJOHBxFJk481zwB//92OzJw29ghdq/EcevniRf9qN0OcmzACh+dr9IYy
         IZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=ojF96BPd8EUFYeGyaKXBzbtc7nCFKd+aDwygkNRVIKk=;
        b=hks8iSf8B75PableQcUXuj0hGxRZ2QvCfXoSvH+jSDi8Uh6R92hT2nKK5MXQMfxNv2
         zZLoo9KxOZXkqll3ENYTb8LWI4WUvbMqz52z3xnCQeh/55hJ0Y+piAR4Ad1bolxV/qH/
         WciA+Jvc/cU+Xy9Vb3D/GJVNuquH2d+/bXR5/jJbbtTOp0+Qr3QlcaFTO4mCAex8JVjt
         45Hbx4IRhWIv1Oi8CkZwSLo8hihSNvi3vKqY0RmKjEU4e6yYqOSD0l8etjGqVitC8EZG
         wJoj6WW4JmdL62YcJoHHhwCtqnGyvIpSIKU5rDzshDGr0PtCmeqE0BExVFbkttc8YRNt
         /sLQ==
X-Gm-Message-State: AA+aEWb+s7BdMrg/iqanZJE1FFCt0ipP5+FUqykmC2pyIJWerYy0Hsla
        ZfYcaoiM1npusqHMlEcsSZRtvQ==
X-Google-Smtp-Source: AFSGD/VqtfCPw4ywIY8OJpzuNp5hYQh6xxi2eKuceKqHxlQ5sGT9UCJHIwXL3R5rPBfvz6p7iBECgQ==
X-Received: by 2002:a9d:4595:: with SMTP id x21mr14856139ote.234.1543239930638;
        Mon, 26 Nov 2018 05:45:30 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id 52sm705134oti.30.2018.11.26.05.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 05:45:29 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-oi1-f174.google.com with SMTP id m6so4158320oig.11;
        Mon, 26 Nov 2018 05:45:28 -0800 (PST)
X-Received: by 2002:aca:ad14:: with SMTP id w20mr13939364oie.3.1543239928345;
 Mon, 26 Nov 2018 05:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-7-otavio@ossystems.com.br> <4443441.F7S2jYBxxL@phil>
In-Reply-To: <4443441.F7S2jYBxxL@phil>
Date:   Mon, 26 Nov 2018 11:45:16 -0200
X-Gmail-Original-Message-ID: <CAP9ODKoFaUP3JyY=x-6H-b_SZnN3BTtS5dMVsqE2-n96AWp2dQ@mail.gmail.com>
Message-ID: <CAP9ODKoFaUP3JyY=x-6H-b_SZnN3BTtS5dMVsqE2-n96AWp2dQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] ARM: dts: rv1108: Fix the timer mask
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 3:27 AM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 25. November 2018, 22:19:01 CET schrieb Otavio Salvador:
> > As done in the Rockchip vendor tree and also on other
> > "arm,armv7-timer" instances, the correct GIC_CPU_MASK_SIMPLE mask
> > is 4 instead of 1.
>
> Nope. That value represents the number of cores in the system.
> As the rv1108 only has one core, that should likely stay as it is.

I see, I will drop it for v2.

> Also, it seems I only got patches 6-13 what happened to 1-5?

It went to other mailing lists, I think. I will add you on Cc to all for v2.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
