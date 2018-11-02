Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467CDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82232081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5wV0/5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82232081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeKBXXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:23:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37563 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeKBXXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:23:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id 40so1589380oth.4;
        Fri, 02 Nov 2018 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3cIkdikIonkkNt2Q3vStPW3xa99SRHf5X2pgglfKpA=;
        b=Z5wV0/5IKLMUpzBik4/EmoGAJl+07JHTn09NwcYzPWj8e4dAxFCqhzSIGS+LcZxUxM
         8vBdlF1cq5PpR5KTLWpXEbRoQauHl+pjaJ8qTfkipcMPUYTXz3zyPojAH4mOGIsmDeQn
         FUTagJ+/vcDw0vjshagdm2jcdDERxX1nQFgWvzp96QGJGfGNT1Mp2q+JtLDlTA/F0Pfl
         RdBfY3VVM80e/fD2Y+Nf37CkpOVoSuXyO+PuLe+/j+lfzJraGvGop6iBoa9JI/wsuWZF
         IV+xb8q+QkF9XAMs1v3BK/WUMpaNQ5SqFKFiJdTg2PH+4mBbEwDjN1dZiSO9qf83R5sh
         3HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3cIkdikIonkkNt2Q3vStPW3xa99SRHf5X2pgglfKpA=;
        b=YP+NY6NrPzGCVoFl4nWRaWawTgF94xCRSft0PlrgFT407iC11LzowlS06TZW4aBh0h
         PlsFnebPNpq1TsmlzFQd1cMLmqtI9nt9F0PZB+jFbvtolpX9Hg1ptwkWn/Z8TwLqfxtk
         Sqs4feRhfG4c6/ooSw7FUn07frqyyzOLVkG1NLlSVBXvXV3/IJ324HEifChL7+49axQ3
         dOobBwyYshbMpGaYe4S9JJpyNlcJdij6t1TYqxu3sGTcqf6OXLvlLehtzRAe4jXn5zLC
         ijhtBk4XwStk+d9l5B4lVNrF7O19MqmKaIB4DmgNyLyjdKJqlXCOs17HrzW0fJ+rreOa
         aBXA==
X-Gm-Message-State: AGRZ1gKdoa5nP0X1HeDV3ITcCtASXKyByXGrjnUPZ4HITUzrwNOWOWP0
        VLyFnOdSMNr7qPWanrNgZ+lRKxLf06d8gRExG4c=
X-Google-Smtp-Source: AJdET5fD3q+sRBVhBuFpYHNKCNiUiThJA08KB4p2bEJteQ52hH9OOGxh5H0EqoOMJSGV2W8zuJrGxs7xGjTi3DYVgW4=
X-Received: by 2002:a9d:fef:: with SMTP id m44mr7746166otd.225.1541168186184;
 Fri, 02 Nov 2018 07:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181031194425.32132-1-TheSven73@googlemail.com>
 <20181031194425.32132-2-TheSven73@googlemail.com> <CACRpkdai-6iNbz4EGuHNHkQYyR+yhTEJdRXP4G6fUKpA+XApjQ@mail.gmail.com>
 <CAGngYiVorxYY+8e75068i4=PJi1gEvnGkgvBfi0+9H+c1qD-oQ@mail.gmail.com> <CACRpkdZkv6ikrFmJptBTwftj7TkR5Bce9e2R1ceTw_pLqH1LcA@mail.gmail.com>
In-Reply-To: <CACRpkdZkv6ikrFmJptBTwftj7TkR5Bce9e2R1ceTw_pLqH1LcA@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 2 Nov 2018 10:16:14 -0400
Message-ID: <CAGngYiXBQkJ6NkZmz=QMDJq-jTdvbZxh=dBa_6pNSqWDye8S_w@mail.gmail.com>
Subject: Re: [PATCH anybus v2 1/5] misc: support the Arcx anybus bridge.
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 5:53 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Nov 1, 2018 at 6:17 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> > Perhaps there is another kernel abstraction I could use?
>
> Maybe the properties should be on the bus though? I don't know :/

Let's keep the version associated with the bridge. After all, the bus
has its own version associated with it. And the app developers have
separate data structures for the bridge and the bus.

Cheers,
Sven
