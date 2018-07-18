Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C630ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6472075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjKoMl9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6472075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeGRCKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:10:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34015 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbeGRCKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:10:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so5743916ois.1;
        Tue, 17 Jul 2018 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dg6AwHIJbmECANqY8a6Hj19kOQ6qysI+Y7YcuFk262Q=;
        b=qjKoMl9N3p58uBv+pK2qQBBpTZyKJz4opqMGrwQvK/6dhWktKcC1oM2wZu9tfZSsR3
         y/sDKN2IZ6C3xr05GDudpCuxQCFXOvXGzwnH55qYvCViLPu02ihGwvvTXWtZ0jm2UTCa
         2MTIJltXznlD7XaDTM0vvspsus7H0w9010aK/LRwAVcxZRym0EzF7mBJSz14vH8u30w1
         38/0hc/v25PCNzWiNcPRVY7tPD9g1m3R4+Ji2vZYDj2hrwK9lgQhGku291qoSQaTmU0F
         9UbQ7N7f2pnqcNFXk9Vc/wZAjE5bJfIPVmz8yEOe0JRSGcanNQxAOVOI7yRjEdkqmjaF
         p+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dg6AwHIJbmECANqY8a6Hj19kOQ6qysI+Y7YcuFk262Q=;
        b=Nvfs8VA1w78RjPsD/mWEb6h0P+1D+ol9gUABA9jX6rfD2HBV154v3WuYHL1Bft0/nz
         p8IcPsT0IyaZZhLzb4cSdzQn6Fk8kVaLcRnfFirLhVz/EtaaYFGkWq79i9n2iumJDr8a
         miZ7bHqOMzAT8icMjNKMRC7HALWf12cwOABxnUSpkGaGMQiQog2gE3TqdzBYZHhi4QFE
         YhThyBVLlZ1o4OG5fwqddG5aVhjDg3edGmb8VuGk55TT3rxFXroBV6WehDdEYzQfwc8O
         +kvkxmjyAesBkGehYbsnNtsvVgDwXYKzHmLTPOYI9jnS7MRldJWDQ0UPwYVxNZuLLixK
         t+EA==
X-Gm-Message-State: AOUpUlEzmLEWPBDDNhhYhCHpKY7ljXvYwlLcK0runY/ZXrPOJuyT44aq
        eIMCws3W0TdnEYFd3U5KaVdDyzLZO4qc2f7+LMA=
X-Google-Smtp-Source: AAOMgpcZI8c9jFo7+KAHf3V/m/eP1cSCNE3fiF1O4rfdxPWP8pdsPUqTySW9mINpGbs7ZVN4e7KCDxvf3ptAG0v4byk=
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr4562750oia.336.1531877686597;
 Tue, 17 Jul 2018 18:34:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 18:34:46
 -0700 (PDT)
In-Reply-To: <1531877132-14280-1-git-send-email-Anson.Huang@nxp.com>
References: <1531877132-14280-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Jul 2018 22:34:46 -0300
Message-ID: <CAOMZO5By77kWa_yjuuzi_0=9F0VCiuAP1bxOV__74g7nmq=XVQ@mail.gmail.com>
Subject: Re: [PATCH V3] gpio: mxc: add power management support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, Jul 17, 2018 at 10:25 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> GPIO registers could lose context on i.MX7D, when
> enter LPSR mode, the whole SoC will be powered off
> except LPSR domain, GPIO banks will lose context
> in this case, need to restore the context after
> resume from LPSR mode.
>
> This patch adds new compatible string for i.MX7D
> which supports GPIO power off feature in suspend,
> and adds the GPIO save/restore operations in noirq
> suspend/resume phase, since GPIO is fundamental
> module which could be used by other peripherals'
> resume phase.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks good for me, thanks:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
