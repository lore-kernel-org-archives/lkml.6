Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCAFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83402081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="LSCiYWm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfBDXP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:15:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38553 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfBDXP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:15:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so2827944otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=H192YLgCOg+eg/Aa/pmeLZbzCL4oRUd4Ap4lq8c1OsQ=;
        b=LSCiYWm16lhfE16kLG/HeKf3AJJoZn4fv7UknHbOTXR7+Or2/HW91yrIvWZ7BmvE1i
         0nmOGQ0sishhnByoeTzB0QMRKX79vg7NN3OwlW10A1W6wxfvflcnK+zi45Me0o08IkXk
         ptap1RBGJN7Xnip873hs6cTzgbP2vvjG6pZGC1MR82VjdRhoW4kb5uCyU1BOb1j92gfN
         IBh6plZUIbatY3dWoYod4+WY3306hTptDKmy+J2v2u/ccNIs2KVyat2Qy8Yrp/iHLT58
         Jk7n/GJ1keJKFXV+PAX2XCWpMYv0mslE51q48g8n9nrcCQ3y+rzdElSq3jPUa4nQE7YZ
         ZNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=H192YLgCOg+eg/Aa/pmeLZbzCL4oRUd4Ap4lq8c1OsQ=;
        b=liqmc2GObK+rerYysGd5ySc1WuZ7hdEeOzXZBC+CE3iUBSjRsaguvgnfsHfkWhlpcV
         DkLWiuZ1gve8c5UdsQwyl9z+N2yhyQTW8COCNHl8Vu0V9oNg7b8aCGb6D0eTSDFzWez6
         Lm8RuLjrjeaNCoqwz8EvASp1fvpO4FZQ+nWtufcjaU+wYVV/IoeuvSqUyhy6dCAG/fep
         qC6ZPXqsnv79trYgJ+hWqVzpy8f6z33jOVk46YOwpbD0ZrNNI1D0+CtRV8VCcUO09w4C
         Y7C/7v5hWyEB1M5cGzBNqQtSrsNCEugOCFRlv0dEB9qhlr6XWvIEo7X9EpbCWRA+bRHI
         4YGA==
X-Gm-Message-State: AHQUAuYgNPp8KZwO3EAOE4quvLd772hvfhQaSbACit31dIL3mSBZZbPt
        rbM7h27nxCktTrzKP44h9X1ar8NLtwSj6g==
X-Google-Smtp-Source: AHgI3Ia3WBhlI7kK68mTtKyDKID9sTMOn6EypIucoHirRmDEumlN5hNsJBPCBS4quiGOzit+Z8xkIA==
X-Received: by 2002:a05:6808:13:: with SMTP id u19mr1003385oic.57.1549322127147;
        Mon, 04 Feb 2019 15:15:27 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id a201sm8515774oii.27.2019.02.04.15.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 15:15:26 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f45.google.com with SMTP id v23so2774803otk.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:15:25 -0800 (PST)
X-Received: by 2002:a9d:842:: with SMTP id 60mr1014778oty.22.1549322125367;
 Mon, 04 Feb 2019 15:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20190204071051.16982-1-axel.lin@ingics.com>
In-Reply-To: <20190204071051.16982-1-axel.lin@ingics.com>
Date:   Mon, 4 Feb 2019 21:15:13 -0200
X-Gmail-Original-Message-ID: <CAP9ODKpdCNk+t_9HxhQaocX3H5fdyNoJd7AeE0chS=5H7xnttA@mail.gmail.com>
Message-ID: <CAP9ODKpdCNk+t_9HxhQaocX3H5fdyNoJd7AeE0chS=5H7xnttA@mail.gmail.com>
Subject: Re: [PATCH] regulator: rk808: Convert rk805 buck1/2 to use linear range
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 5:10 AM Axel Lin <axel.lin@ingics.com> wrote:
>
> It looks like linear range is suitable to describe the voltage table
> for rk805 buck1/2:
>
> selector 0 ~ 59: 0.7125V with uV_step = 12500
> selector 60 ~ 62: 1.8V with uV_step = 200000
> selector 63: 2.3V
>
> With this change, then rk805 buck1/2 can reuse rk808_reg_ops_ranges.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Cool! Thanks for looking at that!

Tested-by: Otavio Salvador <otavio@ossystems.com.br>

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
