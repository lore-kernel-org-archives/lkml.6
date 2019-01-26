Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021BBC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD0C218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBdNR/QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfAZJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:41:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42787 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:41:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so5656364plp.9;
        Sat, 26 Jan 2019 01:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FO83Cx8fAGOOA1b2naAIeCaa4fsfiISE0t38TvkwTB0=;
        b=JBdNR/QGnk764OO/UFFAzPLP7d/xLzUWr5IWbU+LZRMm3nLOuGbhNtfGyx2T64di44
         ON0BRepLTK0dp6ZNZcAr3/i75++LFHpg/ESdMPCroH5dSUY6Z9In73AfYMHmvx8dhQQq
         Sim0QKPNvTxlxYjz6KSgFUquLID40rJdO/gTQ+yujaDgfCyicwTrHWq7xyAwX257p9by
         lauL0M8xYRBHiIvhKO/KWtsAd5k59gz+fa2qsUFsCVz/kiXdpGJ6HoB3JTDzPyshpFKs
         n6zSAC2PL7HAaMA/z7ONu7CZjqQQZM2udEpW5DLEyMy3esZXM5BbI0lMj8hVBWNgNRuS
         8vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FO83Cx8fAGOOA1b2naAIeCaa4fsfiISE0t38TvkwTB0=;
        b=D542J8gowRaDQtmb2QgbG9msblD8tFMnJwAFTFLNYLMzotAPHPEWgrBi1zQfiVjX1+
         8uqmh91p2/eVJu4K9RKwLC/toIp25TSLJJs9TD4QqZtNtyGAOmfhTLsOdHKwxdobHGVW
         hOMV4QkRS9F8vCI9Cc0R/PHhCnnjuX4aRdnprN4cJWp+iPbiZpdC33i0WKoLNJqq6ley
         soTx7XPEr2V8owaNYkqG5tsfbeKlpc7K/kOb6+FIJjy4y97KJ5sTfJ0hQ2sxnO4l8lS3
         d0jplZEZUCPRS/UfKNpi+vLRlg6kDKomWpnlNM9s3uzSQLE4O/LJdGkqJAvHGzdro8qz
         qM0A==
X-Gm-Message-State: AJcUukfxH31CndN8jktIttM0zvdFsvRnS7PCW/XShF/rIFrfbOAQ9aCr
        XnG9aQr6CKfoSzArwinn0GxLWr8r
X-Google-Smtp-Source: ALg8bN4N8f6RTxpIV8cU+kMhlWHC1ROYzZ1y9xXPoRhXGVcIsBV0vFzHtjybvakPVqwj7lskkAbFJg==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr14648780plk.291.1548495716780;
        Sat, 26 Jan 2019 01:41:56 -0800 (PST)
Received: from [192.168.42.184] ([103.44.164.150])
        by smtp.gmail.com with ESMTPSA id p2sm33976733pfb.28.2019.01.26.01.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 01:41:56 -0800 (PST)
From:   Marek Vasut <marek.vasut@gmail.com>
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
Openpgp: preference=signencrypt
Message-ID: <0b3ea94f-a4f3-0780-301b-f88ff2ad2fb1@gmail.com>
Date:   Sat, 26 Jan 2019 10:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <OF891E176A.614DBEEF-ON4825838C.0022D454-4825838C.002396ED@mxic.com.tw>
Content-Type: text/plain; charset=big5
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 7:28 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/24 ¤W¤È 11:14
>> >>
>> >> > +module_platform_driver(rpc_spi_driver);
>> >>
>> >> RPC is not a SPI controller, it's a SPI and HF controller.
>> >>
>> >> Also, how difficult will it be to add the HF support ?
>> >
>> > One of my customers needs RPC SPI driver for our company's
>> > Octal-Flash,MX25UW51245G.
>> > We don't have HF product and hope you could understanding.
>>
>> I am worried that when we need to add RPC HF support (which is what all
>> boards but the D3 Draak use), we will have to rewrite the entire driver
>> and/or convert it to MFD and that would be a tremendous undertaking. I'd
>> prefer to have the driver ready for the HF addition before it's accepted
>> upstream.
>>
> 
> I think maybe your concerned would be happened only if HF driver goes with
> spi-mem layer.
> 
> A comment for HF from Daniel Fishman. FYR.
> 
> https://www.quora.com/What-is-a-hyper-flash-memory-and-how-is-it-different-from-normal-flash-memory

I have a decent idea what HF and SPI NOR are, since I wrote the RPC
driver for both HF and SPI mode for U-Boot (as I mentioned earlier).

The HF in Linux would use the CFI NOR part of MTD framework. My concern
is that when we need to add HF support into this driver, this driver
will have to be basically rewritten, since the architecture won't allow
for that. I'd like to avoid that, since the majority of Gen3 boards,
expect for the D3 Draak, use RPC in HF mode.

-- 
Best regards,
Marek Vasut
