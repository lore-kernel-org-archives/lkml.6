Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2650CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19C621741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xemMwMlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfA1PrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50914 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfA1Pq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so14530269wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=24NjDh3BgzGxjDtL0C3I6Y10gxo/KZPwGxzMjFIVtMI=;
        b=xemMwMlwXf0BKqEfwRqgiOIMoMN8z7uXTejRabvpUg1OmgIO5e4E+nkKCTNHXOiRTi
         BV1XTNcTMnQhJm5Mb6QRGqoKSOvOIMpUa15/eYbBsL3FcM77mV6Kqi4bcpzjLO6Ucf4f
         mTiRQC+gtANadgMmekUTIWJV4CW4y5XZ/gWY/Dawp7l+CXRVUm7tjmD0lTd9FnddIVO9
         njCh1/gsIXcsyorEu28o/maE6XBko7M7h0/vgD9CynxuJ5kX7Xh4/NiGzfBM22D1L6TW
         6bXRkf73eQYrfhu0snVhyTTjOKvlsSeNkZGTNpPRhjw8eyShoaukER1fNagUMfl4p4Gj
         wrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=24NjDh3BgzGxjDtL0C3I6Y10gxo/KZPwGxzMjFIVtMI=;
        b=TFyBfXs8OewJf4rPdfXz/v7XH6xs32OMWsP6vqp4QqKZzuzQj9P4mf/GCTdBF2JRvL
         uuJIqcbnRsstLJDV2SzGUahunnlZHyxZaV5xPywgS9ldePHo5pWBXi+AFtgP9VhSl/A2
         hDu6vKeAsKIWXrMan25fPREjd6t+Vxtqb4rs4pYIKWf3CfiOHNZbKLyy5sHEq4F6XwUT
         LmQ9WJWm8QLyuGWGTdq/9XYrVvd68o5pvDY5SZZ47XLRnne93aAwpZynq5PhbU/vvKNk
         v25mSA/1aKyZdf9iI6JmFpZdaZgcYuG/DGREgr6Cpe/9jPymmQHlZnoD/dQUg8harcPK
         A1VQ==
X-Gm-Message-State: AJcUukfkmRMHmTxHIw6C9clnDskERp0tZawKUGS3Ia7P7h4zAryK9/t6
        mtBROwp5/xk5pyflPtzjsYNvHw==
X-Google-Smtp-Source: ALg8bN6vhE491KDsiIHapLz+m/0OKAtWRRjjytp9mM2ieqMYH7gW7G2QPAcsU1sb6TwEVWuZnYRmUQ==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr18536987wmb.145.1548690415418;
        Mon, 28 Jan 2019 07:46:55 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:d40b])
        by smtp.gmail.com with ESMTPSA id r22sm23802wmh.2.2019.01.28.07.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 07:46:54 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com> <1547744074-28308-3-git-send-email-lollivier@baylibre.com> <20190125090755.GB3691@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190125090755.GB3691@localhost>
Date:   Mon, 28 Jan 2019 16:46:53 +0100
Message-ID: <867eeo7pjm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 25 Jan 2019 at 09:07, Johan Hovold wrote:

> On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
>> Add binding for Mediatek-based GNSS receivers.
>> 
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> ---
>> 
>> v2:
>> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> Moved current-speed as an optional propertie.
>> Removed the status line in the example.
>> Added "mediatek,mt3339" compatible.
>> 
>>  .../devicetree/bindings/gnss/mediatek.txt          | 39 
>>  ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt 
>> b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> new file mode 100644
>> index 000000000000..fd984b4a9a6d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> @@ -0,0 +1,39 @@
>> +Mediatek-based GNSS Receiver DT binding
>> +
>> +Mediatek chipsets are used in GNSS-receiver modules produced by several
>> +vendors and can use UART, SPI or I2C interfaces.
>> +
>> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>> +properties.
>> +
>> +Required properties:
>> +
>> +- compatible	: Must be one of
>> +
>> +			"globaltop,pa6h"
>> +			"mediatek,mt3339"
>
> I'm not sure it makes sense to add the GPS chip itself as it cannot be
> used stand-alone AFAIU, and either not way would require a lot more
> resources to be defined than what you add to this binding.
>

OK, I find it a bit confusing to have Mediatek bindings but no
compatible Mediatek SoCs.
But it is true that it can't be used stand-alone. I will remove this
reference and also remove it from the mtk.c driver code from this patch
serie.

>> +
>> +- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
>
> The pin names in parenthesis were copied from the sirf-star binding and
> were used to capture the various names given to this supply by different
> vendors. Please drop as it doesn't apply here.
>
>> +
>> +Required properties (I2C):
>> +- reg		: I2C slave address
>> +
>> +Required properties (SPI):
>> +- reg		: SPI chip select address
>
> While the mt3339 appears to support these interfaces, the globaltop one
> does not.
>
> Have you looked around for a small sample of mt3339-based receivers, to
> see whether anyone actually provides these?
>

Again I'm confused by the fact that it is the Mediatek bindings.
Hence why I have added it and why it was not present in the v1 that was
only for Globaltop.
I find it odd mentionning the chipset but not all its interfaces.
I will remove these sections and only list supported interfaces (i.e.
UART). Other interfaces can be added afterward if one finds a board that
provides them.

>> +Optional properties:
>> +
>> +- timepulse-gpios	: Time pulse GPIO
>> +- v-bckp-supply		: Backup voltage regulator
>> +- current-speed		: Default UART baud rate
>
> Looks like you forgot the optional NRESET input and 3D-FIX output (even
> if the latter might be of limited use).
>

Thanks I will clean this section.

>> +
>> +Example:
>> +
>> +serial@1234 {
>> +	compatible = "ns16550a";
>> +
>> +	gnss {
>> +		compatible = "globaltop,pa6h";
>> +		vcc-supply = <&vcc_3v3>;
>> +	};
>> +};
>
> Johan


-- 
-L
