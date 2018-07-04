Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D6C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B92C208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b="lkOmwm7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B92C208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934375AbeGDLct (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:32:49 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43785 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbeGDLcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:32:46 -0400
Received: by mail-io0-f196.google.com with SMTP id i23-v6so4583090iog.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sKf0uUAQ4/nGSAIOzHixUG3mEXmkQlusTbpUjVno3mQ=;
        b=lkOmwm7wBXtx50+Bg85mx5ohWYwl6N6C7J5o7lRU7Xiywoa9THIXtBMsTrX8onSidE
         i0Ltzvfw78PmP5MRjQ+m/AqSi83GHiElWd4yTAkvKKhuJhWCtlPjjfaaVMNeR1QIg4Sz
         EivfxK0sdx0n/XRVXEWGDWeun95guP2W3nZ4W4eSq+j/ekfXuYipMfwaPAHghxv3XesA
         YPubsfauBgr+TjqU87uvds9mLO3w+9fvRgD6R+KeSWTB1Lux3qIHRws2/uKbkrjtV7iP
         EpmsgWuA6/hswQ9hWGTuI7+J2LQyDcIzFm7gZ/KxcuJ2rZIWYTevn2ArcmEBYxfcO3ur
         f6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sKf0uUAQ4/nGSAIOzHixUG3mEXmkQlusTbpUjVno3mQ=;
        b=HoVC+1rAJmGvbr2LuwtBBCbb6s/8Zy94oAOkcaaHEmuueoy/GjFERvS3m4V7cJC85m
         XqtDw57Khp4krnzXPjwuukVNGtvy7yryGIDKhJExjwCwRNdPovXKwfgOSufkgcCabu9F
         5P2KR+DglIflyeLqDzBc/P3YyiYiO5G0O0USgy0/xbWpn7V9ZIsKHxE5jp4KhyS7hV4x
         XT0nWlB1NFXSCLMAjRIg3iKtQbzwK7XB4Q+N7FW+y7ZboreDDSRYwjc1PcCFNUKMP42I
         a+PvE6BvzR20J7DyfpNOwWL8prCRH60aJM1hgH9gGpz36j/HJ1iXc5bpXtUYeGNn8iQ6
         2y9Q==
X-Gm-Message-State: APt69E0z6G63l83CFfwevAk7p9GKwQVExdcVnX6moSyc0CHS0vDf9ffp
        sbyYKD8gNsTVjvMeEQRx2Ou7L828DzY9LTs6r4s5+g==
X-Google-Smtp-Source: AAOMgpeNhgtpS6o/Ekf7ZyHolgT809DLiI5+uDuYSp1AnynwJerRYAJjFxRKlu2lBNHvasajLmozdxZ73ET4iG7dxjE=
X-Received: by 2002:a6b:2092:: with SMTP id g140-v6mr1191585iog.167.1530703966010;
 Wed, 04 Jul 2018 04:32:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f017:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 04:32:45 -0700 (PDT)
X-Originating-IP: [195.166.127.210]
In-Reply-To: <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Wed, 4 Jul 2018 13:32:45 +0200
Message-ID: <CABxcv=nSPj6q8-QoPQ99Cc0hk76XM9y1n8XACp_vJwyR+n6cpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 1:26 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

[snip]

>> Ok, in my opinion it is an elegant way of not bloating the driver when no
>> explicit handling (e.g. reading DT properties) is needed. Just adding an
>> of_device_id doesn't change any driver functionality then but only maps to
>> an already existing i2c_table_id.
>>
>
> I disagree, in the case of OF for example a compatible string is
> composed of both a vendor a device, the complete tuple is what should
> be matched.
>
> But with the fallback, only the device portion would be used so both
> <foo,bar> and <baz,bar> will match against the i2c device with id
> "bar". It may or may not be correct but the vendor portion is very
> important to disambiguate.
>

And having a compatible = "bar" is also wrong since the compatible
string would lack the vendor prefix. The fact that the I2C (and SPI)
core allowed this was what caused the problem in the first place IMO.

Best regards,
Javier
