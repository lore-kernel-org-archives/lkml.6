Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76822ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D74F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jDSAspKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D74F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeGSQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:18:49 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54548 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeGSQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:18:49 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so10387431itb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M9rUApt2giMgnzdCEAfEaQGjajQkmsEQa9iejnqjbrM=;
        b=jDSAspKek4bKF/7O5hgSna3QZKYNgwdKyF2zbkkkAtmmXdZaSWNqJQUyF1ExCiNOhp
         3OYOFPRC6wryx4mmENqBUJIKVl0meAdzFLMdwTK8NqeyVJ575IIsdUbv4WIgf0kncXUx
         LoOyxLJbLWcn6uu+PKa/3bI93/wZAVze2Z6vOB3fi0xWkRREKR7+YerollK3eSNCAAWa
         iOtiZutYrJq7th+h6cx9w448bXqAG0VOYsVgxZbGZ0Qs8Gfkk7f3Gnsw/w3CELkX6WvG
         1hEeRUyBystmQLRSgkBl5lVI1+UTXPHatRslCmTC/AffNVN1hPNRFD3b9022HiIc4fxr
         knEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M9rUApt2giMgnzdCEAfEaQGjajQkmsEQa9iejnqjbrM=;
        b=KCtqIrKDoYDy+yGaYvroV0JcItkcmL8Lij4sehOevTbnw0MHeELOwF1PUnX/G8zOzZ
         ADJOu4ZOoIvQ50Y6Lovksz4GtGgEz1VOXMsSiRuelD9Ht3uaBBHM237ffujsfS15pziH
         DjtxJNXVZgO4EQQcmA9s41t+HaE3Jy3hRtPuj8TIxXsUjbdyXbsREDfSGhT+Q+eqSGH+
         3D4c97wh/jbyotNuNAmvZcIdsSQsLTaAPm2tZ2lfq0S/liSIBJP/ITm8iCF1oEdCTrHt
         T4OzDxfe/8VU0t3JR2TloGCl6TUvdxLyBaK93AK5kB14XuyImqK7W9/TR6sIsyCNouAQ
         GSrA==
X-Gm-Message-State: AOUpUlGxN8Q6KcGdxTGdQv2eQXy/Mw8cgOEm3S6JUwwUdjBEKQDjp308
        TNJ/KTD1kHi76my+dlmcIVpgrb2TGsUdo94PXSdp8A==
X-Google-Smtp-Source: AAOMgpcJPgKXYYdG8VKkjDhOjpAUINFkwb6cWM6hB0lDkLCD9MIR3tRsmPVSQy6JdoMZebfPuaCdTMRzg0rICf2EIj8=
X-Received: by 2002:a24:e48c:: with SMTP id o134-v6mr5159496ith.125.1532014505482;
 Thu, 19 Jul 2018 08:35:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 08:35:04
 -0700 (PDT)
In-Reply-To: <20180719152712.GE9119@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch> <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch> <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch> <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
 <20180719152712.GE9119@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Jul 2018 17:35:04 +0200
Message-ID: <CAMRc=MeqnRXF_R1J5G8ySvCr8pZhZMHiV3WHNFun=d8GjiOT9A@mail.gmail.com>
Subject: Re: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 17:27 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> Unfortunately: this would effectively block me from improving the
>> support for older davinci boards.
>
> Is there something blocking you from converting the board to device
> tree? This is something i did with a lot of the Marvell boards a few
> years ago. For a while, we had both DT and board setup files. After a
> couple of cycles, we killed off the setup files.
>
>        Andrew

Actually some board are supported both in DT and board files
(da850-evm) right now, but Sekhar wants to keep the support via board
files in the kernel so that's a no go.

Bart
