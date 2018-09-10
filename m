Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E80C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F98020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORV4yZ9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F98020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIKCoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:44:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42535 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKCon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:44:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so18685675lff.9;
        Mon, 10 Sep 2018 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esSbTasgEEfMZC2V8Lgs4S9w1jZw7ZHyg5PfnBHukvE=;
        b=ORV4yZ9msso6ZZzdGm8BP2PiB6NUAqBOveR6je8GOskYU6QI/s191phvU5vv2r4hJv
         VENcHeXATRsqjlIqfxppOJH7efxW+Dnh46/wtgeSFn/WNAvbZxpmVKDJ1j3KZ4/8mO6E
         djUXxsG71b2XJxCf0EpfWWqSC9H25MtQGJzow230IeIA7bY0Otb7L4jsXbLnEHRy6TjH
         T1ZyKtvuLtmBpTv2B0SajLFH7N5HfVY2vVAbt+KtRkV0W75xmamKb10x+L+L47DRkyJG
         d1dn49rDTcZAD4rIJ1YtUzDq/SBUVPJ72OyGtSusx1WAaB+GrHujQaUAspVrMBWB7/y+
         WVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esSbTasgEEfMZC2V8Lgs4S9w1jZw7ZHyg5PfnBHukvE=;
        b=hI8uGMqWQfsBDOHZ8nHJL8gnDp0+AWf88u+bnOS5nNioQuKo6LnTT3/cwUMgSiZ2pF
         +HxPC9G2XXbEVM81NhieeDoo/8hFlCFG3Iw+wosuGnxg0bHOVsfBWZxly6k4b0xewcgU
         NMwJtMFFlInGdCQJyN2vz33nJYEnaWQsY6bHnwg/0dWjuOhHnql7GhSzaB4443KJyr3Q
         5xes3O8iCDzQ3KxKZJsdlJAVEEON+xVVDagsxqJNPoeurief+mr8Hp5g+JrjC7TgCayz
         gkNWdN0Hr9D7FRdkhy+fyrXZPu8J6UPgRIpYKQ6dHKN+YuTglNnhahr2BGF9kLCYak9V
         EwrA==
X-Gm-Message-State: APzg51C0pYvxZ1HgkWfxiKjKoN5HSlVgVYiRvTMC4FjbhqAEkStqFea/
        0+qKVcxoJ8U95hFJZw+Y54c=
X-Google-Smtp-Source: ANB0VdaaiPAWuN2D9ZFtPV8fOlj2jzT6Cvk/jslkEx6qYCz6k+2SUQlo60RWrC8zxnIcs2vzzQIo1w==
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr13131384lfg.68.1536616116704;
        Mon, 10 Sep 2018 14:48:36 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id u19-v6sm3001516lje.51.2018.09.10.14.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:48:36 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Date:   Mon, 10 Sep 2018 23:49:56 +0200
Message-ID: <2690911.AdkODg5D9b@z50>
In-Reply-To: <20180909234419.31261-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <20180909234419.31261-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 10, 2018 1:44:16 AM CEST Janusz Krzysztofik wrote:
> 
> Convert modem related GPIO setup from integer space to GPIO descriptors.
> Also, restore original initialization order of the MODEM device and its
> related GPIO pins.
> 
> Cleanup of MODEM relaated regulator setup is postponed while waiting for
> upcoming conversion of fixed regulator API to GPIO descriptors.
> 
> 
> Janusz Krzysztofik (3):
>       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
>       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
>       ARM: OMAP1: ams-delta: register MODEM device earlier
> 
> 
> Changelog:
> v2:
> - rebased on v4.19-rc1

Hi Tony,

I forgot to mention: please apply on top of "[PATCH v3 0/3] ARM: OMAP1: ams-
delta: Complete driver gpiod migration" series. Sorry.

Thanks,
Janusz

> - added Reviewed-by: obtained from Linus Walleij
> 
> Please ignore the patch "ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO"
> sent alone on 2018-07-17.
> 
> Thanks,
> Janusz
> 
> 
> diffstat:
>  board-ams-delta.c |  121 ++++++++++++++++++++++++++++++++++++++
+---------------
>  board-ams-delta.h |    7 ---
>  2 files changed, 88 insertions(+), 40 deletions(-)
> 
> 




