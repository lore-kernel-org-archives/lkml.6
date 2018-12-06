Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA43A20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA43A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=robertabel.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeLFXNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:13:21 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:46455 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeLFXNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:13:21 -0500
Received: from [192.168.178.21] (unknown [5.63.58.132])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 5A0DF140EED;
        Fri,  7 Dec 2018 00:13:18 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 5.63.58.132) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181205135247.7964-1-mans@mansr.com>
 <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
 <yw1xr2evkg8t.fsf@mansr.com>
 <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
From:   Robert Abel <rabel@robertabel.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=rabel@robertabel.eu; prefer-encrypt=mutual; keydata=
 xsBNBFuld24BCACo/2iGEWd0080a1KqLfB2AYsRzA/86Yx64XNOynZWKk+ToSzDxmEtgUq3u
 By7wZNpIRVeijJ/DvV2Bk2PVAyUMQrQx85rOX+uLW9+WmXgyiO5o+KN6GZDamJu2nDTnvn4z
 Nqowt/tlXMzt+QSL5ypa76AIh8o7QmoV0JpfnxD9NlLX/ysiYXZD1mFi0B8Ef9i22XIE+kuj
 hx03vmNvmKKjr6ajAN3lX3o6ftC2J3BMXl6BiISeO+FkKKbHfMwP4fz70ezrNhD5EdKJZFHe
 FyVQSThR5D1Yxhw4xWy/bQFqlJ96ulfXx5wYNdVck1Vftf5LnvRzrZgKNZU0zzIhMfvBABEB
 AAHNIVJvYmVydCBBYmVsIDxyYWJlbEByb2JlcnRhYmVsLmV1PsLAlAQTAQgAPhYhBAPU/UOS
 MYeSZeDf9jncurJ4JrbIBQJbpXduAhsDBQkDwmcABQsJCAcCBhUICQoLAgQWAgMBAh4BAheA
 AAoJEDncurJ4JrbI2oIIAIpEXpKW3L3lfZ71QxRp4XiXh+s3QqnMIYlXMNbd/A/ZU+70ulDs
 MnnNUeyzjbx4glUDIfAQ/x3tAJyl3Gr6GJcfCumJG/cVu5XYv48CO52qGLVtJsuc75D+Qu41
 pt6r6jdD0y2bVmTRT2bUtZR1kh0gKy/dL+4INiG38JDkLl/JemErLt9GOTfgJGFSdxjMjsuP
 wZmSPVoc8o+xOUBmUxrEICanaK5Hh2imctpAPkqCCWQKOGF9wW/DfdKdQWER4BT4Y/afq1rC
 Z74g/BN3sKnPSoemfvxP6I+PHJn+nXVm9RX7qcHv2Yg3x2MO5Fz1dZ18Rg0w51pVmjBwaCtx
 R5nOwE0EW6V3bgEIAKgY410eN1ERCBNf3j6Kzpm+OiZCELJf8pXGMxe+hJWZjDZd9gsk5PgX
 H4CTk3fBM+Q3ke1XbqhXvf08ynM/hIvl4mkvSHT0G6tHbKcm1jSantj4gloZd5sjcnire2Gs
 bFt6u9BJdh+qJki981O3YqppYGPuXx770NkP6AL9buAxRqMtPv55dHii4LOKUIrOLn6Z427c
 9lzZAVtG6a5HREtDg+M35QwkGkubB1onn9mRBB2Dr/2sr73htU8cRQCQ6kZPILuV3nHMmlUr
 XaEdHyvufv1YEAWQdg08+Pig1ZK57zlGO4WwWUAUuT/9iQm1qzMLP2683OoWbCihbjtYGskA
 EQEAAcLAfAQYAQgAJhYhBAPU/UOSMYeSZeDf9jncurJ4JrbIBQJbpXduAhsMBQkDwmcAAAoJ
 EDncurJ4JrbI/boH/2AzoE6EfGEwkMHMTjH5lmarhDTkg9EQNwi3orH2836RYPlO1geOrItm
 rM9b/lX5OXrE/K24lvxviVV8EaMN9EhEuCyoo6tnv+pUni3U2qWu3WUfAIMtkKlZspa4sO4Z
 slCvBwZtNTb2Al6Rs/knPXnV8mcQ/gMnd99feaIRL7FvsDvlCqIh+B0785igWYQ9VsGUuDXr
 Dmhm/j1LMoAQS4+31+lARM4sX7pdBnlSp0OGHj7vzTMirAjGAAr/Kh7BgcfRtin7n9rAMenu
 9h1RQsQoayamC18CP2SQIZHbbiquUttmrvj7tkJAI2Y7bWqgfmBHHhNsVslYkpd4wYV62uc=
Message-ID: <05e86c46-8d31-f922-9a34-fd6690cc1f77@robertabel.eu>
Date:   Fri, 7 Dec 2018 00:13:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <20181206231318.8608.94999@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On 05 Dec 2018 17:47, Miguel Ojeda wrote:> Hi Mans,
>
> [CC'ing a few people involved previously on this]

Thanks for CC'ing me!

On 06 Dec 2018 11:06, Miguel Ojeda wrote [to Mans Rullgard]:
> Are you able to test this?

It's unfortunate that my original comment got ignored back when the breaking patch was submitted.
Nevertheless, if somebody posts a patch, I'm happy to test.

Regards,

Robert
