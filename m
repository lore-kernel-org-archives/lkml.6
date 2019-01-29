Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87DFC282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E072177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idoY4koW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfA2Epg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:45:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53586 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfA2Epg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:45:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so16307588wmb.3;
        Mon, 28 Jan 2019 20:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SsxW6fkD/qctw2NjLA6cTEcv/F0TugHn3GC22YwBKRA=;
        b=idoY4koW7bAqvnGdAxBJt5sQlgRcAtq7t61pz+ZCeHixXiNxDYqwPbAzAO4fuvWZ08
         0GhaW1VYrtMRRkiktxr5rDGUpmqzBt4x19Q4GVmxUd9+cEuxXqQWsHzlNPnJVH6qlHQ2
         k4dQcME7ozOEOSFZFjJ9V/WBtCBewgc43OkN8GpFyeeN8MFaXzuYU5xS/Fk3Rvs7fbsN
         iFuoh/P3L1rlE6gowusIzphxbmygfqrzVKmN/MSE6mDXNo1XowxXJbaueIVSCSW1ejnp
         vmZWdATpIaeduP8C01CqxEcq+QzY1/F8XLYkBCnhbml4Uyo586pFzgXT80Ty+p8btv1k
         03dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SsxW6fkD/qctw2NjLA6cTEcv/F0TugHn3GC22YwBKRA=;
        b=BQwd5on/aT0JqRhN9uvbpMPKBtJK5zYfuKVuIvaIluTT5engRFuqHmHsqQIJWjlfG9
         0DwXf/JNAZJMKJcBkZO7nwgiJmdwl9Pl+Htq9iycKdBVVIl3tkfimOCuCjLomoeMuo72
         2szpvuGFqJ1LpsHR3aJDpkx/kLySDsxudVV1ZbYpCZr1Q5zWISUm3E9zaln+i4wKRdv6
         JZq2h3/zfwLHXV/PWOeeCeycBeigwb3TxVML9drkArpAy3Nr8/BwLRHa4lToUanp+279
         Eg5MMsAtHnfjquDXgZsTglSPkLMYezOBta0+i5geDJKJMnC6WaDB5cjvM2Faz8qtMaYH
         ni2g==
X-Gm-Message-State: AJcUukflZ213vJeH8pPSQkH84Qf4L0OlSsF9P/r6EkiJWUJ8zfnSBDEa
        Mmrv0RpZbgitD4erLoaK6vA=
X-Google-Smtp-Source: ALg8bN6/Vb9+tx62ZvTCIAAeOu7/o4NkkvjPEFBmtGSx5r67KUQpAayVjbG5fPF7iQFXm2XvKF0A2A==
X-Received: by 2002:a1c:c70f:: with SMTP id x15mr19388076wmf.130.1548737132688;
        Mon, 28 Jan 2019 20:45:32 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id t199sm2760278wmt.1.2019.01.28.20.45.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 20:45:31 -0800 (PST)
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
 <67fa5f94-886b-f09c-c93d-832e427ffec8@gmail.com>
 <OF891E176A.614DBEEF-ON4825838C.0022D454-4825838C.002396ED@mxic.com.tw>
 <0b3ea94f-a4f3-0780-301b-f88ff2ad2fb1@gmail.com>
 <OFEAAE10B4.20C3E45D-ON48258390.0007CD37-48258390.0009066E@mxic.com.tw>
 <2d762c16-d714-9171-9450-b6adf1a6509c@gmail.com>
 <OF1DC7FF88.3574E5B9-ON48258391.000A5001-48258391.000D5DDE@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a0f86e7c-dd16-f3fa-5387-b0da6900975c@gmail.com>
Date:   Tue, 29 Jan 2019 05:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <OF1DC7FF88.3574E5B9-ON48258391.000A5001-48258391.000D5DDE@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 3:26 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> >> "Marek Vasut" <marek.vasut@gmail.com>
>> >> >> >> > +module_platform_driver(rpc_spi_driver);
>> >> >> >>
>> >> >> >> RPC is not a SPI controller, it's a SPI and HF controller.
>> >> >> >>
>> >> >> >> Also, how difficult will it be to add the HF support ?
>> >> >> >
>> >> >> > One of my customers needs RPC SPI driver for our company's
>> >> >> > Octal-Flash,MX25UW51245G.
>> >> >> > We don't have HF product and hope you could understanding.
>> >> >>
>> >> >> I am worried that when we need to add RPC HF support (which is
> what all
>> >> >> boards but the D3 Draak use), we will have to rewrite the entire
> driver
>> >> >> and/or convert it to MFD and that would be a tremendous
>> > undertaking. I'd
>> >> >> prefer to have the driver ready for the HF addition before it's
>> > accepted
>> >> >> upstream.
>> >> >>
>> >> >
>> >> > I think maybe your concerned would be happened only if HF driver
>> > goes with
>> >> > spi-mem layer.
>> >> >
>> >> > A comment for HF from Daniel Fishman. FYR.
>> >> >
>> >> > https://www.quora.com/What-is-a-hyper-flash-memory-and-how-is-it-
>> >> different-from-normal-flash-memory
>> >>
>> >> I have a decent idea what HF and SPI NOR are, since I wrote the RPC
>> >> driver for both HF and SPI mode for U-Boot (as I mentioned earlier).
>> >>
>> >> The HF in Linux would use the CFI NOR part of MTD framework. My concern
>> >> is that when we need to add HF support into this driver, this driver
>> >> will have to be basically rewritten, since the architecture won't allow
>> >> for that. I'd like to avoid that, since the majority of Gen3 boards,
>> >> expect for the D3 Draak, use RPC in HF mode.
>> >
>> > FYI~
>> >
>> > MX25UW51245g(64MByte Octa)                      S26KL512S(64MByte HF)
>> >    8 IO                                                  8 IO
>> > 200MHz DDR@1.8v                                   166MHz DDR@1.8v
>> >
>> > support Read-while-write                       Not support
>> > good for OTA,etc
>> > powerful application
>>
>> What does that mean ?
> 
> I have no idea why would you say "since the majority of Gen3 boards use
> RPC in HF mode" ?

Well, the H3/M3W/M3N S-X(S) and the H3/M3 ULCB and E3 Ebisu all boot
from HF. Only the D3 Draak uses QSPI NOR.

> So far as I know that HF is provided by Cypress only and
> any mass production product use the component which is provided by only
> one provider
> will be a big risk.
> 
> Compare to HF, there are more provider of SPI/Octa could support the
> mass production product
> as their second provider.
> 
> In addition, from the technical points of view, mx25uw51245g is more
> powerful than HF and
> good for complicate user application, i.e., OTA and so on.

Did you consider protocol overhead too ? I don't think you can compare
them just by raw numbers of pins and bus frequency.

Note that over-the-air update (if that's what you mean by OTA) is
completely separate from the underlying storage device.

> I think customer have more choice for their flash memory component.
Note that none of this is really relevant to my concerns above regarding
HF support. This driver should be implemented as MFD driver and the SPI
part should use the MFD core part , just like the future HF part.

-- 
Best regards,
Marek Vasut
