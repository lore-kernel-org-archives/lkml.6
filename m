Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20EBC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9481219E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9481219E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbeHGJo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:44:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732805AbeHGJo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:44:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so6417080edi.6;
        Tue, 07 Aug 2018 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=osn1YVMNtVUe1pxaMhIQYRLMexsulfNXhGYoSqTSN+4=;
        b=lrcc+PtjzJm7wHGg2bACc7flmd4tcxtb8kqUBGB1TqggG8wi0K9nD7nJvW/sIFfzpM
         o/RcEKx7dKvzTFC61GPKpn9gmXWCkC8hV0U2ecdUREGOisSnEkQHmK0itvhjZKZLwV3N
         2IrwCh9UAfXqJbgfWzy0PrdCT9TCq2Sk1/J/X3xmIsBftmtYSgDjRGz4a9jDJwq3Wgad
         AoR18XG6kc7SN+lug+gquhrC33ayPeBn+TeBHZa++tQlYJcmLJpU2tIkr1eg9Dq4QocA
         t2dBcCFnWN9zPi+rTsM3zVhxtUexm7YumwbPvXVzXMCdVp+78WqAsRzOg6/6RQPIzRqG
         wBLw==
X-Gm-Message-State: AOUpUlHfpvQrS9rVdZvsm33L1pIzv4vXmtszGrZIuKLdPX5mct02PYHV
        VS/K1vbPasVlPAnE9kIsEf8VuYhtBFY=
X-Google-Smtp-Source: AAOMgpf8ejefAyAvd4LYsSXaN94LfRun5ltz09nzeQ2UXCNEhRmH4UA/OteNwXgqAxNVIfZezSdLwQ==
X-Received: by 2002:a50:88a4:: with SMTP id d33-v6mr21753539edd.239.1533627085007;
        Tue, 07 Aug 2018 00:31:25 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id s23-v6sm513639edm.74.2018.08.07.00.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:31:24 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id t25-v6so16854968wmi.3;
        Tue, 07 Aug 2018 00:31:24 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr862311wmc.58.1533627083898;
 Tue, 07 Aug 2018 00:31:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 00:31:03 -0700 (PDT)
In-Reply-To: <20180731205614.GA25776@rob-hp-laptop>
References: <20180722053955.25266-1-icenowy@aosc.io> <20180722053955.25266-2-icenowy@aosc.io>
 <20180731205614.GA25776@rob-hp-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 7 Aug 2018 15:31:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v67rOsxKxxRB0Yc8NugzmBas5s1aXmVBgh1Ts9AGd_OgEA@mail.gmail.com>
Message-ID: <CAGb2v67rOsxKxxRB0Yc8NugzmBas5s1aXmVBgh1Ts9AGd_OgEA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-binding: dwmac-sun8i: add H6 compatible string (w/
 A64 fallback)
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Corentin Labbe <clabbe@baylibre.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 4:56 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Jul 22, 2018 at 01:39:51PM +0800, Icenowy Zheng wrote:
>> The Allwinner H6 SoC features a Ethernet MAC that is similar to the one
>> in A64.
>>
>> Add a compatible string for it with A64 fallback compatible string, in
>> this case the A64 driver can be used.
>>
>> The "internal" PHY is not internal from the perspective of the H6 main
>> die, instead it's on the co-packaged AC200 chip, and connected to the
>> main die with RMII at the in-package Port A PIO bank. So from the SoC
>> driver side it needs no special treatment.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
