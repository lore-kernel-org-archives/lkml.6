Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0369C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0C521479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNCsu8wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0C521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJJN70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:59:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43558 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJJN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:59:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so3853789eds.10;
        Tue, 09 Oct 2018 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+1mlY4BikLXaa0p0zLfrGADPXuVytukdByLu9pnRbvk=;
        b=DNCsu8wxOQWcP1y9ObkllZ6vxGbe627OhP9HXJulxowgYebMJ9I6n5hnqrFJ0Us29j
         2T5aDpI2wBiAGItdxEdTXCMkWSWzTrL2/j4yzKf46txNUR6/9s1w2xRM1iZmLwz7UQ15
         Of5bq7UHn6UT8ldQJrX+aPKASqFfjQ5qQ/F3tP1ZQF8EMg85WoI539SHTUyTIM1xzoNF
         jA4E+ber497WsKSF4RzkzdzMlVNUpUupTdgf54l6VN/jB7g0M2BY3fWcMXgJfDBa61YB
         YBWbRhcfMU2Rl91hYpRGJAwZ1zIVvkgMe/BtHHT/V05SeTJ2nqaffUNQgx0uhX3mzuha
         B/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+1mlY4BikLXaa0p0zLfrGADPXuVytukdByLu9pnRbvk=;
        b=DfH6SxMVN52yXyjBQcrtX/029UXemzTHCS4F7addVdyENz16+CmI67/+1OQ6EKe03j
         7L4lzaMgsql4W9IfbxtOujJdxuppOcf5DqnseuMvFMa/OAPhZhLipxGPyd3k5Nrs0bSG
         ACVsNywthAQKMynwi4uEA4J09s8DEzJx3ZeXnb1NLMTiMmxxlVJZfLGUrcqu1k4PKL4/
         anGK8SKp/PU/5dzDEScJerXWZP+XMqVnrQv3t0akSpeh8eAbfbfFT2E6+El8X4l5oEFY
         w8cqn3Ly/SdhXX4AAn4+i5M+uFKrQA29E730Ygn/jilwiWf0v7yg7l0Qt/nZOceCB3iX
         Jtkg==
X-Gm-Message-State: ABuFfogHz5LGFK3//xZD+GNyhqEjPYaGVgxHsSohph+N9utEZvHiuHSE
        K3w+RZlEXIVaM6Y6Q7tSmcM=
X-Google-Smtp-Source: ACcGV60uEiN4Ncets5H5lFC92GhuaATeS0fsB4Kp1+1ByUGMEINBLzacHPSQpc5Lm90vnP+kjwFb1A==
X-Received: by 2002:a50:9e26:: with SMTP id z35-v6mr39884327ede.90.1539153524773;
        Tue, 09 Oct 2018 23:38:44 -0700 (PDT)
Received: from localhost (80-62-117-210-mobile.dk.customer.tdc.net. [80.62.117.210])
        by smtp.gmail.com with ESMTPSA id w23sm6746473edv.30.2018.10.09.23.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:38:44 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20181009120522.6b2bd15a@bbrezillon>
        <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <87tvlv2wo7.fsf@gmail.com>
        <AM6PR04MB435784E00F0C68A310CD281B97E00@AM6PR04MB4357.eurprd04.prod.outlook.com>
Date:   Wed, 10 Oct 2018 08:38:42 +0200
In-Reply-To: <AM6PR04MB435784E00F0C68A310CD281B97E00@AM6PR04MB4357.eurprd04.prod.outlook.com>
        (Chuanhua Han's message of "Wed, 10 Oct 2018 02:42:54 +0000")
Message-ID: <87d0sii9vx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

>> I am using XSPI mode on LS1021A, talking to a lot of different SPI devices.
>> And they all work, and I believe everything is quite "normal".
>> 
> Since I don't have the board of LS1021, I can't test it. I use other boards
> with DSPI (such as LS1043, LS2088, etc.),
> and I test sp-flash connected on DSPI. If XSPI mode is used at this time, data
> cannot be transmitted normally.

Please describe what happens in much more detailed terms that "cannot be
transmitted normally".  It is simply impossible to assist you when you
report problems in such general terms.

/Esben
