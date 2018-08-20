Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673782154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQfBlrsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673782154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeHTMil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:38:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38986 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeHTMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:38:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so11016951lji.6;
        Mon, 20 Aug 2018 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZXm5iF/ew0W0USd4GzFZ4XE7xPheM3Iug7yPC7u/xro=;
        b=eQfBlrsR2o/JQFBEEfzsSOOHbUOZ4Psq26N/fYDTMQfJam0E9J4LVKoq/eNJt0mHQu
         vSFScZP5xDIT/0n7aNehnogOCn4XqMqG1Io2Ino0Eu7bUS4kQyYkInch90wQolCzwx60
         tpVHAyhMQvtHvVoSxqO2t0jMliWexasOU/6UfKa1GRTbES4J8/SN1ta/TLSuaUZgaKuW
         ef3QYRKHzzWuEUXAZTQ8/+DlT9s9XlicQJpWuj/NX8NH2M3xUM2ZP4B72PTTpA8wpzfR
         qjZ/3W7HkbVbRJRKfVASU0UtgWz1gNsKn2wWTILJHbDI/4F0SrHIzzQNlMUY2z+yY8mY
         3jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZXm5iF/ew0W0USd4GzFZ4XE7xPheM3Iug7yPC7u/xro=;
        b=ONp7VobeMDVbTjTkTppiWD12CUWwhBnICHpPfrqHZ4rAeXBv8qzQ46qI7FKqDPvnSb
         roNbQTbfb/aaWz5FYUYZhy5Vz9I+arPcDmGtCg6qOSbJt4FmnthK6N3J/n4QXfKIHnkC
         1OvDx9UktKhS2QKbdns4m+30idM8OjDz02DPGHX7SmdvNUwwS/EmKG9fYxsJwrmlhiT/
         2KDXtMhj9jg8X2HHXp1MXNmJsmwtlTgR4ARfeaMf4tqT8mkL1f9GSz2MnxCOrKYprDJu
         Z0JCCHxUgyhH/uLyAqx62ljBAYSI2D0CGBZRFBpMTn3IA8+7bCdunwMKUg4kqCTcbBde
         fzww==
X-Gm-Message-State: AOUpUlFCTgcDYIIIEsHnpPASL0QJMpzVFQtMW8g5drdgp5AV7SuU3Vlm
        iCMnwKjXAM0oIGK3uGDIQXw=
X-Google-Smtp-Source: AA+uWPzQy+Chh0K+7XwE5kCUYXkJ2LwE40yya5gjGloy10qr/jEmOsXZikLWZrZEdjZ8rg1dnGwNPQ==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr18609887ljt.8.1534757026702;
        Mon, 20 Aug 2018 02:23:46 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id f18-v6sm1512998lja.85.2018.08.20.02.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 02:23:46 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm: dts: ls1021a: Enable I2C DMA support
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
        <20180816084315.7857-4-esben.haabendal@gmail.com>
        <20180820091531.komc6ypyybnq22nw@ninjato>
Date:   Mon, 20 Aug 2018 11:23:45 +0200
In-Reply-To: <20180820091531.komc6ypyybnq22nw@ninjato> (Wolfram Sang's message
        of "Mon, 20 Aug 2018 11:15:31 +0200")
Message-ID: <87zhxhgzmm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Thu, Aug 16, 2018 at 10:43:14AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>> 
>> Gives substantial performance improvement for transfers larger than 16
>> bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.
>> 
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>
> This needs to go via arm-soc. The two other patches will be in v4.19
> with my pull request later this week.

Ok, do I need to send to additional list(s)?
linux-arm-kernel@lists.infradead.org?

/Esben
