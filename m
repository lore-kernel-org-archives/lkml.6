Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F6EECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5411214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="2LWnP+H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5411214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbeISHjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:39:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55489 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISHjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:39:41 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 54a8ede5;
        Wed, 19 Sep 2018 01:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=oh5Av8KMPztDpn13YdNF1G112xc=; b=2LWnP+
        H5o3QlGiM9VRsLyUaVgsbx62Sm/HK+FQMPrLI6+zIvorAfvANzKYjzfnbidS1N5V
        6sWi2axNh6e8CfWgd8xtUrVs+Tx2MLslUMoWkub4URrejxJLsE0Yb+2FhQQTUREW
        RsckiVLHF5V6Pi013TD5WKXIdQwWpZfib1Vj5hnWAicPks2N/GqpppW0gOF2UcXm
        Mcvbpv5TAFFPZ8ozGAqbZ+ttjvewKGH5IqcHyzVbLf+cdXn9zuAmG82fBHeSQ/f6
        A/gx2V9JyzuK99GO9DxPJnNGS6Yeq2zGZ4Fmkcup0pqIGGgnD0wCkMSR4IBBpEfX
        nnnwIucVheuGV+AQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a786a58e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 01:46:35 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id x197-v6so3651142oix.5;
        Tue, 18 Sep 2018 19:04:12 -0700 (PDT)
X-Gm-Message-State: APzg51DUj54ZOwLpHfZELkFfeFD06EF127Md6S295AcyPrKE8D+gu5Y/
        /Cb97deE+w3Kirklwrmm5vwTXb5j1V79kEEzQR4=
X-Google-Smtp-Source: ANB0VdZauokKY+2VPSsE/eFICEofqVHpywROyiknGERFr6YUGMI3EzZXZv1fDurTQbbIiss7AlMTjQa/aoH/uWGly3w=
X-Received: by 2002:aca:f58f:: with SMTP id t137-v6mr323560oih.244.1537322652282;
 Tue, 18 Sep 2018 19:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-21-Jason@zx2c4.com>
 <20180918233411.GB17466@lunn.ch>
In-Reply-To: <20180918233411.GB17466@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 04:04:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9rwVLu+H88Nq+kGaVfZsZjoVUM_SdosjSRRpreUd2uGuQ@mail.gmail.com>
Message-ID: <CAHmME9rwVLu+H88Nq+kGaVfZsZjoVUM_SdosjSRRpreUd2uGuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 20/20] net: WireGuard secure network tunnel
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Sep 19, 2018 at 1:34 AM Andrew Lunn <andrew@lunn.ch> wrote:
> I see this BUG_ON() is still here. It really needs to be removed. It
> does not look like you need to crash the kernel here. Can you add in a
> test of len >= 128, do a WARN and then return. I think you then leak
> some memory, but i would much prefer that to a crashed machine.

Sure, I'll change it to that.

Regards,
Jason
